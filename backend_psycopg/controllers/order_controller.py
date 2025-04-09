from daos.order_dao import OrderDAO
from models.psycopg_models import Orders
from exceptions import OrderAlreadyExistsError, InvalidOrderDataError, DatabaseError


class OrderController:
    def __init__(self):
        self.order_dao = OrderDAO()

    def get_all_orders(self):
        try:
            return self.order_dao.get_all()
        except Exception as e:
            print(f"Erro no OrderController.get_all_orders: {e}")
            raise

    def get_order_by_id(self, order_id: int):
        try:
            return self.order_dao.get_by_id(order_id)
        except Exception as e:
            print(f"Erro no OrderController.get_order_by_id: {e}")
            raise

    def create_order(self, order: Orders):
        try:
            order_exists = self.order_dao.get_by_id(order.orderid)
            if order_exists:
                raise OrderAlreadyExistsError("Order with this ID already exists.")
            return self.order_dao.create(order)
        except OrderAlreadyExistsError:
            raise
        except Exception as e:
            raise DatabaseError("An error occurred while creating the order") from e
