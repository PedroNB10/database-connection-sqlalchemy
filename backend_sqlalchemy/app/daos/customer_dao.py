import logging
from app.daos.base_dao import BaseDAO
from app.models.models import Customers

logger = logging.getLogger(__name__)


class CustomerDAO(BaseDAO):

    def get_all(self) -> list[Customers]:
        """
        Retrieve all customer records using SQLAlchemy ORM.
        """
        try:
            with self.get_session() as session:
                customers = session.query(Customers).all()
                return customers
        except Exception as e:
            logger.error("Error fetching all customers: %s", e, exc_info=True)
            raise

    def get_by_id(self, customer_id: str) -> Customers | None:
        """
        Retrieve a customer with the specified ID using SQLAlchemy ORM.
        """
        try:
            with self.get_session() as session:
                customer = (
                    session.query(Customers)
                    .filter(Customers.customerid == customer_id)
                    .first()
                )
                return customer
        except Exception as e:
            logger.error(
                "Error fetching customer with ID %s: %s", customer_id, e, exc_info=True
            )
            raise
