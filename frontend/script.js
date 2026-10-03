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

const ideaDialog = document.querySelector("#idea-dialog");
const dialogTitle = document.querySelector("#dialog-title");
const dialogAuthor = document.querySelector("#dialog-author");
const dialogMunicipality = document.querySelector("#dialog-municipality");
const dialogDescription = document.querySelector("#dialog-description");

document.querySelectorAll(".idea-preview-button").forEach((button) => {
  button.addEventListener("click", () => {
    dialogTitle.textContent = button.dataset.title;
    dialogAuthor.textContent = button.dataset.author;
    dialogMunicipality.textContent = button.dataset.municipality;
    dialogDescription.textContent = button.dataset.description;
    ideaDialog.showModal();
  });
});

document.querySelector("#idea-dialog-close")?.addEventListener("click", () => {
  ideaDialog.close();
});

document.querySelectorAll(".decision-button").forEach((button) => {
  button.addEventListener("click", () => {
    const status = button.closest(".idea-status");
    const isApproval = button.textContent.trim() === "Zatwierdź";
    status.className = `idea-status ${isApproval ? "idea-status--approved" : "idea-status--rejected"}`;
    status.textContent = isApproval ? "Zatwierdzone" : "Odrzucone";
  });
});

const forumSearch = document.querySelector("#forum-search");
const forumFilters = document.querySelectorAll(".forum-filter");
const forumThreads = document.querySelector("#thread-list");
const forumEmpty = document.querySelector("#forum-empty");
let activeForumFilter = "all";

const normalizeText = (value) => value.toLocaleLowerCase("pl").normalize("NFD").replace(/[\u0300-\u036f]/g, "");

const updateForumThreads = () => {
  if (!forumThreads) return;
  const query = normalizeText(forumSearch?.value.trim() || "");
  let visibleCount = 0;

  forumThreads.querySelectorAll(".forum-thread").forEach((thread) => {
    const matchesCategory = activeForumFilter === "all" || thread.dataset.category === activeForumFilter;
    const matchesQuery = !query || normalizeText(thread.textContent).includes(query);
    const isVisible = matchesCategory && matchesQuery;
    thread.hidden = !isVisible;
    if (isVisible) visibleCount += 1;
  });

  if (forumEmpty) forumEmpty.hidden = visibleCount !== 0;
};

forumSearch?.addEventListener("input", updateForumThreads);
forumFilters.forEach((button) => {
  button.addEventListener("click", () => {
    activeForumFilter = button.dataset.filter;
    forumFilters.forEach((filter) => filter.classList.toggle("is-active", filter === button));
    updateForumThreads();
  });
});

const threadDialog = document.querySelector("#thread-dialog");
const threadForm = document.querySelector("#thread-form");

document.querySelector("#new-thread-button")?.addEventListener("click", () => {
  threadDialog.showModal();
  document.querySelector("#thread-title")?.focus();
});

document.querySelector("#thread-dialog-close")?.addEventListener("click", () => threadDialog.close());

threadDialog?.addEventListener("click", (event) => {
  if (event.target === threadDialog) threadDialog.close();
});

threadForm?.addEventListener("submit", (event) => {
  event.preventDefault();
  const titleInput = document.querySelector("#thread-title");
  const contentInput = document.querySelector("#thread-content");
  const categoryInput = document.querySelector("#thread-category");
  const message = document.querySelector("#thread-form-message");

  if (!titleInput.value.trim() || !contentInput.value.trim()) {
    message.textContent = "Uzupełnij tytuł i treść pytania.";
    (!titleInput.value.trim() ? titleInput : contentInput).focus();
    return;
  }

  const thread = document.createElement("article");
  thread.className = "forum-thread";
  thread.dataset.category = categoryInput.value;
  const summary = document.createElement("div");
  const title = document.createElement("h3");
  const link = document.createElement("a");
  link.href = "#";
  link.textContent = titleInput.value.trim();
  title.append(link);
  const author = document.createElement("p");
  author.textContent = "Autor: Ty · Nowa dyskusja";
  summary.append(title, author);
  const meta = document.createElement("div");
  meta.className = "thread-meta";
  const replies = document.createElement("strong");
  replies.textContent = "0 odp.";
  const time = document.createElement("span");
  time.textContent = "Opublikowano przed chwilą";
  meta.append(replies, time);
  thread.append(summary, meta);
  forumThreads.prepend(thread);

  threadForm.reset();
  message.textContent = "";
  activeForumFilter = "all";
  forumFilters.forEach((filter) => filter.classList.toggle("is-active", filter.dataset.filter === "all"));
  if (forumSearch) forumSearch.value = "";
  updateForumThreads();
  threadDialog.close();
  thread.scrollIntoView({ behavior: "smooth", block: "center" });
});
