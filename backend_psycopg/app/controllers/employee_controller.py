from typing import Dict, Any, List
from app.daos.order_dao import OrderDAO
from app.daos.order_details_dao import OrderDetailsDAO
from app.daos.customer_dao import CustomerDAO
from app.daos.product_dao import ProductDAO
from app.models.psycopg_models import Orders, OrderDetails
from app.daos.employee_dao import EmployeeDAO
from app.utils.serialize import serialize
from exceptions import (
    CustomerNotFoundError,
    OrderAlreadyExistsError,
    InvalidOrderDataError,
    DatabaseError,
)


class EmployeeController:
    def __init__(self) -> None:
        self.order_dao: OrderDAO = OrderDAO()
        self.order_details_dao: OrderDetailsDAO = OrderDetailsDAO()
        self.employee_dao: EmployeeDAO = EmployeeDAO()
        self.customer_dao: CustomerDAO = CustomerDAO()
        self.product_dao: ProductDAO = ProductDAO()

    def get_employees_ranking_report(self, start_date, end_date) -> dict:
        all_employees = self.employee_dao.get_all() or []
        ranking_list = []

        for emp in all_employees:
            emp_orders = (
                self.order_dao.get_total_orders_by_employee_id(
                    emp.employeeid, start_date, end_date
                )
                or []
            )

            ranking_list.append(
                {
                    "employee_id": emp.employeeid,
                    "employee_name": f"{emp.firstname} {emp.lastname}",
                    "total_orders": len(emp_orders),
                }
            )

        ranking_list.sort(key=lambda x: x["total_orders"], reverse=True)

        for index, employee in enumerate(ranking_list, start=1):
            employee["rank"] = index

        return {"ranking": ranking_list}
