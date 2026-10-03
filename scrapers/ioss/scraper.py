from __future__ import annotations

import logging
import re
import time
import unicodedata
from dataclasses import dataclass
from decimal import Decimal, InvalidOperation
from urllib.parse import urljoin

import requests
from bs4 import BeautifulSoup, Tag
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry


LOGGER = logging.getLogger(__name__)
INDICATOR_PATH_RE = re.compile(r"^/differenceanalysis/(\d+)/?$")
YEAR_RE = re.compile(r"\bRok\s+(\d{4})\b", re.IGNORECASE)


@dataclass(frozen=True)
class Indicator:
    indicator_id: int
    name: str
    url: str
    year: int | None = None

    @property
    def column_name(self) -> str:
        """Return a stable PostgreSQL identifier (maximum 63 bytes)."""
        normalized = unicodedata.normalize("NFKD", self.name)
        ascii_name = normalized.encode("ascii", "ignore").decode("ascii").lower()
        slug = re.sub(r"[^a-z0-9]+", "_", ascii_name).strip("_") or "statystyka"
        prefix = f"s_{self.indicator_id}_"
        available = 63 - len(prefix)
        return prefix + slug[:available].rstrip("_")


def build_session(user_agent: str) -> requests.Session:
    session = requests.Session()
    retry = Retry(
        total=4,
        connect=4,
        read=4,
        backoff_factor=1.0,
        status_forcelist=(429, 500, 502, 503, 504),
        allowed_methods=frozenset(("GET",)),
    )
    session.mount("https://", HTTPAdapter(max_retries=retry))
    session.headers.update({"User-Agent": user_agent, "Accept-Language": "pl-PL,pl;q=0.9"})
    return session


def discover_indicators(html: str, base_url: str) -> list[Indicator]:
    soup = BeautifulSoup(html, "html.parser")
    indicators: dict[int, Indicator] = {}
    for link in soup.select('a[href^="/differenceanalysis/"]'):
        href = link.get("href", "")
        match = INDICATOR_PATH_RE.fullmatch(href)
        name = link.get_text(" ", strip=True)
        if match and name:
            indicator_id = int(match.group(1))
            indicators[indicator_id] = Indicator(
                indicator_id=indicator_id,
                name=name,
                url=urljoin(base_url, href),
            )
    return sorted(indicators.values(), key=lambda item: item.indicator_id)


def _parse_number(raw_value: str) -> Decimal | None:
    value = raw_value.replace("\xa0", " ").strip()
    if not value or value.lower() in {"-", "brak danych", "b.d.", "bd"}:
        return None
    value = value.rstrip("%").strip().replace(" ", "").replace(",", ".")
    try:
        return Decimal(value)
    except InvalidOperation as exc:
        raise ValueError(f"Nie można odczytać wartości liczbowej: {raw_value!r}") from exc


def _find_county_table(soup: BeautifulSoup) -> Tag:
    table = soup.select_one("#tabela .analysisTable > table")
    if table is None:
        table = soup.select_one("table.with-child-tables")
    if not isinstance(table, Tag):
        raise ValueError("Nie znaleziono tabeli powiatów w sekcji 'Tabela'.")
    return table


def parse_county_table(html: str) -> tuple[int, dict[str, Decimal | None]]:
    soup = BeautifulSoup(html, "html.parser")
    table = _find_county_table(soup)
    headings = [cell.get_text(" ", strip=True) for cell in table.select("thead th")]
    years = [int(match.group(1)) for heading in headings if (match := YEAR_RE.search(heading))]
    if len(years) != 1:
        raise ValueError(f"Nie udało się jednoznacznie ustalić roku tabeli: {headings!r}.")

    result: dict[str, Decimal | None] = {}
    # direct=True excludes the nested municipality tables contained in county rows.
    tbody = table.find("tbody", recursive=False)
    if not isinstance(tbody, Tag):
        raise ValueError("Tabela powiatów nie zawiera sekcji tbody.")
    for row in tbody.find_all("tr", recursive=False):
        cells = row.find_all("td", recursive=False)
        if len(cells) < 2:
            continue
        county = cells[0].get_text(" ", strip=True)
        if county.lower().startswith("powiat "):
            result[county] = _parse_number(cells[1].get_text(" ", strip=True))
    if not result:
        raise ValueError("Tabela nie zawiera danych powiatowych.")
    return years[0], result


def scrape(
    base_url: str,
    timeout: float,
    delay: float,
    user_agent: str,
) -> tuple[list[Indicator], dict[str, dict[str, Decimal | None]]]:
    session = build_session(user_agent)
    start_url = urljoin(base_url.rstrip("/") + "/", "differenceanalysis/1")
    response = session.get(start_url, timeout=timeout)
    response.raise_for_status()
    indicators = discover_indicators(response.text, base_url)
    if not indicators:
        raise RuntimeError("Nie znaleziono odnośników do statystyk IOSS.")

    data: dict[str, dict[str, Decimal | None]] = {}
    available: list[Indicator] = []
    for position, indicator in enumerate(indicators, start=1):
        LOGGER.info("[%d/%d] %s", position, len(indicators), indicator.name)
        try:
            page = response if indicator.url.rstrip("/").endswith("/1") else session.get(
                indicator.url, timeout=timeout
            )
            page.raise_for_status()
        except requests.RequestException as exc:
            LOGGER.warning("Pomijam statystykę %s: błąd HTTP: %s", indicator.indicator_id, exc)
            continue
        try:
            table_year, county_values = parse_county_table(page.text)
        except ValueError as exc:
            LOGGER.warning("Pomijam statystykę %s: %s", indicator.indicator_id, exc)
        else:
            indicator = Indicator(
                indicator_id=indicator.indicator_id,
                name=indicator.name,
                url=indicator.url,
                year=table_year,
            )
            available.append(indicator)
            LOGGER.info("Rok danych: %d", table_year)
            for county, value in county_values.items():
                data.setdefault(county, {})[indicator.column_name] = value
        if delay > 0 and position != len(indicators):
            time.sleep(delay)

    if not data:
        raise RuntimeError("Nie znaleziono żadnych danych powiatowych.")
    return available, data
