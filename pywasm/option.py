import typing

from . import binary


class Option:
    # A option consists of the current execution state
    def __init__(self):
        # A function used to count cycle consumption
        self.instruction_cycle_func: typing.Callable[[binary.Instruction], int] = lambda _: 1
        # If cycle exceeded limit, an out of gas error will be throwed
        self.cycle_limit = 0
        # Count the currently used cycles
        self.cycle = 0
        # Memory page limit. 1 page = 65536 bytes
        self.pages_limit = 0
