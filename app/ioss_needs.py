import os
import re
import statistics
import unicodedata

import psycopg2

MIN_YEAR = 2019  # starsze dane pomijamy
TOP_NEEDS = 8
POPULATION_COLUMN = "s_186_ludnosc_ogoem"
COUNT_LIKE_CORRELATION = 0.8  # wskaźniki tak mocno skorelowane z ludnością to liczby bezwzględne
COMMENT_RE = re.compile(r"^(.*) \(IOSS id=\d+, najnowszy dostępny rok=(\d{4})\)$")

# Miasta na prawach powiatu i siedziby powiatów — wzorce po normalizacji, z odmianą
ALIASES = {
    "powiat m. Kraków": r"\bkrakow(ie|a)?\b",
    "powiat m. Nowy Sącz": r"\bnow(y|ym|ego) sac(z|zu|za)\b",
    "powiat m. Tarnów": r"\btarnow(ie|a)?\b",
    "powiat bocheński": r"\bbochni",
    "powiat brzeski": r"\bbrzesk(o|a|u)\b",
    "powiat chrzanowski": r"\bchrzanow(a|ie)?\b",
    "powiat dąbrowski": r"\bdabrow\w* tarnowsk",
    "powiat gorlicki": r"\bgorlic(e|ach)?\b",
    "powiat limanowski": r"\blimanow(a|ej)\b",
    "powiat miechowski": r"\bmiechow(a|ie)?\b",
    "powiat myślenicki": r"\bmyslenic(e|ach)?\b",
    "powiat nowotarski": r"\bnow(y|ym|ego) targ(u|iem)?\b",
    "powiat olkuski": r"\bolkusz(a|u)?\b",
    "powiat oświęcimski": r"\boswiecim(ia|iu)?\b",
    "powiat proszowicki": r"\bproszowic(e|ach)?\b",
    "powiat suski": r"\bsuch(a|ej) beskidzk(a|iej)\b",
    "powiat tatrzański": r"\bzakopane(go|m)?\b",
    "powiat wadowicki": r"\bwadowic(e|ach)?\b",
    "powiat wielicki": r"\bwieliczk(a|i|e)\b",
}


def _normalize(text):
    text = text.lower().replace("ł", "l")
    return unicodedata.normalize("NFKD", text).encode("ascii", "ignore").decode("ascii")


def _connect():
    return psycopg2.connect(
        dbname=os.getenv("DB_NAME", "mydb"),
        user=os.getenv("DB_USER", "myuser"),
        password=os.getenv("DB_PASSWORD", "mypassword"),
        host=os.getenv("DB_HOST", "db"),
        port=os.getenv("DB_PORT", "5432"),
    )


def _load_table():
    with _connect() as conn, conn.cursor() as cur:
        cur.execute(
            "SELECT column_name, col_description('ioss'::regclass, ordinal_position) "
            "FROM information_schema.columns WHERE table_name = 'ioss' AND column_name <> 'powiat'"
        )
        meta = {}
        for column, comment in cur.fetchall():
            match = COMMENT_RE.match(comment or "")
            if match:
                meta[column] = {"name": match.group(1), "year": int(match.group(2))}
        cur.execute("SELECT * FROM ioss")
        columns = [d[0] for d in cur.description]
        rows = {row[0]: dict(zip(columns, row)) for row in cur.fetchall()}
    return meta, rows


def detect_county(text, counties):
    text = f" {_normalize(text)} "
    for county in counties:
        if county in ALIASES and re.search(ALIASES[county], text):
            return county
        if county.startswith("powiat m. "):
            continue
        adjective = _normalize(county.removeprefix("powiat "))
        # Przymiotnik tylko po słowie "powiat" — "Krakowskie Przedmieście" to nie powiat krakowski
        if re.search(rf"\bpowi\w*\s+{adjective[:-1]}\w*", text):  # w powiecie nowotarskim
            return county
    return None


def county_needs(texts):
    """Zwraca (powiat, lista potrzeb) dla pierwszego tekstu z rozpoznanym powiatem albo (None, [])."""
    meta, rows = _load_table()
    counties = sorted(rows)
    county = next((c for c in (detect_county(t, counties) for t in texts) if c), None)
    if county is None:
        return None, []

    population = {c: float(r[POPULATION_COLUMN]) for c, r in rows.items() if r.get(POPULATION_COLUMN)}
    needs = []
    for column, info in meta.items():
        if column == POPULATION_COLUMN or info["year"] < MIN_YEAR:
            continue
        values = {c: float(r[column]) for c, r in rows.items() if r.get(column) is not None}
        if county not in values or len(values) < 10:
            continue

        per_capita = False
        common = [c for c in values if c in population]
        if len(common) >= 10 and len(set(values[c] for c in common)) > 1:
            if statistics.correlation([values[c] for c in common], [population[c] for c in common]) > COUNT_LIKE_CORRELATION:
                values = {c: values[c] / population[c] * 10000 for c in common}
                per_capita = True
                if county not in values:
                    continue

        mean = statistics.mean(values.values())
        stdev = statistics.pstdev(values.values())
        if stdev == 0:
            continue
        needs.append({
            "wskaznik": info["name"],
            "rok": info["year"],
            "wartosc": round(values[county], 2),
            "srednia_malopolski": round(mean, 2),
            "na_10_tys_mieszkancow": per_capita,
            "z": round((values[county] - mean) / stdev, 2),
        })

    needs.sort(key=lambda n: abs(n["z"]), reverse=True)
    return county, needs[:TOP_NEEDS]


def format_needs(county, needs):
    lines = [f"Dane IOSS dla: {county} (wskaźniki najbardziej odstające od średniej Małopolski):"]
    for n in needs:
        unit = " na 10 tys. mieszkańców" if n["na_10_tys_mieszkancow"] else ""
        direction = "wyżej" if n["z"] > 0 else "niżej"
        lines.append(f"- {n['wskaznik']} ({n['rok']}): {n['wartosc']}{unit}, średnia Małopolski {n['srednia_malopolski']} – {direction} niż średnia")
    return "\n".join(lines)
