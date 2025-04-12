from flask import Blueprint, jsonify, request
from psycopg import DatabaseError
from exceptions import (
    CustomerNotFoundError,
    InvalidOrderDataError,
    OrderAlreadyExistsError,
)
from app.models.models import Orders
from app.controllers.order_controller import OrderController


orders_bp = Blueprint("orders", __name__)
order_controller = OrderController()


@orders_bp.route("/", methods=["GET"])
def get_orders():
    # return jsonify({"message": "Hello, World!"}), 200
    try:
        orders = order_controller.get_all_orders()
        if not orders:
            return jsonify({"message": "No orders found"}), 404

        return jsonify(orders), 200
    except AttributeError as e:
        return jsonify({"error": "Attribute error occurred", "details": str(e)}), 500

    except Exception as e:
        return jsonify({"error": str(e)}), 500


@orders_bp.route("/", methods=["POST"])
def create_order():
    try:
        data = request.get_json()
        order_id = order_controller.create_order(data)

        return (
            jsonify({"message": "Order created successfully", "order_id": order_id}),
            201,
        )

    except OrderAlreadyExistsError as oae:
        return jsonify({"error": str(oae)}), 409

    except InvalidOrderDataError as iode:
        return jsonify({"error": str(iode)}), 400

    except CustomerNotFoundError as cnfe:
        return jsonify({"error": str(cnfe)}), 404

    except DatabaseError as de:
        return jsonify({"error": str(de)}), 500

    except Exception as e:
        return jsonify({"error": "Unexpected error", "details": str(e)}), 500
