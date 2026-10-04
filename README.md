# ROPS — innowacje społeczne
Responsywny portal wspierający rozwój innowacji społecznych. Projekt zawiera frontend demonstracyjny, backend napisany w środowisku Flask z bazą PostgreSQL, system zarządzania treścią Directus (Headless CMS) oraz wyszukiwanie semantyczne z wykorzystaniem wektorowej bazy Qdrant i modeli sztucznej inteligencji.

## 1. Najszybsze uruchomienie strony (Tylko Frontend) 
Do obejrzenia samego interfejsu nie jest potrzebna instalacja zależności, Dockera ani bazy danych. Logowanie, rejestracja i role działają w trybie demonstracyjnym (dane zapisywane są w localStorage przeglądarki).

Linux / macOS:
```Bash
python3 -m http.server 8080 --directory frontend
```

Windows 10/11 (PowerShell):
```PowerShell
py -m http.server 8080 --directory frontend
```

Frontend będzie dostępny od razu na stronie głównej pod adresem `http://localhost:8080/` — bez dopisywania `/frontend`. Serwer zatrzymasz skrótem Ctrl+C. Uwaga: wysyłka formularzy oraz funkcje AI wymagają uruchomienia backendu.

## 2. Pełne uruchomienie z Dockerem (Backend + Baza danych)
Wymagania: zainstalowany Docker Desktop (Windows/macOS) lub Docker Engine (Linux). Projekt podzielono na dwa tryby, aby oszczędzać zasoby komputera, gdy funkcje AI nie są potrzebne.

Tryb lekki (Bez modułu AI)
Przeznaczony do standardowej pracy nad kodem, panelem Directus i bazą danych PostgreSQL. Działa płynnie, nie obciążając procesora ani pamięci. Nie uruchamia bazy Qdrant ani modeli AI.
```Bash
docker compose up -d
```
Cała aplikacja, wraz ze stroną główną i API, będzie dostępna pod adresem `http://localhost:8080/`. Nie trzeba osobno uruchamiać frontendu ani dopisywać `/frontend` do adresu.

Po zmianie konfiguracji uruchom kontenery ponownie, aby Docker odtworzył usługę z właściwym portem:

```bash
docker compose down
docker compose up -d --build
```

## Tryb pełny (Wymagany mocny sprzęt / Karta NVIDIA)
Uruchamia pełne środowisko analityczne, w tym modele językowe Ollama, Qdrant oraz wyszukiwanie semantyczne. Pierwsze uruchomienie pobiera kilka gigabajtów danych modeli.
```Bash
docker compose --profile ai up -d
```
Uwaga: Domyślnie system wykorzystuje kartę graficzną ```(COMPUTE_DEVICE=cuda)```. Jeśli nie posiadasz dedykowanej karty, zmień w pliku ```docker-compose.yml``` wartość na ```COMPUTE_DEVICE=cpu```.
## 3. Zarządzanie Treścią (Directus)
Directus służy do wprowadzania danych o innowacjach, zarządzania plikami PDF oraz wyzwalania indeksacji tekstów do bazy wektorowej za pomocą webhooków. Działa w obu trybach Dockera.
 - Adres: ```http://localhost:8055```
 - Login: ```admin@example.com```
 - Hasło: ```admin```

 # Wdrożenie bazy przy pierwszym uruchomieniu
 Jeśli pobierasz repozytorium po raz pierwszy, musisz załadować strukturę kolekcji i uprawnień. Wykonaj poniższe polecenia w terminalu:
 Zresetuj środowisko i uruchom kontenery:
 ```Bash
 docker compose down
docker compose up -d
```
Zaimportuj gotową konfigurację Directusa:
```Bash
docker exec postgres_db psql -U myuser -d mydb -f /docker-entrypoint-initdb.d/init-directus.sql
```
Zrestartuj panel, aby odczytał zaktualizowane tabele:
```Bash
docker compose restart directus
```
## 4. Konfiguracja wysyłki zgłoszeń wsparcia
Formularz wsparcia wysyła wiadomości e-mail. W głównym katalogu projektu utwórz plik .env (nie dodawaj go do Git) o następującej strukturze:
```
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=twoj_adres@gmail.com
SMTP_PASSWORD=haslo_aplikacji_gmail
SMTP_FROM=twoj_adres@gmail.com
```
Po zmianie konfiguracji zrestartuj kontener backendu: 
```
docker compose restart web
```
## 5. Wyszukiwanie Semantyczne i Asystent AI
Funkcje te działają wyłącznie w "Trybie pełnym" z uruchomionym profilem AI.

### Inicjalizacja i wczytanie dokumentów
Przed wyszukiwaniem należy umieścić plik innovation-library.json w katalogu data/ oraz powiązane pliki PDF w data/documents/. Następnie wykonaj indeksację (proces ten nadpisze stare zbiory w Qdrant):
```Bash
docker compose exec web python app/ingest.py
```
### Najważniejsze adresy API

| Funkcja | Metoda | Adres |
|---|---|---|
| Strona główna | GET | `http://localhost:8080/` |
| Wyszukiwanie semantyczne | POST | `http://localhost:8080/search` |
| Asystent AI | POST | `http://localhost:8080/chat` |
| Zgłoszenie wsparcia | POST | `http://localhost:8080/support` |

**Przykładowe zapytanie (PowerShell):**
```powershell
Invoke-RestMethod -Method Post -Uri "http://localhost:8080/search" -ContentType "application/json" -Body '{"query":"projekty dla seniorów","top_k":3}'
```

## 6. Struktura projektu
```
Plaintextapp/                 backend Flask, wyszukiwanie i asystent
frontend/            strony HTML, CSS, JavaScript i zasoby
scrapers/            pobieranie danych IOSS
data/                lokalne dane do indeksacji
Dockerfile           obraz aplikacji backendu
docker-compose.yml   usługi aplikacji, Directus, PostgreSQL i AI
init-directus.sql    struktura początkowa bazy danych CMS
requirements*.txt    zależności środowiska Python
```
## 7. Typowe problemy
- Port 8080 lub 8055 jest zajęty: zatrzymaj inną usługę używającą portu albo zmień jego mapowanie w pliku docker-compose.yml.
- Docker nie odpowiada: Upewnij się, że usługa Docker Desktop lub Docker Engine jest włączona.
- Brak odpowiedzi AI / Endpoint nie działa: Sprawdź, czy uruchomiono projekt z flagą --profile ai i czy wykonano indeksację skryptem ingest.py.
- Pierwsze zapytanie do AI trwa bardzo długo: To standardowe zachowanie (ładowanie modeli do pamięci RAM/VRAM). Kolejne zapytania są przetwarzane natychmiastowo.
- Formularz nie wysyła e-maili: Sprawdź poprawność danych w pliku .env oraz logi backendu poleceniem docker compose logs web. W przypadku Gmaila wymagane jest wygenerowanie specjalnego "Hasła aplikacji" w ustawieniach konta Google.
