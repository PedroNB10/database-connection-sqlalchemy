from daos.order_dao import OrderDAO


class OrderController:
    def __init__(self):
        self.order_dao = OrderDAO()

    def get_all_orders(self):
        return self.order_dao.get_all()
