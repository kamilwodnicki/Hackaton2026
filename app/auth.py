import os
import requests
from flask import Blueprint, jsonify, redirect, request, session

auth_bp = Blueprint("auth", __name__)

DIRECTUS_URL = os.getenv("DIRECTUS_URL", "http://directus:8055")
DIRECTUS_ADMIN_EMAIL = os.getenv("DIRECTUS_ADMIN_EMAIL", "admin@example.com")
DIRECTUS_ADMIN_PASSWORD = os.getenv("DIRECTUS_ADMIN_PASSWORD", "admin")
EXPERT_INVITE_CODE = os.getenv("EXPERT_INVITE_CODE", "mentor2026")

# Kod roli używany na froncie -> nazwa roli w Directusie
ROLE_NAMES = {
    "resident": "Mieszkaniec / NGO",
    "jst": "Pracownik JST",
    "rops": "Pracownik ROPS",
    "expert": "Ekspert / mentor",
}
ROLE_CODES = {name: code for code, name in ROLE_NAMES.items()}

# Widoki dostępne tylko dla danej roli
PROTECTED_PAGES = {
    "/rops-worker.html": "rops",
    "/residents-ideas.html": "rops",
    "/eksperci.html": "expert",
}

_role_ids = {}


class AuthError(Exception):
    def __init__(self, message, status=400):
        super().__init__(message)
        self.message = message
        self.status = status


def _directus(method, path, token=None, **kwargs):
    headers = {"Authorization": f"Bearer {token}"} if token else {}
    try:
        return requests.request(method, f"{DIRECTUS_URL}{path}", headers=headers, timeout=10, **kwargs)
    except requests.RequestException:
        raise AuthError("Serwer kont jest chwilowo niedostępny.", 502)


def _login_token(email, password):
    r = _directus("POST", "/auth/login", json={"email": email, "password": password})
    if r.status_code == 401:
        raise AuthError("Nieprawidłowy e-mail lub hasło.", 401)
    if not r.ok:
        raise AuthError("Nie udało się zalogować.", 502)
    return r.json()["data"]["access_token"]


def _role_id(code, admin):
    # Role zakładamy w Directusie przy pierwszym użyciu
    if code not in _role_ids:
        name = ROLE_NAMES[code]
        r = _directus("GET", "/roles", admin, params={"filter[name][_eq]": name, "fields": "id"})
        found = r.json().get("data", []) if r.ok else []
        if found:
            _role_ids[code] = found[0]["id"]
        else:
            r = _directus("POST", "/roles", admin, json={"name": name, "icon": "person"})
            if not r.ok:
                raise AuthError("Nie udało się utworzyć roli w Directusie.", 502)
            _role_ids[code] = r.json()["data"]["id"]
    return _role_ids[code]


def _validate_registration(data):
    email = (data.get("email") or "").strip().lower()
    roles = data.get("roles") or ["resident"]
    if not email or len(data.get("password") or "") < 8:
        raise AuthError("Podaj e-mail i hasło (min. 8 znaków).")
    if len(roles) != 1 or roles[0] not in ROLE_NAMES:
        raise AuthError("Wybierz jedną rolę.")
    role = roles[0]
    if role == "rops" and not email.endswith("@rops.krakow.pl"):
        raise AuthError("Rola pracownika ROPS wymaga adresu w domenie @rops.krakow.pl.")
    if role == "jst" and any(f"@{domain}." in email for domain in ("gmail", "outlook", "wp")):
        raise AuthError("Rola JST wymaga służbowego adresu e-mail jednostki samorządowej.")
    if role == "expert" and data.get("invite") != EXPERT_INVITE_CODE:
        raise AuthError("Rola eksperta lub mentora jest dostępna wyłącznie przez indywidualny link zaproszeniowy.")
    return email, role


def _start_session(email, password):
    _login_token(email, password)  # Directus sprawdza hasło
    # Role użytkowników nie mają uprawnień do odczytu w Directusie — dane konta czytamy jako admin
    admin = _login_token(DIRECTUS_ADMIN_EMAIL, DIRECTUS_ADMIN_PASSWORD)
    r = _directus("GET", "/users", admin, params={"filter[email][_eq]": email, "fields": "first_name,email,role.name", "limit": 1})
    users = r.json().get("data", []) if r.ok else []
    if not users:
        raise AuthError("Nie udało się pobrać danych konta.", 502)
    user = users[0]
    code = ROLE_CODES.get((user.get("role") or {}).get("name"), "resident")
    session.permanent = True
    session["user"] = {"name": user.get("first_name") or email.split("@")[0], "email": user["email"], "roles": [code], "role": code}
    return session["user"]


@auth_bp.errorhandler(AuthError)
def handle_auth_error(error):
    return jsonify({"message": error.message}), error.status


@auth_bp.route("/api/auth/register", methods=["POST"])
def register():
    data = request.get_json(silent=True) or {}
    email, role = _validate_registration(data)
    admin = _login_token(DIRECTUS_ADMIN_EMAIL, DIRECTUS_ADMIN_PASSWORD)
    r = _directus("POST", "/users", admin, json={
        "email": email,
        "password": data["password"],
        "first_name": (data.get("name") or "").strip(),
        "role": _role_id(role, admin),
        "status": "active",
    })
    if not r.ok:
        codes = [e.get("extensions", {}).get("code") for e in r.json().get("errors", [])]
        if "RECORD_NOT_UNIQUE" in codes:
            raise AuthError("Konto z tym adresem e-mail już istnieje.", 409)
        raise AuthError("Nie udało się utworzyć konta.", 502)
    return jsonify(_start_session(email, data["password"]))


@auth_bp.route("/api/auth/login", methods=["POST"])
def login():
    data = request.get_json(silent=True) or {}
    return jsonify(_start_session((data.get("email") or "").strip().lower(), data.get("password") or ""))


@auth_bp.route("/api/auth/logout", methods=["POST"])
def logout():
    session.pop("user", None)
    return jsonify({"ok": True})


@auth_bp.route("/api/auth/me")
def me():
    user = session.get("user")
    return (jsonify(user), 200) if user else (jsonify({"message": "Niezalogowany"}), 401)


@auth_bp.before_app_request
def guard_protected_pages():
    # Prawdziwa ochrona widoków — role-guard.js na froncie da się obejść
    required = PROTECTED_PAGES.get(request.path)
    if not required:
        return None
    user = session.get("user")
    if not user:
        return redirect(f"/logowanie.html?reason=login-required&redirect={request.path.lstrip('/')}")
    if required not in user["roles"]:
        return redirect("/panel.html?access=denied")
    return None
