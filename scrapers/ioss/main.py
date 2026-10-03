from __future__ import annotations

import argparse
import logging
import os
import sys
import time

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


LOGGER = logging.getLogger(__name__)


def run_import() -> None:
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
    LOGGER.info(
        "Gotowe: zapisano %d powiatów i %d statystyk (najnowsze dostępne lata) do tabeli ioss.",
        len(data),
        len(indicators),
    )


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Import danych IOSS do PostgreSQL.")
    parser.add_argument(
        "--interval-hours",
        type=float,
        default=None,
        help="Powtarzaj import co podaną liczbę godzin; bez tej opcji wykonaj go jeden raz.",
    )
    return parser.parse_args()


def main() -> None:
    logging.basicConfig(level=os.getenv("LOG_LEVEL", "INFO"), format="%(levelname)s %(message)s")
    args = parse_args()
    interval_hours = args.interval_hours
    if interval_hours is None and os.getenv("IOSS_INTERVAL_HOURS"):
        interval_hours = env_float("IOSS_INTERVAL_HOURS", 48)
    if interval_hours is not None and interval_hours <= 0:
        raise ValueError("Interwał scrapowania musi być większy od zera.")

    while True:
        try:
            run_import()
        except Exception:
            if interval_hours is None:
                raise
            LOGGER.exception("Import IOSS zakończył się błędem; kolejna próba nastąpi zgodnie z harmonogramem.")

        if interval_hours is None:
            return
        wait_seconds = interval_hours * 60 * 60
        LOGGER.info("Kolejny import za %.2f godz.", interval_hours)
        try:
            time.sleep(wait_seconds)
        except KeyboardInterrupt:
            LOGGER.info("Zatrzymano harmonogram importu IOSS.")
            return


if __name__ == "__main__":
    main()
