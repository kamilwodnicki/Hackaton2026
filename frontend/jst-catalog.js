// Warstwa danych demonstracyjnych. Po podłączeniu bazy zastąp tablicę wynikiem API,
// pozostawiając ten sam kształt obiektu: id, title, category, county, submittedAt,
// description, implementation i audience.
const jstSolutions = [
  { id: 1, title: "Sąsiedzki system usług opiekuńczych", category: "Pomoc społeczna", county: "krakowski", submittedAt: "2026-09-18", audience: "Seniorzy i opiekunowie", description: "Model koordynacji lokalnych usług sąsiedzkich i wolontariatu dla osób wymagających codziennego wsparcia.", implementation: "Pilotaż w dwóch gminach, lokalny koordynator i prosty formularz zgłoszeń." },
  { id: 2, title: "Mobilny punkt konsultacji dla młodzieży", category: "Zdrowie", county: "tarnowski", submittedAt: "2026-08-07", audience: "Młodzież", description: "Mobilne dyżury psychologa i pedagoga docierające do mniejszych miejscowości.", implementation: "Partnerstwo powiatu, szkół i organizacji społecznej; harmonogram objazdowy." },
  { id: 3, title: "Gminna biblioteka rzeczy", category: "Środowisko", county: "wielicki", submittedAt: "2026-06-21", audience: "Mieszkańcy", description: "System bezpłatnego wypożyczania rzadko używanych narzędzi i sprzętu domowego.", implementation: "Punkt przy bibliotece, regulamin wypożyczeń oraz katalog internetowy." },
  { id: 4, title: "Asystent dostępności wydarzeń lokalnych", category: "Dostępność", county: "nowosadecki", submittedAt: "2026-05-12", audience: "Osoby ze szczególnymi potrzebami", description: "Standard opisu dostępności wydarzeń i możliwość wcześniejszego zgłoszenia potrzeb uczestnika.", implementation: "Wspólny formularz dla instytucji kultury i przeszkolony koordynator dostępności." },
  { id: 5, title: "Klub kompetencji cyfrowych 60+", category: "Edukacja", county: "olkuski", submittedAt: "2026-03-03", audience: "Seniorzy", description: "Regularne warsztaty obsługi usług publicznych, bankowości i bezpieczeństwa cyfrowego.", implementation: "Małe grupy, lokal w bibliotece oraz wsparcie wolontariuszy międzypokoleniowych." },
];

const list = document.querySelector("#jst-solution-list");
const empty = document.querySelector("#jst-empty");
const count = document.querySelector("#jst-result-count");
const form = document.querySelector("#jst-filters");
const reset = document.querySelector("#jst-reset-filters");

const formatDate = (value) => new Intl.DateTimeFormat("pl-PL", { dateStyle: "long" }).format(new Date(`${value}T12:00:00`));

const render = () => {
  const data = Object.fromEntries(new FormData(form).entries());
  const query = data.query.trim().toLocaleLowerCase("pl");
  const results = jstSolutions.filter((solution) => {
    const searchable = `${solution.title} ${solution.description} ${solution.implementation} ${solution.audience}`.toLocaleLowerCase("pl");
    return (!query || searchable.includes(query)) &&
      (!data.category || solution.category === data.category) &&
      (!data.county || solution.county === data.county) &&
      (!data.date_from || solution.submittedAt >= data.date_from) &&
      (!data.date_to || solution.submittedAt <= data.date_to);
  });

  list.replaceChildren();
  results.forEach((solution) => {
    const article = document.createElement("article");
    article.className = "jst-solution-card";
    const top = document.createElement("div");
    top.className = "jst-solution-top";
    const category = document.createElement("span");
    category.textContent = solution.category;
    const date = document.createElement("time");
    date.dateTime = solution.submittedAt;
    date.textContent = formatDate(solution.submittedAt);
    top.append(category, date);
    const title = document.createElement("h3");
    title.textContent = solution.title;
    const description = document.createElement("p");
    description.textContent = solution.description;
    const facts = document.createElement("dl");
    [["Powiat", solution.county], ["Odbiorcy", solution.audience]].forEach(([label, value]) => {
      const fact = document.createElement("div");
      const term = document.createElement("dt");
      const detail = document.createElement("dd");
      term.textContent = label;
      detail.textContent = value;
      fact.append(term, detail);
      facts.append(fact);
    });
    const details = document.createElement("details");
    const summary = document.createElement("summary");
    summary.textContent = "Jak wdrożyć rozwiązanie";
    const implementation = document.createElement("p");
    implementation.textContent = solution.implementation;
    details.append(summary, implementation);
    article.append(top, title, description, facts, details);
    list.append(article);
  });
  count.textContent = `${results.length} ${results.length === 1 ? "rozwiązanie" : "rozwiązań"}`;
  empty.hidden = results.length > 0;
};

form.addEventListener("input", render);
form.addEventListener("change", render);
form.addEventListener("submit", (event) => { event.preventDefault(); render(); });
reset.addEventListener("click", () => { form.reset(); render(); });
render();
