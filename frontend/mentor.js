const submittedIdeasKey = "rops-proposed-ideas";
const profileKey = "rops-account-profile";
const mentorFeedbackKey = "rops-mentor-feedback";
const numberFormat = new Intl.NumberFormat("pl-PL");

const sampleIdeas = [
  {
    id: "mentor-senior-circle",
    title: "Sąsiedzki punkt wsparcia dla opiekunów",
    author: "Koło Sąsiedzkie Nadzieja",
    email: "",
    city: "Tarnów",
    date: "2026-09-28T12:00:00.000Z",
    category: "Seniorzy i opiekunowie",
    description: "Dyżury wolontariuszy, którzy pomagają opiekunom osób starszych w codziennych sprawach i organizują krótkie zastępstwa wytchnieniowe.",
  },
  {
    id: "mentor-youth-workshop",
    title: "Warsztaty kompetencji cyfrowych dla młodzieży",
    author: "Fundacja Rozwój Lokalny",
    email: "",
    city: "Bochnia",
    date: "2026-09-25T12:00:00.000Z",
    category: "Młodzież i edukacja",
    description: "Cykl spotkań prowadzonych przez lokalnych wolontariuszy. Młodzi mieszkańcy uczą się bezpiecznego korzystania z usług cyfrowych i tworzą materiały dla sąsiadów.",
  },
  {
    id: "mentor-accessible-culture",
    title: "Dostępne wydarzenia kulturalne w gminie",
    author: "Stowarzyszenie Otwarta Przestrzeń",
    email: "",
    city: "Nowy Sącz",
    date: "2026-09-21T12:00:00.000Z",
    category: "Dostępność i kultura",
    description: "Prosty standard organizacji lokalnych wydarzeń obejmujący informacje o dostępności miejsca, możliwość zgłoszenia potrzeb i wsparcie wolontariuszy.",
  },
];

const mentorForumThreads = [
  { id: "idea-community-garden", title: "Czy ogród społeczny może działać przy domu kultury?", category: "pomysly", categoryLabel: "Pomysły", author: "Marta, Kraków", replies: 5, activity: "12 min temu" },
  { id: "idea-care-sharing", title: "Jak zorganizować sąsiedzką wymianę opieki?", category: "pomysly", categoryLabel: "Pomysły", author: "Stowarzyszenie Razem", replies: 8, activity: "35 min temu" },
  { id: "senior-club", title: "Lokal dla gminnego klubu seniora", category: "seniorzy", categoryLabel: "Seniorzy", author: "Koło Seniorów", replies: 14, activity: "1 godz. temu" },
  { id: "wcag-support", title: "Szukamy partnera do audytu dostępności strony", category: "wcag", categoryLabel: "Dostępność", author: "Fundacja Widok", replies: 6, activity: "wczoraj" },
  { id: "jst-grants", title: "Jak przygotować się do rozmowy z gminą o grancie?", category: "jst", categoryLabel: "JST", author: "Piotr, innowator", replies: 3, activity: "wczoraj" },
];

const readArray = (key) => {
  try {
    const parsed = JSON.parse(localStorage.getItem(key) || "[]");
    return Array.isArray(parsed) ? parsed : [];
  } catch {
    return [];
  }
};

const readObject = (key) => {
  try {
    const parsed = JSON.parse(localStorage.getItem(key) || "{}");
    return parsed && typeof parsed === "object" && !Array.isArray(parsed) ? parsed : {};
  } catch {
    return {};
  }
};

const profile = readObject(profileKey);
const visitorIdeas = readArray(submittedIdeasKey).map((idea, index) => ({
  id: `visitor-${idea.createdAt || index}-${index}`,
  title: idea.title || "Pomysł mieszkańca",
  author: profile.name || "Mieszkaniec Małopolski",
  email: profile.email || "",
  city: profile.city || "Małopolska",
  date: idea.createdAt || new Date().toISOString(),
  category: (idea.audience || []).map((audience) => ({
    seniorzy: "Seniorzy",
    rodzice: "Rodzice i opiekunowie",
    szkoly: "Edukacja",
    mlodziez: "Dzieci i młodzież",
    niepelnosprawnosci: "Dostępność",
    mieszkancy: "Mieszkańcy",
  }[audience] || audience)).join(", ") || "Pomysł społeczny",
  description: "Szczegóły tego zgłoszenia są dostępne w formularzu mieszkańca. Skontaktuj się z autorem, aby doprecyzować założenia.",
}));
const ideas = [...visitorIdeas, ...sampleIdeas];
let feedbackByIdea = readObject(mentorFeedbackKey);
let selectedIdea = null;
let activeIdeaFilter = "all";
let activeMentorForumFilter = "all";

const ideaList = document.querySelector("#mentor-idea-list");
const ideaEmpty = document.querySelector("#mentor-ideas-empty");
const ideaSearch = document.querySelector("#mentor-idea-search");
const ideaControls = document.querySelector(".mentor-idea-controls");
const ideaDetail = document.querySelector("#mentor-idea-detail");
const forumList = document.querySelector("#mentor-forum-list");
const mentorForumSearch = document.querySelector("#mentor-forum-search");
const mentorForumEmpty = document.querySelector("#mentor-forum-empty");
const normalizeMentorText = (value) => value.toLocaleLowerCase("pl").normalize("NFD").replace(/[\u0300-\u036f]/g, "");
const dateLabel = (value) => new Intl.DateTimeFormat("pl-PL", { day: "numeric", month: "long", year: "numeric" }).format(new Date(value));

const renderMentorStats = () => {
  const reviewedCount = Object.values(feedbackByIdea).reduce((total, entries) => total + (Array.isArray(entries) ? entries.length : 0), 0);
  document.querySelector("#mentor-pending-count").textContent = numberFormat.format(ideas.filter((idea) => !(feedbackByIdea[idea.id] || []).length).length);
  document.querySelector("#mentor-feedback-count").textContent = numberFormat.format(reviewedCount);
  document.querySelector("#mentor-idea-thread-count").textContent = numberFormat.format(mentorForumThreads.filter((thread) => thread.category === "pomysly").length);
  document.querySelector("#mentor-ideas-total").textContent = `${numberFormat.format(ideas.length)} ${ideas.length === 1 ? "pomysł" : ideas.length >= 2 && ideas.length <= 4 ? "pomysły" : "pomysłów"}`;
};

const renderIdeas = () => {
  if (!ideaList) return;
  const query = normalizeMentorText(ideaSearch?.value.trim() || "");
  const filtered = ideas.filter((idea) => {
    const hasFeedback = Boolean(feedbackByIdea[idea.id]?.length);
    const matchesFilter = activeIdeaFilter === "all" || (activeIdeaFilter === "needs-feedback" ? !hasFeedback : hasFeedback);
    const matchesQuery = !query || normalizeMentorText(`${idea.title} ${idea.author} ${idea.category} ${idea.city}`).includes(query);
    return matchesFilter && matchesQuery;
  });
  ideaList.replaceChildren();
  filtered.forEach((idea) => {
    const card = document.createElement("button");
    card.type = "button";
    card.className = "mentor-idea-card";
    card.dataset.ideaId = idea.id;
    const content = document.createElement("span");
    content.className = "mentor-idea-card-content";
    const category = document.createElement("span");
    category.className = "mentor-idea-category";
    category.textContent = idea.category;
    const title = document.createElement("strong");
    title.className = "mentor-idea-title";
    title.textContent = idea.title;
    const author = document.createElement("span");
    author.className = "mentor-idea-author";
    author.textContent = `${idea.author} · ${idea.city}`;
    const status = document.createElement("span");
    status.className = `mentor-idea-status${feedbackByIdea[idea.id]?.length ? " is-reviewed" : ""}`;
    status.textContent = feedbackByIdea[idea.id]?.length ? "Feedback dodany" : "Do opinii";
    content.append(category, title, author);
    card.append(content, status);
    card.addEventListener("click", () => openIdea(idea));
    ideaList.append(card);
  });
  if (ideaEmpty) ideaEmpty.hidden = filtered.length !== 0;
};

const renderForum = () => {
  if (!forumList) return;
  const query = normalizeMentorText(mentorForumSearch?.value.trim() || "");
  const filtered = mentorForumThreads.filter((thread) => {
    const matchesFilter = activeMentorForumFilter === "all" || thread.category === activeMentorForumFilter;
    const matchesQuery = !query || normalizeMentorText(`${thread.title} ${thread.author} ${thread.categoryLabel}`).includes(query);
    return matchesFilter && matchesQuery;
  });
  forumList.replaceChildren();
  filtered.forEach((thread) => {
    const item = document.createElement("a");
    item.className = "mentor-forum-item";
    item.href = "forum.html";
    const category = document.createElement("span");
    category.className = "mentor-forum-category";
    category.textContent = thread.categoryLabel;
    const title = document.createElement("strong");
    title.textContent = thread.title;
    const meta = document.createElement("span");
    meta.className = "mentor-forum-meta";
    meta.textContent = `${thread.author} · ${thread.replies} odp. · ${thread.activity}`;
    item.append(category, title, meta);
    forumList.append(item);
  });
  if (mentorForumEmpty) mentorForumEmpty.hidden = filtered.length !== 0;
};

const renderFeedbackHistory = (idea) => {
  const feedbackList = document.querySelector("#mentor-feedback-list");
  const empty = document.querySelector("#mentor-no-feedback");
  feedbackList.replaceChildren();
  const entries = feedbackByIdea[idea.id] || [];
  entries.forEach((entry) => {
    const article = document.createElement("article");
    article.className = "mentor-feedback-entry";
    const body = document.createElement("p");
    body.textContent = entry.message;
    const date = document.createElement("time");
    date.dateTime = entry.createdAt;
    date.textContent = `Mentor · ${dateLabel(entry.createdAt)}`;
    article.append(body, date);
    feedbackList.append(article);
  });
  empty.hidden = entries.length > 0;
};

const openIdea = (idea) => {
  selectedIdea = idea;
  document.querySelector("#mentor-detail-title").textContent = idea.title;
  document.querySelector("#mentor-detail-author").textContent = idea.author;
  document.querySelector("#mentor-detail-city").textContent = idea.city;
  document.querySelector("#mentor-detail-date").textContent = dateLabel(idea.date);
  document.querySelector("#mentor-detail-category").textContent = idea.category;
  document.querySelector("#mentor-detail-description").textContent = idea.description;
  document.querySelector("#mentor-detail-status").textContent = feedbackByIdea[idea.id]?.length ? "Feedback dodany" : "Oczekuje na feedback";
  const contact = document.querySelector("#mentor-contact-author");
  const subject = `Informacja o pomyśle: ${idea.title}`;
  if (idea.email && !idea.email.endsWith("@example.org")) {
    contact.href = `mailto:${encodeURIComponent(idea.email)}?subject=${encodeURIComponent(subject)}`;
    contact.textContent = "Napisz do autora";
  } else {
    const body = `Proszę o przekazanie autorowi ${idea.author} wiadomości w sprawie pomysłu „${idea.title}”.`;
    contact.href = `mailto:biuro@rops.krakow.pl?subject=${encodeURIComponent(subject)}&body=${encodeURIComponent(body)}`;
    contact.textContent = "Poproś ROPS o kontakt z autorem";
  }
  renderFeedbackHistory(idea);
  document.querySelector("#mentor-feedback-input").value = "";
  document.querySelector("#mentor-feedback-message").textContent = "";
  ideaControls.hidden = true;
  ideaList.hidden = true;
  ideaEmpty.hidden = true;
  ideaDetail.hidden = false;
  window.scrollTo(0, 0);
  document.querySelector("#mentor-detail-title").focus();
};

const ideaFilters = document.querySelectorAll("[data-idea-filter]");
ideaFilters.forEach((button) => button.addEventListener("click", () => {
  activeIdeaFilter = button.dataset.ideaFilter;
  ideaFilters.forEach((item) => {
    const active = item === button;
    item.classList.toggle("is-active", active);
    item.setAttribute("aria-pressed", String(active));
  });
  renderIdeas();
}));
ideaSearch?.addEventListener("input", renderIdeas);

document.querySelector("#mentor-back-to-ideas")?.addEventListener("click", () => {
  ideaDetail.hidden = true;
  ideaControls.hidden = false;
  ideaList.hidden = false;
  renderIdeas();
  renderMentorStats();
  document.querySelector(".mentor-idea-card")?.focus();
});

document.querySelector("#mentor-feedback-form")?.addEventListener("submit", (event) => {
  event.preventDefault();
  if (!selectedIdea) return;
  const input = document.querySelector("#mentor-feedback-input");
  const message = input.value.trim();
  if (!message) {
    input.focus();
    return;
  }
  const entries = feedbackByIdea[selectedIdea.id] || [];
  entries.push({ message, createdAt: new Date().toISOString() });
  feedbackByIdea[selectedIdea.id] = entries;
  localStorage.setItem(mentorFeedbackKey, JSON.stringify(feedbackByIdea));
  input.value = "";
  document.querySelector("#mentor-feedback-message").textContent = "Feedback został zapisany.";
  document.querySelector("#mentor-detail-status").textContent = "Feedback dodany";
  renderFeedbackHistory(selectedIdea);
  renderMentorStats();
});

const mentorForumFilters = document.querySelectorAll("[data-forum-filter]");
mentorForumFilters.forEach((button) => button.addEventListener("click", () => {
  activeMentorForumFilter = button.dataset.forumFilter;
  mentorForumFilters.forEach((item) => {
    const active = item === button;
    item.classList.toggle("is-active", active);
    item.setAttribute("aria-pressed", String(active));
  });
  renderForum();
}));
mentorForumSearch?.addEventListener("input", renderForum);

renderIdeas();
renderForum();
renderMentorStats();
