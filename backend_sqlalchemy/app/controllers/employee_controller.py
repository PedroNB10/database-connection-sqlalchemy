from typing import List
from app.daos.order_dao import OrderDAO
from app.daos.order_details_dao import OrderDetailsDAO
from app.daos.customer_dao import CustomerDAO
from app.daos.product_dao import ProductDAO
from app.models.models import OrderDetails
from app.daos.employee_dao import EmployeeDAO


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

            emp_orders_details = (
                self.order_dao.get_total_orders_by_employee_id(
                    emp.employeeid, start_date, end_date
                )
                or []
            )

            emp_order_details: List[OrderDetails] = []
            for order in emp_orders_details:
                details = self.order_details_dao.get_order_details_by_order_id(
                    order.orderid
                )
                if details:
                    if isinstance(details, list):
                        emp_order_details.extend(details)
                    else:
                        emp_order_details.append(details)

            emp_total_amount = 0
            for detail in emp_order_details:
                qty = detail.quantity if detail.quantity is not None else 0
                price = detail.unitprice if detail.unitprice is not None else 0
                discount = detail.discount if detail.discount is not None else 0
                emp_total_amount += qty * price * (1 - discount)

            ranking_list.append(
                {
                    "employee_id": emp.employeeid,
                    "employee_name": f"{emp.firstname} {emp.lastname}",
                    "total_orders": len(emp_orders),
                    "total_orders_details": len(emp_order_details),
                    "total_amount": emp_total_amount,
                }
            )

        ranking_list.sort(key=lambda x: float(x["total_orders"]), reverse=True)

        for index, employee in enumerate(ranking_list, start=1):
            employee["rank"] = index

        return {"ranking": ranking_list}
