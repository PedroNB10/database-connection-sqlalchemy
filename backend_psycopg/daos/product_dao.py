from daos.base_dao import BaseDAO
from models.psycopg_models import Products

class ProductDAO(BaseDAO):
    def __init__(self):
        super().__init__()

    def get_all(self) -> list[Products]:
        with self.get_cursor() as cursor:
            cursor.execute("SELECT * FROM northwind.products")
            col_names = [desc[0] for desc in cursor.description]
            rows = cursor.fetchall()
            products = []
            for row in rows:
                row_dict = dict(zip(col_names, row))
                products.append(Products(**row_dict))
            return products
