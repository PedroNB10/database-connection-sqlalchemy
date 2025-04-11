from flask import Blueprint, jsonify, request
from psycopg import DatabaseError
from exceptions import InvalidOrderDataError, OrderAlreadyExistsError
from models.psycopg_models import Orders
from controllers.order_controller import OrderController


orders_bp = Blueprint("orders", __name__)
order_controller = OrderController()


@orders_bp.route("/", methods=["GET"])
def get_orders():
    try:
        orders = order_controller.get_all_orders()
        if not orders:
            return jsonify({"message": "No orders found"}), 404

        orders_dict = [order.__dict__ for order in orders]
        return jsonify(orders_dict), 200
    except AttributeError as e:
        return jsonify({"error": "Attribute error occurred", "details": str(e)}), 500

    except Exception as e:
        return jsonify({"error": str(e)}), 500


@orders_bp.route("/<int:order_id>", methods=["GET"])
def get_order(order_id):
    try:
        order = order_controller.get_order_by_id(order_id)
        if not order:
            return jsonify({"message": "Order not found"}), 404

        return jsonify(order.__dict__), 200
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

    except DatabaseError as de:
        return jsonify({"error": str(de)}), 500

    except Exception as e:
        return jsonify({"error": "Unexpected error", "details": str(e)}), 500
