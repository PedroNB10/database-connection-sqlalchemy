from flask import Blueprint
from app.routes.orders import orders_bp

api_bp = Blueprint("api", __name__, url_prefix="/api")

api_bp.register_blueprint(orders_bp, url_prefix="/orders")
