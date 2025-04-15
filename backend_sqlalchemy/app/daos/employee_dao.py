import logging
from app.daos.base_dao import BaseDAO
from app.models.models import Employees

logger = logging.getLogger(__name__)


class EmployeeDAO(BaseDAO):

    def get_all(self) -> list[Employees]:
        """
        Retrieve all employee records using SQLAlchemy ORM.
        """
        try:
            with self.get_session() as session:
                employees = session.query(Employees).all()
                session.expunge_all()
                return employees
        except Exception as e:
            logger.error("Error fetching all employees: %s", e, exc_info=True)
            raise

    def get_by_id(self, id: int) -> Employees | None:
        """
        Retrieve a single employee by their employeeid.
        """
        try:
            with self.get_session() as session:
                employee = (
                    session.query(Employees).filter(Employees.employeeid == id).first()
                )
                session.expunge(employee)
                return employee
        except Exception as e:
            logger.error("Error fetching employee with ID %d: %s", id, e, exc_info=True)
            raise
