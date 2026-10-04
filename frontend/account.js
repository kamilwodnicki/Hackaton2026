const ideasKey = "rops-proposed-ideas";
const profileKey = "rops-account-profile";
const feedbackKey = "rops-mentor-feedback";
const readFeedbackKey = "rops-account-read-feedback";
const directMessagesKey = "rops-direct-messages";

const readJson = (key, fallback) => {
  try {
    return JSON.parse(localStorage.getItem(key)) ?? fallback;
  } catch {
    return fallback;
  }
};

const storedIdeas = readJson(ideasKey, []);
const ideas = Array.isArray(storedIdeas) ? storedIdeas : [];
const storedFeedback = readJson(feedbackKey, {});
const mentorFeedback = storedFeedback && typeof storedFeedback === "object" && !Array.isArray(storedFeedback) ? storedFeedback : {};
const storedReadIds = readJson(readFeedbackKey, []);
const readMessageIds = new Set(Array.isArray(storedReadIds) ? storedReadIds : []);
const profile = readJson(profileKey, {});
const accountSession = readJson("rops-auth-session", {});
const ideasList = document.querySelector("#account-ideas-list");
const ideasEmpty = document.querySelector("#account-empty");
const ideaTotal = document.querySelector("#idea-total");
const formatDate = (value) => {
  const date = new Date(value);
  return Number.isNaN(date.valueOf()) ? "Data nieznana" : new Intl.DateTimeFormat(window.siteLocale || "pl-PL", { dateStyle: "medium" }).format(date);
};

if (ideasList) {
  ideasList.replaceChildren();
  ideas.forEach((idea) => {
    const row = document.createElement("tr");
    const title = document.createElement("td");
    title.textContent = idea.title || "Pomysł mieszkańca";
    const statusCell = document.createElement("td");
    const status = document.createElement("span");
    status.className = "account-status account-status--submitted";
    status.textContent = idea.status || "Przyjęty";
    statusCell.append(status);
    row.append(title);

    if (ideasList.closest(".account-ideas-table")?.querySelector("thead th:nth-child(2)")?.textContent === "Data zgłoszenia") {
      const dateCell = document.createElement("td");
      dateCell.textContent = formatDate(idea.createdAt);
      row.append(dateCell);
    }
    row.append(statusCell);
    ideasList.append(row);
  });
  if (ideasEmpty) ideasEmpty.hidden = ideas.length > 0;
  if (ideaTotal) ideaTotal.textContent = `${ideas.length} ${ideas.length === 1 ? "pomysł" : ideas.length >= 2 && ideas.length <= 4 ? "pomysły" : "pomysłów"}`;
}

const profileForm = document.querySelector("#profile-form");
const profileMessage = document.querySelector("#profile-message");
const updateProfileSummary = (currentProfile) => {
  const name = currentProfile.name?.trim() || "Mieszkaniec Małopolski";
  const initials = name.split(/\s+/).slice(0, 2).map((part) => part[0]).join("").toLocaleUpperCase("pl");
  const displayName = document.querySelector("#account-display-name");
  const avatar = document.querySelector("#account-initials");
  const location = document.querySelector("#account-profile-location");
  if (displayName) displayName.textContent = name;
  if (avatar) avatar.textContent = initials;
  if (location) location.textContent = currentProfile.city?.trim() || "Uzupełnij miejscowość w danych profilu";
  const activityIdeas = document.querySelector("#account-activity-ideas");
  if (activityIdeas) activityIdeas.textContent = String(ideas.length);
};

updateProfileSummary(profile);

if (profileForm) {
  for (const [name, value] of Object.entries(profile)) {
    const field = profileForm.elements.namedItem(name);
    if (field) field.value = value;
  }

  profileForm.addEventListener("submit", (event) => {
    event.preventDefault();
    const data = Object.fromEntries(new FormData(profileForm).entries());
    localStorage.setItem(profileKey, JSON.stringify(data));
    updateProfileSummary(data);
    profileMessage.textContent = "Dane konta zostały zapisane.";
  });
}

document.querySelectorAll("[data-account-view]").forEach((tab) => {
  tab.addEventListener("click", () => {
    const viewName = tab.dataset.accountView;
    document.querySelectorAll("[data-account-view]").forEach((item) => {
      const isActive = item === tab;
      item.classList.toggle("is-active", isActive);
      item.setAttribute("aria-pressed", String(isActive));
    });
    document.querySelectorAll("[data-account-view-panel]").forEach((panel) => {
      panel.hidden = panel.dataset.accountViewPanel !== viewName;
    });
  });
});

const messages = [];
ideas.forEach((idea, index) => {
  const ideaId = `visitor-${idea.createdAt || index}-${index}`;
  (Array.isArray(mentorFeedback[ideaId]) ? mentorFeedback[ideaId] : []).forEach((entry, entryIndex) => {
    const id = `${ideaId}:${entry.createdAt || entryIndex}:${entryIndex}`;
    messages.push({
      id,
      ideaTitle: idea.title || "Pomysł mieszkańca",
      sender: entry.sender || "Ekspert / mentor ROPS",
      email: entry.email || "",
      message: entry.message || "Otrzymano nową wiadomość dotyczącą Twojego pomysłu.",
      createdAt: entry.createdAt || idea.createdAt,
      read: readMessageIds.has(id),
    });
  });
});
const directMessages = readJson(directMessagesKey, []);
if (Array.isArray(directMessages)) {
  const accountEmail = String(accountSession.email || profile.email || "").trim().toLowerCase();
  directMessages
    .filter((entry) => entry.ownerEmail === accountEmail)
    .forEach((entry) => messages.push({
      id: entry.id,
      ideaTitle: `Rozmowa z: ${entry.mentorName || "Mentor ROPS"}`,
      sender: entry.sender === "mentor" ? (entry.mentorName || "Mentor ROPS") : "Wiadomość wysłana przez Ciebie",
      message: entry.text,
      createdAt: entry.createdAt,
      read: entry.sender !== "mentor" || readMessageIds.has(entry.id),
      mentorId: entry.mentorId,
    }));
}
messages.sort((first, second) => new Date(second.createdAt) - new Date(first.createdAt));

const messageList = document.querySelector("#account-message-list");
const messagesEmpty = document.querySelector("#account-messages-empty");
const messageDetail = document.querySelector("#account-message-detail");
const setMessageCounters = () => {
  const unread = messages.filter((message) => !message.read).length;
  const unreadActivity = document.querySelector("#account-activity-unread");
  const badge = document.querySelector("#account-unread-badge");
  const total = document.querySelector("#account-message-total");
  if (unreadActivity) unreadActivity.textContent = String(unread);
  if (badge) {
    badge.textContent = String(unread);
    badge.hidden = unread === 0;
  }
  if (total) total.textContent = `${messages.length} ${messages.length === 1 ? "wiadomość" : "wiadomości"}`;
};

const openAccountMessage = (message, button) => {
  message.read = true;
  readMessageIds.add(message.id);
  localStorage.setItem(readFeedbackKey, JSON.stringify([...readMessageIds]));
  document.querySelectorAll(".account-message-item").forEach((item) => {
    item.classList.toggle("is-selected", item === button);
    item.setAttribute("aria-selected", String(item === button));
  });

  messageDetail.hidden = false;
  const article = document.createElement("article");
  article.className = "account-open-message";
  const heading = document.createElement("div");
  heading.className = "account-open-message-heading";
  const sender = document.createElement("strong");
  sender.textContent = message.sender;
  const date = document.createElement("time");
  date.dateTime = message.createdAt;
  date.textContent = formatDate(message.createdAt);
  heading.append(sender, date);
  const title = document.createElement("h3");
  title.textContent = `W sprawie: ${message.ideaTitle}`;
  const body = document.createElement("p");
  body.className = "account-open-message-body";
  body.textContent = message.message;
  const reply = document.createElement("a");
  reply.className = "account-reply-link";
  const subject = `Odpowiedź: ${message.ideaTitle}`;
  if (message.mentorId) {
    reply.href = `forum.html?mentor=${encodeURIComponent(message.mentorId)}`;
    reply.textContent = "Kontynuuj rozmowę";
  } else if (message.email && !message.email.endsWith("@example.org")) {
    reply.href = `mailto:${encodeURIComponent(message.email)}?subject=${encodeURIComponent(subject)}`;
    reply.textContent = "Odpowiedz ekspertowi";
  } else {
    reply.href = `mailto:biuro@rops.krakow.pl?subject=${encodeURIComponent(subject)}`;
    reply.textContent = "Odpowiedz przez ROPS";
  }
  article.append(heading, title, body, reply);
  messageDetail.replaceChildren(article);
  setMessageCounters();
};

if (messageList) {
  messageList.replaceChildren();
  messages.forEach((message) => {
    const button = document.createElement("button");
    button.type = "button";
    button.className = `account-message-item${message.read ? "" : " is-unread"}`;
    button.setAttribute("role", "option");
    button.setAttribute("aria-selected", "false");
    const sender = document.createElement("span");
    sender.className = "account-message-sender";
    sender.textContent = message.sender;
    const date = document.createElement("time");
    date.dateTime = message.createdAt;
    date.textContent = formatDate(message.createdAt);
    const title = document.createElement("strong");
    title.textContent = message.ideaTitle;
    const preview = document.createElement("span");
    preview.className = "account-message-preview";
    preview.textContent = message.message;
    button.append(sender, date, title, preview);
    button.addEventListener("click", () => openAccountMessage(message, button));
    messageList.append(button);
  });
  if (messagesEmpty) messagesEmpty.hidden = messages.length > 0;
  if (messageDetail) messageDetail.hidden = messages.length === 0;
}

setMessageCounters();
