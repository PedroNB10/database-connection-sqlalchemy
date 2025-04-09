import time
import subprocess
import psycopg
from flask import Flask, render_template
from routes.api import api_bp
from config import DB_HOST, DB_PORT, DB_USER, DB_PASS, DB_NAME, DB_SCHEMA
from daos.product_dao import ProductDAO

app = Flask(__name__, template_folder="templates")
app.config.from_object("config")
app.register_blueprint(api_bp)


@app.route("/")
def index():
    try:
        products = ProductDAO().get_all()
        return render_template("index.html", products=products)
    except Exception as e:
        print(f"Erro ao carregar produtos: {e}")
        return render_template("index.html", products=[], error_message="Erro ao carregar produtos.")

def wait_for_db(retry_delay=2, max_retries=60):
    """Wait until the database is ready before starting the application."""
    db_config = {
        "host": DB_HOST or "localhost",
        "port": DB_PORT or "5432",
        "user": DB_USER or "postgres",
        "password": DB_PASS or "root",
        "dbname": DB_NAME or "northwind",
    }

    print("Using database configuration:")
    # print(f"POSTGRES_HOST: {db_config['host']}")
    # print(f"POSTGRES_PORT: {db_config['port']}")
    # print(f"POSTGRES_USER: {db_config['user']}")
    # print(f"POSTGRES_PASSWORD: {db_config['password']}")
    # print(f"POSTGRES_DB: {db_config['dbname']}")
    # print(f"POSTGRES_SCHEMA: {DB_SCHEMA}")

    retries = 0
    while retries < max_retries:
        try:
            conn = psycopg.connect(**db_config)
            conn.close()
            print("Database is available!")
            return
        except psycopg.OperationalError:
            print(f"Database not available yet, waiting {retry_delay} seconds...")
            time.sleep(retry_delay)
            retries += 1

    raise RuntimeError("Database did not become available after several retries.")


if __name__ == "__main__":
    # Run the docker compose command to start the containers.
    print("Starting Docker Compose...")
    subprocess.run(["docker", "compose", "up", "-d"], check=True)

    # Wait for the database to be ready.
    wait_for_db()

    # Now start the Flask app.
    app.run(debug=True, host="0.0.0.0", port=3000)
