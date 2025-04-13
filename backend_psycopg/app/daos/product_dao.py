from app.daos.base_dao import BaseDAO
from app.models.psycopg_models import Products


class ProductDAO(BaseDAO):

    def get_by_id(self, product_id: int) -> Products | None:
        try:
            with self.get_cursor() as cursor:
                cursor.execute(
                    "SELECT * FROM northwind.products WHERE productid = %s",
                    (product_id,),
                )
                col_names = [desc[0] for desc in cursor.description]
                row = cursor.fetchone()
                if row:
                    row_dict = dict(zip(col_names, row))
                    return Products(**row_dict)
                return None
        except Exception as e:
            print(f"Error fetching product with ID {product_id}: {e}")
            raise
