from daos.base_dao import BaseDAO
from models.psycopg_models import Customers
from db import get_connection


class CustomerDao(BaseDAO):
    def __init__(self):
        super().__init__()

    def get_all(self) -> list[Customers]:
        with self.cursor as cursor:
            cursor.execute("SELECT * FROM northwind.customers")
            col_names = [desc[0] for desc in cursor.description]
            rows = cursor.fetchall()
            customers = []
            for row in rows:
                row_dict = dict(zip(col_names, row))
                customers.append(Customers(**row_dict))
            return customers

    def get_customer_by_id(self, customer_id: str) -> Customers | None:
        with get_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute(
                    "SELECT * FROM northwind.customers WHERE customer_id = %s",
                    (customer_id,),
                )
                col_names = [desc[0] for desc in cursor.description]
                row = cursor.fetchone()
                if row:
                    row_dict = dict(zip(col_names, row))
                    return Customers(**row_dict)
                return None
