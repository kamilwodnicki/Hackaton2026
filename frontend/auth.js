const AUTH_CONFIG = {
  mode: "mock", // Zmień na "backend" po uruchomieniu API.
  apiBase: "/api/auth",
  endpoints: {
    login: "/login",
    register: "/register",
    sso: "/sso",
  },
};

const authSessionKey = "rops-auth-session";
const authProfileKey = "rops-account-profile";
const mockAccountsKey = "rops-mock-accounts";
const form = document.querySelector("#auth-form");
const message = document.querySelector("#auth-message");
const params = new URLSearchParams(location.search);
const redirectTarget = params.get("redirect") || "panel.html";
const pageMode = document.body.dataset.authPage;

const readStorage = (key, fallback) => {
  try {
    return JSON.parse(localStorage.getItem(key)) ?? fallback;
  } catch {
    return fallback;
  }
};

const roleLabels = {
  resident: "Mieszkaniec / NGO",
  jst: "Pracownik JST",
  rops: "Pracownik ROPS",
  expert: "Ekspert branżowy / mentor",
};

const normalizeRoles = (value) => {
  const roles = Array.isArray(value) ? value : value ? [value] : [];
  return [...new Set(roles)].filter((role) => roleLabels[role]).slice(0, 3);
};

const showMessage = (text) => {
  if (message) message.textContent = text;
};

const validateRole = ({ roles, role, email = "" }) => {
  const normalizedEmail = email.trim().toLowerCase();
  const selectedRoles = normalizeRoles(roles || role || "resident");
  if (selectedRoles.length < 1) return "Wybierz co najmniej jedną rolę.";
  if (Array.isArray(roles) && roles.length > 3) return "Możesz wybrać maksymalnie trzy role.";
  if (selectedRoles.includes("rops") && !normalizedEmail.endsWith("@rops.krakow.pl")) return "Rola pracownika ROPS wymaga adresu w domenie @rops.krakow.pl.";
  if (selectedRoles.includes("jst") && (!normalizedEmail.includes("@") || /@(gmail|outlook|wp)\./.test(normalizedEmail))) return "Rola JST wymaga służbowego adresu e-mail jednostki samorządowej.";
  if (selectedRoles.includes("expert") && !params.get("invite")) return "Rola eksperta lub mentora jest dostępna wyłącznie przez indywidualny link zaproszeniowy.";
  return "";
};

// Jedyny adapter do podmiany przy podłączaniu bazy i prawdziwego OAuth.
const authenticate = async (action, payload) => {
  if (AUTH_CONFIG.mode === "backend") {
    const response = await fetch(`${AUTH_CONFIG.apiBase}${AUTH_CONFIG.endpoints[action]}`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      credentials: "include",
      body: JSON.stringify(payload),
    });
    if (!response.ok) throw new Error((await response.json().catch(() => ({}))).message || "Nie udało się uwierzytelnić użytkownika.");
    return response.json();
  }

  await new Promise((resolve) => setTimeout(resolve, 250));
  const accounts = readStorage(mockAccountsKey, []);
  const email = String(payload.email || `${payload.provider}.mock@example.org`).trim().toLowerCase();
  let account = accounts.find((item) => item.email === email);

  if (action === "register" || action === "sso") {
    const roles = normalizeRoles(payload.roles || payload.role || "resident");
    account = account || { name: payload.name || roleLabels[roles[0]] || "Użytkownik testowy", email, roles, role: roles[0] };
    if (!accounts.some((item) => item.email === email)) localStorage.setItem(mockAccountsKey, JSON.stringify([...accounts, account]));
  } else if (!account) {
    account = { name: email.split("@")[0], email, roles: ["resident"], role: "resident" };
  }
  const roles = normalizeRoles(account.roles || account.role || "resident");
  if (!roles.length) roles.push("resident");
  return { ...account, roles, role: roles[0], provider: payload.provider || "email", mock: true };
};

const finishAuthentication = (session) => {
  const completeSession = { ...session, signedInAt: new Date().toISOString() };
  localStorage.setItem(authSessionKey, JSON.stringify(completeSession));
  localStorage.setItem(authProfileKey, JSON.stringify({ name: session.name, email: session.email, roles: session.roles, role: session.role }));
  location.href = redirectTarget;
};

const runAuthentication = async (action, payload, button) => {
  const validationError = validateRole(payload);
  if (validationError) return showMessage(validationError);
  showMessage("Trwa uwierzytelnianie w trybie demonstracyjnym…");
  if (button) button.disabled = true;
  try {
    finishAuthentication(await authenticate(action, payload));
  } catch (error) {
    showMessage(error.message);
    if (button) button.disabled = false;
  }
};

if (message && params.get("reason") === "login-required") showMessage("Twój panel jest dostępny po zalogowaniu. Jeśli nie masz konta, możesz zarejestrować się poniżej.");

form?.addEventListener("submit", (event) => {
  event.preventDefault();
  if (!form.reportValidity()) return;
  const formData = new FormData(form);
  const data = Object.fromEntries(formData.entries());
  if (pageMode === "register") data.roles = formData.getAll("roles");
  runAuthentication(pageMode === "register" ? "register" : "login", data, event.submitter);
});

document.querySelectorAll("[data-sso-provider]").forEach((button) => {
  button.addEventListener("click", () => {
    const formData = form ? new FormData(form) : null;
    const data = formData ? Object.fromEntries(formData.entries()) : {};
    if (formData && pageMode === "register") data.roles = formData.getAll("roles");
    runAuthentication("sso", { ...data, provider: button.dataset.ssoProvider }, button);
  });
});

const roleInputs = [...document.querySelectorAll('input[name="roles"]')];
const roleHelp = document.querySelector("#role-help");
const emailField = document.querySelector("#register-email");
const updateRoleHelp = () => {
  if (!roleInputs.length || !roleHelp) return;
  const help = {
    resident: "Rejestracja standardowa dla mieszkańców i organizacji pozarządowych.",
    jst: "Wymagany jest służbowy adres e-mail jednostki samorządowej.",
    rops: "Wymagany jest służbowy adres e-mail w domenie @rops.krakow.pl.",
    expert: "Ta rola wymaga indywidualnego linku zaproszeniowego.",
  };
  const selected = roleInputs.filter((input) => input.checked).map((input) => input.value);
  roleInputs.forEach((input) => { input.disabled = !input.checked && selected.length >= 3; });
  roleHelp.textContent = selected.length ? selected.map((role) => help[role]).join(" ") : "Wybierz od jednej do trzech ról.";
  if (emailField) emailField.placeholder = selected.includes("rops") ? "imie.nazwisko@rops.krakow.pl" : "adres@instytucja.pl";
};
roleInputs.forEach((input) => input.addEventListener("change", updateRoleHelp));
updateRoleHelp();

if (readStorage(authSessionKey, null) && pageMode === "login") location.href = redirectTarget;
