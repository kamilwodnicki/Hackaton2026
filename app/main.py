import os
import psycopg2
from flask import Flask

app = Flask(__name__)


def check_db_connection():
  try:
    conn = psycopg2.connect(
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        host=os.getenv("DB_HOST"),
        port=os.getenv("DB_PORT"),
    )
    conn.close()
    return "Połączenie z bazą danych PostgreSQL powiodło się!"
  except Exception as e:
    return f"Błąd połączenia z bazą: {e}"


@app.route("/")
def home():
  db_status = check_db_connection()
  return f"<h1>Backend w Pythonie działa!</h1><p>{db_status}</p>"


if __name__ == "__main__":
  app.run(host="0.0.0.0", port=5000)