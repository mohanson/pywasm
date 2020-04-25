import io
import typing


class instruction:
    opcode: int

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        opcode = ord(r.read(1))
        return {
            unreachable.opcode: unreachable.from_reader,
            nop.opcode: nop.from_reader,
            block.opcode: block.from_reader,
            loop.opcode: loop.from_reader,
        }[opcode](r)


class unreachable:
    opcode = 0x00

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        return unreachable()


class nop:
    opcode = 0x01

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        return nop()


class block:
    opcode = 0x02

    def __init__(self):
        self.bt: int
        self.expr: typing.List[instruction]

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = block()
        o.bt = ord(r.read(1))
        o.expr = []
        while r.read(1) != 0x0b:
            r.seek(-1, 1)
            o.expr.append(instruction.from_reader(r))
        return o


class loop:
    opcode = 0x03

    def __init__(self):
        self.bt: int
        self.expr: typing.List[instruction]

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = loop()
        o.bt = ord(r.read(1))
        o.expr = []
        while r.read(1) != 0x0b:
            r.seek(-1, 1)
            o.expr.append(instruction.from_reader(r))
        return o


class if_:
    opcode = 0x04

    def __init__(self):
        self.bt: int
        self.expr: typing.List[instruction]
        self.expr_else: typing.List[instruction]

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = if_()
        o.bt = ord(r.read(1))
        o.expr = []
        o.expr_else = []
        k = 0
        while True:
            n = r.read(1)
            if n == 0x05:
                k = 1
                continue
            if n == 0x0b:
                break
            r.seek(-1, 1)
            i = instruction.from_reader(r)
            if k:
                o.expr_else.append(i)
            else:
                o.expr.append(i)
        return o
