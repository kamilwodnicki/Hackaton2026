const root = document.documentElement;
const menuButton = document.querySelector(".mobile-menu-button");
const navigation = document.querySelector(".main-navigation");
const problemForm = document.querySelector("#problem-form");
const problemInput = document.querySelector("#problem");
const formMessage = document.querySelector("#form-message");

menuButton?.addEventListener("click", () => {
  const isOpen = menuButton.getAttribute("aria-expanded") === "true";
  menuButton.setAttribute("aria-expanded", String(!isOpen));
  navigation.classList.toggle("is-open", !isOpen);
});

document.querySelectorAll("[data-theme]").forEach((button) => {
  button.addEventListener("click", () => {
    const theme = button.dataset.theme;
    if (theme === "default") {
      root.removeAttribute("data-theme");
    } else {
      root.dataset.theme = theme;
    }

    document.querySelectorAll("[data-theme]").forEach((item) => item.classList.remove("is-active"));
    button.classList.add("is-active");
    localStorage.setItem("site-theme", theme);
  });
});

document.querySelectorAll("[data-font-size]").forEach((button) => {
  button.addEventListener("click", () => {
    const scales = { normal: "1", large: "1.1", largest: "1.2" };
    root.style.setProperty("--font-scale", scales[button.dataset.fontSize]);
    localStorage.setItem("font-size", button.dataset.fontSize);
  });
});

document.querySelector("#toggle-visibility")?.addEventListener("click", () => {
  root.classList.toggle("hide-decorations");
});

document.querySelector("#reset-accessibility")?.addEventListener("click", () => {
  root.removeAttribute("data-theme");
  root.classList.remove("hide-decorations");
  root.style.setProperty("--font-scale", "1");
  localStorage.removeItem("site-theme");
  localStorage.removeItem("font-size");
  document.querySelectorAll("[data-theme]").forEach((item) => item.classList.toggle("is-active", item.dataset.theme === "default"));
});

problemForm?.addEventListener("submit", (event) => {
  event.preventDefault();
  const query = problemInput.value.trim();

  if (!query) {
    formMessage.textContent = "Najpierw opisz problem, który chcesz rozwiązać.";
    problemInput.focus();
    return;
  }

  formMessage.textContent = "Opis zapisany. Moduł asystenta można podłączyć w tym miejscu.";
});

const ideaForm = document.querySelector("#idea-form");
const ideaTitleInput = document.querySelector("#idea-title-input");
const ideaFormMessage = document.querySelector("#idea-form-message");
const assistantPrompt = document.querySelector("#assistant-prompt");

ideaForm?.addEventListener("submit", (event) => {
  event.preventDefault();
  const selectedGroups = ideaForm.querySelectorAll('input[name="audience"]:checked');

  if (!ideaTitleInput.value.trim()) {
    ideaFormMessage.textContent = "Wpisz tytuł pomysłu, aby przejść dalej.";
    ideaTitleInput.focus();
    return;
  }

  if (!selectedGroups.length) {
    ideaFormMessage.textContent = "Wybierz co najmniej jedną grupę odbiorców.";
    ideaForm.querySelector('input[name="audience"]').focus();
    return;
  }

  ideaFormMessage.textContent = "Świetnie! Podstawowe informacje zostały zapisane.";
});

assistantPrompt?.addEventListener("click", () => {
  const title = ideaTitleInput.value.trim();
  if (!title) {
    ideaFormMessage.textContent = "Najpierw wpisz tytuł pomysłu — na jego podstawie rozpoczniemy wyszukiwanie.";
    ideaTitleInput.focus();
    return;
  }

  window.location.href = `index.html?problem=${encodeURIComponent(title)}`;
});

const savedTheme = localStorage.getItem("site-theme");
if (savedTheme && savedTheme !== "default") {
  root.dataset.theme = savedTheme;
  document.querySelectorAll("[data-theme]").forEach((item) => item.classList.toggle("is-active", item.dataset.theme === savedTheme));
}

const savedFontSize = localStorage.getItem("font-size");
if (savedFontSize) {
  const scales = { normal: "1", large: "1.1", largest: "1.2" };
  root.style.setProperty("--font-scale", scales[savedFontSize] || "1");
}

const problemFromUrl = new URLSearchParams(window.location.search).get("problem");
if (problemFromUrl && problemInput) {
  problemInput.value = problemFromUrl;
  problemInput.focus();
}
