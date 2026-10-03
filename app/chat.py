import os
import psycopg2
import requests
from flask import Blueprint, request, jsonify
from ioss_needs import county_needs, format_needs

chat_bp = Blueprint("chat", __name__)

OLLAMA_HOST = os.getenv("OLLAMA_HOST", "http://ollama:11434")
OLLAMA_MODEL = os.getenv("OLLAMA_MODEL", "SpeakLeash/bielik-minitron-7B-v3.0-instruct:Q4_K_M")
SEARCH_URL = os.getenv("SEARCH_URL", "http://localhost:5000/search")
TOP_K = 5
MIN_RERANK_SCORE = 0.5  # poniżej tego progu fragment uznajemy za nietrafiony
MAX_HISTORY = 6

SYSTEM_PROMPT = """Jesteś asystentem Regionalnego Ośrodka Polityki Społecznej w Krakowie. Pomagasz mieszkańcom Małopolski, organizacjom pozarządowym i samorządom w pracy nad innowacjami społecznymi.
Otrzymujesz wiadomość użytkownika oraz ponumerowane projekty z bazy wiedzy.

Krok 1. Ustal, czy użytkownik ma konkretny pomysł, czy opisuje tylko problem (np. pisze, że nie wie, co zrobić).

Krok 2. Zacznij odpowiedź od dokładnie jednej etykiety:
- "ISTNIEJE:" – projekt z bazy realizuje ten sam pomysł,
- "PODOBNE:" – projekt z bazy ma podobny cel, grupę odbiorców lub sposób działania,
- "NOWY POMYSŁ:" – żaden projekt z bazy nie jest podobny,
- "POMOC W POMYŚLE:" – użytkownik opisuje tylko problem, bez pomysłu.
Jeśli w bazie wiedzy jest jakikolwiek projekt o podobnym celu lub grupie odbiorców, nie używaj etykiety "NOWY POMYSŁ:".

Krok 3. Krótko napisz, czym pasujące projekty z bazy różnią się od pomysłu użytkownika lub czym mogą go zainspirować (bez linków – zostaną dodane automatycznie).

Krok 4.
- Przy "ISTNIEJE:" i "PODOBNE:" – zaproponuj, co użytkownik może zrobić inaczej lub lepiej albo jak wykorzystać istniejący projekt.
- Przy "NOWY POMYSŁ:" – zaproponuj, jak rozwinąć pomysł.
- Przy "POMOC W POMYŚLE:" – zadaj 1–2 pytania doprecyzowujące (np. o grupę odbiorców, zasoby, miejsce) ORAZ od razu zaproponuj 2–3 krótkie kierunki rozwiązań, nie czekając na odpowiedź.

Opieraj się wyłącznie na projektach z bazy wiedzy. Nie wymyślaj projektów, tytułów ani linków. Odpowiadaj po polsku, zwięźle.

Jeśli otrzymasz dane IOSS o powiecie: na podstawie nazwy każdego wskaźnika oceń, czy odchylenie od średniej oznacza problem społeczny (np. wyższe bezrobocie, niższa dostępność usług), a wskaźniki neutralne pomiń. Proponując innowacje, odpowiadaj na te problemy i powołuj się na konkretne wskaźniki z liczbami. Nie podawaj liczb, których nie ma w danych."""


def search_knowledge(query):
    r = requests.post(SEARCH_URL, json={"query": query, "top_k": TOP_K}, timeout=60)
    r.raise_for_status()
    results = r.json().get("results", [])
    return [res for res in results if (res.get("score_reranker") or 0) >= MIN_RERANK_SCORE]


def format_context(sources):
    if not sources:
        return "Brak pasujących projektów w bazie wiedzy."
    parts = []
    for i, s in enumerate(sources, 1):
        parts.append(f"[{i}] {s.get('tytul')}\nLink: {s.get('url')}\nFragment: {s.get('fragment')}")
    return "\n\n".join(parts)


@chat_bp.route("/chat", methods=["POST"])
def chat():
    data = request.get_json(silent=True) or {}
    message = (data.get("message") or "").strip()
    history = [m for m in data.get("history", []) if m.get("role") in ("user", "assistant")]

    if not message:
        return jsonify({"error": "Brak wiadomości"}), 400

    # Powiat może paść wcześniej w rozmowie — szukamy w wiadomościach użytkownika
    user_text = " ".join([m.get("content", "") for m in history if m.get("role") == "user"] + [message])
    try:
        county, needs = county_needs(user_text)
    except psycopg2.Error:
        county, needs = None, []  # bez danych IOSS czat działa dalej

    try:
        sources = search_knowledge(message)
    except requests.RequestException as e:
        return jsonify({"error": f"Błąd wyszukiwarki: {str(e)}"}), 502

    messages = [{"role": "system", "content": SYSTEM_PROMPT}]
    messages += history[-MAX_HISTORY:]
    context = f"Baza wiedzy:\n{format_context(sources)}"
    if needs:
        context += f"\n\n{format_needs(county, needs)}"
    messages.append({
        "role": "user",
        "content": f"{context}\n\nWiadomość użytkownika:\n{message}\n\nOdpowiedz zgodnie z krokami 1–4, zaczynając od etykiety.",
    })

    try:
        r = requests.post(
            f"{OLLAMA_HOST}/api/chat",
            json={"model": OLLAMA_MODEL, "messages": messages, "stream": False, "options": {"temperature": 0.4}},
            timeout=300,  # pierwsze zapytanie ładuje model do pamięci
        )
        r.raise_for_status()
    except requests.RequestException as e:
        return jsonify({"error": f"Błąd modelu językowego: {str(e)}"}), 502

    answer = r.json()["message"]["content"].strip()
    if sources:
        # Linki dopisujemy w kodzie — model często je pomija
        answer += "\n\nPowiązane projekty z bazy:\n" + "\n".join(f"- {s.get('tytul')} – {s.get('url')}" for s in sources)

    return jsonify({"answer": answer, "sources": sources, "powiat": county, "potrzeby": needs})
