# Scraper IOSS

Scraper pobiera wszystkie statystyki, które mają tabelę powiatową w sekcji
„Analiza zróżnicowania”. Dla każdej statystyki używa najnowszego roku dostępnego
na jej stronie, a następnie zapisuje dane do jednej tabeli PostgreSQL `ioss`.

- klucz główny: `powiat`,
- pozostałe kolumny: statystyki w formacie `s_<id>_<nazwa>`,
- wartości procentowe są zapisywane liczbowo (np. `79.26%` jako `79.26`),
- pełna nazwa statystyki i rok danych są zapisane jako komentarz kolumny w PostgreSQL,
- ponowne uruchomienie wykonuje upsert danych.

## Uruchomienie

Jednorazowo, z katalogu głównego projektu:

```bash
pip install -r requirements.txt
python scrapers/ioss/main.py
```

Domyślne parametry połączenia są zgodne z `docker-compose.yml`. Można je zmienić
przez `DATABASE_URL` albo zmienne `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER` i
`DB_PASSWORD`.

Uruchomienie cykliczne z Docker Compose:

```bash
docker compose up -d db
docker compose --profile tools up -d ioss-scraper
```

Kontener wykonuje import od razu po starcie, a następnie co 48 godzin. Interwał
można zmienić przez `IOSS_INTERVAL_HOURS` lub argument `--interval-hours`.

Jednorazowy import w Dockerze, bez uruchamiania harmonogramu:

```bash
docker compose run --rm ioss-scraper python scrapers/ioss/main.py
```
