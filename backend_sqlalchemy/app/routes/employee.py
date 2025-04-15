from flask import Blueprint, jsonify, request
from psycopg import DatabaseError
from datetime import datetime
from exceptions import (
    CustomerNotFoundError,
    InvalidOrderDataError,
    OrderAlreadyExistsError,
)
from app.controllers.employee_controller import EmployeeController

employee_bp = Blueprint("employees", __name__)
employee_controller = EmployeeController()


@employee_bp.route("/report", methods=["GET"])
def get_employees_ranking_report():
    try:
        start_date_str = request.args.get("start_date")
        end_date_str = request.args.get("end_date")
        if not start_date_str or not end_date_str:
            return (
                jsonify(
                    {
                        "error": "Missing required parameters: 'start_date' and 'end_date' are required"
                    }
                ),
                400,
            )

        try:
            start_date = datetime.fromisoformat(start_date_str)
            end_date = datetime.fromisoformat(end_date_str)
        except ValueError:
            return (
                jsonify(
                    {"error": "Invalid date format. Please provide ISO format dates."}
                ),
                400,
            )

        report = employee_controller.get_employees_ranking_report(start_date, end_date)
        if not report:
            return jsonify({"message": "No orders found"}), 404

        return jsonify(report), 200

    except AttributeError as e:
        return jsonify({"error": "Attribute error occurred", "details": str(e)}), 500
    except DatabaseError as e:
        return jsonify({"error": "Database error occurred", "details": str(e)}), 500
    except Exception as e:
        return jsonify({"Unknown error": str(e)}), 500
