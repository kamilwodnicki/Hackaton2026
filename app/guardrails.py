import re
import unicodedata

MAX_MESSAGE_LENGTH = 2000


def _normalize(text):
    text = text.lower().replace("ł", "l")
    return unicodedata.normalize("NFKD", text).encode("ascii", "ignore").decode("ascii")


# Wzorce po normalizacji (bez polskich znaków). Celowo w 1. osobie / o konkretnej sytuacji,
# żeby nie łapać opisów projektów typu "przeciwdziałanie przemocy domowej".
CRISIS_PATTERNS = {
    "samobojstwo": [
        r"samoboj", r"\bzabic sie\b", r"\bzabije sie\b", r"odebrac sobie zycie", r"skonczyc ze soba",
        r"ze soba skonczyc", r"nie chce (mi sie )?zyc", r"nie widze sensu (w )?zyci", r"chce umrzec",
        r"okaleczam sie", r"\btne sie\b",
    ],
    "przemoc": [
        r"\bbije mnie\b", r"\bmnie bije\b", r"\bbil mnie\b", r"\bmnie bil\b", r"zneca sie nade mna",
        r"grozi mi", r"jestem ofiara przemocy", r"zgwalc", r"molestuje mnie", r"mnie molestuje",
    ],
    "dziecko": [
        r"zostawia (male |swoje )?dzieci same", r"bije (swoje )?dzieci", r"dziecko jest bite",
        r"krzywdzi (swoje )?dzieck", r"glodzi (swoje )?dzieci",
    ],
}

CRISIS_REPLIES = {
    "samobojstwo": (
        "Bardzo mi przykro, że tak się czujesz. Nie musisz radzić sobie z tym w pojedynkę — "
        "porozmawiaj z kimś, kto może pomóc od razu:\n"
        "- 116 123 – Kryzysowy Telefon Zaufania dla dorosłych\n"
        "- 116 111 – Telefon Zaufania dla Dzieci i Młodzieży\n"
        "- 800 70 2222 – Centrum Wsparcia dla osób w stanie kryzysu psychicznego (całodobowo)\n"
        "Jeśli grozi Ci bezpośrednie niebezpieczeństwo, zadzwoń pod 112."
    ),
    "przemoc": (
        "To, co opisujesz, to przemoc i nie jest Twoją winą. Możesz uzyskać pomoc:\n"
        "- 800 120 002 – „Niebieska Linia”, telefon dla osób doznających przemocy domowej\n"
        "- 112 – jeśli jesteś w niebezpieczeństwie teraz\n"
        "Wsparcie możesz też uzyskać w najbliższym ośrodku pomocy społecznej (OPS)."
    ),
    "dziecko": (
        "Jeśli dziecku grozi niebezpieczeństwo, zadzwoń pod 112. Możesz też:\n"
        "- zgłosić sytuację w ośrodku pomocy społecznej (OPS) lub na policji,\n"
        "- skonsultować się z Dziecięcym Telefonem Zaufania Rzecznika Praw Dziecka: 800 12 12 12."
    ),
}

OFF_TOPIC_REPLY = (
    "Jestem asystentem innowacji społecznych ROPS w Krakowie i pomagam tylko w tym temacie. "
    "Opisz pomysł na projekt społeczny albo problem w swojej okolicy (np. „seniorzy w mojej gminie są samotni”), "
    "a sprawdzę, czy podobne rozwiązania już istnieją, i pomogę go rozwinąć."
)

LABELS = {
    "ISTNIEJE": "odpowiedz",
    "PODOBNE": "odpowiedz",
    "NOWY POMYSŁ": "odpowiedz",
    "POMOC W POMYŚLE": "odpowiedz",
    "ODMOWA": "odmowa",
    "POZA TEMATEM": "poza_tematem",
}


def detect_crisis(message):
    """Zwraca gotową odpowiedź kryzysową albo None."""
    text = _normalize(message)
    for kind, patterns in CRISIS_PATTERNS.items():
        if any(re.search(p, text) for p in patterns):
            return CRISIS_REPLIES[kind]
    return None


def classify_answer(answer):
    """Zwraca (rodzaj, odpowiedź). Odpowiedź bez znanej etykiety traktujemy jak poza tematem."""
    clean = answer.replace("**", "").strip()
    head = clean[:40].upper()
    for label, kind in LABELS.items():
        if label in head:
            if kind == "poza_tematem":
                return kind, OFF_TOPIC_REPLY
            return kind, clean
    return "poza_tematem", OFF_TOPIC_REPLY
