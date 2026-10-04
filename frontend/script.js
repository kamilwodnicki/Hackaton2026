const root = document.documentElement;
const menuButton = document.querySelector(".mobile-menu-button");
const navigation = document.querySelector(".main-navigation");
const problemForm = document.querySelector("#problem-form");
const problemInput = document.querySelector("#problem");
const formMessage = document.querySelector("#form-message");
const languageSelect = document.querySelector("#language");
const languageFlag = document.querySelector(".language-flag");

const getCurrentSession = () => {
  try {
    return JSON.parse(localStorage.getItem("rops-auth-session") || "null");
  } catch {
    return null;
  }
};

const currentSession = getCurrentSession();

if (new URLSearchParams(location.search).get("access") === "denied") {
  const main = document.querySelector("main");
  if (main) {
    const notice = document.createElement("p");
    notice.className = "access-denied-notice";
    notice.setAttribute("role", "alert");
    notice.textContent = "To konto nie ma roli wymaganej do otwarcia wybranej sekcji.";
    main.prepend(notice);
  }
}

if (currentSession) {
  const allowedRoles = new Set(Array.isArray(currentSession.roles) ? currentSession.roles : [currentSession.role || "resident"]);
  const rolePages = {
    "mieszkancy.html": "resident",
    "samorzady.html": "jst",
    "rops-worker.html": "rops",
    "eksperci.html": "expert",
  };

  document.querySelectorAll(".audience-navigation .audience-link").forEach((link) => {
    const requiredRole = rolePages[link.getAttribute("href")];
    if (requiredRole && !allowedRoles.has(requiredRole)) link.remove();
  });

  document.querySelectorAll(".account-actions").forEach((actions) => {
    const hasGuestActions = actions.querySelector('a[href="logowanie.html"], a[href="rejestracja.html"]');
    if (!hasGuestActions) return;

    const accountLink = document.createElement("a");
    accountLink.className = "button button--account";
    accountLink.href = "ustawienia-konta.html";
    accountLink.textContent = "Twoje konto";

    const logoutButton = document.createElement("button");
    logoutButton.className = "button button--secondary";
    logoutButton.type = "button";
    logoutButton.dataset.logout = "";
    logoutButton.textContent = "Wyloguj";

    actions.replaceChildren(accountLink, logoutButton);
  });
}

document.querySelectorAll('a[href="panel.html"], a[href="ustawienia-konta.html"]').forEach((link) => {
  link.addEventListener("click", (event) => {
    if (getCurrentSession()) return;
    event.preventDefault();
    const target = encodeURIComponent(link.getAttribute("href"));
    location.href = `logowanie.html?reason=login-required&redirect=${target}`;
  });
});

document.querySelectorAll("[data-logout]").forEach((button) => {
  button.addEventListener("click", async () => {
    await fetch("/api/auth/logout", { method: "POST" }).catch(() => {});
    localStorage.removeItem("rops-auth-session");
    location.href = "index.html";
  });
});

languageSelect?.addEventListener("change", () => {
  languageFlag.dataset.language = languageSelect.value;
});

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

    document.querySelectorAll("[data-theme]").forEach((item) => {
      const isActive = item.dataset.theme === theme;
      item.classList.toggle("is-active", isActive);
      item.setAttribute("aria-pressed", String(isActive));
    });
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

const voiceButton = document.querySelector("#toggle-voice-assistant");
const accessibilityTools = document.querySelector("#accessibility");
const accessibilityStatus = document.createElement("span");
accessibilityStatus.className = "sr-only";
accessibilityStatus.setAttribute("role", "status");
accessibilityStatus.setAttribute("aria-live", "polite");
accessibilityTools?.append(accessibilityStatus);

voiceButton?.addEventListener("click", () => {
  if (!("speechSynthesis" in window) || !("SpeechSynthesisUtterance" in window)) {
    accessibilityStatus.textContent = "Ta przeglądarka nie obsługuje czytania strony na głos.";
    return;
  }

  if (window.speechSynthesis.speaking) {
    window.speechSynthesis.cancel();
    voiceButton.setAttribute("aria-pressed", "false");
    voiceButton.setAttribute("aria-label", "Czytaj stronę na głos");
    accessibilityStatus.textContent = "Czytanie zatrzymane.";
    return;
  }

  const mainContent = document.querySelector("main");
  const text = mainContent?.innerText.replace(/\s+/g, " ").trim();
  if (!text) {
    accessibilityStatus.textContent = "Nie znaleziono treści do przeczytania.";
    return;
  }

  const utterance = new SpeechSynthesisUtterance(text);
  utterance.lang = window.siteLocale || "pl-PL";
  const languageVoice = window.speechSynthesis.getVoices().find((voice) => voice.lang.toLowerCase().startsWith(document.documentElement.lang));
  if (languageVoice) utterance.voice = languageVoice;
  const finishReading = () => {
    voiceButton.setAttribute("aria-pressed", "false");
    voiceButton.setAttribute("aria-label", "Czytaj stronę na głos");
  };
  utterance.onend = finishReading;
  utterance.onerror = finishReading;
  voiceButton.setAttribute("aria-pressed", "true");
  voiceButton.setAttribute("aria-label", "Zatrzymaj czytanie strony na głos");
  accessibilityStatus.textContent = "Czytam treść strony na głos.";
  window.speechSynthesis.speak(utterance);
});

const signLanguageButton = document.querySelector("#toggle-sign-language");
if (signLanguageButton) {
  const signLanguageDialog = document.createElement("dialog");
  signLanguageDialog.className = "accessibility-dialog";
  signLanguageDialog.setAttribute("aria-labelledby", "sign-language-title");
  signLanguageDialog.innerHTML = `
    <div class="accessibility-dialog-inner">
      <h2 id="sign-language-title">Polski Język Migowy (PJM)</h2>
      <div class="sign-language-content"></div>
      <button class="accessibility-dialog-close" type="button">Zamknij</button>
    </div>`;
  document.body.append(signLanguageDialog);

  const signLanguageContent = signLanguageDialog.querySelector(".sign-language-content");
  const signLanguageSource = signLanguageButton.dataset.pjmUrl;
  let pjmUrl;
  try {
    pjmUrl = signLanguageSource ? new URL(signLanguageSource, window.location.href) : null;
  } catch {
    pjmUrl = null;
  }

  if (pjmUrl?.protocol === "https:") {
    const video = document.createElement("iframe");
    video.className = "sign-language-video";
    video.src = pjmUrl.href;
    video.title = "Tłumaczenie w Polskim Języku Migowym";
    video.allow = "autoplay; fullscreen; picture-in-picture";
    video.allowFullscreen = true;
    signLanguageContent.append(video);
  } else {
    const notice = document.createElement("p");
    notice.textContent = "Nie podłączono jeszcze tłumacza ani nagrań PJM. Ten panel nie zastępuje tłumaczenia na Polski Język Migowy.";
    const contact = document.createElement("a");
    contact.href = "mailto:biuro@rops.krakow.pl?subject=Wsparcie%20w%20PJM";
    contact.textContent = "Napisz do ROPS w sprawie wsparcia w PJM";
    signLanguageContent.append(notice, contact);
  }

  signLanguageButton.addEventListener("click", () => {
    signLanguageDialog.showModal();
    signLanguageButton.setAttribute("aria-expanded", "true");
    signLanguageDialog.querySelector(".accessibility-dialog-close").focus();
  });
  signLanguageDialog.querySelector(".accessibility-dialog-close").addEventListener("click", () => signLanguageDialog.close());
  signLanguageDialog.addEventListener("close", () => signLanguageButton.setAttribute("aria-expanded", "false"));
  signLanguageDialog.addEventListener("click", (event) => {
    if (event.target === signLanguageDialog) signLanguageDialog.close();
  });
}

// Czat z asystentem (POST /chat) — każde wywołanie tworzy osobną rozmowę z własną historią
const createChat = ({ form, input, log, onStart, onEmpty, endpoint = "/chat" }) => {
  const history = [];
  const submitButton = form.querySelector("button[type=submit]");

  const append = (role, text, sources = []) => {
    const bubble = document.createElement("div");
    bubble.className = `chat-message chat-message--${role}`;
    const body = document.createElement("p");
    body.textContent = text;
    bubble.append(body);

    if (sources.length) {
      const list = document.createElement("ul");
      list.className = "chat-sources";
      sources.forEach((source) => {
        const item = document.createElement("li");
        const link = document.createElement("a");
        link.href = source.url;
        link.target = "_blank";
        link.rel = "noopener";
        link.textContent = source.tytul || source.url;
        item.append(link);
        list.append(item);
      });
      bubble.append(list);
    }

    log.hidden = false;
    log.append(bubble);
    bubble.scrollIntoView({ behavior: "smooth", block: "nearest" });
    return bubble;
  };

  const send = async (message) => {
    onStart?.();
    append("user", message);
    const pending = append("assistant", "Asystent analizuje Twoją wiadomość…");
    input.value = "";
    submitButton.disabled = true;

    try {
      const response = await fetch(endpoint, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ message, history }),
      });
      const data = await response.json().catch(() => ({}));
      pending.remove();

      if (!response.ok) {
        append("error", data.error || "Asystent jest chwilowo niedostępny. Spróbuj ponownie.");
        return;
      }

      // Linki do projektów pokazujemy jako listę — usuwamy ich tekstową wersję z odpowiedzi
      const answer = data.answer.split("\n\nPowiązane projekty z bazy:")[0];
      append("assistant", answer, data.sources || []);
      history.push({ role: "user", content: message }, { role: "assistant", content: data.answer });
    } catch (error) {
      pending.remove();
      append("error", "Nie udało się połączyć z asystentem. Sprawdź połączenie i spróbuj ponownie.");
    } finally {
      submitButton.disabled = false;
      input.focus();
    }
  };

  form.addEventListener("submit", (event) => {
    event.preventDefault();
    const message = input.value.trim();
    if (!message) {
      onEmpty?.();
      input.focus();
      return;
    }
    send(message);
  });

  return send;
};

const sendProblem = problemForm && createChat({
  form: problemForm,
  input: problemInput,
  log: document.querySelector("#chat-log"),
  onStart: () => (formMessage.textContent = ""),
  onEmpty: () => (formMessage.textContent = "Najpierw opisz problem, który chcesz rozwiązać."),
});

const ideaForm = document.querySelector("#idea-form");
const ideaTitleInput = document.querySelector("#idea-title-input");
const ideaFormMessage = document.querySelector("#idea-form-message");
const assistantPrompt = document.querySelector("#assistant-prompt");
const ideaAssistantForm = document.querySelector("#assistant-form");

const askAssistant = ideaAssistantForm && createChat({
  form: ideaAssistantForm,
  input: document.querySelector("#assistant-input"),
  log: document.querySelector("#assistant-chat-log"),
  onStart: () => (assistantPrompt.hidden = true),
});

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

  const ideas = JSON.parse(localStorage.getItem("rops-proposed-ideas") || "[]");
  ideas.unshift({
    title: ideaTitleInput.value.trim(),
    audience: [...selectedGroups].map((group) => group.value),
    status: "Przyjęty",
    createdAt: new Date().toISOString(),
  });
  localStorage.setItem("rops-proposed-ideas", JSON.stringify(ideas));
  ideaFormMessage.textContent = "Świetnie! Podstawowe informacje zostały zapisane.";
});

assistantPrompt?.addEventListener("click", () => {
  const title = ideaTitleInput.value.trim();
  if (!title) {
    ideaFormMessage.textContent = "Najpierw wpisz tytuł pomysłu — na jego podstawie rozpoczniemy wyszukiwanie.";
    ideaTitleInput.focus();
    return;
  }

  const groups = [...ideaForm.querySelectorAll('input[name="audience"]:checked')].map((item) => item.nextElementSibling.textContent);
  const audience = groups.length ? ` (dla: ${groups.join(", ")})` : "";
  askAssistant(`Mam pomysł: „${title}”${audience}. Czy podobny projekt już istnieje?`);
});

const savedTheme = localStorage.getItem("site-theme");
if (["default", "orange", "dark"].includes(savedTheme)) {
  if (savedTheme !== "default") root.dataset.theme = savedTheme;
  document.querySelectorAll("[data-theme]").forEach((item) => {
    const isActive = item.dataset.theme === savedTheme;
    item.classList.toggle("is-active", isActive);
    item.setAttribute("aria-pressed", String(isActive));
  });
} else if (savedTheme) {
  localStorage.removeItem("site-theme");
}

const savedFontSize = localStorage.getItem("font-size");
if (savedFontSize) {
  const scales = { normal: "1", large: "1.1", largest: "1.2" };
  root.style.setProperty("--font-scale", scales[savedFontSize] || "1");
}

const problemFromUrl = new URLSearchParams(window.location.search).get("problem");
if (problemFromUrl && sendProblem) {
  sendProblem(problemFromUrl);
}

const countySelect = document.querySelector("#county-select");
const countyName = document.querySelector("#county-name");
const countyChart = document.querySelector("#county-chart");
const countyData = {
  krakowski: { name: "Powiat Krakowski", values: [19, 14, 15] },
  wielicki: { name: "Powiat Wielicki", values: [13, 18, 10] },
  tatrzanski: { name: "Powiat Tatrzański", values: [11, 9, 17] },
};

countySelect?.addEventListener("change", () => {
  const selectedCounty = countyData[countySelect.value];
  if (!selectedCounty || !countyChart || !countyName) return;

  countyName.textContent = selectedCounty.name;
  const maximum = Math.max(...selectedCounty.values);
  countyChart.querySelectorAll("li").forEach((item, index) => {
    const value = selectedCounty.values[index];
    item.querySelector("strong").textContent = value;
    item.querySelector(".chart-bar").style.setProperty("--bar-width", `${Math.round((value / maximum) * 92)}%`);
  });
});

const ideasListView = document.querySelector("#ideas-list-view");
const ideaDetailView = document.querySelector("#idea-detail-view");
let activeIdeaRow = null;
let lastIdeaPreviewButton = null;
let moderationStatuses = {};

try {
  moderationStatuses = JSON.parse(localStorage.getItem("rops-idea-moderation") || "{}");
} catch {
  moderationStatuses = {};
}

const decisionLabels = {
  approved: "Zatwierdzone",
  pending: "Oczekuje na decyzję",
  rejected: "Odrzucone",
};

const setIdeaStatus = (row, status) => {
  const statusElement = row.querySelector("[data-idea-status]");
  const resolvedStatus = decisionLabels[status] ? status : "pending";
  statusElement.dataset.ideaStatus = resolvedStatus;
  statusElement.className = `idea-status idea-status--${resolvedStatus}`;
  statusElement.textContent = decisionLabels[resolvedStatus];
  row.dataset.status = resolvedStatus;
};

document.querySelectorAll(".ideas-table tbody tr[data-idea-id]").forEach((row) => {
  const savedStatus = moderationStatuses[row.dataset.ideaId];
  if (savedStatus) setIdeaStatus(row, savedStatus);
});

document.querySelectorAll(".idea-preview-button").forEach((button) => {
  button.addEventListener("click", () => {
    const row = button.closest("tr[data-idea-id]");
    if (!row || !ideasListView || !ideaDetailView) return;
    activeIdeaRow = row;
    lastIdeaPreviewButton = button;
    document.querySelector("#idea-detail-title").textContent = row.dataset.title;
    document.querySelector("#idea-detail-author").textContent = row.dataset.author;
    document.querySelector("#idea-detail-date").textContent = new Intl.DateTimeFormat(window.siteLocale || "pl-PL", { dateStyle: "long" }).format(new Date(`${row.dataset.date}T12:00:00`));
    document.querySelector("#idea-detail-municipality").textContent = row.dataset.municipality;
    document.querySelector("#idea-detail-category").textContent = row.dataset.category;
    document.querySelector("#idea-detail-description").textContent = row.dataset.description;
    const contactLink = document.querySelector("#idea-contact-author");
    const contactSubject = `Kontakt w sprawie pomysłu: ${row.dataset.title}`;
    if (row.dataset.email && !row.dataset.email.endsWith("@example.org")) {
      contactLink.href = `mailto:${encodeURIComponent(row.dataset.email)}?subject=${encodeURIComponent(contactSubject)}`;
      contactLink.textContent = "Skontaktuj się z autorem";
    } else {
      const message = `Proszę o przekazanie prośby o kontakt autorowi ${row.dataset.author} w sprawie pomysłu „${row.dataset.title}” z gminy ${row.dataset.municipality}.`;
      contactLink.href = `mailto:biuro@rops.krakow.pl?subject=${encodeURIComponent(contactSubject)}&body=${encodeURIComponent(message)}`;
      contactLink.textContent = "Poproś ROPS o kontakt z autorem";
    }
    const status = row.querySelector("[data-idea-status]");
    const statusLabel = document.querySelector("#idea-detail-status");
    statusLabel.className = `idea-detail-status idea-status--${status.dataset.ideaStatus}`;
    statusLabel.textContent = status.textContent;
    document.querySelector("#idea-detail-feedback").textContent = "";
    ideasListView.hidden = true;
    ideaDetailView.hidden = false;
    window.scrollTo(0, 0);
    document.querySelector("#idea-detail-title").focus();
  });
});

document.querySelector("#idea-back-to-list")?.addEventListener("click", () => {
  if (!ideasListView || !ideaDetailView) return;
  ideaDetailView.hidden = true;
  ideasListView.hidden = false;
  lastIdeaPreviewButton?.focus();
});

const saveIdeaDecision = (status) => {
  if (!activeIdeaRow) return;
  setIdeaStatus(activeIdeaRow, status);
  moderationStatuses[activeIdeaRow.dataset.ideaId] = status;
  localStorage.setItem("rops-idea-moderation", JSON.stringify(moderationStatuses));
  const detailStatus = document.querySelector("#idea-detail-status");
  detailStatus.className = `idea-detail-status idea-status--${status}`;
  detailStatus.textContent = decisionLabels[status];
  document.querySelector("#idea-detail-feedback").textContent = `Status pomysłu zmieniono na: ${decisionLabels[status]}.`;
};

document.querySelector("#idea-approve")?.addEventListener("click", () => saveIdeaDecision("approved"));
document.querySelector("#idea-reject")?.addEventListener("click", () => saveIdeaDecision("rejected"));

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
    forumFilters.forEach((filter) => {
      const isActive = filter === button;
      filter.classList.toggle("is-active", isActive);
      filter.setAttribute("aria-pressed", String(isActive));
    });
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
