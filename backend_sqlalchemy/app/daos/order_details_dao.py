import logging
from typing import Any, Dict, List
from app.daos.base_dao import BaseDAO
from app.models.models import OrderDetails
from app.serialize import serialize

logger = logging.getLogger(__name__)


class OrderDetailsDAO(BaseDAO):
    def create(self, order_detail: OrderDetails) -> None:
        """
        Inserts a new OrderDetails record using the ORM.
        """
        try:
            with self.get_session() as session:
                session.add(order_detail)
                session.flush()  # Flush pending changes so that autogenerated values are assigned.
                session.refresh(
                    order_detail
                )  # Refresh the instance to load generated values.
                # The commit will be handled by the context manager.
        except Exception as e:
            logger.error("Error creating order detail: %s", e, exc_info=True)
            raise

    def get_by_id(self, order_id: int) -> List[Dict[str, Any]]:
        """
        Retrieves all order detail records for a given order_id as a list of dictionaries.
        """
        try:
            with self.get_session() as session:
                details = (
                    session.query(OrderDetails)
                    .filter(OrderDetails.orderid == order_id)
                    .all()
                )
                # Convert each OrderDetails instance into a dictionary.
                details_dicts = [serialize(detail) for detail in details]
                return details_dicts
        except Exception as e:
            logger.error("Error fetching order details: %s", e, exc_info=True)
            raise
