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

        try:
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

        except Exception as e:
            print(f"Erro ao buscar pedido: {e}")
            raise

    def create(self, order: Orders) -> int:
        try:
            with self.get_cursor() as cursor:
                print(f"Dados do pedido: {order.__dict__}")
                cursor.execute(
                    "INSERT INTO northwind.orders "
                    "(orderid, customerid, employeeid, orderdate, requireddate, shippeddate, shipperid, freight, shipname, shipaddress, shipcity, shipregion, shippostalcode, shipcountry) "
                    "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) RETURNING orderid",
                    (
                        order.orderid,
                        order.customerid,
                        order.employeeid,
                        order.orderdate,
                        order.requireddate,
                        order.shippeddate,
                        order.shipperid,
                        order.freight,
                        order.shipname,
                        order.shipaddress,
                        order.shipcity,
                        order.shipregion,
                        order.shippostalcode,
                        order.shipcountry,
                    ),
                )
                order_id = cursor.fetchone()[0]
                return order_id

        except Exception as e:
            print(f"Erro ao criar pedido: {e}")
            raise
