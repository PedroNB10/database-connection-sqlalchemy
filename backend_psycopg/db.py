from psycopg_pool import ConnectionPool
from config import DB_USER, DB_PASS, DB_HOST, DB_PORT, DB_NAME, DB_SCHEMA

pool = ConnectionPool(
    conninfo=f"host={DB_HOST} port={DB_PORT} dbname={DB_NAME} user={DB_USER} password={DB_PASS}",
    min_size=1,
    max_size=10,
    timeout=5,
)


def get_connection():
    conn = pool.connection()
    if not conn:
        raise RuntimeError("❌ Failed to get a connection from the pool")
    return conn
