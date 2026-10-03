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

Z katalogu głównego projektu:

```bash
pip install -r requirements.txt
python scrapers/ioss/main.py
```

Domyślne parametry połączenia są zgodne z `docker-compose.yml`. Można je zmienić
przez `DATABASE_URL` albo zmienne `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER` i
`DB_PASSWORD`.

Uruchomienie z Docker Compose po starcie bazy:

```bash
docker compose up -d db
docker compose run --rm ioss-scraper
```
