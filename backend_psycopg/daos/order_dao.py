from daos.base_dao import BaseDAO
from models.psycopg_models import Orders


class OrderDAO(BaseDAO):

    def get_all(self) -> list[Orders]:
        try:
            with self.get_cursor() as cursor:
                cursor.execute("SELECT * FROM northwind.orders")
                col_names = [desc[0] for desc in cursor.description]
                rows = cursor.fetchall()
                orders = []
                for row in rows:
                    row_dict = dict(zip(col_names, row))
                    orders.append(Orders(**row_dict))
                return orders
        except Exception as e:
            print(f"Erro ao buscar pedidos: {e}")
            raise

    def get_by_id(self, order_id: int) -> Orders | None:
        with self.get_cursor() as cursor:
            cursor.execute(
                "SELECT * FROM northwind.orders WHERE orderid = %s", (order_id,)
            )
            col_names = [desc[0] for desc in cursor.description]
            row = cursor.fetchone()
            if row:
                row_dict = dict(zip(col_names, row))
                return Orders(**row_dict)
            return None
