import os
from flask import Flask, request, jsonify

app = Flask(__name__)

# Konfiguracja środowiska
QDRANT_HOST = os.getenv("QDRANT_HOST", "qdrant")
QDRANT_PORT = int(os.getenv("QDRANT_PORT", 6333))
COLLECTION_NAME = "teksty_kolekcja"
DEVICE = os.getenv("COMPUTE_DEVICE", "cpu")

# Globalne zmienne, do których przypiszemy instancje przy pierwszym użyciu
embedding_model = None
reranker = None
qdrant_client = None

def get_embedding_model():
    global embedding_model
    if embedding_model is None:
        # Importujemy bibliotekę dopiero w momencie użycia
        from sentence_transformers import SentenceTransformer
        embedding_model = SentenceTransformer('sdadas/mmlw-retrieval-roberta-base', device=DEVICE)
    return embedding_model

def get_reranker():
    global reranker
    if reranker is None:
        from sentence_transformers import CrossEncoder
        reranker = CrossEncoder("sdadas/polish-reranker-roberta-v3", device=DEVICE)
    return reranker

def get_qdrant_client():
    global qdrant_client
    if qdrant_client is None:
        from qdrant_client import QdrantClient
        qdrant_client = QdrantClient(host=QDRANT_HOST, port=QDRANT_PORT)
    return qdrant_client

@app.route('/')
def home():
    return "Serwer działa! Tutaj znajdzie się API wyszukiwarki."
    
@app.route("/search", methods=["POST"])
def search():
    data = request.json
    query = data.get("query", "")
    top_k = data.get("top_k", 5) 
    fetch_k = 20 

    if not query:
        return jsonify({"error": "Brak zapytania"}), 400

    # 1. Pobranie modeli i klienta bazy (załadowanie, jeśli to pierwsze użycie)
    try:
        model = get_embedding_model()
        cross_encoder = get_reranker()
        client = get_qdrant_client()
    except Exception as e:
        return jsonify({"error": f"Błąd inicjalizacji usług AI: {str(e)}"}), 500

    # 2. Wektoryzacja zapytania
    query_vector = model.encode(query).tolist()

    # 3. Wstępne wyszukiwanie w Qdrant
    try:
        search_result = client.query_points(
            collection_name=COLLECTION_NAME,
            query=query_vector,
            limit=fetch_k
        ).points
    except Exception as e:
        return jsonify({"error": f"Błąd połączenia z bazą Qdrant: {str(e)}"}), 500

    if not search_result:
        return jsonify({"results": []})

    # 4. Przygotowanie danych do modelu sortującego
    pairs = []
    for hit in search_result:
        fragment = hit.payload.get("fragment_tekstu", "")
        pairs.append([query, fragment])

    # 5. Obliczenie nowych wyników
    rerank_scores = cross_encoder.predict(pairs)

    # 6. Łączenie wyników i sortowanie
    reranked_results = []
    for idx, hit in enumerate(search_result):
        hit_dict = hit.model_dump()
        hit_dict['rerank_score'] = float(rerank_scores[idx])
        reranked_results.append(hit_dict)

    reranked_results = sorted(reranked_results, key=lambda x: x['rerank_score'], reverse=True)

    # 7. Formatowanie danych końcowych z usunięciem duplikatów dokumentów
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