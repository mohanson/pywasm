import typing


class Option:
    # A option consists of the current execution state
    def __init__(self):
        # A function used to count cycle consumption, the parameter is the opcode of the instruction
        self.instruction_cycle_func: typing.Callable[[int], int] = lambda _: 1
        # If cycle exceeded limit, an out of gas error will be throwed
        self.cycle_limit = 0
        # Count the currently used cycles
        self.cycle = 0
