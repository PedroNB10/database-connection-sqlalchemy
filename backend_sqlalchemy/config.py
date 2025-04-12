import os
from dotenv import load_dotenv

# Load environment variables from a .env file
load_dotenv()

# Define configuration variables with defaults if not provided
SQL_DATABASE_URI = os.getenv(
    "SQL_DATABASE_URI", "postgresql+psycopg://postgres:root@localhost:4000/northwind"
)
DB_USER = os.getenv("POSTGRES_USER", "postgres")
DB_PASS = os.getenv("POSTGRES_PASSWORD", "root")
DB_HOST = os.getenv("POSTGRES_HOST", "localhost")
DB_PORT = os.getenv("POSTGRES_PORT", "4000")
DB_NAME = os.getenv("POSTGRES_DB", "northwind")
DB_SCHEMA = os.getenv("POSTGRES_SCHEMA", "northwind")
