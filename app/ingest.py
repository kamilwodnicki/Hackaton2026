import json
import os
import fitz  # PyMuPDF
import uuid
from qdrant_client import QdrantClient
from qdrant_client.http import models
from sentence_transformers import SentenceTransformer
from langchain_text_splitters import RecursiveCharacterTextSplitter

QDRANT_HOST = os.getenv("QDRANT_HOST", "qdrant")
QDRANT_PORT = int(os.getenv("QDRANT_PORT", 6333))
COLLECTION_NAME = "teksty_kolekcja"
MODEL_NAME = "sdadas/mmlw-retrieval-roberta-base"

# Pobieranie urządzenia ze zmiennych środowiskowych (domyślnie CPU)
DEVICE = os.getenv("COMPUTE_DEVICE", "cpu")
print(f"Inicjalizacja klienta Qdrant... Urządzenie dla modelu: {DEVICE.upper()}")

qdrant_client = QdrantClient(host=QDRANT_HOST, port=QDRANT_PORT)

# Przekazanie parametru device do modelu wektorowego
model = SentenceTransformer(MODEL_NAME, device=DEVICE)

JSON_PATH = "data/innovation-library.json"
PDF_DIR = "data/documents"

print("Inicjalizacja klienta Qdrant i modelu...")
qdrant_client = QdrantClient(host=QDRANT_HOST, port=QDRANT_PORT)
model = SentenceTransformer(MODEL_NAME)

# 1500 znaków to około 200-250 słów. Zakładka to 300 znaków.
text_splitter = RecursiveCharacterTextSplitter(
    chunk_size=1500,
    chunk_overlap=300,
    length_function=len,
    separators=["\n\n", "\n", ".", " ", ""]
)

def ensure_collection_exists():
    if qdrant_client.collection_exists(COLLECTION_NAME):
        qdrant_client.delete_collection(COLLECTION_NAME)
        print(f"Usunięto starą kolekcję {COLLECTION_NAME}.")
        
    qdrant_client.create_collection(
        collection_name=COLLECTION_NAME,
        vectors_config=models.VectorParams(
            size=768, distance=models.Distance.COSINE
        ),
    )
    print(f"Utworzono świeżą kolekcję {COLLECTION_NAME} dla modelu base (768 wymiarów).")

def process_and_ingest():
    ensure_collection_exists()

    with open(JSON_PATH, "r", encoding="utf-8") as f:
        innowacje = json.load(f)

    points = []
    
    for item in innowacje:
        # Próba pobrania doc_id z pliku JSON
        doc_id = item.get("doc_id")
        
        # Jeśli brakuje doc_id, próbujemy wyciągnąć je z adresu URL
        if not doc_id and item.get("url"):
            doc_id = item.get("url").split(",")[-1].strip()
            
        # Zabezpieczenie, jeśli ostatecznie nie udało się ustalić ID
        if not doc_id:
            doc_id = "nieznany_dokument"

        pdf_path = os.path.join(PDF_DIR, f"{doc_id}.pdf")
        
        pdf_text = ""
        if os.path.exists(pdf_path):
            try:
                doc = fitz.open(pdf_path)
                for page in doc:
                    pdf_text += page.get_text() + "\n"
                doc.close()
            except Exception as e:
                print(f"Błąd odczytu PDF {pdf_path}: {e}")
        else:
            print(f"Brak pliku PDF dla: {doc_id} (ścieżka: {pdf_path})")

        pelny_tekst = f"{item.get('tytul', '')}\n\n{item.get('opis', '')}\n\n{pdf_text}"
        
        chunks = text_splitter.split_text(pelny_tekst)
        
        for idx, chunk in enumerate(chunks):
            # Tworzenie stałego, unikalnego ID na podstawie doc_id i numeru fragmentu
            # Dzięki temu ponowne uruchomienie nadpisze wpis, zamiast go dublować
            point_id = str(uuid.uuid5(uuid.NAMESPACE_DNS, f"{doc_id}_chunk_{idx}"))
            
            payload = {
                "doc_id": doc_id,
                "tytul": item.get("tytul"),
                "url": item.get("url"),
                "kategorie": item.get("kategorie", []),
                "film": item.get("film"),
                "opis_krotki": item.get("opis"),
                "fragment_tekstu": chunk 
            }
            
            vector = model.encode(chunk).tolist()
            
            points.append(
                models.PointStruct(
                    id=point_id,
                    vector=vector,
                    payload=payload
                )
            )

    # Wysłanie danych do bazy wektorowej w paczkach po 50
    batch_size = 50
    for i in range(0, len(points), batch_size):
        batch = points[i:i+batch_size]
        qdrant_client.upsert(
            collection_name=COLLECTION_NAME,
            points=batch
        )
        print(f"Zapisano paczkę {i // batch_size + 1} w Qdrant ({len(batch)} wektorów)")

    # Wysłanie danych do bazy wektorowej w paczkach po 50
    batch_size = 50
    for i in range(0, len(points), batch_size):
        batch = points[i:i+batch_size]
        qdrant_client.upsert(
            collection_name=COLLECTION_NAME,
            points=batch
        )
        print(f"Zapisano paczkę {i // batch_size + 1} w Qdrant ({len(batch)} wektorów)")

if __name__ == "__main__":
    print("Rozpoczęto mapowanie i wektoryzację danych...")
    process_and_ingest()
    print("Operacja zakończona pomyślnie.")