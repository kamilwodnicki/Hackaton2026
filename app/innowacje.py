import os
import requests
from flask import Blueprint, Response, jsonify

innowacje_bp = Blueprint("innowacje", __name__)

DIRECTUS_URL = os.getenv("DIRECTUS_URL", "http://directus:8055")
# "*" zamiast listy pól — thumbnail jest tylko w części instancji Directusa, a brakujące pole w fields daje 403
FIELDS = "*,pliki.directus_files_id.id,pliki.directus_files_id.filename_download"


@innowacje_bp.route("/api/innowacje")
def list_innowacje():
    try:
        r = requests.get(f"{DIRECTUS_URL}/items/innowacje", params={"fields": FIELDS, "sort": "-date_created", "limit": -1}, timeout=10)
        r.raise_for_status()
    except requests.RequestException as e:
        return jsonify({"error": f"Błąd pobierania innowacji: {e}"}), 502

    items = []
    for item in r.json().get("data", []):
        files = [p["directus_files_id"] for p in item.get("pliki") or [] if p.get("directus_files_id")]
        items.append({
            "id": item["id"],
            "title": item.get("tytul") or "",
            "description": item.get("opis") or "",
            "thumbnail": f"/api/assets/{item['thumbnail']}" if item.get("thumbnail") else None,
            "files": [{"name": f.get("filename_download") or "plik", "url": f"/api/assets/{f['id']}"} for f in files],
        })
    return jsonify({"items": items})


@innowacje_bp.route("/api/assets/<uuid:file_id>")
def asset(file_id):
    # Pliki i miniatury z Directusa podajemy przez Flaska — jeden port, bez CORS
    try:
        r = requests.get(f"{DIRECTUS_URL}/assets/{file_id}", timeout=30, stream=True)
    except requests.RequestException:
        return jsonify({"error": "Plik jest chwilowo niedostępny."}), 502
    if not r.ok:
        return jsonify({"error": "Nie znaleziono pliku."}), r.status_code
    headers = {k: r.headers[k] for k in ("Content-Type", "Content-Disposition") if k in r.headers}
    return Response(r.iter_content(64 * 1024), headers=headers)
