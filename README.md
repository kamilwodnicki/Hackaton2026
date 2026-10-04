# Dokumentacja Projektu
Projekt został podzielony na dwa środowiska pracy. W zależności od sprzętu oraz celu uruchomienia, możesz wybrać tryb lekki (do pracy nad interfejsem i bazą danych) lub tryb pełny (wymagający mocnego sprzętu, uruchamiający modele sztucznej inteligencji).

## 1. Uruchamianie aplikacji (Wybór trybu)
### Opcja A: Tryb lekki (Bez modułu AI)
Przeznaczony do standardowej pracy nad kodem, panelem Directus i bazą danych PostgreSQL. Działa płynnie na każdym komputerze, nie obciążając procesora ani pamięci. Nie uruchamia bazy wektorowej Qdrant ani modeli sztucznej inteligencji.

Aby uruchomić projekt w trybie lekkim, wpisz w terminalu:

```Bash
docker compose up -d
```
### Opcja B: Tryb pełny (Sztuczna Inteligencja / Wymagana karta NVIDIA)
Uruchamia pełne środowisko analityczne, w tym modele językowe oraz wyszukiwanie semantyczne. Ten tryb wymaga wydajnego sprzętu, w szczególności dedykowanej karty graficznej NVIDIA.

Aby uruchomić pełną infrastrukturę projektu, użyj polecenia:

```Bash
docker compose --profile ai up -d
```
## 2. Zarządzanie Treścią (Directus)
Directus pełni w projekcie rolę głównego panelu administracyjnego (Headless CMS). Służy do wprowadzania i edycji danych, zarządzania plikami oraz automatycznego wyzwalania indeksacji tekstów do bazy wektorowej.

Po uruchomieniu kontenerów (w dowolnym z dwóch trybów), panel graficzny jest dostępny w przeglądarce internetowej pod adresem:

Adres: ``` http://localhost:8055 ```

Login: ``` admin@example.com ```

Hasło: ``` password ```

### Wdrożenie bazy przy pierwszym uruchomieniu
Jeżeli pobierasz repozytorium na swój komputer po raz pierwszy, musisz załadować strukturę bazy danych (kolekcje, relacje, webhooki i uprawnienia), aby panel Directus zadziałał poprawnie.

Wykonaj kolejno te trzy polecenia w terminalu:

Zresetuj środowisko i uruchom kontenery (upewnia się, że plik SQL został prawidłowo podpięty):

```Bash
docker compose down
docker compose up -d
```
Zaimportuj gotową konfigurację do bazy PostgreSQL:

```Bash
docker exec postgres_db psql -U myuser -d mydb -f /docker-entrypoint-initdb.d/init-directus.sql
```
Zrestartuj system Directus, aby odczytał zaktualizowane tabele:

```Bash
docker compose restart directus
```
Panel jest teraz gotowy do pracy i uzupełniania danych.

## 3. Wyszukiwanie Semantyczne i Baza Wektorowa
### Uwaga: Te funkcje działają wyłącznie, jeśli projekt został uruchomiony w "Trybie pełnym" (Opcja B).

Moduł ten służy do odnajdywania informacji w dokumentach tekstowych (PDF) na podstawie znaczenia słów.

### Inicjalizacja i wczytanie dokumentów
Zanim będzie można cokolwiek wyszukać, pliki PDF muszą zostać przetworzone i zapisane w bazie Qdrant. Skrypt automatycznie podmieni stare dane przy każdym uruchomieniu.

Pobierz pliki PDF i umieść je w folderze data/dokumenty/ oraz upewnij się, że plik innowacje_biblioteka.json znajduje się w folderze data/.

### Uruchom proces indeksacji wpisując polecenie:

```Bash
docker compose exec web python app/ingest.py
```
Korzystanie z punktu dostępowego (Endpoint API)
Aplikacja pozwala na wyszukiwanie przetworzonych informacji poprzez lokalne API.

Adres: ``` http://localhost:5000/search ```

Metoda: ``` POST ```

Wymagany nagłówek: ``` Content-Type: application/json ```

Przykładowe wywołanie zapytania z terminala Windows (PowerShell):

```PowerShell
curl.exe -X POST http://localhost:5000/search -H "Content-Type: application/json" -d "{\`"query\`": \`"projekty dla seniorów\`", \`"top_k\`": 3}"
```
Struktura odpowiedzi:
Endpoint zwraca obiekt JSON z wynikami posortowanymi według najwyższej trafności. Zawiera tytuł, link do innowacji oraz dokładny cytat z załączonego dokumentu PDF. Pierwsze wyszukiwanie po uruchomieniu komputera trwa dłużej (wczytywanie modeli do pamięci), natomiast kolejne odpowiedzi generowane są natychmiastowo.