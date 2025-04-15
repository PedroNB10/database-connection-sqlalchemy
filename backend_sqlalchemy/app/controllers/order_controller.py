from typing import Dict, Any, List
from app.daos.order_dao import OrderDAO
from app.daos.order_details_dao import OrderDetailsDAO
from app.daos.customer_dao import CustomerDAO
from app.daos.product_dao import ProductDAO
from app.models.models import Orders, OrderDetails
from app.daos.employee_dao import EmployeeDAO
from exceptions import (
    CustomerNotFoundError,
    OrderAlreadyExistsError,
    InvalidOrderDataError,
    DatabaseError,
)

from app.serialize import serialize


def remove_duplicate_order_details(
    order_details: List[Dict[str, Any]],
) -> List[Dict[str, Any]]:
    seen = set()
    unique_details = []
    for detail in order_details:
        pid = detail.get("productid")
        if pid not in seen:
            seen.add(pid)
            unique_details.append(detail)
    return unique_details


class OrderController:
    def __init__(self) -> None:
        self.order_dao: OrderDAO = OrderDAO()
        self.order_details_dao: OrderDetailsDAO = OrderDetailsDAO()
        self.customer_dao: CustomerDAO = CustomerDAO()
        self.employee_dao: EmployeeDAO = EmployeeDAO()
        self.product_dao: ProductDAO = ProductDAO()

    def get_order_report(self, orderid) -> dict:
        order = self.order_dao.get_by_id(orderid)
        if not order:
            raise AttributeError("Order not found")

        order_details = self.order_details_dao.get_order_details_by_order_id(orderid)
        for detail in order_details:
            product = self.product_dao.get_by_id(detail.productid)
            if product:
                setattr(detail, "product_name", product.productname)
            else:
                setattr(detail, "product_name", "Unknown Product")

        if not order_details:
            raise AttributeError("Order details not found")

        customer = self.customer_dao.get_by_id(order.customerid)
        if not customer:
            raise AttributeError("Customer not found")
        customer_name = customer.contactname

        employee = self.employee_dao.get_by_id(order.employeeid)
        if not employee:
            raise AttributeError("Employee not found")
        employee_name = employee.firstname + " " + employee.lastname

        order_report = {
            "orderid": order.orderid,
            "order_date": order.orderdate,
            "customer_name": customer_name,
            "employee_name": employee_name,
            "order_details": [serialize(order) for order in order_details],
        }

        return order_report

    def get_all_orders(self) -> List[Orders]:
        try:
            orders = self.order_dao.get_all()
            if not orders:
                raise AttributeError("No orders found")
            return orders
        except Exception as e:
            print(f"Error fetching all orders: {e}")
            raise

    def get_order_by_id(self, order_id):
        try:
            order = self.order_dao.get_by_id(order_id)
            if not order:
                raise AttributeError("Couldn't find order")
            return order
        except Exception as e:
            print(f"Error fetching ordes: {e}")
            raise

    def create_order(self, order_data: Dict[str, Any]) -> int:

        try:
            required_order_fields = ["customerid", "employeeid"]
            for field in required_order_fields:
                if field not in order_data or order_data[field] is None:
                    raise InvalidOrderDataError(
                        f"Missing required field in order: {field}"
                    )

            order_details: List[Dict[str, Any]] = order_data.pop("order_details", [])
            order_details = remove_duplicate_order_details(order_details)

            required_detail_fields = ["productid", "quantity", "unitprice"]
            for detail in order_details:
                for field in required_detail_fields:
                    if field not in detail or detail[field] is None:
                        raise InvalidOrderDataError(
                            f"Missing required field in order_detail: {field}"
                        )

            if "orderid" in order_data and self.order_dao.get_by_id(
                order_data["orderid"]
            ):
                raise OrderAlreadyExistsError("Order with this ID already exists.")

            customer_exists = self.customer_dao.get_by_id(order_data["customerid"])

            if not customer_exists:
                raise CustomerNotFoundError(
                    f"Customer with ID {order_data['customerid']} not found."
                )

            order = Orders(**order_data)
            order_id: int = self.order_dao.create(order)

            for detail in order_details:
                detail["orderid"] = order_id
                order_detail = OrderDetails(**detail)
                self.order_details_dao.create(order_detail)

            return order_id

        except OrderAlreadyExistsError:
            raise
        except InvalidOrderDataError:
            raise
        except CustomerNotFoundError:
            raise

        except Exception as e:
            print(f"Error creating order: {e}")
            raise DatabaseError("An error occurred while creating the order") from e
