(() => {
  const requiredRole = document.currentScript?.dataset.requiredRole;
  if (!requiredRole) return;
  let session = null;
  try {
    session = JSON.parse(localStorage.getItem("rops-auth-session") || "null");
  } catch {}
  if (!session) {
    const target = encodeURIComponent(location.pathname.split("/").pop());
    location.replace(`logowanie.html?reason=login-required&redirect=${target}`);
    return;
  }
  const roles = Array.isArray(session.roles) ? session.roles : [session.role || "resident"];
  if (!roles.includes(requiredRole)) location.replace("panel.html?access=denied");
})();
