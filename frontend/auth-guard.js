(() => {
  try {
    if (JSON.parse(localStorage.getItem("rops-auth-session") || "null")) return;
  } catch {}
  const target = encodeURIComponent(location.pathname.split("/").pop() || "panel.html");
  location.replace(`logowanie.html?reason=login-required&redirect=${target}`);
})();
