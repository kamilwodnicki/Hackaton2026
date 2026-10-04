const cities = [
  { id: "krakow", name: "Kraków", lat: 50.0647, lon: 19.945, innovations: 62, proposals: 124, problems: 172, categories: [45, 38, 34, 29, 26] },
  { id: "tarnow", name: "Tarnów", lat: 50.0121, lon: 20.9858, innovations: 18, proposals: 45, problems: 58, categories: [15, 13, 11, 10, 9] },
  { id: "nowy-sacz", name: "Nowy Sącz", lat: 49.6218, lon: 20.6971, innovations: 16, proposals: 38, problems: 49, categories: [13, 11, 10, 8, 7] },
  { id: "oswiecim", name: "Oświęcim", lat: 50.0344, lon: 19.2104, innovations: 12, proposals: 29, problems: 37, categories: [10, 8, 7, 6, 6] },
  { id: "zakopane", name: "Zakopane", lat: 49.2992, lon: 19.9496, innovations: 10, proposals: 24, problems: 29, categories: [8, 6, 6, 5, 4] },
  { id: "nowy-targ", name: "Nowy Targ", lat: 49.4774, lon: 20.0323, innovations: 9, proposals: 20, problems: 25, categories: [6, 6, 5, 4, 4] },
  { id: "bochnia", name: "Bochnia", lat: 49.9691, lon: 20.4303, innovations: 8, proposals: 15, problems: 22, categories: [6, 5, 4, 4, 3] },
  { id: "gorlice", name: "Gorlice", lat: 49.6554, lon: 21.1597, innovations: 7, proposals: 10, problems: 18, categories: [5, 4, 3, 4, 2] },
  { id: "wieliczka", name: "Wieliczka", lat: 49.987, lon: 20.064, innovations: 6, proposals: 11, problems: 18, categories: [5, 4, 4, 3, 2] },
];

const issueCategories = [
  "Dostępność usług",
  "Wsparcie seniorów i opiekunów",
  "Zdrowie psychiczne dzieci i młodzieży",
  "Samotność i integracja społeczna",
  "Transport i mobilność",
];
const regionStats = {
  innovations: cities.reduce((sum, city) => sum + city.innovations, 0),
  proposals: cities.reduce((sum, city) => sum + city.proposals, 0),
  problems: cities.reduce((sum, city) => sum + city.problems, 0),
  categories: issueCategories.map((_, index) => cities.reduce((sum, city) => sum + city.categories[index], 0)),
};

const cityList = document.querySelector("#city-list");
const fallback = document.querySelector("#map-fallback");
const mapCanvas = document.querySelector("#needs-map");
const mapFrame = document.querySelector(".needs-map-frame");
const selectedLocation = document.querySelector("#selected-location");
const categoryList = document.querySelector("#category-list");
const numberFormat = new Intl.NumberFormat(window.siteLocale || "pl-PL");
let liveMap;
let mapMarkers = new Map();

const renderCityList = () => {
  const regionButton = document.createElement("button");
  regionButton.type = "button";
  regionButton.className = "city-choice city-choice--all";
  regionButton.dataset.city = "all";
  regionButton.setAttribute("aria-pressed", "true");
  regionButton.innerHTML = "<span>Cała Małopolska</span><strong>148</strong>";
  cityList.append(regionButton);

  cities.forEach((city) => {
    const button = document.createElement("button");
    button.type = "button";
    button.className = "city-choice";
    button.dataset.city = city.id;
    button.setAttribute("aria-pressed", "false");
    button.innerHTML = `<span>${city.name}</span><strong>${numberFormat.format(city.innovations)}</strong>`;
    cityList.append(button);

    const marker = document.createElement("button");
    marker.type = "button";
    marker.className = "fallback-city-marker";
    marker.dataset.city = city.id;
    marker.setAttribute("aria-label", `${city.name}: ${numberFormat.format(city.innovations)} wdrożonych innowacji`);
    marker.style.left = `${((city.lon - 19.08) / (21.7 - 19.08)) * 100}%`;
    marker.style.top = `${((50.58 - city.lat) / (50.58 - 49.15)) * 100}%`;
    marker.innerHTML = `<span>${numberFormat.format(city.innovations)}</span>`;
    fallback.append(marker);
  });
};

const renderCategories = (values) => {
  const total = values.reduce((sum, value) => sum + value, 0);
  const maximum = Math.max(...values, 1);
  categoryList.replaceChildren();
  issueCategories.forEach((category, index) => {
    const item = document.createElement("li");
    const row = document.createElement("div");
    row.className = "category-row";
    const label = document.createElement("span");
    label.textContent = category;
    const count = document.createElement("strong");
    count.textContent = numberFormat.format(values[index]);
    const track = document.createElement("span");
    track.className = "category-track";
    const bar = document.createElement("span");
    bar.className = "category-bar";
    bar.style.width = `${(values[index] / maximum) * 100}%`;
    track.append(bar);
    row.append(label, count);
    item.append(row, track);
    categoryList.append(item);
  });
  document.querySelector("#category-count").textContent = `${numberFormat.format(total)} zgłoszeń`;
};

const updateSelection = (cityId) => {
  const city = cities.find((item) => item.id === cityId);
  const stats = city || regionStats;
  selectedLocation.textContent = city ? city.name : "Cała Małopolska";
  document.querySelector("#innovation-total").textContent = numberFormat.format(stats.innovations);
  document.querySelector("#proposal-total").textContent = numberFormat.format(stats.proposals);
  document.querySelector("#problem-total").textContent = numberFormat.format(stats.problems);
  renderCategories(stats.categories);

  document.querySelectorAll("[data-city]").forEach((button) => {
    const isActive = button.dataset.city === cityId;
    button.classList.toggle("is-active", isActive);
    button.setAttribute("aria-pressed", String(isActive));
  });

  mapMarkers.forEach((marker, id) => marker.getElement()?.classList.toggle("is-active", id === cityId));
  if (liveMap) {
    if (city) liveMap.flyTo([city.lat, city.lon], Math.max(liveMap.getZoom(), 9), { duration: 0.35 });
    else liveMap.flyToBounds(L.latLngBounds(cities.map((item) => [item.lat, item.lon])), { padding: [28, 28], maxZoom: 8, duration: 0.35 });
  }
};

renderCityList();
renderCategories(regionStats.categories);
cityList.addEventListener("click", (event) => {
  const button = event.target.closest("[data-city]");
  if (button) updateSelection(button.dataset.city);
});
fallback.addEventListener("click", (event) => {
  const marker = event.target.closest("[data-city]");
  if (marker) updateSelection(marker.dataset.city);
});

if (window.L && mapCanvas) {
  liveMap = L.map(mapCanvas, {
    scrollWheelZoom: false,
    zoomControl: false,
    attributionControl: false,
  });
  liveMap.fitBounds(L.latLngBounds(cities.map((city) => [city.lat, city.lon])), { padding: [28, 28], maxZoom: 8 });
  L.control.zoom({ position: "topright" }).addTo(liveMap);
  L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    maxZoom: 18,
    attribution: "&copy; OpenStreetMap contributors",
  }).addTo(liveMap);

  cities.forEach((city) => {
    const icon = L.divIcon({
      className: "leaflet-city-icon",
      html: `<span class="map-city-marker">${numberFormat.format(city.innovations)}</span>`,
      iconSize: [42, 42],
      iconAnchor: [21, 21],
    });
    const marker = L.marker([city.lat, city.lon], { icon, title: `${city.name}: ${city.innovations} wdrożonych innowacji`, alt: city.name }).addTo(liveMap);
    marker.bindTooltip(`${city.name} · ${numberFormat.format(city.innovations)} innowacji`);
    marker.on("click", () => updateSelection(city.id));
    mapMarkers.set(city.id, marker);
  });

  liveMap.whenReady(() => {
    setTimeout(() => {
      if (mapFrame.querySelector(".leaflet-tile-loaded")) mapFrame.classList.add("has-live-map");
    }, 800);
  });
  mapCanvas.addEventListener("keydown", (event) => {
    if (event.key === "Escape") updateSelection("all");
  });
}
