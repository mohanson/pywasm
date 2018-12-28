class WAException(Exception):
    def __init__(self, message):
        self.message = message


class InvalidMagicNumber(Exception):
    pass


class Unreachable(Exception):
    pass


class MultipleLinearMemories(Exception):
    pass


class EmptyInitExpr(Exception):
    pass
