from app.daos.base_dao import BaseDAO
from app.models.psycopg_models import OrderDetails
from typing import Any, Dict


class OrderDetailsDAO(BaseDAO):
    def create(self, order_detail: OrderDetails) -> None:

        try:
            with self.get_cursor() as cursor:
                cursor.execute(
                    "INSERT INTO northwind.order_details "
                    "(orderid, productid, unitprice, quantity, discount) "
                    "VALUES (%s, %s, %s, %s, %s)",
                    (
                        order_detail.orderid,
                        order_detail.productid,
                        order_detail.unitprice,
                        order_detail.quantity,
                        (
                            order_detail.discount
                            if order_detail.discount is not None
                            else 0
                        ),
                    ),
                )
        except Exception as e:
            print(f"Erro ao criar order detail: {e}")
            raise

    def get_order_details_by_order_id(self, order_id: int) -> list[OrderDetails] | None:
        try:
            with self.get_cursor() as cursor:
                cursor.execute(
                    "SELECT * FROM northwind.order_details WHERE orderid = %s",
                    (order_id,),
                )
                col_names = [desc[0] for desc in cursor.description]
                rows = cursor.fetchall()
                order_details = []
                for row in rows:
                    row_dict = dict(zip(col_names, row))
                    order_details.append(OrderDetails(**row_dict))

                return order_details

        except Exception as e:
            print(f"Erro ao buscar order details: {e}")
            raise
