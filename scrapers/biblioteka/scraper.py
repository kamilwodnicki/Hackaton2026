"""Scraper Biblioteki Innowacji Społecznych ROPS Kraków.

Dla każdej innowacji zapisuje: tytuł, link, kategorie, link do filmu, doc_id i cały opis
jako jeden tekst. PDF spod ikony "dowiedz się więcej" (jeśli jest) pobiera do
katalogu <docs_dir>/<doc_id>.pdf.
"""
import csv
import os
import re
import time
from urllib.parse import urljoin, urlparse

import requests
from bs4 import BeautifulSoup

BASE_URL = "https://rops.krakow.pl"
LIBRARY_PATH = "/innowacje-spoleczne/biblioteka-innowacji-spolecznych/"
CATEGORIES_URL = urljoin(BASE_URL, LIBRARY_PATH + "kategorie")

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
                  "(KHTML, like Gecko) Chrome/126.0 Safari/537.36"
}

FIELDS = ["tytul", "url", "kategorie", "film", "doc_id", "opis"]


def norm(text):
    # Usuwamy niewidoczne znaki (zero-width space, miękki dywiz, BOM)
    text = re.sub(r"[​­﻿]", "", text or "")
    return re.sub(r"\s+", " ", text).strip()


class Scraper:
    def __init__(self, delay=0.5):
        self.session = requests.Session()
        self.session.headers.update(HEADERS)
        self.delay = delay

    def get_soup(self, url, retries=3):
        for attempt in range(1, retries + 1):
            try:
                resp = self.session.get(url, timeout=30)
                resp.raise_for_status()
                time.sleep(self.delay)
                return BeautifulSoup(resp.text, "html.parser")
            except requests.RequestException as e:
                print(f"  ! {url} (próba {attempt}/{retries}): {e}")
                time.sleep(2 * attempt)
        return None

    def get_categories(self):
        """Zwraca listę (slug, nazwa) kategorii z menu bocznego biblioteki."""
        soup = self.get_soup(CATEGORIES_URL)
        categories = {}
        if soup:
            for a in soup.select(".side-menu a[href]"):
                m = re.search(re.escape(LIBRARY_PATH) + r"(dla-[\w-]+)$", a["href"])
                if m:
                    categories[m.group(1)] = norm(a.get_text())
        return list(categories.items())

    def get_category_urls(self, slug):
        """Zwraca URL-e innowacji w danej kategorii (wszystkie są na jednej stronie)."""
        soup = self.get_soup(urljoin(BASE_URL, LIBRARY_PATH + slug))
        if not soup:
            return []
        return [urljoin(BASE_URL, a["href"]) for a in soup.select("a.news-list__title[href]")]

    @staticmethod
    def find_icon_links(table):
        """Linki spod ikon w tabelce: {podpis: url} (1. wiersz - ikony, 2. wiersz - podpisy)."""
        rows = table.find_all("tr")
        if len(rows) < 2:
            return {}
        icon_cells = [td for td in rows[0].find_all("td") if not td.get("rowspan")]
        labels = [norm(td.get_text(" ")).lower() for td in rows[1].find_all("td")]
        links = {}
        for cell, label in zip(icon_cells, labels):
            a = cell.find("a", href=True)
            if label and a:
                links[label] = urljoin(BASE_URL, a["href"].strip())
        return links

    def download_pdf(self, url, doc_id, docs_dir):
        """Pobiera PDF jako <docs_dir>/<doc_id>.pdf. Zwraca True, jeśli plik jest na dysku."""
        path = os.path.join(docs_dir, f"{doc_id}.pdf")
        if os.path.exists(path):
            return True
        try:
            resp = self.session.get(url, timeout=60)
            resp.raise_for_status()
        except requests.RequestException as e:
            print(f"     ! nie udało się pobrać {url}: {e}")
            return False
        if not resp.content.startswith(b"%PDF"):
            print(f"     ! {url} to nie jest PDF - pomijam")
            return False
        with open(path, "wb") as f:
            f.write(resp.content)
        time.sleep(self.delay)
        return True

    @staticmethod
    def extract_text(content):
        """Cały opis jako jeden tekst: akapity/nagłówki w osobnych liniach, listy jako '- '."""
        lines = []
        for el in content.find_all(["h1", "h2", "h3", "h4", "h5", "h6", "p", "li"]):
            # Pomijamy elementy zagnieżdżone w innych już zebranych (np. <p> w <li>)
            if el.find_parent(["p", "li"]):
                continue
            text = norm(el.get_text(" "))
            if text:
                lines.append(f"- {text}" if el.name == "li" else text)
        return "\n".join(lines)

    def scrape_innovation(self, url):
        soup = self.get_soup(url)
        main = soup.select_one(".content__main") if soup else None
        if not main:
            return None
        content = main.select_one(".text-content") or main
        title = main.select_one(".page-title")

        # Tabelka z ikonami nie jest częścią opisu - wyciągamy z niej linki i usuwamy
        links = {}
        for table in content.find_all("table"):
            links = {**self.find_icon_links(table), **links}
            table.decompose()

        return {
            "tytul": norm(title.get_text()) if title else "",
            "film": links.get("zobacz film"),
            "dowiedz_sie_wiecej": links.get("dowiedz się więcej"),
            "opis": self.extract_text(content),
        }

    def run(self, docs_dir):
        os.makedirs(docs_dir, exist_ok=True)
        categories = self.get_categories()
        print(f"Znaleziono {len(categories)} kategorii")

        doc_ids = {}  # url PDF-a -> doc_id (ten sam PDF pobieramy tylko raz)
        innovations = {}  # url -> dane (innowacja może być w kilku kategoriach)
        for slug, name in categories:
            urls = self.get_category_urls(slug)
            print(f"[{name}] {len(urls)} innowacji")
            for url in urls:
                if url in innovations:
                    if name not in innovations[url]["kategorie"]:
                        innovations[url]["kategorie"].append(name)
                    continue
                data = self.scrape_innovation(url)
                if not data:
                    continue
                doc_id = None
                pdf_url = data["dowiedz_sie_wiecej"]
                if pdf_url and urlparse(pdf_url).path.lower().endswith(".pdf"):
                    if pdf_url in doc_ids:
                        doc_id = doc_ids[pdf_url]
                    else:
                        # doc_id = slug pomysłu z adresu (część po przecinku), np. "bawita"
                        doc_id = url.rsplit(",", 1)[-1]
                        if self.download_pdf(pdf_url, doc_id, docs_dir):
                            doc_ids[pdf_url] = doc_id
                        else:
                            doc_id = None
                innovations[url] = {"tytul": data["tytul"], "url": url, "kategorie": [name],
                                    "film": data["film"], "doc_id": doc_id, "opis": data["opis"]}
                print(f"   + {data['tytul']}" + (f"  [PDF: {doc_id}.pdf]" if doc_id else ""))
        return list(innovations.values())


def save_csv(innovations, path):
    with open(path, "w", encoding="utf-8-sig", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=FIELDS)
        writer.writeheader()
        for inn in innovations:
            writer.writerow({**inn, "kategorie": "; ".join(inn["kategorie"])})
