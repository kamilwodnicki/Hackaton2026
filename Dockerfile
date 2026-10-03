FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# 1. Najpierw instalujemy lekką bazę
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 2. Opcjonalna instalacja ciężkich paczek AI (domyślnie wyłączona)
ARG INSTALL_AI=false
COPY requirements-ai.txt .
RUN if [ "$INSTALL_AI" = "true" ] ; then \
      pip install --no-cache-dir -r requirements-ai.txt ; \
    fi

COPY . .

CMD ["python", "main.py"]