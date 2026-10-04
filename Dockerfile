# Wybieramy oficjalny obraz Pythona
FROM python:3.11-slim

# Ustawiamy katalog roboczy wewnątrz kontenera
WORKDIR /app

# Instalujemy systemowe zależności
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Zmienna sterująca instalacją pakietów AI (domyślnie false)
ARG INSTALL_AI=false

# Kopiujemy oba pliki z wymaganiami
COPY requirements.txt .
COPY requirements-ai.txt .

# Instalujemy zawsze podstawowe pakiety
RUN pip install --no-cache-dir -r requirements.txt

# Jeśli argument INSTALL_AI to "true", instalujemy pakiety AI
RUN if [ "$INSTALL_AI" = "true" ]; then pip install --no-cache-dir -r requirements-ai.txt; fi

# Kopiujemy pozostałe pliki projektu do kontenera
COPY . .

EXPOSE 8080

CMD ["python", "app/main.py"]
