/* Global i18n controller for the legacy HTML views.
 * React owns the language state; this adapter lets the existing, progressively
 * enhanced DOM use the same react-i18next instance without rewriting every view. */
(function () {
  "use strict";

  const en = {
    "Przejdź do treści": "Skip to content", "Dostępność": "Accessibility", "Kontrast": "Contrast",
    "Wielkość tekstu": "Text size", "Język strony": "Page language", "Wybierz język strony": "Select page language",
    "Polski": "Polish", "Strona główna": "Home", "Mam pomysł!": "I have an idea!", "Zostań testerem": "Become a tester",
    "Mapa potrzeb": "Needs map", "Wsparcie": "Support", "Zaloguj się": "Log in", "Zarejestruj się": "Sign up",
    "Twoje konto": "Your account", "Twój panel": "Your dashboard", "Mieszkańcy i NGO": "Residents and NGOs",
    "Jednostki samorządu terytorialnego": "Local government units", "Pracownicy ROPS": "ROPS staff",
    "Eksperci branżowi i mentorzy": "Industry experts and mentors", "Menu": "Menu", "Logo organizacji": "Organisation logo",
    "Wspólnie zmieniamy Małopolskę": "Together we are changing Małopolska", "Masz problem?": "Have a problem?",
    "Znajdźmy": "Let's find a", "rozwiązanie.": "solution.",
    "Opowiedz nam własnymi słowami, z czym mierzy się Twoja społeczność — resztą zajmiemy się my.": "Tell us in your own words what your community is facing — we will take care of the rest.",
    "Opisz swój problem i skorzystaj z pomocy naszego asystenta": "Describe your problem and get help from our assistant",
    "wdrożonych innowacji": "implemented innovations", "w Małopolsce": "in Małopolska", "wykorzystane granty": "grants used",
    "inicjatywy w trakcie": "initiatives currently", "realizacji": "under way", "Regionalny Ośrodek Polityki": "Regional Centre for Social Policy",
    "Społecznej": "", "Zacznijmy od początku...": "Let's start at the beginning...",
    "Napisz krótko, pomożemy Ci dopracować szczegóły później": "Keep it brief; we will help you refine the details later",
    "Tytuł pomysłu": "Idea title", "Dla kogo jest to rozwiązanie?": "Who is this solution for?",
    "Możesz wybrać kilka grup": "You can select several groups", "Seniorzy": "Seniors", "Rodzice / Opiekunowie": "Parents / Carers",
    "Nauczyciele / Szkoły": "Teachers / Schools", "Dzieci i młodzież": "Children and young people",
    "Osoby z niepełnosprawnościami": "People with disabilities", "Mieszkańcy / Sąsiedzi": "Residents / Neighbours", "Dalej": "Continue",
    "Skorzystaj z pomocy naszego Asystenta AI": "Get help from our AI Assistant", "przy wypełnianiu formularza": "while completing the form",
    "Sprawdź, czy Twój pomysł nie istnieje już w bazie innowacji, pytając o to naszego Asystenta...": "Ask our Assistant whether your idea already exists in the innovation database...",
    "Małopolska · potrzeby i działania": "Małopolska · needs and activities",
    "Zobacz, gdzie powstają innowacje społeczne i jakie problemy zgłaszają mieszkańcy.": "See where social innovations are created and what problems residents report.",
    "Dane demonstracyjne": "Demo data", "Przykład widoku przed podłączeniem rejestru zgłoszeń.": "Example view before connecting the submissions register.",
    "Innowacje w miastach": "Innovations in cities", "Wybierz punkt lub miasto": "Select a point or city", "Miasta na mapie": "Cities on the map",
    "9 miast": "9 cities", "Liczba innowacji oznacza przykładowe wdrożenia przypisane do miasta.": "The number of innovations represents sample implementations assigned to a city.",
    "Wybrany obszar": "Selected area", "Cała Małopolska": "All of Małopolska", "Wdrożone innowacje": "Implemented innovations",
    "społeczne rozwiązania": "social solutions", "Zaproponowane innowacje": "Proposed innovations", "pomysły mieszkańców": "residents' ideas",
    "Zgłoszone problemy": "Reported problems", "potrzeby społeczności": "community needs", "Kategorie problemów": "Problem categories",
    "428 zgłoszeń": "428 submissions", "Dane przykładowe do celów prezentacyjnych. Nie pochodzą z bieżącego rejestru zgłoszeń.": "Sample data for presentation purposes. It does not come from the current submissions register.",
    "Wybierz powiat i monitoruj pomysły": "Select a county and monitor ideas", "Filtruj całe podsumowanie dla wybranego regionu:": "Filter the whole summary for the selected region:",
    "Wybierz powiat": "Select a county", "powiat krakowski": "Kraków County", "powiat wielicki": "Wieliczka County", "powiat tatrzański": "Tatra County",
    "Sprawdź zgłoszenia": "Review submissions", "Dodaj materiały": "Add resources", "Sprawdź forum": "Visit forum", "Statystyki i Potrzeby:": "Statistics and needs:",
    "Powiat Krakowski": "Kraków County", "Rozkład zgłoszonych Pomysłów wg kategorii w powiecie:": "Distribution of submitted ideas by category in the county:",
    "Seniorzy i Dostępność Cyfrowa (": "Seniors and digital accessibility (", "Opieka Wytchnieniowa i Zdrowie (": "Respite care and health (",
    "Aktywizacja Młodzieży i Integracja (": "Youth activation and integration (", "pomysłów)": "ideas)",
    "Pomysły mieszkańców": "Residents' ideas", "Autor": "Author", "Gmina": "Municipality", "Status": "Status", "Szczegóły": "Details", "Otwórz": "Open",
    "Zatwierdzone": "Approved", "Oczekuje na decyzję": "Awaiting decision", "Odrzucone": "Rejected", "Wróć do listy pomysłów": "Back to ideas",
    "Szczegóły zgłoszenia": "Submission details", "Data zaproponowania": "Date proposed", "Kategoria": "Category", "Opis pomysłu": "Idea description",
    "Skontaktuj się z autorem": "Contact the author", "Zaakceptuj pomysł": "Accept idea", "Odrzuć pomysł": "Reject idea",
    "Szukaj w dyskusjach": "Search discussions", "Rozpocznij nowy wątek": "Start a new thread", "Dostępni mentorzy:": "Available mentors:",
    "Dyskusje": "Discussions", "Wszystkie": "All", "Pomysły": "Ideas", "Dostępność WCAG": "WCAG accessibility", "Pytania do JST": "Questions for local government",
    "Wsparcie AI": "AI support", "Nie znaleziono dyskusji pasujących do zapytania.": "No discussions match your query.",
    "Asystent AI Forum & Mentorzy": "AI Assistant, Forum & Mentors", "Zadaj szybkie pytanie do Bazy RAG ROPS": "Ask the ROPS RAG database a quick question",
    "Nie czekaj — sprawdź dofinansowania i innowacje w Małopolsce!": "Don't wait — check funding and innovations in Małopolska!", "Zapytaj AI Bazy Wiedzy": "Ask the AI knowledge base",
    "Dostępni Mentorzy ROPS i Eksperci": "Available ROPS mentors and experts", "Czat": "Chat", "Specjalizacja: Innowacje Senioralne": "Specialisation: Senior innovation",
    "Specjalizacja: Dostępność WCAG i Prawo": "Specialisation: WCAG accessibility and law", "Specjalizacja: Finansowanie i Granty": "Specialisation: Funding and grants",
    "Tytuł dyskusji": "Discussion title", "Treść pytania": "Question", "Opublikuj wątek": "Publish thread",
    "Przestrzeń ekspercka": "Expert space", "Panel mentorów": "Mentor dashboard",
    "Przeglądaj pomysły mieszkańców, przekazuj rekomendacje i uczestnicz w rozmowach.": "Review residents' ideas, provide recommendations and join discussions.",
    "Przejdź do forum": "Go to forum", "Pomysły do przejrzenia": "Ideas to review", "oczekujące na feedback": "awaiting feedback",
    "Udzielony feedback": "Feedback provided", "zapisane rekomendacje": "saved recommendations", "Wątki o pomysłach": "Idea threads", "dyskusje społeczności": "community discussions",
    "Otwórz zgłoszenie, aby dodać rekomendację.": "Open a submission to add a recommendation.", "Szukaj pomysłów": "Search ideas", "Do opinii": "To review",
    "Z moim feedbackiem": "With my feedback", "Brak pomysłów pasujących do wybranego filtra.": "No ideas match the selected filter.", "Data propozycji": "Proposal date",
    "Historia feedbacku": "Feedback history", "Nie dodano jeszcze rekomendacji.": "No recommendations yet.", "Twoja rekomendacja": "Your recommendation",
    "Kontakt z autorem": "Contact with author", "Zapisz feedback": "Save feedback", "Forum społeczności": "Community forum",
    "Wybierz temat i dołącz do rozmowy.": "Choose a topic and join the conversation.", "Wszystkie wątki": "All threads", "Szukaj wątków": "Search threads",
    "Otwórz forum": "Open forum", "Strefa mieszkańca": "Resident area", "Tutaj znajdziesz statusy swoich zaproponowanych pomysłów.": "Here you can track the status of your submitted ideas.",
    "Zaproponuj pomysł": "Submit an idea", "Twoje pomysły": "Your ideas", "Aktualny etap obsługi zgłoszenia": "Current processing stage", "Pomysł": "Idea",
    "Data zgłoszenia": "Submission date", "Nie masz jeszcze zgłoszonych pomysłów. Dodaj pierwszy, aby śledzić jego status.": "You have not submitted any ideas yet. Add your first one to track its status.",
    "Pomysły, wiadomości i dane profilu w jednym miejscu.": "Ideas, messages and profile details in one place.", "Wróć do panelu": "Back to dashboard",
    "Mieszkaniec Małopolski": "Małopolska resident", "Uzupełnij miejscowość w danych profilu": "Add your town in profile details", "zgłoszonych pomysłów": "submitted ideas",
    "nieprzeczytanych wiadomości": "unread messages", "Wiadomości": "Messages", "Moje pomysły": "My ideas", "Moje dane": "My details", "Moje pytania": "My questions",
    "Przegląd innowacji": "Innovation overview", "Informacje zwrotne i kontakt w sprawie Twoich pomysłów.": "Feedback and contact regarding your ideas.",
    "Wiadomości od mentorów i ROPS pojawią się tutaj.": "Messages from mentors and ROPS will appear here.", "Wybierz wiadomość z listy, aby ją przeczytać.": "Select a message to read it.",
    "Śledź status zgłoszeń.": "Track submission status.", "Dodaj pomysł": "Add idea", "Nie masz jeszcze zgłoszonych pomysłów.": "You have not submitted any ideas yet.",
    "Możesz je zaktualizować w dowolnym momencie.": "You can update them at any time.", "Imię i nazwisko": "Full name", "Adres e-mail": "Email address",
    "Numer telefonu": "Phone number", "Miejscowość": "Town / city", "Zapisz zmiany": "Save changes",
    "Czytaj stronę na głos": "Read page aloud", "Zatrzymaj czytanie strony na głos": "Stop reading page aloud", "Zamknij": "Close",
    "Ustawienia dostępności": "Accessibility settings", "Główna nawigacja": "Main navigation", "Nawigacja według grup odbiorców": "Navigation by audience group",
    "Wyślij": "Send", "Zapytaj asystenta…": "Ask the assistant…", "Zadaj pytanie asystentowi": "Ask the assistant a question",
    "Asystent analizuje Twoją wiadomość…": "The assistant is analysing your message…",
    "Asystent jest chwilowo niedostępny. Spróbuj ponownie.": "The assistant is temporarily unavailable. Please try again.",
    "Nie udało się połączyć z asystentem. Sprawdź połączenie i spróbuj ponownie.": "Could not connect to the assistant. Check your connection and try again."
  };

  const uk = Object.assign({}, en, {
    "Przejdź do treści": "Перейти до вмісту", "Dostępność": "Доступність", "Kontrast": "Контраст", "Wielkość tekstu": "Розмір тексту",
    "Język strony": "Мова сторінки", "Wybierz język strony": "Виберіть мову сторінки", "Polski": "Польська", "Strona główna": "Головна",
    "Mam pomysł!": "У мене є ідея!", "Zostań testerem": "Стати тестувальником", "Mapa potrzeb": "Мапа потреб", "Forum": "Форум", "Wsparcie": "Підтримка",
    "Zaloguj się": "Увійти", "Zarejestruj się": "Зареєструватися", "Twoje konto": "Ваш обліковий запис", "Twój panel": "Ваша панель",
    "Mieszkańcy i NGO": "Мешканці та НУО", "Jednostki samorządu terytorialnego": "Органи місцевого самоврядування", "Pracownicy ROPS": "Працівники ROPS",
    "Eksperci branżowi i mentorzy": "Галузеві експерти та ментори", "Menu": "Меню", "Logo organizacji": "Логотип організації",
    "Wspólnie zmieniamy Małopolskę": "Разом змінюємо Малопольщу", "Masz problem?": "Маєте проблему?", "Znajdźmy": "Знайдімо", "rozwiązanie.": "рішення.",
    "Opowiedz nam własnymi słowami, z czym mierzy się Twoja społeczność — resztą zajmiemy się my.": "Розкажіть своїми словами, з чим стикається ваша громада — решту зробимо ми.",
    "Opisz swój problem i skorzystaj z pomocy naszego asystenta": "Опишіть проблему та скористайтеся допомогою нашого асистента",
    "wdrożonych innowacji": "впроваджених інновацій", "w Małopolsce": "у Малопольщі", "wykorzystane granty": "використані гранти", "inicjatywy w trakcie": "ініціативи в процесі", "realizacji": "реалізації",
    "Regionalny Ośrodek Polityki": "Регіональний центр соціальної", "Społecznej": "політики", "Zacznijmy od początku...": "Почнімо спочатку...",
    "Napisz krótko, pomożemy Ci dopracować szczegóły później": "Напишіть коротко, ми допоможемо уточнити деталі пізніше", "Tytuł pomysłu": "Назва ідеї",
    "Dla kogo jest to rozwiązanie?": "Для кого це рішення?", "Możesz wybrać kilka grup": "Можна вибрати кілька груп", "Seniorzy": "Літні люди",
    "Rodzice / Opiekunowie": "Батьки / Опікуни", "Nauczyciele / Szkoły": "Вчителі / Школи", "Dzieci i młodzież": "Діти та молодь",
    "Osoby z niepełnosprawnościami": "Люди з інвалідністю", "Mieszkańcy / Sąsiedzi": "Мешканці / Сусіди", "Dalej": "Далі",
    "Skorzystaj z pomocy naszego Asystenta AI": "Скористайтеся допомогою нашого ШІ-асистента", "przy wypełnianiu formularza": "під час заповнення форми",
    "Małopolska · potrzeby i działania": "Малопольща · потреби та заходи", "Zobacz, gdzie powstają innowacje społeczne i jakie problemy zgłaszają mieszkańcy.": "Подивіться, де виникають соціальні інновації та про які проблеми повідомляють мешканці.",
    "Dane demonstracyjne": "Демонстраційні дані", "Innowacje w miastach": "Інновації в містах", "Wybierz punkt lub miasto": "Виберіть точку або місто",
    "Miasta na mapie": "Міста на мапі", "9 miast": "9 міст", "Wybrany obszar": "Вибрана територія", "Cała Małopolska": "Уся Малопольща",
    "Wdrożone innowacje": "Впроваджені інновації", "społeczne rozwiązania": "соціальні рішення", "Zaproponowane innowacje": "Запропоновані інновації",
    "pomysły mieszkańców": "ідеї мешканців", "Zgłoszone problemy": "Заявлені проблеми", "potrzeby społeczności": "потреби громади", "Kategorie problemów": "Категорії проблем",
    "Wybierz powiat i monitoruj pomysły": "Виберіть повіт і відстежуйте ідеї", "Wybierz powiat": "Виберіть повіт", "Sprawdź zgłoszenia": "Переглянути заявки",
    "Dodaj materiały": "Додати матеріали", "Sprawdź forum": "Перейти на форум", "Statystyki i Potrzeby:": "Статистика та потреби:", "Powiat Krakowski": "Краківський повіт",
    "Pomysły mieszkańców": "Ідеї мешканців", "Autor": "Автор", "Gmina": "Гміна", "Status": "Статус", "Szczegóły": "Деталі", "Otwórz": "Відкрити",
    "Zatwierdzone": "Схвалено", "Oczekuje na decyzję": "Очікує рішення", "Odrzucone": "Відхилено", "Wróć do listy pomysłów": "Назад до списку ідей",
    "Szczegóły zgłoszenia": "Деталі заявки", "Data zaproponowania": "Дата пропозиції", "Kategoria": "Категорія", "Opis pomysłu": "Опис ідеї",
    "Skontaktuj się z autorem": "Зв’язатися з автором", "Zaakceptuj pomysł": "Схвалити ідею", "Odrzuć pomysł": "Відхилити ідею",
    "Szukaj w dyskusjach": "Шукати в обговореннях", "Rozpocznij nowy wątek": "Почати нову тему", "Dostępni mentorzy:": "Доступні ментори:",
    "Dyskusje": "Обговорення", "Wszystkie": "Усі", "Pomysły": "Ідеї", "Dostępność WCAG": "Доступність WCAG", "Pytania do JST": "Питання до місцевої влади",
    "Wsparcie AI": "Підтримка ШІ", "Nie znaleziono dyskusji pasujących do zapytania.": "Обговорень за запитом не знайдено.", "Czat": "Чат",
    "Tytuł dyskusji": "Назва обговорення", "Treść pytania": "Текст запитання", "Opublikuj wątek": "Опублікувати тему", "Przestrzeń ekspercka": "Експертний простір",
    "Panel mentorów": "Панель менторів", "Przejdź do forum": "Перейти на форум", "Pomysły do przejrzenia": "Ідеї для перегляду", "Udzielony feedback": "Наданий відгук",
    "Wątki o pomysłach": "Теми про ідеї", "Szukaj pomysłów": "Шукати ідеї", "Do opinii": "Для оцінки", "Z moim feedbackiem": "З моїм відгуком",
    "Data propozycji": "Дата пропозиції", "Historia feedbacku": "Історія відгуків", "Twoja rekomendacja": "Ваша рекомендація", "Zapisz feedback": "Зберегти відгук",
    "Forum społeczności": "Форум спільноти", "Wszystkie wątki": "Усі теми", "Szukaj wątków": "Шукати теми", "Otwórz forum": "Відкрити форум",
    "Strefa mieszkańca": "Зона мешканця", "Zaproponuj pomysł": "Запропонувати ідею", "Twoje pomysły": "Ваші ідеї", "Pomysł": "Ідея",
    "Data zgłoszenia": "Дата подання", "Pomysły, wiadomości i dane profilu w jednym miejscu.": "Ідеї, повідомлення та дані профілю в одному місці.",
    "Wróć do panelu": "Назад до панелі", "Mieszkaniec Małopolski": "Мешканець Малопольщі", "Wiadomości": "Повідомлення", "Moje pomysły": "Мої ідеї",
    "Moje dane": "Мої дані", "Moje pytania": "Мої запитання", "Przegląd innowacji": "Огляд інновацій", "Dodaj pomysł": "Додати ідею",
    "Imię i nazwisko": "Ім’я та прізвище", "Adres e-mail": "Електронна адреса", "Numer telefonu": "Номер телефону", "Miejscowość": "Населений пункт",
    "Zapisz zmiany": "Зберегти зміни", "Czytaj stronę na głos": "Прочитати сторінку вголос", "Zatrzymaj czytanie strony na głos": "Зупинити читання",
    "Zamknij": "Закрити", "Ustawienia dostępności": "Налаштування доступності", "Główna nawigacja": "Головна навігація", "Nawigacja według grup odbiorców": "Навігація за групами користувачів"
  });

  Object.assign(uk, {
    "428 zgłoszeń": "428 заявок", "Aktualny etap obsługi zgłoszenia": "Поточний етап розгляду заявки",
    "Aktywizacja Młodzieży i Integracja (": "Активізація молоді та інтеграція (", "Asystent AI Forum & Mentorzy": "ШІ-асистент, форум і ментори",
    "Brak pomysłów pasujących do wybranego filtra.": "Немає ідей, що відповідають вибраному фільтру.",
    "Dane przykładowe do celów prezentacyjnych. Nie pochodzą z bieżącego rejestru zgłoszeń.": "Прикладні дані для презентації. Вони не походять із поточного реєстру заявок.",
    "Dostępni Mentorzy ROPS i Eksperci": "Доступні ментори ROPS та експерти", "Filtruj całe podsumowanie dla wybranego regionu:": "Фільтрувати все зведення для вибраного регіону:",
    "Informacje zwrotne i kontakt w sprawie Twoich pomysłów.": "Відгуки та контакти щодо ваших ідей.", "Kontakt z autorem": "Зв’язок з автором",
    "Liczba innowacji oznacza przykładowe wdrożenia przypisane do miasta.": "Кількість інновацій означає приклади впроваджень, закріплених за містом.",
    "Możesz je zaktualizować w dowolnym momencie.": "Ви можете оновити їх у будь-який час.",
    "Nie czekaj — sprawdź dofinansowania i innowacje w Małopolsce!": "Не зволікайте — перегляньте фінансування та інновації в Малопольщі!",
    "Nie dodano jeszcze rekomendacji.": "Рекомендацій ще не додано.", "Nie masz jeszcze zgłoszonych pomysłów.": "Ви ще не подали жодної ідеї.",
    "Nie masz jeszcze zgłoszonych pomysłów. Dodaj pierwszy, aby śledzić jego status.": "Ви ще не подали жодної ідеї. Додайте першу, щоб відстежувати її статус.",
    "Opieka Wytchnieniowa i Zdrowie (": "Перепочинковий догляд і здоров’я (", "Otwórz zgłoszenie, aby dodać rekomendację.": "Відкрийте заявку, щоб додати рекомендацію.",
    "Przeglądaj pomysły mieszkańców, przekazuj rekomendacje i uczestnicz w rozmowach.": "Переглядайте ідеї мешканців, надавайте рекомендації та беріть участь в обговореннях.",
    "Przykład widoku przed podłączeniem rejestru zgłoszeń.": "Приклад вигляду до підключення реєстру заявок.",
    "Rozkład zgłoszonych Pomysłów wg kategorii w powiecie:": "Розподіл поданих ідей за категоріями в повіті:",
    "Seniorzy i Dostępność Cyfrowa (": "Літні люди та цифрова доступність (", "Specjalizacja: Dostępność WCAG i Prawo": "Спеціалізація: доступність WCAG і право",
    "Specjalizacja: Finansowanie i Granty": "Спеціалізація: фінансування та гранти", "Specjalizacja: Innowacje Senioralne": "Спеціалізація: інновації для літніх людей",
    "Sprawdź, czy Twój pomysł nie istnieje już w bazie innowacji, pytając o to naszego Asystenta...": "Запитайте нашого асистента, чи вашої ідеї ще немає в базі інновацій...",
    "Tutaj znajdziesz statusy swoich zaproponowanych pomysłów.": "Тут ви знайдете статуси запропонованих вами ідей.",
    "Uzupełnij miejscowość w danych profilu": "Додайте населений пункт у даних профілю", "Wiadomości od mentorów i ROPS pojawią się tutaj.": "Тут з’являться повідомлення від менторів і ROPS.",
    "Wybierz temat i dołącz do rozmowy.": "Виберіть тему та долучіться до розмови.", "Wybierz wiadomość z listy, aby ją przeczytać.": "Виберіть повідомлення зі списку, щоб прочитати його.",
    "Zadaj szybkie pytanie do Bazy RAG ROPS": "Поставте коротке запитання базі RAG ROPS", "Zapytaj AI Bazy Wiedzy": "Запитати ШІ бази знань",
    "dyskusje społeczności": "обговорення спільноти", "nieprzeczytanych wiadomości": "непрочитаних повідомлень", "oczekujące na feedback": "очікують на відгук",
    "pomysłów)": "ідей)", "powiat krakowski": "Краківський повіт", "powiat tatrzański": "Татранський повіт", "powiat wielicki": "Велицький повіт",
    "zapisane rekomendacje": "збережені рекомендації", "zgłoszonych pomysłów": "поданих ідей", "Śledź status zgłoszeń.": "Відстежуйте статус заявок.",
    "Wyślij": "Надіслати", "Zapytaj asystenta…": "Запитайте асистента…", "Zadaj pytanie asystentowi": "Поставте запитання асистенту",
    "Asystent analizuje Twoją wiadomość…": "Асистент аналізує ваше повідомлення…",
    "Asystent jest chwilowo niedostępny. Spróbuj ponownie.": "Асистент тимчасово недоступний. Спробуйте ще раз.",
    "Nie udało się połączyć z asystentem. Sprawdź połączenie i spróbuj ponownie.": "Не вдалося з’єднатися з асистентом. Перевірте з’єднання та спробуйте ще раз."
  });

  const resources = { pl: { translation: {} }, en: { translation: en }, uk: { translation: uk } };
  const originalText = new WeakMap();
  const originalAttributes = new WeakMap();
  const translatedAttributes = ["aria-label", "title", "placeholder", "content"];
  let observer;

  function translateValue(value, t) {
    if (!value) return value;
    const leading = value.match(/^\s*/)[0];
    const trailing = value.match(/\s*$/)[0];
    const clean = value.trim();
    return clean ? leading + t(clean, { defaultValue: clean }) + trailing : value;
  }

  function translateTree(root, t, language) {
    if (root.nodeType === Node.TEXT_NODE) {
      if (!originalText.has(root)) originalText.set(root, root.nodeValue);
      const source = originalText.get(root);
      root.nodeValue = language === "pl" ? source : translateValue(source, t);
      return;
    }
    if (root.nodeType !== Node.ELEMENT_NODE && root.nodeType !== Node.DOCUMENT_NODE) return;
    const walker = document.createTreeWalker(root, NodeFilter.SHOW_TEXT, {
      acceptNode(node) {
        return /^(SCRIPT|STYLE|SVG|NOSCRIPT)$/.test(node.parentElement?.tagName) ? NodeFilter.FILTER_REJECT : NodeFilter.FILTER_ACCEPT;
      }
    });
    while (walker.nextNode()) {
      const node = walker.currentNode;
      if (!originalText.has(node)) originalText.set(node, node.nodeValue);
      const source = originalText.get(node);
      node.nodeValue = language === "pl" ? source : translateValue(source, t);
    }
    const elements = root.nodeType === Node.ELEMENT_NODE ? [root, ...root.querySelectorAll("*")] : root.querySelectorAll("*");
    elements.forEach((element) => {
      let originals = originalAttributes.get(element);
      if (!originals) { originals = {}; originalAttributes.set(element, originals); }
      translatedAttributes.forEach((attribute) => {
        if (!element.hasAttribute(attribute)) return;
        if (!(attribute in originals)) originals[attribute] = element.getAttribute(attribute);
        const source = originals[attribute];
        element.setAttribute(attribute, language === "pl" ? source : t(source, { defaultValue: source }));
      });
    });
  }

  function observeChanges(t, language) {
    observer = new MutationObserver((mutations) => {
      observer.disconnect();
      mutations.forEach((mutation) => {
        if (mutation.type === "childList") mutation.addedNodes.forEach((node) => translateTree(node, t, language));
        if (mutation.type === "characterData") {
          originalText.set(mutation.target, mutation.target.nodeValue);
          translateTree(mutation.target, t, language);
        }
        if (mutation.type === "attributes") {
          const originals = originalAttributes.get(mutation.target) || {};
          originals[mutation.attributeName] = mutation.target.getAttribute(mutation.attributeName);
          originalAttributes.set(mutation.target, originals);
          translateTree(mutation.target, t, language);
        }
      });
      observer.observe(document.body, { childList: true, subtree: true, characterData: true, attributes: true, attributeFilter: translatedAttributes });
    });
    observer.observe(document.body, { childList: true, subtree: true, characterData: true, attributes: true, attributeFilter: translatedAttributes });
  }

  function applyTranslations(t, language) {
    observer && observer.disconnect();
    translateTree(document.documentElement, t, language);
    document.documentElement.lang = language;
    document.documentElement.dir = "ltr";
    window.siteLocale = ({ pl: "pl-PL", en: "en-GB", uk: "uk-UA" })[language] || "pl-PL";
    document.querySelectorAll("#language").forEach((select) => { select.value = language; });
    document.querySelectorAll(".language-flag").forEach((flag) => { flag.dataset.language = language; });
    observeChanges(t, language);
    window.dispatchEvent(new CustomEvent("site-language-changed", { detail: { language } }));
  }

  function TranslationController() {
    const hook = ReactI18next.useTranslation();
    React.useEffect(() => {
      const render = (requestedLanguage) => {
        const language = typeof requestedLanguage === "string" ? requestedLanguage : (hook.i18n.resolvedLanguage || hook.i18n.language);
        applyTranslations(hook.i18n.getFixedT(language), language);
      };
      render();
      const selectLanguage = (event) => hook.i18n.changeLanguage(event.target.value);
      document.addEventListener("change", (event) => { if (event.target.matches("#language")) selectLanguage(event); });
      hook.i18n.on("languageChanged", render);
      return () => { observer.disconnect(); hook.i18n.off("languageChanged", render); };
    }, [hook.i18n]);
    return null;
  }

  const savedLanguage = ["pl", "en", "uk"].includes(localStorage.getItem("site-language")) ? localStorage.getItem("site-language") : "pl";
  window.siteLocale = ({ pl: "pl-PL", en: "en-GB", uk: "uk-UA" })[savedLanguage];
  i18next.use(ReactI18next.initReactI18next).init({
    resources,
    lng: savedLanguage,
    fallbackLng: "pl",
    keySeparator: false,
    nsSeparator: false,
    interpolation: { escapeValue: false }
  }).then(() => {
    i18next.on("languageChanged", (language) => localStorage.setItem("site-language", language));
    const mount = document.createElement("div");
    mount.id = "i18n-react-root";
    mount.hidden = true;
    document.body.append(mount);
    ReactDOM.createRoot(mount).render(React.createElement(ReactI18next.I18nextProvider, { i18n: i18next }, React.createElement(TranslationController)));
    window.siteI18n = i18next;
  });
})();
