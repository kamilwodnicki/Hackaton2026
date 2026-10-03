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

# Miasta na prawach powiatu — odmiana nazw
CITY_ALIASES = {
    "powiat m. Kraków": ["krakow", "krakowie", "krakowa"],
    "powiat m. Nowy Sącz": ["nowy sacz", "nowym saczu", "nowego sacza"],
    "powiat m. Tarnów": ["tarnow", "tarnowie", "tarnowa"],
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
        for alias in CITY_ALIASES.get(county, []):
            if re.search(rf"\b{alias}\b", text):
                return county
        if county.startswith("powiat m. "):
            continue
        adjective = _normalize(county.removeprefix("powiat "))
        if re.search(rf"\b{adjective[:-1]}\w*", text):  # nowotarski -> nowotarsk...
            return county
    return None


def county_needs(text):
    """Zwraca (powiat, lista potrzeb) albo (None, []) gdy w tekście nie ma powiatu."""
    meta, rows = _load_table()
    county = detect_county(text, sorted(rows))
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
