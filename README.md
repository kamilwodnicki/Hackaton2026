## Moduł Wyszukiwania Semantycznego (Baza Wektorowa i API)

Ten komponent systemu odpowiada za analizę, przechowywanie oraz zaawansowane wyszukiwanie fragmentów tekstu w dokumentach PDF i danych strukturalnych. Pozwala on na precyzyjne odnajdywanie informacji na podstawie znaczenia zapytania, dostarczając niezbędny kontekst dla dalszych procesów w aplikacji.

### 1. Architektura i uruchamianie modułu
Moduł działa w oparciu o konteneryzację (Docker). W celu optymalizacji obciążenia systemu, elementy związane ze sztuczną inteligencją oraz bazą wektorową nie są uruchamiane domyślnie. 

**Uruchamianie usług AI:** 
Aby włączyć pełne środowisko analityczne wymagane do działania tego modułu, należy uruchomić kontenery z parametrem profilu `ai`:
```cmd
docker compose --profile ai up -d
```
Wykorzystywane technologie:
* **Baza wektorowa Qdrant:** Przechowuje wektory (reprezentacje liczbowe tekstów) o wymiarze 768.
* **Model wektoryzujący:** Przekształca tekst z dokumentów i zapytania użytkownika na wektory (`sdadas/mmlw-retrieval-roberta-base`).
* **Model sortujący (Cross-Encoder):** Weryfikuje i precyzyjnie układa wyniki wyszukiwania od najbardziej trafnego (`sdadas/polish-reranker-roberta-v3`).
* **Zarządzanie zasobami:** System obsługuje przełączanie obciążenia między procesorem a kartą graficzną za pomocą zmiennej środowiskowej `COMPUTE_DEVICE` w pliku `docker-compose.yml`. Ustawienie tej wartości na `cpu` pozwala zarezerwować pamięć VRAM wyłącznie dla głównego modelu językowego.

### 2. Wprowadzanie danych do systemu (Indeksacja)
Przed rozpoczęciem wyszukiwania należy przetworzyć pliki źródłowe, co obejmuje podzielenie ich na fragmenty, wygenerowanie wektorów i zapisanie ich w bazie Qdrant. Skrypt automatycznie usuwa stare dane przy każdym uruchomieniu, aby zachować spójność bazy.

**Wymagania wstępne:**
* Plik z metadanymi `innowacje_biblioteka.json` musi znajdować się w folderze `data/`.
* Powiązane pliki PDF muszą znajdować się w podkatalogu `data/dokumenty/`.
Dane pobierz z linka https://drive.google.com/file/d/1uCTI-b5s0RGgIjOS_qKEqo8x2-AfhE0i/view?usp=drive_link

**Uruchomienie indeksacji:**
Aby przetworzyć pliki, wykonaj w terminalu polecenie:
```cmd
docker compose exec web python app/ingest.py
```

### 3. Wyszukiwanie danych (Endpoint API)
Moduł udostępnia lokalny punkt końcowy, który przyjmuje zapytania i zwraca najbardziej pasujące fragmenty, eliminując przy tym zduplikowane wyniki z tego samego dokumentu.

* **Adres URL:** `http://localhost:5000/search`
* **Metoda:** `POST`
* **Nagłówek:** `Content-Type: application/json`

**Struktura zapytania:**
Należy przesłać obiekt JSON zawierający szukaną frazę (`query`) oraz opcjonalnie limit oczekiwanych wyników (`top_k`). Przykład wywołania z poziomu terminala Windows (CMD / PowerShell):
```powershell
curl.exe -X POST http://localhost:5000/search -H "Content-Type: application/json" -d "{\`"query\`": \`"projekty dla seniorów\`", \`"top_k\`": 3}"
```

**Struktura odpowiedzi:**
Zwracany jest obiekt JSON z tablicą `results`. Zawiera ona podstawowe metadane dokumentu, dopasowany fragment tekstu oraz oceny trafności.
```json
{
  "results": [
    {
      "doc_id": "stworzenie-narzedzia-ulatwiajacego-seniorom-prawidlowe-regulowanie-spraw-spadkowych",
      "tytul": "Stworzenie narzędzia ułatwiającego seniorom prawidłowe regulowanie spraw spadkowych",
      "url": "[https://rops.krakow.pl/](https://rops.krakow.pl/)...",
      "fragment": "Zasadnicza treść dopasowanego tekstu z pliku PDF...",
      "score_qdrant": 0.8653362,
      "score_reranker": 0.9933578372001648
    }
  ]
}
```

### 4. Wydajność i czasy odpowiedzi
Podczas odpytywania systemu występują zauważalne różnice w czasie obsługi żądań:
* **Pierwsze zapytanie (ok. 6-8 sekund):** Wymaga pełnego wczytania modeli do pamięci operacyjnej urządzenia oraz nawiązania pierwszego połączenia z bazą danych Qdrant.
* **Kolejne zapytania (ok. 0.2 - 0.4 sekundy):** Struktury obliczeniowe i połączenia są już aktywne, co pozwala na bieżące przetwarzanie zapytań bez konieczności ponownej inicjalizacji systemu.
