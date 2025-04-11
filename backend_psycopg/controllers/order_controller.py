from typing import Dict, Any, List
from daos.order_dao import OrderDAO
from daos.order_details_dao import OrderDetailsDAO
from models.psycopg_models import Orders, OrderDetails
from exceptions import OrderAlreadyExistsError, InvalidOrderDataError, DatabaseError


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

            required_detail_fields = ["productid"]
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
        except Exception as e:
            print(f"Erro no OrderController.create_order: {e}")
            raise DatabaseError("An error occurred while creating the order") from e
