from app.daos.base_dao import BaseDAO
from app.models.psycopg_models import Employees


class EmployeeDAO(BaseDAO):

    def get_all(self) -> list[Employees]:
        with self.get_cursor() as cursor:
            cursor.execute("SELECT * FROM northwind.employees")
            col_names = [desc[0] for desc in cursor.description]
            rows = cursor.fetchall()
            employees = []
            for row in rows:
                row_dict = dict(zip(col_names, row))
                employees.append(Employees(**row_dict))
            return employees

    def get_by_id(self, id):
        try:
            with self.get_cursor() as cursor:
                cursor.execute(
                    "SELECT * FROM northwind.employees WHERE employeeid = %s",
                    (id,),
                )
                col_names = [desc[0] for desc in cursor.description]
                row = cursor.fetchone()
                if row:
                    row_dict = dict(zip(col_names, row))
                    return Employees(**row_dict)
                return None

        except Exception as e:
            print(f"Error fetching customer with ID {id}: {e}")
            raise
