import os
from flask import Flask, request, jsonify
from qdrant_client import QdrantClient
from qdrant_client.http import models
from sentence_transformers import SentenceTransformer, CrossEncoder

app = Flask(__name__)

# Konfiguracja środowiska i urządzeń
QDRANT_HOST = os.getenv("QDRANT_HOST", "qdrant")
QDRANT_PORT = int(os.getenv("QDRANT_PORT", 6333))
COLLECTION_NAME = "teksty_kolekcja"

# Pobranie argumentu urządzenia z konfiguracji Dockera (domyślnie 'cpu' jako zabezpieczenie)
DEVICE = os.getenv("COMPUTE_DEVICE", "cpu")

print(f"Inicjalizacja modeli na urządzeniu: {DEVICE.upper()}...")

# Ładowanie głównego modelu do wektorów
EMBEDDING_MODEL_NAME = "sdadas/mmlw-retrieval-roberta-base"
embedding_model = SentenceTransformer(EMBEDDING_MODEL_NAME, device=DEVICE)

# Ładowanie modelu Rerankera
RERANKER_MODEL_NAME = "sdadas/polish-reranker-roberta-v3"
reranker = CrossEncoder(RERANKER_MODEL_NAME, device=DEVICE)

print("Modele załadowane pomyślnie.")

qdrant_client = QdrantClient(host=QDRANT_HOST, port=QDRANT_PORT)

@app.route("/search", methods=["POST"])
def search():
    data = request.json
    query = data.get("query", "")
    top_k = data.get("top_k", 5) # Ile wyników zwrócić użytkownikowi
    fetch_k = 20 # Ile wyników pobrać z Qdranta do rerankowania

    if not query:
        return jsonify({"error": "Brak zapytania"}), 400

    # 1. Wektoryzacja zapytania
    query_vector = embedding_model.encode(query).tolist()

    # 2. Wstępne wyszukiwanie w Qdrant
    # 2. Wstępne wyszukiwanie w Qdrant
    search_result = qdrant_client.query_points(
        collection_name=COLLECTION_NAME,
        query=query_vector,
        limit=fetch_k
    ).points

    if not search_result:
        return jsonify({"results": []})

    # 3. Przygotowanie danych do rerankera
    # Tworzymy pary: [zapytanie, fragment_tekstu_z_bazy]
    pairs = []
    for hit in search_result:
        fragment = hit.payload.get("fragment_tekstu", "")
        pairs.append([query, fragment])

    # 4. Obliczenie nowych wyników przez reranker
    rerank_scores = reranker.predict(pairs)

    # 5. Łączenie wyników ze strukturą Qdranta i sortowanie
    reranked_results = []
    for idx, hit in enumerate(search_result):
        hit_dict = hit.model_dump()
        hit_dict['rerank_score'] = float(rerank_scores[idx])
        reranked_results.append(hit_dict)

    # Sortowanie malejąco według wyniku rerankera
    reranked_results = sorted(reranked_results, key=lambda x: x['rerank_score'], reverse=True)

    # 6. Zwrócenie najlepszych top_k wyników, usunięcie duplikatów dokumentów
    final_results = []
    seen_docs = set()

    for item in reranked_results:
        doc_id = item['payload'].get('doc_id')
        if doc_id not in seen_docs:
            seen_docs.add(doc_id)
            final_results.append({
                "doc_id": doc_id,
                "tytul": item['payload'].get('tytul'),
                "url": item['payload'].get('url'),
                "score_qdrant": item['score'],
                "score_reranker": item['rerank_score'],
                "fragment": item['payload'].get('fragment_tekstu')
            })
            
        if len(final_results) >= top_k:
            break

    return jsonify({"results": final_results})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)