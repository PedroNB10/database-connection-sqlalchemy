from flask import Blueprint, jsonify
from controllers.order_controller import OrderController


orders_bp = Blueprint("orders", __name__)
order_controller = OrderController()


@orders_bp.route("/", methods=["GET"])
def get_all_orders():
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
