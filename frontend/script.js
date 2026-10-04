const root = document.documentElement;
const menuButton = document.querySelector(".mobile-menu-button");
const navigation = document.querySelector(".main-navigation");
const problemForm = document.querySelector("#problem-form");
const problemInput = document.querySelector("#problem");
const formMessage = document.querySelector("#form-message");
const languageSelect = document.querySelector("#language");
const languageFlag = document.querySelector(".language-flag");
const SUPPORTED_LANGUAGES = ["pl", "en"];
const LANGUAGE_STORAGE_KEY = "site-language";
const GOOGLE_TRANSLATE_WIDGET_ID = "43217984";

const shouldSkipTranslation = (value) => {
  const normalized = String(value ?? "").trim();
  return normalized.length <= 0 || /^A\+{0,2}$/.test(normalized) || /^A$/.test(normalized) || /^[A-Za-z]$/.test(normalized);
};

const initGoogleTranslateWidget = () => {
  const accessibilityPanel = document.querySelector("#accessibility");
  if (accessibilityPanel && !document.querySelector("#gt-mordadam-43217984")) {
    const widget = document.createElement("div");
    widget.id = "gt-mordadam-43217984";
    widget.className = "google-translate-widget";
    accessibilityPanel.appendChild(widget);
  }

  const currentLanguage = getCurrentLanguage();
  const defaultLanguage = currentLanguage === "en" ? "en" : "pl";

  window.gtranslateSettings = window.gtranslateSettings || {};
  window.gtranslateSettings[GOOGLE_TRANSLATE_WIDGET_ID] = {
    default_language: defaultLanguage,
    languages: ["pl", "en"],
    wrapper_selector: "#gt-mordadam-43217984",
    native_language_names: 1,
    flag_style: "2d",
    flag_size: 24,
    horizontal_position: "inline",
    flags_location: "flags/",
  };

  if (!document.querySelector(`script[data-gt-widget-id="${GOOGLE_TRANSLATE_WIDGET_ID}"]`)) {
    const script = document.createElement("script");
    script.src = "js/gt.min.js";
    script.dataset.gtWidgetId = GOOGLE_TRANSLATE_WIDGET_ID;
    script.async = true;
    document.body.appendChild(script);
  }
};

const translationCatalog = {
  pl: {
    "przejdz do treści": "Przejdź do treści",
    "przejdz do ustawien dostepnosci": "Przejdź do ustawień dostępności",
    "ustawienia dostepnosci": "Ustawienia dostępności",
    "dostepnosc": "Dostępność",
    "szukaj w dyskusjach": "Szukaj w dyskusjach",
    "rozpocznij nowy wątek": "Rozpocznij nowy wątek",
    "dyskusje": "Dyskusje",
    "asystent ai forum & mentorzy": "Asystent AI Forum & Mentorzy",
    "dostępni mentorzy rops i eksperci": "Dostępni Mentorzy ROPS i Eksperci",
    "zadaj szybkie pytanie do bazy rag rops": "Zadaj szybkie pytanie do Bazy RAG ROPS",
    "nie czekaj — sprawdź dofinansowania i innowacje w małopolsce!": "Nie czekaj — sprawdź dofinansowania i innowacje w Małopolsce!",
    "zapytaj ai bazy wiedzy": "Zapytaj AI Bazy Wiedzy",
    "nie znaleziono dyskusji pasujących do zapytania.": "Nie znaleziono dyskusji pasujących do zapytania.",
    "tytuł dyskusji": "Tytuł dyskusji",
    "kategoria": "Kategoria",
    "treść pytania": "Treść pytania",
    "opublikuj wątek": "Opublikuj wątek",
    "kontrast": "Kontrast",
    "kontrast domyslny: biale tlo, niebieski akcent": "Kontrast domyślny: białe tło, niebieski akcent",
    "kontrast: czarne tlo, pomaranczowy akcent": "Kontrast: czarne tło, pomarańczowy akcent",
    "kontrast bialo-czarny": "Kontrast biało-czarny",
    "standardowa wielkosc tekstu": "Standardowa wielkość tekstu",
    "wielkosc tekstu": "Wielkość tekstu",
    "jezyk strony": "Język strony",
    "wybierz jezyk strony": "Wybierz język strony",
    "polski": "Polski",
    "english": "English",
    "ukrainian": "Українська",
    "menu": "Menu",
    "strona glowna": "Strona główna",
    "mam pomysl!": "Mam pomysł!",
    "mam pomysl! | dostępność": "Mam pomysł! | Dostępność",
    "zostan testerem": "Zostań testerem",
    "zacznijmy od początku...": "Zacznijmy od początku...",
    "napisz krótko, pomożemy ci dopracować szczegóły później": "Napisz krótko, pomożemy Ci dopracować szczegóły później",
    "tytuł pomysłu": "Tytuł pomysłu",
    "np. sąsiedzka biblioteka rzeczy": "Np. Sąsiedzka biblioteka rzeczy",
    "dla kogo jest to rozwiązanie?": "Dla kogo jest to rozwiązanie?",
    "możesz wybrać kilka grup": "Możesz wybrać kilka grup",
    "seniorzy": "Seniorzy",
    "rodzice / opiekunowie": "Rodzice / Opiekunowie",
    "nauczyciele / szkoły": "Nauczyciele / Szkoły",
    "dzieci i młodzież": "Dzieci i młodzież",
    "osoby z niepełnosprawnościami": "Osoby z niepełnosprawnościami",
    "mieszkańcy / sąsiedzi": "Mieszkańcy / Sąsiedzi",
    "dalej": "Dalej",
    "skorzystaj z pomocy naszego asystenta ai przy wypełnianiu formularza": "Skorzystaj z pomocy naszego Asystenta AI przy wypełnianiu formularza",
    "sprawdź, czy twój pomysł nie istnieje już w bazie innowacji, pytając o to naszego asystenta...": "Sprawdź, czy Twój pomysł nie istnieje już w bazie innowacji, pytając o to naszego Asystenta...",
    "regionalny ośrodek polityki społecznej": "Regionalny Ośrodek Polityki Społecznej",
    "specjalizacja: innowacje senioralne": "Specjalizacja: Innowacje Senioralne",
    "specjalizacja: dostępność wcag i prawo": "Specjalizacja: Dostępność WCAG i Prawo",
    "specjalizacja: finansowanie i granty": "Specjalizacja: Finansowanie i Granty",
    "mapa potrzeb": "Mapa potrzeb",
    "mapa potrzeb | dostępność": "Mapa potrzeb | Dostępność",
    "forum": "Forum",
    "forum | dostępność": "Forum | Dostępność",
    "wsparcie": "Wsparcie",
    "seniorzy": "Seniorzy",
    "pomysły": "Pomysły",
    "dostępność wcag": "Dostępność WCAG",
    "pytania do jst": "Pytania do JST",
    "wsparcie ai": "Wsparcie AI",
    "zaloguj sie": "Zaloguj się",
    "zarejestruj sie": "Zarejestruj się",
    "twoj panel": "Twój panel",
    "mieszkancy i ngo": "Mieszkańcy i NGO",
    "jednostki samorzadu terytorialnego": "Jednostki samorządu terytorialnego",
    "pracownicy rops": "Pracownicy ROPS",
    "eksperci branżowi i mentorzy": "Eksperci branżowi i mentorzy",
    "twoje konto": "Twoje konto",
    "wspólnie zmieniamy małopolskę": "Wspólnie zmieniamy Małopolskę",
    "masz problem?": "Masz problem?",
    "masz problem? znajdzmy rozwiązanie.": "Masz problem? Znajdźmy rozwiązanie.",
    "znajdzmy rozwiązanie.": "Znajdźmy rozwiązanie.",
    "opowiedz nam własnymi słowami, z czym mierzy się twoja społeczność — resztą zajmiemy się my.": "Opowiedz nam własnymi słowami, z czym mierzy się Twoja społeczność — resztą zajmiemy się my.",
    "opisz swój problem i skorzystaj z pomocy naszego asystenta": "Opisz swój problem i skorzystaj z pomocy naszego asystenta",
    "np. seniorzy w naszej gminie czują się samotni i potrzebują…": "Np. Seniorzy w naszej gminie czują się samotni i potrzebują…",
    "wyślij opis problemu": "Wyślij opis problemu",
    "najpierw opisz problem, który chcesz rozwiązać.": "Najpierw opisz problem, który chcesz rozwiązać.",
    "opis zapisany. moduł asystenta można podłączyć w tym miejscu.": "Opis zapisany. Moduł asystenta można podłączyć w tym miejscu.",
    "najważniejsze statystyki": "Najważniejsze statystyki",
    "wdrożonych innowacji": "wdrożonych innowacji",
    "w małopolsce": "w Małopolsce",
    "wykorzystane granty": "wykorzystane granty",
    "inicjatywy w trakcie realizacji": "inicjatywy w trakcie realizacji",
    "zaproponuj pomysł": "Zaproponuj pomysł",
    "stwórz pomysł": "Stwórz pomysł",
    "status": "Status",
    "pomysł": "Pomysł",
    "data zgłoszenia": "Data zgłoszenia",
    "nie masz jeszcze zgłoszonych pomysłów. dodaj pierwszy, aby śledzić jego status.": "Nie masz jeszcze zgłoszonych pomysłów. Dodaj pierwszy, aby śledzić jego status.",
    "0 pomysłów": "0 pomysłów",
    "czytaj stronę na głos": "Czytaj stronę na głos",
    "zatrzymaj czytanie strony na głos": "Zatrzymaj czytanie strony na głos",
    "otwórz wsparcie w polskim języku migowym": "Otwórz wsparcie w Polskim Języku Migowym",
    "zamknij": "Zamknij",
    "polski język migowy (pjm)": "Polski Język Migowy (PJM)",
    "wspólnie zmieniamy małopolskę": "Wspólnie zmieniamy Małopolskę",
    "twój panel": "Twój panel",
    "strefa mieszkańca": "Strefa mieszkańca",
    "sąsiedzki punkt wsparcia dla opiekunów": "Sąsiedzki punkt wsparcia dla opiekunów",
    "pomysł mieszkańca": "Pomysł mieszkańca",
    "przyjęty": "Przyjęty",
    "zatwierdzone": "Zatwierdzone",
    "oczekuje na decyzję": "Oczekuje na decyzję",
    "odrzucone": "Odrzucone",
    "do opinii": "Do opinii",
    "feedback dodany": "Feedback dodany",
    "oczekuje na feedback": "Oczekuje na feedback",
    "napięcie w kierunku pomysłu": "Napięcie w kierunku pomysłu",
    "wyszukaj pomysły": "Szukaj pomysłów",
    "wyszukaj tematy": "Szukaj tematów",
    "wszystkie": "Wszystkie",
    "czy ogrod społeczny może działać przy domu kultury?": "Czy ogród społeczny może działać przy domu kultury?",
    "najnowsze": "Najnowsze",
    "zaproponuj pomysł": "Zaproponuj pomysł",
    "dostępność": "Dostępność",
    "kontrast": "Kontrast",
    "większy tekst": "Większy tekst",
    "największy tekst": "Największy tekst",
    "logo organizacji": "Logo organizacji",
    "wszystkie wątki": "Wszystkie wątki",
    "dostępni mentorzy:": "Dostępni mentorzy:",
    "forum mieszkańców, organizacji społecznych i mentorów małopolski.": "Forum mieszkańców, organizacji społecznych i mentorów Małopolski.",
    "przestrzeń ekspercka": "Przestrzeń ekspercka",
    "panel mentorów": "Panel mentorów",
    "przeglądaj pomysły mieszkańców, przekazuj rekomendacje i uczestnicz w rozmowach.": "Przeglądaj pomysły mieszkańców, przekazuj rekomendacje i uczestnicz w rozmowach.",
    "przejdź do forum": "Przejdź do forum",
    "pomysły do przejrzenia": "Pomysły do przejrzenia",
    "udzielony feedback": "Udzielony feedback",
    "wątki o pomysłach": "Wątki o pomysłach",
    "oczekujące na feedback": "oczekujące na feedback",
    "zapisane rekomendacje": "zapisane rekomendacje",
    "dyskusje społeczności": "dyskusje społeczności",
    "pomysły mieszkańców": "Pomysły mieszkańców",
    "otwórz zgłoszenie, aby dodać rekomendację.": "Otwórz zgłoszenie, aby dodać rekomendację.",
    "szukaj pomysłów": "Szukaj pomysłów",
    "szukaj po tytule, autorze lub kategorii": "Szukaj po tytule, autorze lub kategorii",
    "z moim feedbackiem": "Z moim feedbackiem",
    "wróć do listy pomysłów": "Wróć do listy pomysłów",
    "autor": "Autor",
    "miejscowość": "Miejscowość",
    "data propozycji": "Data propozycji",
    "opis pomysłu": "Opis pomysłu",
    "historia feedbacku": "Historia feedbacku",
    "twoja rekomendacja": "Twoja rekomendacja",
    "napisz autorowi, co warto rozwinąć lub sprawdzić...": "Napisz autorowi, co warto rozwinąć lub sprawdzić...",
    "kontakt z autorem": "Kontakt z autorem",
    "zapisz feedback": "Zapisz feedback",
    "forum społeczności": "Forum społeczności",
    "wybierz temat i dołącz do rozmowy.": "Wybierz temat i dołącz do rozmowy.",
    "szukaj wątków": "Szukaj wątków",
    "brak pomysłów pasujących do wybranego filtra.": "Brak pomysłów pasujących do wybranego filtra.",
    "brak wątków pasujących do wyszukiwania.": "Brak wątków pasujących do wyszukiwania.",
    "otwórz forum": "Otwórz forum",
    "lista zawiera zgłoszenia przykładowe i dodane w tej przeglądarce. feedback zapisuje się lokalnie; współdzielenie między mentorami wymaga backendu.": "Lista zawiera zgłoszenia przykładowe i dodane w tej przeglądarce. Feedback zapisuje się lokalnie; współdzielenie między mentorami wymaga backendu.",
    "twój panel": "Twój panel",
    "strefa mieszkańca": "Strefa mieszkańca",
    "tutaj znajdziesz statusy swoich zaproponowanych pomysłów.": "Tutaj znajdziesz statusy swoich zaproponowanych pomysłów.",
    "zaproponuj pomysł": "Zaproponuj pomysł",
    "twoje pomysły": "Twoje pomysły",
    "aktualny etap obsługi zgłoszenia": "Aktualny etap obsługi zgłoszenia",
    "nie masz jeszcze zgłoszonych pomysłów. dodaj pierwszy, aby śledzić jego status.": "Nie masz jeszcze zgłoszonych pomysłów. Dodaj pierwszy, aby śledzić jego status.",
    "wybierz powiat i monitoruj pomysły": "Wybierz powiat i monitoruj pomysły",
    "filtruj całe podsumowanie dla wybranego regionu:": "Filtruj całe podsumowanie dla wybranego regionu:",
    "wybierz powiat": "Wybierz powiat",
    "powiat krakowski": "powiat krakowski",
    "powiat wielicki": "powiat wielicki",
    "powiat tatrzański": "powiat tatrzański",
    "sprawdź zgłoszenia": "Sprawdź zgłoszenia",
    "dodaj materiały": "Dodaj materiały",
    "sprawdź forum": "Sprawdź forum",
    "statystyki i potrzeby:": "Statystyki i potrzeby:",
    "rozkład zgłoszonych pomysłów wg kategorii w powiecie:": "Rozkład zgłoszonych pomysłów wg kategorii w powiecie:",
    "seniorzy i dostępność cyfrowa": "Seniorzy i dostępność cyfrowa",
    "opieka wytchnieniowa i zdrowie": "Opieka wytchnieniowa i zdrowie",
    "aktywacja młodzieży i integracja": "Aktywizacja młodzieży i integracja",
    "mapa innowacji społecznych i zgłaszanych potrzeb w miastach małopolski.": "Mapa innowacji społecznych i zgłaszanych potrzeb w miastach Małopolski.",
    "małopolska · potrzeby i działania": "Małopolska · potrzeby i działania",
    "zobacz, gdzie powstają innowacje społeczne i jakie problemy zgłaszają mieszkańcy.": "Zobacz, gdzie powstają innowacje społeczne i jakie problemy zgłaszają mieszkańcy.",
    "dane demonstracyjne": "Dane demonstracyjne",
    "przykład widoku przed podłączeniem rejestru zgłoszeń.": "Przykład widoku przed podłączeniem rejestru zgłoszeń.",
    "innowacje w miastach": "Innowacje w miastach",
    "wybierz punkt lub miasto": "Wybierz punkt lub miasto",
    "miasta na mapie": "Miasta na mapie",
    "9 miast": "9 miast",
    "liczba innowacji oznacza przykładowe wdrożenia przypisane do miasta.": "Liczba innowacji oznacza przykładowe wdrożenia przypisane do miasta.",
    "wybrany obszar": "Wybrany obszar",
    "cała małopolska": "Cała Małopolska",
    "wdrożone innowacje": "Wdrożone innowacje",
    "społeczne rozwiązania": "społeczne rozwiązania",
    "zaproponowane innowacje": "Zaproponowane innowacje",
    "pomysły mieszkańców": "Pomysły mieszkańców",
    "zgłoszone problemy": "Zgłoszone problemy",
    "potrzeby społeczności": "potrzeby społeczności",
    "kategorie problemów": "Kategorie problemów",
    "428 zgłoszeń": "428 zgłoszeń",
    "dane przykładowe do celów prezentacyjnych. nie pochodzą z bieżącego rejestru zgłoszeń.": "Dane przykładowe do celów prezentacyjnych. Nie pochodzą z bieżącego rejestru zgłoszeń.",
    "mapa ulic: © openstreetmap contributors": "Mapa ulic: © OpenStreetMap contributors",
    "jak zdobyć lokal na gminny klub seniora w powiecie krakowskim?": "Jak zdobyć lokal na gminny klub seniora w powiecie krakowskim?"
  },
  en: {
    "przejdz do treści": "Skip to content",
    "przejdz do ustawien dostepnosci": "Skip to accessibility settings",
    "ustawienia dostepnosci": "Accessibility settings",
    "dostepnosc": "Accessibility",
    "szukaj w dyskusjach": "Search discussions",
    "rozpocznij nowy wątek": "Start a new thread",
    "dyskusje": "Discussions",
    "asystent ai forum & mentorzy": "AI Forum Assistant & Mentors",
    "dostępni mentorzy rops i eksperci": "Available ROPS mentors and experts",
    "zadaj szybkie pytanie do bazy rag rops": "Ask a quick question to the ROPS RAG knowledge base",
    "nie czekaj — sprawdź dofinansowania i innowacje w małopolsce!": "Don’t wait — check funding and innovations in Małopolskie!",
    "zapytaj ai bazy wiedzy": "Ask the AI knowledge base",
    "nie znaleziono dyskusji pasujących do zapytania.": "No discussions match your search.",
    "tytuł dyskusji": "Discussion title",
    "kategoria": "Category",
    "treść pytania": "Question content",
    "opublikuj wątek": "Publish thread",
    "kontrast": "Contrast",
    "kontrast domyslny: biale tlo, niebieski akcent": "Default contrast: white background, blue accent",
    "kontrast: czarne tlo, pomaranczowy akcent": "High contrast: black background, orange accent",
    "kontrast bialo-czarny": "Black-and-white contrast",
    "standardowa wielkosc tekstu": "Default text size",
    "wielkosc tekstu": "Text size",
    "jezyk strony": "Language",
    "wybierz jezyk strony": "Choose site language",
    "polski": "Polish",
    "english": "English",
    "ukrainian": "Ukrainian",
    "menu": "Menu",
    "strona glowna": "Home",
    "mam pomysl!": "I have an idea!",
    "mam pomysl! | dostępność": "I have an idea! | Accessibility",
    "zostan testerem": "Become a tester",
    "zacznijmy od początku...": "Let’s start from the beginning...",
    "napisz krótko, pomożemy ci dopracować szczegóły później": "Write briefly and we will help refine the details later",
    "tytuł pomysłu": "Idea title",
    "np. sąsiedzka biblioteka rzeczy": "E.g. Neighbourhood library of things",
    "dla kogo jest to rozwiązanie?": "Who is this solution for?",
    "możesz wybrać kilka grup": "You can choose several groups",
    "seniorzy": "Seniors",
    "rodzice / opiekunowie": "Parents / Caregivers",
    "nauczyciele / szkoły": "Teachers / Schools",
    "dzieci i młodzież": "Children and youth",
    "osoby z niepełnosprawnościami": "People with disabilities",
    "mieszkańcy / sąsiedzi": "Residents / Neighbours",
    "dalej": "Next",
    "skorzystaj z pomocy naszego asystenta ai przy wypełnianiu formularza": "Use our AI Assistant to help you complete the form",
    "sprawdź, czy twój pomysł nie istnieje już w bazie innowacji, pytając o to naszego asystenta...": "Check whether your idea already exists in the innovation database by asking our Assistant...",
    "regionalny ośrodek polityki społecznej": "Regional Social Policy Centre",
    "specjalizacja: innowacje senioralne": "Specialization: Senior Innovations",
    "specjalizacja: dostępność wcag i prawo": "Specialization: WCAG Accessibility and Law",
    "specjalizacja: finansowanie i granty": "Specialization: Funding and Grants",
    "mam pomysl!": "I have an idea!",
    "mapa potrzeb": "Map of needs",
    "mapa potrzeb | dostępność": "Map of needs | Accessibility",
    "forum": "Forum",
    "forum | dostępność": "Forum | Accessibility",
    "wsparcie": "Support",
    "seniorzy": "Seniors",
    "pomysły": "Ideas",
    "dostępność wcag": "WCAG accessibility",
    "pytania do jst": "Questions for local government",
    "wsparcie ai": "AI support",
    "jak zdobyć lokal na gminny klub seniora w powiecie krakowskim?": "How to secure a venue for a senior club in the Kraków district?",
    "autor: stowarzyszenie razem · kategoria: powiat krakowski": "Author: Stowarzyszenie Razem · Category: Kraków district",
    "14 odp.": "14 replies",
    "odp. mentor rops (10 min temu)": "ROPS mentor reply (10 minutes ago)",
    "czy ogród społeczny może działać przy domu kultury?": "Can a community garden operate next to a cultural centre?",
    "autor: marta, kraków · kategoria: pomysły": "Author: Marta, Kraków · Category: Ideas",
    "5 odp.": "5 replies",
    "odp. mentor społeczny (12 min temu)": "Community mentor reply (12 minutes ago)",
    "czy asystent ai dobrze weryfikuje arkusz social innovation canvas?": "Does the AI assistant properly review the Social Innovation Canvas sheet?",
    "autor: piotr, innowator · kategoria: ogólne": "Author: Piotr, Innovator · Category: General",
    "8 odp.": "8 replies",
    "odp. asystent ai (1 godz. temu)": "AI assistant reply (1 hour ago)",
    "wzór uchwały dla gminy na dzienny dom pobytu — skąd pobrać?": "Where can I find a municipal resolution template for a daytime stay facility?",
    "autor: jst, miechów · kategoria: pytania do jst": "Author: Local Government, Miechów · Category: Questions for local government",
    "22 odp.": "22 replies",
    "odp. ekspert prawny (3 godz. temu)": "Legal expert reply (3 hours ago)",
    "szukamy partnera technologicznego do aplikacji dla osób słabowidzących": "We are looking for a technology partner for an app for visually impaired people",
    "autor: fundacja widok · kategoria: dostępność": "Author: Fundacja Widok · Category: Accessibility",
    "6 odp.": "6 replies",
    "odp. mentor tech (1 dzień temu)": "Tech mentor reply (1 day ago)",
    "zaloguj sie": "Log in",
    "zarejestruj sie": "Register",
    "twoj panel": "Your dashboard",
    "mieszkancy i ngo": "Residents and NGOs",
    "jednostki samorzadu terytorialnego": "Local government units",
    "pracownicy rops": "ROPS staff",
    "eksperci branżowi i mentorzy": "Industry experts and mentors",
    "twoje konto": "Your account",
    "wspólnie zmieniamy małopolskę": "Together we are changing Małopolskie",
    "masz problem?": "Do you have a problem?",
    "masz problem? znajdzmy rozwiązanie.": "Do you have a problem? Let's find a solution.",
    "znajdzmy rozwiązanie.": "Let's find a solution.",
    "opowiedz nam własnymi słowami, z czym mierzy się twoja społeczność — resztą zajmiemy się my.": "Tell us in your own words what your community is facing — we will take care of the rest.",
    "opisz swój problem i skorzystaj z pomocy naszego asystenta": "Describe your problem and use our assistant",
    "np. seniorzy w naszej gminie czują się samotni i potrzebują…": "E.g. Seniors in our municipality feel lonely and need…",
    "wyślij opis problemu": "Send problem description",
    "najpierw opisz problem, który chcesz rozwiązać.": "First describe the problem you want to solve.",
    "opis zapisany. moduł asystenta można podłączyć w tym miejscu.": "Description saved. The assistant module can be connected here.",
    "najważniejsze statystyki": "Key statistics",
    "wdrożonych innowacji": "implemented innovations",
    "w małopolsce": "in Małopolskie",
    "wykorzystane granty": "used grants",
    "inicjatywy w trakcie realizacji": "initiatives in progress",
    "zaproponuj pomysł": "Suggest an idea",
    "stwórz pomysł": "Create an idea",
    "status": "Status",
    "pomysł": "Idea",
    "data zgłoszenia": "Submission date",
    "nie masz jeszcze zgłoszonych pomysłów. dodaj pierwszy, aby śledzić jego status.": "You have not submitted any ideas yet. Add your first one to track its status.",
    "0 pomysłów": "0 ideas",
    "czytaj stronę na głos": "Read the page aloud",
    "zatrzymaj czytanie strony na głos": "Stop reading the page aloud",
    "otwórz wsparcie w polskim języku migowym": "Open support in Polish Sign Language",
    "zamknij": "Close",
    "polski język migowy (pjm)": "Polish Sign Language (PSL)",
    "twój panel": "Your dashboard",
    "strefa mieszkańca": "Resident area",
    "sąsiedzki punkt wsparcia dla opiekunów": "Neighbourly support point for caregivers",
    "pomysł mieszkańca": "Resident idea",
    "przyjęty": "Accepted",
    "zatwierdzone": "Approved",
    "oczekuje na decyzję": "Pending decision",
    "odrzucone": "Rejected",
    "do opinii": "Needs review",
    "feedback dodany": "Feedback added",
    "oczekuje na feedback": "Awaiting feedback",
    "wyszukaj pomysły": "Search ideas",
    "wyszukaj tematy": "Search topics",
    "wszystkie": "All",
    "czy ogrod społeczny może działać przy domu kultury?": "Can a community garden work near the cultural centre?",
    "dostępność": "Accessibility",
    "większy tekst": "Larger text",
    "największy tekst": "Largest text",
    "logo organizacji": "Organization logo",
    "dostępni mentorzy:": "Available mentors:",
    "dostępni mentorzy": "Available mentors",
    "przestrzeń ekspercka": "Expert space",
    "zgłoszeń": "submissions",
    "innowacji": "innovations",
    "odp": "replies",
    "panel mentorów": "Mentor panel",
    "przeglądaj pomysły mieszkańców, przekazuj rekomendacje i uczestnicz w rozmowach.": "Review residents' ideas, provide recommendations, and join the conversation.",
    "przejdź do forum": "Go to forum",
    "pomysły do przejrzenia": "Ideas to review",
    "udzielony feedback": "Feedback provided",
    "wątki o pomysłach": "Idea threads",
    "oczekujące na feedback": "awaiting feedback",
    "zapisane rekomendacje": "saved recommendations",
    "dyskusje społeczności": "community discussions",
    "pomysły mieszkańców": "Residents' ideas",
    "otwórz zgłoszenie, aby dodać rekomendację.": "Open a submission to add a recommendation.",
    "szukaj pomysłów": "Search ideas",
    "szukaj po tytule, autorze lub kategorii": "Search by title, author or category",
    "z moim feedbackiem": "With my feedback",
    "wróć do listy pomysłów": "Back to ideas list",
    "autor": "Author",
    "miejscowość": "Location",
    "data propozycji": "Proposal date",
    "opis pomysłu": "Idea description",
    "historia feedbacku": "Feedback history",
    "twoja rekomendacja": "Your recommendation",
    "napisz autorowi, co warto rozwinąć lub sprawdzić...": "Write to the author about what is worth developing or checking...",
    "kontakt z autorem": "Contact the author",
    "zapisz feedback": "Save feedback",
    "forum społeczności": "Community forum",
    "wybierz temat i dołącz do rozmowy.": "Choose a topic and join the discussion.",
    "szukaj wątków": "Search threads",
    "brak pomysłów pasujących do wybranego filtra.": "No ideas match the selected filter.",
    "brak wątków pasujących do wyszukiwania.": "No threads match the search.",
    "otwórz forum": "Open forum",
    "lista zawiera zgłoszenia przykładowe i dodane w tej przeglądarce. feedback zapisuje się lokalnie; współdzielenie między mentorami wymaga backendu.": "The list contains sample submissions and entries added in this browser. Feedback is saved locally; sharing between mentors requires a backend.",
    "wybierz powiat i monitoruj pomysły": "Choose a district and monitor ideas",
    "filtruj całe podsumowanie dla wybranego regionu:": "Filter the overview for the selected region:",
    "wybierz powiat": "Select district",
    "sprawdź zgłoszenia": "Check submissions",
    "dodaj materiały": "Add materials",
    "sprawdź forum": "Check the forum",
    "statystyki i potrzeby:": "Statistics and needs:",
    "rozkład zgłoszonych pomysłów wg kategorii w powiecie:": "Distribution of submitted ideas by category in the district:",
    "małopolska · potrzeby i działania": "Małopolskie · needs and actions",
    "dostępność usług": "Accessibility services",
    "wsparcie seniorów i opiekunów": "Support for seniors and caregivers",
    "zdrowie psychiczne dzieci i młodzieży": "Mental health of children and youth",
    "samotność i integracja społeczna": "Loneliness and social integration",
    "transport i mobilność": "Transport and mobility",
    "społeczne rozwiązania": "social solutions",
    "potrzeby społeczności": "community needs",
    "zobacz, gdzie powstają innowacje społeczne i jakie problemy zgłaszają mieszkańcy.": "See where social innovations are emerging and which problems residents raise.",
    "dane demonstracyjne": "Demo data",
    "przykład widoku przed podłączeniem rejestru zgłoszeń.": "Example view before connecting the submissions registry.",
    "innowacje w miastach": "Innovations in cities",
    "wybierz punkt lub miasto": "Select a point or city",
    "miasta na mapie": "Cities on the map",
    "9 miast": "9 cities",
    "liczba innowacji oznacza przykładowe wdrożenia przypisane do miasta.": "The number of innovations represents sample implementations assigned to the city.",
    "wybrany obszar": "Selected area",
    "cała małopolska": "Whole Małopolskie",
    "wdrożone innowacje": "Implemented innovations",
    "zaproponowane innowacje": "Proposed innovations",
    "zgłoszone problemy": "Reported problems",
    "kategorie problemów": "Problem categories",
    "dane przykładowe do celów prezentacyjnych. nie pochodzą z bieżącego rejestru zgłoszeń.": "Sample data for presentation purposes only. It does not come from the current submissions registry.",
    "mapa ulic: © openstreetmap contributors": "Street map: © OpenStreetMap contributors",
    "twoje pomysły": "Your ideas",
    "aktualny etap obsługi zgłoszenia": "Current stage of request processing",
    "pomysły mieszkańców": "Residents' ideas",
    "otwórz zgłoszenie, aby dodać rekomendację.": "Open a submission to add a recommendation."
  },
  uk: {
    "przejdz do treści": "Перейти до вмісту",
    "przejdz do ustawien dostepnosci": "Перейти до налаштувань доступності",
    "ustawienia dostepnosci": "Налаштування доступності",
    "dostepnosc": "Доступність",
    "kontrast": "Контраст",
    "kontrast domyslny: biale tlo, niebieski akcent": "Типовий контраст: біле тло, синій акцент",
    "kontrast: czarne tlo, pomaranczowy akcent": "Контраст: чорне тло, помаранчевий акцент",
    "kontrast bialo-czarny": "Чорно-білий контраст",
    "standardowa wielkosc tekstu": "Типовий розмір тексту",
    "wielkosc tekstu": "Розмір тексту",
    "jezyk strony": "Мова сайту",
    "wybierz jezyk strony": "Виберіть мову сайту",
    "polski": "Польська",
    "english": "Англійська",
    "ukrainian": "Українська",
    "menu": "Меню",
    "strona glowna": "Головна",
    "mam pomysl!": "У мене є ідея!",
    "zostan testerem": "Стати тестувальником",
    "mapa potrzeb": "Карта потреб",
    "forum": "Форум",
    "wsparcie": "Підтримка",
    "zaloguj sie": "Увійти",
    "zarejestruj sie": "Зареєструватися",
    "twoj panel": "Ваш кабінет",
    "mieszkancy i ngo": "Мешканці та НГО",
    "jednostki samorzadu terytorialnego": "Одиниці місцевого самоврядування",
    "pracownicy rops": "Співробітники ROPS",
    "eksperci branżowi i mentorzy": "Промислові експерти та ментори",
    "twoje konto": "Ваш обліковий запис",
    "wspólnie zmieniamy małopolskę": "Разом змінюємо Малопольщу",
    "masz problem?": "У вас є проблема?",
    "masz problem? znajdzmy rozwiązanie.": "У вас є проблема? Знайдемо рішення.",
    "znajdzmy rozwiązanie.": "Знайдемо рішення.",
    "opowiedz nam własnymi słowami, z czym mierzy się twoja społeczność — resztą zajmiemy się my.": "Розкажіть нам власними словами, з чим стикається ваша громада — решту зробимо ми.",
    "opisz swój problem i skorzystaj z pomocy naszego asystenta": "Опишіть свою проблему та скористайтеся допомогою нашого асистента",
    "np. seniorzy w naszej gminie czują się samotni i potrzebują…": "Напр. Літні люди у нашій громаді почуваються самотніми і потребують…",
    "wyślij opis problemu": "Надіслати опис проблеми",
    "najpierw opisz problem, który chcesz rozwiązać.": "Спочатку опишіть проблему, яку хочете вирішити.",
    "opis zapisany. moduł asystenta można podłączyć w tym miejscu.": "Опис збережено. Модуль асистента можна підключити тут.",
    "najważniejsze statystyki": "Ключова статистика",
    "wdrożonych innowacji": "впроваджених інновацій",
    "w małopolsce": "у Малопольщі",
    "wykorzystane granty": "використані гранти",
    "inicjatywy w trakcie realizacji": "ініціативи в процесі реалізації",
    "zaproponuj pomysł": "Запропонуйте ідею",
    "stwórz pomysł": "Створити ідею",
    "status": "Статус",
    "pomysł": "Ідея",
    "data zgłoszenia": "Дата подання",
    "nie masz jeszcze zgłoszonych pomysłów. dodaj pierwszy, aby śledzić jego status.": "У вас ще немає поданих ідей. Додайте першу, щоб відстежувати її статус.",
    "0 pomysłów": "0 ідей",
    "czytaj stronę na głos": "Читати сторінку вголос",
    "zatrzymaj czytanie strony na głos": "Зупинити читання сторінки вголос",
    "otwórz wsparcie w polskim języku migowym": "Відкрити підтримку польською жестовою мовою",
    "zamknij": "Закрити",
    "polski język migowy (pjm)": "Польська жестова мова (PJM)",
    "twój panel": "Ваш кабінет",
    "strefa mieszkańca": "Сектор мешканця",
    "sąsiedzki punkt wsparcia dla opiekunów": "Сусідня точка підтримки для опікунів",
    "pomysł mieszkańca": "Ідея мешканця",
    "przyjęty": "Прийнято",
    "zatwierdzone": "Підтверджено",
    "oczekuje na decyzję": "Очікує на рішення",
    "odrzucone": "Відхилено",
    "do opinii": "Чекає на оцінку",
    "feedback dodany": "Відгук додано",
    "oczekuje na feedback": "Чекає на відгук",
    "wyszukaj pomysły": "Шукати ідеї",
    "wyszukaj tematy": "Шукати теми",
    "wszystkie": "Усі",
    "czy ogrod społeczny może działać przy domu kultury?": "Чи може працювати громадський сад біля будинку культури?",
    "dostępność": "Доступність",
    "większy tekst": "Більший текст",
    "największy tekst": "Найбільший текст",
    "logo organizacji": "Логотип організації",
    "dostępni mentorzy:": "Доступні ментори:",
    "przestrzeń ekspercka": "Експертний простір",
    "panel mentorów": "Панель менторів",
    "przeglądaj pomysły mieszkańców, przekazuj rekomendacje i uczestnicz w rozmowach.": "Переглядайте ідеї мешканців, давайте рекомендації та беріть участь у дискусіях.",
    "przejdź do forum": "Перейти до форуму",
    "pomysły do przejrzenia": "Ідеї до перегляду",
    "udzielony feedback": "Надано відгук",
    "wątki o pomysłach": "Теми про ідеї",
    "oczekujące na feedback": "чекає на відгук",
    "zapisane rekomendacje": "збережені рекомендації",
    "dyskusje społeczності": "дискусії громади",
    "pomysły mieszkańców": "Ідеї мешканців",
    "otwórz zgłoszenie, aby dodać rekomendację.": "Відкрийте подання, щоб додати рекомендацію.",
    "szukaj pomysłów": "Шукати ідеї",
    "szukaj po tytule, autorze lub kategorii": "Шукати за назвою, автором або категорією",
    "z moim feedbackiem": "З моїм відгуком",
    "wróć do listy pomysłów": "Повернутися до списку ідей",
    "autor": "Автор",
    "miejscowość": "Місцевість",
    "data propozycji": "Дата пропозиції",
    "opis pomysłu": "Опис ідеї",
    "historia feedbacku": "Історія відгуків",
    "twoja rekomendacja": "Ваша рекомендація",
    "napisz autorowi, co warto rozwinąć lub sprawdzić...": "Напишіть автору, що варто розвивати або перевірити...",
    "kontakt z autorem": "Зв'язатися з автором",
    "zapisz feedback": "Зберегти відгук",
    "forum społeczności": "Форум спільноти",
    "wybierz temat i dołącz do rozmowy.": "Виберіть тему та приєднуйтесь до обговорення.",
    "szukaj wątków": "Шукати теми",
    "brak pomysłów pasujących do wybranego filtra.": "Немає ідей, що відповідають вибраному фільтру.",
    "brak wątków pasujących do wyszukiwania.": "Немає тем, які відповідають пошуку.",
    "otwórz forum": "Відкрити форум",
    "lista zawiera zgłoszenia przykładowe i dodane w tej przeglądarce. feedback zapisuje się lokalnie; współdzielenie między mentorami wymaga backendu.": "Список містить зразкові подання й записи, додані в цьому браузері. Відгуки зберігаються локально; спільне використання між менторами вимагає бекенду.",
    "wybierz powiat i monitoruj pomysły": "Виберіть повіт і відстежуйте ідеї",
    "filtruj całe podsumowanie dla wybranego regionu:": "Фільтруйте підсумок для обраного регіону:",
    "wybierz powiat": "Виберіть повіт",
    "sprawdź zgłoszenia": "Перевірити подання",
    "dodaj materiały": "Додати матеріали",
    "sprawdź forum": "Перевірити форум",
    "statystyki i potrzeby:": "Статистика та потреби:",
    "rozkład zgłoszonych pomysłów wg kategorii w powiecie:": "Розподіл поданих ідей за категоріями в повіті:",
    "małopolska · potrzeby i działania": "Малопольща · потреби та дії",
    "zobacz, gdzie powstają innowacje społeczne i jakie problemy zgłaszają mieszkańcy.": "Дізнайтеся, де з'являються соціальні інновації і які проблеми піднімають мешканці.",
    "dane demonstracyjne": "Демо-дані",
    "przykład widoku przed podłączeniem rejestru zgłoszeń.": "Приклад вигляду до підключення реєстру подань.",
    "innowacje w miastach": "Іновації в містах",
    "wybierz punkt lub miasto": "Виберіть точку або місто",
    "miasta na mapie": "Міста на карті",
    "9 miast": "9 міст",
    "liczba innowacji oznacza przykładowe wdrożenia przypisane do miasta.": "Кількість інновацій означає зразкові впровадження, прив'язані до міста.",
    "wybrany obszar": "Обрана область",
    "cała małopolska": "Уся Малопольща",
    "wdrożone innowacje": "Впроваджені інновації",
    "zaproponowane innowacje": "Запропоновані інновації",
    "zgłoszone problemy": "Подані проблеми",
    "kategorie problemów": "Категорії проблем",
    "dane przykładowe do celów prezentacyjnych. nie pochodzą z bieżącego rejestru zgłoszeń.": "Зразкові дані для презентаційних цілей. Вони не походять з поточного реєстру подань.",
    "mapa ulic: © openstreetmap contributors": "Карта вулиць: © OpenStreetMap contributors",
    "twoje pomysły": "Ваші ідеї",
    "aktualny etap obsługi zgłoszenia": "Поточний етап обробки подання",
    "pomysły mieszkańców": "Ідеї мешканців",
    "otwórz zgłoszenie, aby dodać rekomendację.": "Відкрийте подання, щоб додати рекомендацію."
  }
};

const localeForLanguage = (lang) => ({ pl: "pl-PL", en: "en-US", uk: "uk-UA" })[lang] || "pl-PL";
const normalizeTranslationKey = (value) => String(value ?? "")
  .toLocaleLowerCase("pl")
  .normalize("NFKD")
  .replace(/[\u0300-\u036f]/g, "")
  .replace(/[łŁ]/g, "l")
  .replace(/[ąĄ]/g, "a")
  .replace(/[ćĆ]/g, "c")
  .replace(/[ęĘ]/g, "e")
  .replace(/[óÓ]/g, "o")
  .replace(/[śŚ]/g, "s")
  .replace(/[żŻ]/g, "z")
  .replace(/[źŹ]/g, "z")
  .replace(/[ńŃ]/g, "n")
  .replace(/[^\p{L}\p{N}\s]/gu, " ")
  .replace(/\s+/g, " ")
  .trim();
const getNormalizedTranslationEntry = (lang = getCurrentLanguage()) => {
  const source = translationCatalog[lang] || translationCatalog.pl;
  const entry = {};

  Object.entries(source).forEach(([key, translatedText]) => {
    const normalized = normalizeTranslationKey(key);
    entry[normalized] = translatedText;
    entry[normalized.replace(/\s+/g, "").trim()] = translatedText;
  });

  return entry;
};

const translateText = (value, lang = getCurrentLanguage()) => {
  if (shouldSkipTranslation(value)) {
    return value;
  }

  const key = normalizeTranslationKey(value);
  const entry = getNormalizedTranslationEntry(lang);

  const candidates = new Set([key]);
  candidates.add(key.replace(/\d+/g, "").replace(/\s+/g, " ").trim());
  candidates.add(key.replace(/\s+/g, "").trim());
  candidates.add(key.replace(/[^\p{L}\p{N}\s]/gu, " ").replace(/\s+/g, " ").trim());

  for (const candidate of candidates) {
    if (!candidate) continue;
    if (entry[candidate]) return entry[candidate];
  }

  return value;
};

function getCurrentLanguage() {
  const saved = sessionStorage.getItem(LANGUAGE_STORAGE_KEY);
  return saved && SUPPORTED_LANGUAGES.includes(saved) && translationCatalog[saved] ? saved : "pl";
}

function applyTranslations() {
  const language = getCurrentLanguage();
  const langCode = language === "en" ? "en" : "pl";
  document.documentElement.lang = langCode;
  document.documentElement.dataset.lang = langCode;
  if (languageSelect) languageSelect.value = language;
  if (languageFlag) languageFlag.dataset.language = language;

  document.querySelectorAll('meta[name="description"]').forEach((node) => {
    const description = node.getAttribute("content");
    if (description) {
      const translated = translateText(description, language);
      if (translated !== description) node.setAttribute("content", translated);
    }
  });

  document.querySelectorAll("[aria-label]").forEach((node) => {
    const ariaLabel = node.getAttribute("aria-label");
    if (ariaLabel) {
      const translated = translateText(ariaLabel, language);
      if (translated !== ariaLabel) node.setAttribute("aria-label", translated);
    }
  });

  document.querySelectorAll("[title]").forEach((node) => {
    const title = node.getAttribute("title");
    if (title) {
      const translated = translateText(title, language);
      if (translated !== title) node.setAttribute("title", translated);
    }
  });

  document.querySelectorAll("[placeholder]").forEach((node) => {
    const placeholder = node.getAttribute("placeholder");
    if (placeholder) {
      const translated = translateText(placeholder, language);
      if (translated !== placeholder) node.setAttribute("placeholder", translated);
    }
  });

  document.querySelectorAll("[alt]").forEach((node) => {
    const alt = node.getAttribute("alt");
    if (alt && alt !== "") {
      const translated = translateText(alt, language);
      if (translated !== alt) node.setAttribute("alt", translated);
    }
  });

  const textWalker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT, {
    acceptNode: (node) => {
      const parent = node.parentElement;
      if (!parent || parent.closest("script") || parent.closest("style") || parent.closest("svg") || parent.closest("[data-translation-ignore='true']")) {
        return NodeFilter.FILTER_REJECT;
      }
      return NodeFilter.FILTER_ACCEPT;
    }
  });

  while (textWalker.nextNode()) {
    const textNode = textWalker.currentNode;
    const original = textNode.textContent?.trim() || "";
    if (!original) continue;
    const translated = translateText(original, language);
    if (translated !== original) textNode.textContent = translated;
  }

  if (document.title) {
    const translatedTitle = translateText(document.title, language);
    if (translatedTitle !== document.title) document.title = translatedTitle;
  }

  if (typeof window.syncAccessibilityText === "function") window.syncAccessibilityText();
  if (typeof window.rebuildAccountTranslations === "function") window.rebuildAccountTranslations();
  if (typeof window.rebuildMentorTranslations === "function") window.rebuildMentorTranslations();
}

window.getCurrentLanguage = getCurrentLanguage;
window.translateText = translateText;
window.applyTranslations = applyTranslations;
initGoogleTranslateWidget();
applyTranslations();

languageSelect?.addEventListener("change", () => {
  const selectedLanguage = SUPPORTED_LANGUAGES.includes(languageSelect.value) ? languageSelect.value : "pl";
  sessionStorage.setItem(LANGUAGE_STORAGE_KEY, selectedLanguage);
  if (languageFlag) languageFlag.dataset.language = selectedLanguage;
  applyTranslations();
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

const getVoiceMessages = () => {
  const language = getCurrentLanguage();
  return {
    pl: {
      unsupported: "Ta przeglądarka nie obsługuje czytania strony na głos.",
      stopped: "Czytanie zatrzymane.",
      noText: "Nie znaleziono treści do przeczytania.",
      reading: "Czytam treść strony na głos.",
      readLabel: "Czytaj stronę na głos",
      stopLabel: "Zatrzymaj czytanie strony na głos"
    },
    en: {
      unsupported: "This browser does not support reading the page aloud.",
      stopped: "Reading stopped.",
      noText: "No text was found to read.",
      reading: "Reading the page aloud.",
      readLabel: "Read the page aloud",
      stopLabel: "Stop reading the page aloud"
    },
    uk: {
      unsupported: "Цей браузер не підтримує озвучування сторінки.",
      stopped: "Озвучування зупинено.",
      noText: "Не знайдено тексту для озвучування.",
      reading: "Озвучую вміст сторінки.",
      readLabel: "Читати сторінку вголос",
      stopLabel: "Зупинити читання сторінки вголос"
    }
  }[language] || { unsupported: "Ta przeglądarka nie obsługuje czytania strony na głos.", stopped: "Czytanie zatrzymane.", noText: "Nie znaleziono treści do przeczytania.", reading: "Czytam treść strony na głos.", readLabel: "Czytaj stronę na głos", stopLabel: "Zatrzymaj czytanie strony na głos" };
};

window.syncAccessibilityText = () => {
  if (!voiceButton) return;
  const labels = getVoiceMessages();
  const isSpeaking = window.speechSynthesis?.speaking;
  voiceButton.setAttribute("aria-label", isSpeaking ? labels.stopLabel : labels.readLabel);
  voiceButton.setAttribute("title", isSpeaking ? labels.stopLabel : labels.readLabel);
};

voiceButton?.addEventListener("click", () => {
  const labels = getVoiceMessages();
  if (!("speechSynthesis" in window) || !("SpeechSynthesisUtterance" in window)) {
    accessibilityStatus.textContent = labels.unsupported;
    return;
  }

  if (window.speechSynthesis.speaking) {
    window.speechSynthesis.cancel();
    voiceButton.setAttribute("aria-pressed", "false");
    voiceButton.setAttribute("aria-label", labels.readLabel);
    accessibilityStatus.textContent = labels.stopped;
    return;
  }

  const mainContent = document.querySelector("main");
  const text = mainContent?.innerText.replace(/\s+/g, " ").trim();
  if (!text) {
    accessibilityStatus.textContent = labels.noText;
    return;
  }

  const utterance = new SpeechSynthesisUtterance(text);
  utterance.lang = localeForLanguage(getCurrentLanguage());
  const matchingVoice = window.speechSynthesis.getVoices().find((voice) => voice.lang?.toLowerCase().startsWith(getCurrentLanguage() === "en" ? "en" : getCurrentLanguage() === "uk" ? "uk" : "pl"));
  if (matchingVoice) utterance.voice = matchingVoice;
  const finishReading = () => {
    voiceButton.setAttribute("aria-pressed", "false");
    voiceButton.setAttribute("aria-label", labels.readLabel);
  };
  utterance.onend = finishReading;
  utterance.onerror = finishReading;
  voiceButton.setAttribute("aria-pressed", "true");
  voiceButton.setAttribute("aria-label", labels.stopLabel);
  accessibilityStatus.textContent = labels.reading;
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

problemForm?.addEventListener("submit", (event) => {
  event.preventDefault();
  const query = problemInput.value.trim();

  if (!query) {
    formMessage.textContent = translateText("Najpierw opisz problem, który chcesz rozwiązać.", getCurrentLanguage());
    problemInput.focus();
    return;
  }

  formMessage.textContent = translateText("Opis zapisany. Moduł asystenta można podłączyć w tym miejscu.", getCurrentLanguage());
});

const ideaForm = document.querySelector("#idea-form");
const ideaTitleInput = document.querySelector("#idea-title-input");
const ideaFormMessage = document.querySelector("#idea-form-message");
const assistantPrompt = document.querySelector("#assistant-prompt");

ideaForm?.addEventListener("submit", (event) => {
  event.preventDefault();
  const selectedGroups = ideaForm.querySelectorAll('input[name="audience"]:checked');

  if (!ideaTitleInput.value.trim()) {
    ideaFormMessage.textContent = translateText("Wpisz tytuł pomysłu, aby przejść dalej.", getCurrentLanguage());
    ideaTitleInput.focus();
    return;
  }

  if (!selectedGroups.length) {
    ideaFormMessage.textContent = translateText("Wybierz co najmniej jedną grupę odbiorców.", getCurrentLanguage());
    ideaForm.querySelector('input[name="audience"]').focus();
    return;
  }

  const ideas = JSON.parse(localStorage.getItem("rops-proposed-ideas") || "[]");
  ideas.unshift({
    title: ideaTitleInput.value.trim(),
    audience: [...selectedGroups].map((group) => group.value),
    status: translateText("Przyjęty", getCurrentLanguage()),
    createdAt: new Date().toISOString(),
  });
  localStorage.setItem("rops-proposed-ideas", JSON.stringify(ideas));
  ideaFormMessage.textContent = translateText("Świetnie! Podstawowe informacje zostały zapisane.", getCurrentLanguage());
});

assistantPrompt?.addEventListener("click", () => {
  const title = ideaTitleInput.value.trim();
  if (!title) {
    ideaFormMessage.textContent = translateText("Najpierw wpisz tytuł pomysłu — na jego podstawie rozpoczniemy wyszukiwanie.", getCurrentLanguage());
    ideaTitleInput.focus();
    return;
  }

  window.location.href = `index.html?problem=${encodeURIComponent(title)}`;
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
if (problemFromUrl && problemInput) {
  problemInput.value = problemFromUrl;
  problemInput.focus();
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
    document.querySelector("#idea-detail-date").textContent = new Intl.DateTimeFormat(localeForLanguage(getCurrentLanguage()), { dateStyle: "long" }).format(new Date(`${row.dataset.date}T12:00:00`));
    document.querySelector("#idea-detail-municipality").textContent = row.dataset.municipality;
    document.querySelector("#idea-detail-category").textContent = row.dataset.category;
    document.querySelector("#idea-detail-description").textContent = row.dataset.description;
    const contactLink = document.querySelector("#idea-contact-author");
    const contactSubject = `Kontakt w sprawie pomysłu: ${row.dataset.title}`;
    if (row.dataset.email && !row.dataset.email.endsWith("@example.org")) {
      contactLink.href = `mailto:${encodeURIComponent(row.dataset.email)}?subject=${encodeURIComponent(contactSubject)}`;
      contactLink.textContent = translateText("Skontaktuj się z autorem", getCurrentLanguage());
    } else {
      const message = `Proszę o przekazanie prośby o kontakt autorowi ${row.dataset.author} w sprawie pomysłu „${row.dataset.title}” z gminy ${row.dataset.municipality}.`;
      contactLink.href = `mailto:biuro@rops.krakow.pl?subject=${encodeURIComponent(contactSubject)}&body=${encodeURIComponent(message)}`;
      contactLink.textContent = translateText("Poproś ROPS o kontakt z autorem", getCurrentLanguage());
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

const normalizeText = (value) => String(value ?? "")
  .toLocaleLowerCase("pl")
  .normalize("NFKD")
  .replace(/[\u0300-\u036f]/g, "")
  .replace(/[łŁ]/g, "l")
  .replace(/[ąĄ]/g, "a")
  .replace(/[ćĆ]/g, "c")
  .replace(/[ęĘ]/g, "e")
  .replace(/[óÓ]/g, "o")
  .replace(/[śŚ]/g, "s")
  .replace(/[żŻ]/g, "z")
  .replace(/[źŹ]/g, "z")
  .replace(/[ńŃ]/g, "n");

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
    message.textContent = translateText("Uzupełnij tytuł i treść pytania.", getCurrentLanguage());
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
  author.textContent = translateText("Autor: Ty · Nowa dyskusja", getCurrentLanguage());
  summary.append(title, author);
  const meta = document.createElement("div");
  meta.className = "thread-meta";
  const replies = document.createElement("strong");
  replies.textContent = translateText("0 odp.", getCurrentLanguage());
  const time = document.createElement("span");
  time.textContent = translateText("Opublikowano przed chwilą", getCurrentLanguage());
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

if (typeof window.applyTranslations === "function") {
  window.applyTranslations();
}
