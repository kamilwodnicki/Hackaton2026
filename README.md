# ROPS — innowacje społeczne

Responsywny portal wspierający rozwój innowacji społecznych. Projekt zawiera frontend demonstracyjny, formularze i panele użytkowników oraz backend Flask z PostgreSQL, wyszukiwaniem semantycznym, Qdrantem i opcjonalnym lokalnym modelem językowym Ollama.

## Najszybsze uruchomienie strony

Do obejrzenia interfejsu nie jest potrzebna instalacja zależności ani baza danych. Logowanie, rejestracja i role działają obecnie w trybie demonstracyjnym i zapisują dane wyłącznie w pamięci przeglądarki (`localStorage`).

### Linux / Ubuntu / macOS

1. Otwórz terminal w katalogu projektu.
2. Uruchom lokalny serwer:

```bash
python3 -m http.server 8000 --directory frontend
```

3. Wejdź w przeglądarce na [http://localhost:8000](http://localhost:8000).
4. Serwer zatrzymasz skrótem `Ctrl+C`.

Jeśli polecenie `python3` nie istnieje, spróbuj `python`.

### Windows 10/11

1. Otwórz folder projektu w Eksploratorze plików.
2. Kliknij pasek adresu, wpisz `powershell` i naciśnij Enter.
3. Uruchom:

```powershell
py -m http.server 8000 --directory frontend
```

4. Wejdź w przeglądarce na [http://localhost:8000](http://localhost:8000).
5. Serwer zatrzymasz skrótem `Ctrl+C`.

Jeśli polecenie `py` nie istnieje, zainstaluj [Python 3](https://www.python.org/downloads/) i podczas instalacji zaznacz opcję **Add Python to PATH**, a następnie użyj `python` zamiast `py`.

> Sam frontend wystarcza do prezentacji widoków i funkcji mock. Wysyłka zgłoszeń wsparcia oraz funkcje AI wymagają backendu.

## Pełne uruchomienie z Dockerem

Ta metoda działa na Linuxie, Ubuntu, macOS i Windows. Wymaga:

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) na Windowsie lub macOS,
- Docker Engine z wtyczką Compose na Linuxie,
- co najmniej 8 GB wolnej pamięci RAM; moduły AI mogą wymagać znacznie więcej.

Sprawdź instalację:

```text
docker --version
docker compose version
```

### Backend bez modułów AI

Ten wariant uruchamia Flask i PostgreSQL. Jest najlepszy do pracy nad zwykłym API i formularzem wsparcia.

Linux / Ubuntu / macOS:

```bash
INSTALL_AI=false docker compose up --build db web
```

Windows PowerShell:

```powershell
$env:INSTALL_AI="false"
docker compose up --build db web
```

API będzie dostępne pod adresem [http://localhost:5000](http://localhost:5000). Frontend uruchom równolegle zgodnie z wcześniejszą instrukcją pod adresem `http://localhost:8000`.

Zatrzymanie usług:

```bash
docker compose down
```

### Pełne środowisko AI

Profil `ai` uruchamia dodatkowo Qdrant i Ollamę oraz pobiera model językowy. Pierwsze uruchomienie może potrwać długo i pobrać kilka gigabajtów danych.

```bash
docker compose --profile ai up --build
```

Aktualna konfiguracja AI jest przygotowana dla karty NVIDIA (`COMPUTE_DEVICE=cuda`). Na komputerze bez zgodnej karty ustaw w `docker-compose.yml` wartość `COMPUTE_DEVICE=cpu`. Na macOS i Windows upewnij się również, że Docker Desktop ma przydzieloną wystarczającą ilość pamięci.

## Dane wyszukiwarki semantycznej

Przed indeksacją umieść:

- plik `innowacje_biblioteka.json` w katalogu `data/`,
- powiązane dokumenty PDF w katalogu `data/dokumenty/`.

Następnie, przy uruchomionym profilu AI, wykonaj:

```bash
docker compose exec web python app/ingest.py
```

Indeksacja zastępuje wcześniejszą zawartość kolekcji w Qdrant.

## Konfiguracja wysyłki zgłoszeń wsparcia

Formularz wsparcia wysyła wiadomości na adres `thecookedhan@gmail.com`. W katalogu projektu utwórz plik `.env`:

```dotenv
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=nadawca@example.com
SMTP_PASSWORD=haslo-aplikacji
SMTP_FROM=nadawca@example.com
```

Dla Gmaila użyj hasła aplikacji, a nie zwykłego hasła do konta. Nie dodawaj pliku `.env` do repozytorium.

Po zmianie konfiguracji uruchom kontenery ponownie:

```bash
docker compose up --build db web
```

Kontrola zalogowania w formularzu jest obecnie demonstracyjna (`X-Demo-Auth: mock-session`). Przed wdrożeniem produkcyjnym należy zastąpić ją sesją serwerową lub zweryfikowanym tokenem OAuth.

## Najważniejsze adresy API

| Funkcja | Metoda | Adres |
|---|---:|---|
| Kontrola działania API | GET | `http://localhost:5000/` |
| Wyszukiwanie semantyczne | POST | `http://localhost:5000/search` |
| Asystent AI | POST | `http://localhost:5000/chat` |
| Zgłoszenie wsparcia | POST | `http://localhost:5000/support` |

Przykładowe zapytanie do wyszukiwarki:

Linux / macOS:

```bash
curl -X POST http://localhost:5000/search \
  -H 'Content-Type: application/json' \
  -d '{"query":"projekty dla seniorów","top_k":3}'
```

Windows PowerShell:

```powershell
Invoke-RestMethod -Method Post `
  -Uri "http://localhost:5000/search" `
  -ContentType "application/json" `
  -Body '{"query":"projekty dla seniorów","top_k":3}'
```

## Struktura projektu

```text
app/                 backend Flask, wyszukiwanie i asystent
frontend/            strony HTML, CSS, JavaScript i zasoby
scrapers/            pobieranie danych IOSS
data/                lokalne dane do indeksacji (jeśli dodane)
Dockerfile           obraz aplikacji
docker-compose.yml   usługi aplikacji, baz danych i AI
requirements.txt     podstawowe zależności Pythona
requirements-ai.txt  zależności wyszukiwania semantycznego
```

## Typowe problemy

- **Port 8000 lub 5000 jest zajęty:** zatrzymaj inną usługę używającą portu albo zmień numer portu w poleceniu / `docker-compose.yml`.
- **Docker nie odpowiada:** uruchom Docker Desktop lub usługę Docker Engine.
- **Brak odpowiedzi AI:** sprawdź, czy uruchomiono profil `ai`, wykonano indeksację i czy kontenery są aktywne przez `docker compose ps`.
- **Pierwsze zapytanie trwa długo:** modele są wtedy pobierane lub ładowane do pamięci; kolejne odpowiedzi powinny być szybsze.
- **Formularz wsparcia nie wysyła wiadomości:** sprawdź dane SMTP i logi poleceniem `docker compose logs web`.
