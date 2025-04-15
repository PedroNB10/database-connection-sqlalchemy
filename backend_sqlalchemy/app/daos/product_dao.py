from app.daos.base_dao import BaseDAO
from app.models.models import Products
from app.serialize import serialize


class ProductDAO(BaseDAO):

    def get_by_id(self, product_id: int) -> Products | None:
        try:
            with self.get_session() as session:
                product = session.query(Products).filter(Products.productid == product_id).first()
                session.expunge(product)
                if product:
                    return product
                return None
                

        except Exception as e:
            print(f"Error fetching product with ID {product_id}: {e}")
            raise
