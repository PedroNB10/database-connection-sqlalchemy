from daos.order_dao import OrderDAO


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
