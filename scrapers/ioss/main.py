from __future__ import annotations

import logging
import os
import sys

if __package__ in {None, ""}:
    # Allows: python scrapers/ioss/main.py
    sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(__file__))))

from scrapers.ioss.database import connect, save_to_postgres
from scrapers.ioss.scraper import scrape


def env_float(name: str, default: float) -> float:
    try:
        return float(os.getenv(name, str(default)))
    except ValueError as exc:
        raise ValueError(f"Zmienna {name} musi być liczbą.") from exc


def main() -> None:
    logging.basicConfig(level=os.getenv("LOG_LEVEL", "INFO"), format="%(levelname)s %(message)s")
    indicators, data = scrape(
        base_url=os.getenv("IOSS_BASE_URL", "https://obserwator.rops.krakow.pl/"),
        timeout=env_float("IOSS_TIMEOUT", 45),
        delay=env_float("IOSS_REQUEST_DELAY", 0.2),
        user_agent=os.getenv(
            "IOSS_USER_AGENT",
            "IOSSDataImporter/1.0 (+https://obserwator.rops.krakow.pl/)",
        ),
    )
    connection = connect(
        os.getenv("DATABASE_URL"),
        {
            "dbname": os.getenv("DB_NAME", "mydb"),
            "user": os.getenv("DB_USER", "myuser"),
            "password": os.getenv("DB_PASSWORD", "mypassword"),
            "host": os.getenv("DB_HOST", "localhost"),
            "port": os.getenv("DB_PORT", "5432"),
        },
    )
    try:
        save_to_postgres(connection, indicators, data)
    finally:
        connection.close()
    logging.info(
        "Gotowe: zapisano %d powiatów i %d statystyk (najnowsze dostępne lata) do tabeli ioss.",
        len(data),
        len(indicators),
    )


if __name__ == "__main__":
    main()
