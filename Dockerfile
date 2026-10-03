# Wybieramy oficjalny obraz Pythona
FROM python:3.11-slim

# Ustawiamy katalog roboczy wewnątrz kontenera
WORKDIR /app

# Instalujemy systemowe zależności wymagane m.in. przez sterowniki baz danych
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Kopiujemy plik z wymaganiami i instalujemy biblioteki Pythona
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Kopiujemy pozostałe pliki projektu do kontenera
COPY . .

# Domyślne polecenie uruchamiające aplikację (dostosuj do swojego projektu, np. main.py)
CMD ["python", "main.py"]