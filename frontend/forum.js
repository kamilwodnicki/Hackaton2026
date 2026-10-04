const directMessagesKey = "rops-direct-messages";
const sessionKey = "rops-auth-session";
const chatDialog = document.querySelector("#mentor-chat-dialog");
const chatForm = document.querySelector("#mentor-chat-form");
const chatInput = document.querySelector("#mentor-chat-message");
const chatHistory = document.querySelector("#mentor-chat-history");
const chatStatus = document.querySelector("#mentor-chat-status");
const chatCounter = document.querySelector("#mentor-chat-counter");
let activeMentor = null;

const readForumJson = (key, fallback) => {
  try { return JSON.parse(localStorage.getItem(key)) ?? fallback; } catch { return fallback; }
};

const currentForumUser = () => readForumJson(sessionKey, null);
const currentForumEmail = () => String(currentForumUser()?.email || "").trim().toLowerCase();
const readDirectMessages = () => {
  const value = readForumJson(directMessagesKey, []);
  return Array.isArray(value) ? value : [];
};

const formatChatTime = (value) => new Intl.DateTimeFormat(window.siteLocale || "pl-PL", {
  day: "2-digit", month: "2-digit", hour: "2-digit", minute: "2-digit",
}).format(new Date(value));

const renderMentorChat = () => {
  const messages = readDirectMessages().filter((message) =>
    message.ownerEmail === currentForumEmail() && message.mentorId === activeMentor.id
  );
  chatHistory.replaceChildren();
  if (!messages.length) {
    const empty = document.createElement("p");
    empty.className = "mentor-chat-empty";
    empty.textContent = "To początek rozmowy. Napisz, w czym mentor może Ci pomóc.";
    chatHistory.append(empty);
    return;
  }
  messages.forEach((message) => {
    const article = document.createElement("article");
    article.className = `mentor-chat-message mentor-chat-message--${message.sender === "mentor" ? "mentor" : "user"}`;
    const author = document.createElement("strong");
    author.textContent = message.sender === "mentor" ? activeMentor.name : "Ty";
    const body = document.createElement("p");
    body.textContent = message.text;
    const time = document.createElement("time");
    time.dateTime = message.createdAt;
    time.textContent = formatChatTime(message.createdAt);
    article.append(author, body, time);
    chatHistory.append(article);
  });
  chatHistory.scrollTop = chatHistory.scrollHeight;
};

const openMentorChat = (button) => {
  if (!currentForumUser()) {
    location.href = `login.html?reason=login-required&redirect=${encodeURIComponent(`forum.html?mentor=${button.dataset.mentorId}`)}`;
    return;
  }
  activeMentor = {
    id: button.dataset.mentorId,
    name: button.dataset.mentorName,
    specialization: button.dataset.mentorSpecialization,
  };
  document.querySelector("#mentor-chat-title").textContent = activeMentor.name;
  document.querySelector("#mentor-chat-specialization").textContent = `Specjalizacja: ${activeMentor.specialization}`;
  chatStatus.textContent = "";
  chatInput.value = "";
  chatCounter.textContent = "0";
  renderMentorChat();
  chatDialog.showModal();
  chatInput.focus();
};

document.querySelectorAll("[data-mentor-chat]").forEach((button) => {
  button.addEventListener("click", () => openMentorChat(button));
});

document.querySelector("#mentor-chat-close")?.addEventListener("click", () => chatDialog.close());
chatDialog?.addEventListener("click", (event) => {
  if (event.target === chatDialog) chatDialog.close();
});
chatInput?.addEventListener("input", () => { chatCounter.textContent = String(chatInput.value.length); });

chatForm?.addEventListener("submit", (event) => {
  event.preventDefault();
  const text = chatInput.value.trim();
  if (!activeMentor || !text || text.length > 1000) return;
  const messages = readDirectMessages();
  messages.push({
    id: crypto.randomUUID?.() || `message-${Date.now()}`,
    ownerEmail: currentForumEmail(),
    mentorId: activeMentor.id,
    mentorName: activeMentor.name,
    specialization: activeMentor.specialization,
    sender: "user",
    text,
    createdAt: new Date().toISOString(),
    read: true,
  });
  localStorage.setItem(directMessagesKey, JSON.stringify(messages));
  chatInput.value = "";
  chatCounter.textContent = "0";
  chatStatus.textContent = "Wiadomość została wysłana i zapisana w Twojej poczcie.";
  renderMentorChat();
});

const requestedMentor = new URLSearchParams(location.search).get("mentor");
if (requestedMentor && currentForumUser()) {
  document.querySelector(`[data-mentor-chat][data-mentor-id="${CSS.escape(requestedMentor)}"]`)?.click();
}
