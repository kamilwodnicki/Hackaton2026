const resourceKey = "rops-resource-catalog";
const defaultResources = [
  { id: "social-canvas", title: "Social Innovation Canvas", category: "Narzędzia", description: "Przewodnik pomagający opisać problem społeczny, odbiorców, partnerów i oczekiwany wpływ innowacji.", type: "Poradnik", url: "#", fileName: "social-innovation-canvas.pdf" },
  { id: "funding-guide", title: "Finansowanie innowacji społecznych", category: "Finansowanie", description: "Zestawienie podstawowych źródeł finansowania, grantów i programów wsparcia dla innowatorów.", type: "Opracowanie", url: "#", fileName: "finansowanie-innowacji.pdf" },
  { id: "wcag-checklist", title: "Lista kontrolna dostępności WCAG", category: "Dostępność", description: "Krótka lista kontrolna do wstępnej oceny dostępności cyfrowej projektu lub usługi.", type: "Lista kontrolna", url: "#", fileName: "wcag-checklista.pdf" },
];

const readResources = () => {
  try {
    const stored = JSON.parse(localStorage.getItem(resourceKey) || "null");
    return Array.isArray(stored) ? stored : defaultResources;
  } catch {
    return defaultResources;
  }
};

let resources = readResources();
// Innowacje z Directusa trzymamy osobno — nie mogą trafić do localStorage razem z materiałami ROPS
let directusResources = [];
const allResources = () => [...directusResources, ...resources];
const list = document.querySelector("#resource-list");
const empty = document.querySelector("#resource-empty");
const search = document.querySelector("#resource-search");
const categoryFilter = document.querySelector("#resource-category-filter");
const addPanel = document.querySelector("#resource-admin-panel");
const addForm = document.querySelector("#resource-form");
const addMessage = document.querySelector("#resource-form-message");

// Link z Asystenta Zasobnika (?q=tytuł) otwiera Zasobnik z wpisanym wyszukiwaniem
const initialQuery = new URLSearchParams(location.search).get("q");
if (initialQuery) search.value = initialQuery;

const session = (() => {
  try { return JSON.parse(localStorage.getItem("rops-auth-session") || "null"); } catch { return null; }
})();
const roles = Array.isArray(session?.roles) ? session.roles : [session?.role].filter(Boolean);
if (roles.includes("rops")) addPanel.hidden = false;

const renderResources = () => {
  const query = search.value.trim().toLocaleLowerCase("pl");
  const category = categoryFilter.value;
  const visible = allResources().filter((resource) => {
    const content = `${resource.title} ${resource.description} ${resource.category} ${resource.type}`.toLocaleLowerCase("pl");
    return (!query || content.includes(query)) && (!category || resource.category === category);
  });
  list.replaceChildren();
  visible.forEach((resource) => {
    const article = document.createElement("article");
    article.className = "resource-item";
    const heading = document.createElement("div");
    heading.className = "resource-item-heading";
    const text = document.createElement("div");
    const badge = document.createElement("span");
    badge.className = "resource-badge";
    badge.textContent = resource.category;
    const title = document.createElement("h2");
    title.textContent = resource.title;
    text.append(badge);
    if (resource.thumbnail) {
      const thumbnail = document.createElement("img");
      thumbnail.className = "resource-thumbnail";
      thumbnail.src = resource.thumbnail;
      thumbnail.alt = "";
      thumbnail.loading = "lazy";
      text.append(thumbnail);
    }
    text.append(title);
    const toggle = document.createElement("button");
    toggle.type = "button";
    toggle.textContent = "Rozwiń";
    toggle.setAttribute("aria-expanded", "false");
    heading.append(text, toggle);
    const details = document.createElement("div");
    details.className = "resource-item-details";
    details.hidden = true;
    const description = document.createElement("p");
    description.textContent = resource.description;
    const meta = document.createElement("p");
    meta.className = "resource-meta";
    if (resource.files) {
      meta.textContent = `${resource.type} · Dostępne dokumenty: ${resource.files.length}`;
      const files = document.createElement("ul");
      files.className = "resource-files";
      resource.files.forEach((file) => {
        const item = document.createElement("li");
        const link = document.createElement("a");
        link.href = file.url;
        link.target = "_blank";
        link.rel = "noopener";
        link.textContent = file.name;
        item.append(link);
        files.append(item);
      });
      details.append(description, meta, files);
    } else {
      meta.textContent = `${resource.type}${resource.fileName ? ` · ${resource.fileName}` : ""}`;
      const link = document.createElement("a");
      link.href = resource.url || "#";
      link.textContent = resource.url && resource.url !== "#" ? "Otwórz materiał" : "Plik będzie dostępny po podłączeniu magazynu dokumentów";
      if (!resource.url || resource.url === "#") link.setAttribute("aria-disabled", "true");
      details.append(description, meta, link);
    }
    toggle.addEventListener("click", () => {
      const open = toggle.getAttribute("aria-expanded") === "true";
      toggle.setAttribute("aria-expanded", String(!open));
      toggle.textContent = open ? "Rozwiń" : "Zwiń";
      details.hidden = open;
    });
    article.append(heading, details);
    list.append(article);
  });
  empty.hidden = visible.length > 0;
};

search.addEventListener("input", renderResources);
categoryFilter.addEventListener("change", renderResources);
renderResources();

fetch("/api/innowacje")
  .then((response) => (response.ok ? response.json() : { items: [] }))
  .then((data) => {
    directusResources = data.items.map((item) => ({
      id: `innowacja-${item.id}`,
      title: item.title,
      category: "Innowacje",
      description: item.description,
      type: "Innowacja społeczna",
      thumbnail: item.thumbnail,
      files: item.files,
    }));
    renderResources();
  })
  .catch(() => {}); // bez Directusa zasobnik pokazuje same lokalne materiały

addForm?.addEventListener("submit", (event) => {
  event.preventDefault();
  if (!roles.includes("rops")) return;
  if (!addForm.reportValidity()) return;
  const data = Object.fromEntries(new FormData(addForm).entries());
  const file = addForm.elements.file.files[0];
  if (file && file.size > 10 * 1024 * 1024) {
    addMessage.textContent = "Plik może mieć maksymalnie 10 MB.";
    return;
  }
  let safeUrl = "";
  if (data.url.trim()) {
    try {
      const parsedUrl = new URL(data.url.trim());
      if (!["http:", "https:"].includes(parsedUrl.protocol)) throw new Error();
      safeUrl = parsedUrl.href;
    } catch {
      addMessage.textContent = "Link musi być prawidłowym adresem HTTP lub HTTPS.";
      return;
    }
  }
  resources.unshift({ id: crypto.randomUUID?.() || String(Date.now()), title: data.title.trim(), category: data.category, description: data.description.trim(), type: data.type.trim(), url: safeUrl, fileName: file?.name || "" });
  localStorage.setItem(resourceKey, JSON.stringify(resources));
  addForm.reset();
  addMessage.textContent = "Materiał został dodany do katalogu w trybie demonstracyjnym.";
  renderResources();
});
