class OrderAlreadyExistsError(Exception):
    """Exceção para indicar que um pedido com o ID informado já existe."""

    pass


class InvalidOrderDataError(Exception):
    """Exceção para indicar que os dados do pedido são inválidos ou estão incompletos."""

    pass


class DatabaseError(Exception):
    """Exceção para encapsular erros gerais de banco de dados."""

    pass


class CustomerNotFoundError(Exception):
    """Exceção para indicar que o cliente não foi encontrado no banco de dados."""

    pass


class OrderNotFoundError(Exception):
    """Exceção para indicar que o pedido não foi encontrado no banco de dados."""

    pass


class EmployeeNotFoundError(Exception):
    """Exceção para indicar que o funcionário não foi encontrado no banco de dados."""

    pass
