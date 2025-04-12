import time
import psycopg
from flask import Flask, render_template
from app.routes.api import api_bp
from config import (
    DB_HOST,
    DB_PORT,
    DB_USER,
    DB_PASS,
    DB_NAME,
)


def create_app() -> Flask:
    """
    Application factory function that creates and configures the Flask application.
    """
    app = Flask(__name__, template_folder="templates", static_folder="static")
    app.config.from_object("config")  # or from a config class if you define one

    # Register the blueprint(s)
    app.register_blueprint(api_bp)

    @app.route("/")
    def index():
        return render_template("index.html")

    return app


def wait_for_db(retry_delay=2, max_retries=60):
    """
    Wait until the database is ready before starting the application.
    """
    db_config = {
        "host": DB_HOST or "localhost",
        "port": DB_PORT or "5432",
        "user": DB_USER or "postgres",
        "password": DB_PASS or "root",
        "dbname": DB_NAME or "northwind",
    }

    print("Using database configuration:", db_config)
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
