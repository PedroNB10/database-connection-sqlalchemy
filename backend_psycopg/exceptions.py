class OrderAlreadyExistsError(Exception):
    """Exceção para indicar que um pedido com o ID informado já existe."""

    pass


class InvalidOrderDataError(Exception):
    """Exceção para indicar que os dados do pedido são inválidos ou estão incompletos."""

    pass


class DatabaseError(Exception):
    """Exceção para encapsular erros gerais de banco de dados."""

    pass
