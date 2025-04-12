from daos.base_dao import BaseDAO
from models.psycopg_models import Customers


class CustomerDAO(BaseDAO):

    def get_all(self) -> list[Customers]:

        try:
            with self.get_cursor() as cursor:
                cursor.execute("SELECT * FROM northwind.customers")
                col_names = [desc[0] for desc in cursor.description]
                rows = cursor.fetchall()
                customers = []
                for row in rows:
                    row_dict = dict(zip(col_names, row))
                    customers.append(Customers(**row_dict))
                return customers

        except Exception as e:
            print(f"Error fetching all customers: {e}")
            raise

    def get_by_id(self, customer_id: str) -> Customers | None:
        try:
            with self.get_cursor() as cursor:
                cursor.execute(
                    "SELECT * FROM northwind.customers WHERE customerid = %s",
                    (customer_id,),
                )
                col_names = [desc[0] for desc in cursor.description]
                row = cursor.fetchone()
                if row:
                    row_dict = dict(zip(col_names, row))
                    return Customers(**row_dict)
                return None

        except:
            print(f"Error fetching customer with ID {customer_id}")
            raise
