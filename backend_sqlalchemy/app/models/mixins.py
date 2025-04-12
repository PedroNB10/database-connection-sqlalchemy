from sqlalchemy.inspection import inspect


class SerializableMixin:
    def to_dict(self) -> dict:
        """
        Convert the SQLAlchemy model instance into a dictionary.
        Only includes columns mapped to the database, excluding internal state.
        """
        return {c.key: getattr(self, c.key) for c in inspect(self).mapper.column_attrs}
