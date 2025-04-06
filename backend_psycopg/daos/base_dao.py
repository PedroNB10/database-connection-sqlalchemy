from db import get_connection


class BaseDAO:
    def __init__(self):
        self.connection = get_connection()

    def cursor(self):
        try:
            return self.connection.cursor()
        except Exception as e:
            raise e

    def commit(self):
        try:
            self.connection.commit()
        except Exception as e:
            self.connection.rollback()
            raise e

    def close(self):
        self.connection.close()
