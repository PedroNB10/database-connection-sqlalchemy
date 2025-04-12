from contextlib import contextmanager
from db import get_connection
import logging

logger = logging.getLogger(__name__)


class BaseDAO:
    @contextmanager
    def get_cursor(self):
        """
        Obtains a cursor to perform operations on the database.
        Ensures that the transaction is committed if everything goes well,
        or rolled back if an error occurs.
        """
        with get_connection() as conn:
            with conn.cursor() as cursor:
                try:
                    yield cursor
                    conn.commit()
                except Exception as e:
                    conn.rollback()
                    logger.error("Error while executing cursor", exc_info=True)
                    raise e

    def get_all(self) -> list:
        """
        Returns a list of all records.
        Should be implemented by the subclass.
        """
        pass

    def get_by_id(self, id: int) -> object | None:
        """
        Returns a record with the specified ID, or None if not found.
        Should be implemented by the subclass.
        """
        pass

    def create(self, obj: object) -> int:
        """
        Creates a new record and returns the generated ID.
        Should be implemented by the subclass.
        """
        pass

    def update(self, obj: object) -> None:
        """
        Updates an existing record.
        Should be implemented by the subclass.
        """
        pass
