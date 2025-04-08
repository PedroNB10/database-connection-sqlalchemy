from contextlib import contextmanager
from db import get_connection


class BaseDAO:
    @contextmanager
    def get_cursor(self):
        with get_connection() as conn:
            with conn.cursor() as cursor:
                try:
                    yield cursor
                    conn.commit()
                except Exception as e:
                    conn.rollback()
                    raise e
