import os
import smtplib
from email.message import EmailMessage
import uuid
import requests
from flask import Flask, request, jsonify
from werkzeug.exceptions import RequestEntityTooLarge
from werkzeug.utils import secure_filename
from chat import chat_bp
from flask import Flask, request, jsonify
from auth import auth_bp
from datetime import timedelta

FRONTEND_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "frontend")
app = Flask(__name__, static_folder=FRONTEND_DIR, static_url_path="")
app.secret_key = os.getenv("FLASK_SECRET_KEY", "dev-secret-zmien-mnie")
app.permanent_session_lifetime = timedelta(days=7)
app.register_blueprint(chat_bp)
app.register_blueprint(auth_bp)

SUPPORT_RECIPIENT = "thecookedhan@gmail.com"
SUPPORT_CATEGORIES = {
    "logowanie": "Logowanie i konto",
    "formularze": "Formularze i zgłoszenia",
    "wyswietlanie": "Wyświetlanie strony",
    "dostepnosc": "Dostępność",
    "wydajnosc": "Wydajność",
    "inna": "Inna",
}
IMAGE_SIGNATURES = {
    "image/jpeg": (b"\xff\xd8\xff",),
    "image/png": (b"\x89PNG\r\n\x1a\n",),
    "image/gif": (b"GIF87a", b"GIF89a"),
    "image/webp": (b"RIFF",),
}


@app.errorhandler(RequestEntityTooLarge)
def support_file_too_large(_error):
    return jsonify({"error": "Załącznik jest zbyt duży. Maksymalny rozmiar całego zgłoszenia to 6 MB."}), 413


def valid_image(content, mime_type):
    signatures = IMAGE_SIGNATURES.get(mime_type, ())
    if not any(content.startswith(signature) for signature in signatures):
        return False
    return mime_type != "image/webp" or (len(content) >= 12 and content[8:12] == b"WEBP")


@app.route("/support", methods=["POST"])
def submit_support_request():
    # Tymczasowa kontrola dla frontendu mock. Po podłączeniu bazy należy zastąpić ją
    # weryfikacją serwerowej sesji/OAuth. Endpoint nigdy nie wykonuje zapytań SQL.
    if request.headers.get("X-Demo-Auth") != "mock-session":
        return jsonify({"error": "Zaloguj się, aby wysłać zgłoszenie."}), 401

    description = request.form.get("description", "").strip()
    category_key = request.form.get("category", "")
    other_category = request.form.get("other_category", "").strip()
    user_email = request.form.get("user_email", "").strip()[:254]

    if not description or len(description) > 1000:
        return jsonify({"error": "Opis musi mieć od 1 do 1000 znaków."}), 400
    if category_key not in SUPPORT_CATEGORIES:
        return jsonify({"error": "Wybierz prawidłową kategorię problemu."}), 400
    if category_key == "inna" and (not other_category or len(other_category) > 80):
        return jsonify({"error": "Podaj nazwę innej kategorii (maksymalnie 80 znaków)."}), 400
    if any(ord(character) < 32 for character in other_category):
        return jsonify({"error": "Nazwa kategorii zawiera niedozwolone znaki."}), 400

    attachment = request.files.get("image")
    attachment_data = None
    attachment_name = None
    attachment_type = None
    if attachment and attachment.filename:
        attachment_type = attachment.mimetype
        attachment_data = attachment.read(5 * 1024 * 1024 + 1)
        if len(attachment_data) > 5 * 1024 * 1024:
            return jsonify({"error": "Zdjęcie może mieć maksymalnie 5 MB."}), 400
        if not valid_image(attachment_data, attachment_type):
            return jsonify({"error": "Dozwolone są wyłącznie obrazy JPG, PNG, GIF lub WEBP."}), 400
        attachment_name = secure_filename(attachment.filename) or "zalacznik"

    smtp_host = os.getenv("SMTP_HOST", "smtp.gmail.com")
    smtp_port = int(os.getenv("SMTP_PORT", "587"))
    smtp_user = os.getenv("SMTP_USER")
    smtp_password = os.getenv("SMTP_PASSWORD")
    smtp_from = os.getenv("SMTP_FROM", smtp_user or "")
    if not smtp_user or not smtp_password or not smtp_from:
        return jsonify({"error": "Wysyłka e-mail nie została jeszcze skonfigurowana na serwerze."}), 503

    category = other_category if category_key == "inna" else SUPPORT_CATEGORIES[category_key]
    email = EmailMessage()
    email["Subject"] = f"Zgłoszenie techniczne: {category}"
    email["From"] = smtp_from
    email["To"] = SUPPORT_RECIPIENT
    if "@" in user_email and "\n" not in user_email and "\r" not in user_email:
        email["Reply-To"] = user_email
    email.set_content(f"Kategoria: {category}\nE-mail użytkownika: {user_email or 'brak'}\n\nOpis:\n{description}")
    if attachment_data:
        maintype, subtype = attachment_type.split("/", 1)
        email.add_attachment(attachment_data, maintype=maintype, subtype=subtype, filename=attachment_name)

    try:
        with smtplib.SMTP(smtp_host, smtp_port, timeout=15) as smtp:
            smtp.starttls()
            smtp.login(smtp_user, smtp_password)
            smtp.send_message(email)
    except (OSError, smtplib.SMTPException):
        app.logger.exception("Nie udało się wysłać zgłoszenia wsparcia")
        return jsonify({"error": "Nie udało się wysłać zgłoszenia. Spróbuj ponownie później."}), 502

    return jsonify({"message": "Zgłoszenie zostało wysłane do wsparcia technicznego."}), 201

# Konfiguracja środowiska
QDRANT_HOST = os.getenv("QDRANT_HOST", "qdrant")
QDRANT_PORT = int(os.getenv("QDRANT_PORT", 6333))
COLLECTION_NAME = "teksty_kolekcja"
DEVICE = os.getenv("COMPUTE_DEVICE", "cpu")

# Globalne instancje
embedding_model = None
reranker = None
qdrant_client = None

def is_ai_enabled():
    """Sprawdza, czy biblioteki AI zostały zainstalowane podczas budowania obrazu."""
    try:
        import sentence_transformers
        import qdrant_client
        import langchain_text_splitters
        import pymupdf
        return True
    except ImportError:
        return False

def get_embedding_model():
    global embedding_model
    if embedding_model is None:
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
    return app.send_static_file("index.html")
    
@app.route("/search", methods=["POST"])
def search():
    if not is_ai_enabled():
        return jsonify({"error": "Moduł AI jest wyłączony. Wyszukiwanie semantyczne jest niedostępne."}), 503

    data = request.json
    query = data.get("query", "")
    top_k = data.get("top_k", 5) 
    fetch_k = 20 

    if not query:
        return jsonify({"error": "Brak zapytania"}), 400

    try:
        model = get_embedding_model()
        cross_encoder = get_reranker()
        client = get_qdrant_client()
    except Exception as e:
        return jsonify({"error": f"Błąd inicjalizacji usług AI: {str(e)}"}), 500

    query_vector = model.encode(query).tolist()

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

    pairs = []
    for hit in search_result:
        fragment = hit.payload.get("fragment_tekstu", "")
        pairs.append([query, fragment])

    rerank_scores = cross_encoder.predict(pairs)

    reranked_results = []
    for idx, hit in enumerate(search_result):
        hit_dict = hit.model_dump()
        hit_dict['rerank_score'] = float(rerank_scores[idx])
        reranked_results.append(hit_dict)

    reranked_results = sorted(reranked_results, key=lambda x: x['rerank_score'], reverse=True)

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


@app.route("/webhook/index", methods=["POST"])
def index_new_item():
    if not is_ai_enabled():
        return jsonify({"status": "skipped", "message": "Moduł AI jest wyłączony."}), 200

    import pymupdf
    from qdrant_client.http import models
    from langchain_text_splitters import RecursiveCharacterTextSplitter
    import json
    import time

    data = request.get_json(force=True, silent=True) or {}
    if isinstance(data, str):
        try:
            data = json.loads(data)
        except Exception:
            data = {}

    print(f"\n--- OTRZYMANO ŻĄDANIE Z DIRECTUSA ---", flush=True)
    print(json.dumps(data, indent=2, ensure_ascii=False), flush=True)
    print("---------------------------------------", flush=True)

    doc_id = data.get("id_create") or data.get("id_update") or data.get("id")
    if not doc_id or "{{" in str(doc_id):
        return jsonify({"error": "Brak ID dokumentu."}), 400

    DIRECTUS_COLLECTION = "innowacje"

    # Dajemy Directusowi 3 sekundy na domknięcie zapisu relacji i pliku
    time.sleep(3.0) 

    # TYLKO JEDNO POBRANIE DANYCH z parametrem fields=*.*
    try:
        api_url = f"http://directus:8055/items/{DIRECTUS_COLLECTION}/{doc_id}?fields=*.*"
        item_response = requests.get(api_url)
        
        if item_response.status_code != 200:
            return jsonify({"error": f"Błąd pobierania danych z Directusa (HTTP {item_response.status_code})."}), 400
            
        item_data = item_response.json().get("data", {})
    except Exception as e:
        import traceback
        print("\n--- KRYTYCZNY BŁĄD WEBHOKA ---", flush=True)
        traceback.print_exc()
        print(f"Szczegóły błędu: {str(e)}", flush=True)
        print("------------------------------\n", flush=True)
        return jsonify({"error": f"Błąd indeksacji: {str(e)}"}), 500

    tytul = item_data.get("tytul", "")
    tekst = item_data.get("opis", "")
    
    print(f"Zawartość pola pliki z API Directusa: {item_data.get('pliki')}", flush=True)

    pliki_raw = item_data.get("pliki")
    url = f"https://adres-twojego-frontendu.pl/innowacje/{doc_id}"
    
    pdf_text = ""
    pliki_ids = []
    
    if isinstance(pliki_raw, list):
        for p in pliki_raw:
            if isinstance(p, dict):
                file_id = p.get("directus_files_id") or p.get("id")
                if isinstance(file_id, dict):
                    file_id = file_id.get("id")
                if file_id:
                    pliki_ids.append(file_id)
            elif isinstance(p, (str, int)):
                pliki_ids.append(p)
    elif isinstance(pliki_raw, (str, int)) and str(pliki_raw).strip():
        pliki_ids = [str(pliki_raw)]

    pliki_ids = [str(p) for p in pliki_ids if p and not str(p).startswith("{{")]
    print(f"Ostatecznie wykryte ID plików PDF: {pliki_ids}", flush=True)

    for plik_id in pliki_ids:
        try:
            asset_url = f"http://directus:8055/assets/{plik_id}"
            res = requests.get(asset_url)
            
            if res.status_code == 200:
                with pymupdf.open(stream=res.content, filetype="pdf") as doc:
                    for page in doc:
                        extracted = page.get_text()
                        if extracted:
                            pdf_text += extracted + "\n"
                print(f"Sukces: Pobrano i odczytano plik {plik_id}", flush=True)
            else:
                print(f"Błąd HTTP {res.status_code} przy pobieraniu pliku {plik_id}", flush=True)
        except Exception as e:
            print(f"Błąd przetwarzania pliku {plik_id}: {e}", flush=True)

    pelny_tekst = f"{tytul}\n\n{tekst}\n\n{pdf_text}".strip()
    
    if not pelny_tekst:
        return jsonify({"error": "Dokument nie zawiera treści do indeksacji."}), 400

    try:
        model = get_embedding_model()
        client = get_qdrant_client()
        
        if not client.collection_exists(collection_name=COLLECTION_NAME):
            client.create_collection(
                collection_name=COLLECTION_NAME,
                vectors_config=models.VectorParams(
                    size=768, distance=models.Distance.COSINE
                )
            )
        
        client.delete(
            collection_name=COLLECTION_NAME,
            points_selector=models.FilterSelector(
                filter=models.Filter(
                    must=[
                        models.FieldCondition(
                            key="doc_id",
                            match=models.MatchValue(value=doc_id)
                        )
                    ]
                )
            )
        )
        
        text_splitter = RecursiveCharacterTextSplitter(
            chunk_size=1500,
            chunk_overlap=300,
            length_function=len,
            separators=["\n\n", "\n", ".", " ", ""]
        )
        
        chunks = text_splitter.split_text(pelny_tekst)
        points = []
        
        for idx, chunk in enumerate(chunks):
            point_id = str(uuid.uuid5(uuid.NAMESPACE_DNS, f"{doc_id}_chunk_{idx}"))
            vector = model.encode(chunk).tolist()
            
            points.append(
                models.PointStruct(
                    id=point_id,
                    vector=vector,
                    payload={
                        "doc_id": doc_id,
                        "tytul": tytul,
                        "url": url,
                        "fragment_tekstu": chunk,
                        "zrodlo": "directus"
                    }
                )
            )

        if points:
            client.upsert(
                collection_name=COLLECTION_NAME,
                points=points
            )
            
        print(f"Zapisano w Qdrant dokument {doc_id} w {len(points)} fragmentach.", flush=True)
        return jsonify({
            "status": "success", 
            "message": "Zapisano w Qdrant",
            "chunks_count": len(points)
        }), 200

    except Exception as e:
        import traceback
        print("\n--- KRYTYCZNY BŁĄD WEBHOKA ---", flush=True)
        traceback.print_exc()
        print(f"Szczegóły błędu: {str(e)}", flush=True)
        print("------------------------------\n", flush=True)
        return jsonify({"error": f"Błąd indeksacji: {str(e)}"}), 500
        
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
