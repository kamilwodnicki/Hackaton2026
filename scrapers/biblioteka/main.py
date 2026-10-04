from __future__ import annotations

import argparse
import json
import os
import sys
import time

if __package__ in {None, ""}:
    # Allows: python scrapers/biblioteka/main.py
    sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(__file__))))

from scrapers.biblioteka.scraper import Scraper, save_csv


def run_import(args) -> None:
    innovations = Scraper(delay=args.delay).run(args.docs_dir)
    if not innovations:
        # Nie nadpisujemy dobrych danych pustym wynikiem (np. gdy strona ROPS nie odpowiada)
        raise RuntimeError("Nie pobrano żadnych innowacji — pomijam zapis.")

    os.makedirs(os.path.dirname(args.output) or ".", exist_ok=True)
    tmp_path = args.output + ".tmp"
    with open(tmp_path, "w", encoding="utf-8") as f:
        json.dump(innovations, f, ensure_ascii=False, indent=2)
    os.replace(tmp_path, args.output)  # zapis atomowy — ingest nie przeczyta połowy pliku
    print(f"Zapisano {len(innovations)} innowacji do {args.output}")

    if args.csv:
        save_csv(innovations, args.csv)
        print(f"Zapisano CSV do {args.csv}")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Scraper Biblioteki Innowacji Społecznych ROPS Kraków.")
    parser.add_argument("-o", "--output", default="data/innowacje_biblioteka.json")
    parser.add_argument("--csv", help="opcjonalnie zapisz także do CSV")
    parser.add_argument("--docs-dir", default="data/dokumenty", help="katalog na pobrane PDF-y")
    parser.add_argument("--delay", type=float, default=0.5, help="przerwa między zapytaniami [s]")
    parser.add_argument(
        "--interval-hours",
        type=float,
        default=None,
        help="Powtarzaj scrapowanie co podaną liczbę godzin; bez tej opcji wykonaj je jeden raz.",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    interval_hours = args.interval_hours
    if interval_hours is None and os.getenv("BIBLIOTEKA_INTERVAL_HOURS"):
        interval_hours = float(os.getenv("BIBLIOTEKA_INTERVAL_HOURS"))
    if interval_hours is not None and interval_hours <= 0:
        raise ValueError("Interwał scrapowania musi być większy od zera.")

    while True:
        try:
            run_import(args)
        except Exception as exc:
            if interval_hours is None:
                raise
            print(f"Scrapowanie biblioteki zakończyło się błędem: {exc}; kolejna próba zgodnie z harmonogramem.")

        if interval_hours is None:
            return
        print(f"Kolejne scrapowanie za {interval_hours:.2f} godz.")
        try:
            time.sleep(interval_hours * 60 * 60)
        except KeyboardInterrupt:
            print("Zatrzymano harmonogram scrapowania biblioteki.")
            return


if __name__ == "__main__":
    main()
