import logging
from typing import List
from app.daos.base_dao import BaseDAO
from app.models.models import Orders
from app.serialize import serialize

logger = logging.getLogger(__name__)


class OrderDAO(BaseDAO):
    def get_all(self) -> list[dict]:
        """
        Retrieve all orders using SQLAlchemy ORM and return them as dictionaries.
        This conversion happens while the session is still active.
        """
        try:
            with self.get_session() as session:
                orders = session.query(Orders).all()
                # Convert each order to a plain dictionary using your SerializableMixin's to_dict
                orders_dicts = [serialize(order) for order in orders]
                session.expunge_all()
                return orders_dicts
        except Exception as e:
            logger.error("Error fetching all orders: %s", e, exc_info=True)
            raise

    def get_by_id(self, order_id: int) -> dict | None:
        """
        Retrieve a single order by its order_id and return it as a dictionary,
        or None if not found.
        """
        try:
            with self.get_session() as session:
                order = session.query(Orders).filter(Orders.orderid == order_id).first()
                session.expunge(order)
                if order:
                    return order
                return None
        except Exception as e:
            logger.error(
                "Error fetching order with ID %d: %s", order_id, e, exc_info=True
            )
            raise

    def get_total_orders_by_employee_id(self, employee_id, start_date, end_date) -> List[Orders] | None:
        try:
            with self.get_session() as session:
                orders = session.query(Orders).filter(Orders.employeeid == employee_id, Orders.orderdate.between(start_date, end_date)).all()
                session.expunge_all()
                return orders
        except Exception as e:
            logger.error("Error getting orders by employee id")
            raise
    

    def create(self, order: Orders) -> int:
        try:
            with self.get_session() as session:
                session.add(order)
                session.flush()  # Ensure pending changes are sent, so auto-generated keys are set.
                session.refresh(order)  # Refresh to get the auto-generated fields.
                order_id = order.orderid
                # Commit will be handled by the context manager.
                return order_id
        except Exception as e:
            logger.error("Error creating order: %s", e, exc_info=True)
            raise

    def update(self, order: Orders) -> None:
        try:
            with self.get_session() as session:
                session.merge(order)
                # Commit is handled by the context manager.
        except Exception as e:
            logger.error("Error updating order: %s", e, exc_info=True)
            raise
