from daos.base_dao import BaseDAO
from models.psycopg_models import Orders
from db import get_connection


class OrderDAO(BaseDAO):
    def get_all(self) -> list[Orders]:
        with get_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute("SELECT * FROM northwind.orders")
                col_names = [desc[0] for desc in cursor.description]
                rows = cursor.fetchall()
                orders = []
                for row in rows:
                    row_dict = dict(zip(col_names, row))
                    orders.append(Orders(**row_dict))
                return orders

    def create_order(self, order):
        pass
