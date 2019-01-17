import typing

from pywasm import convention
from pywasm import num


class OperandEntry:
    def __init__(self, valtype: int, n):
        self.valtype = valtype
        self.n = n

    def __repr__(self):
        return f'{convention.valtype[self.valtype]}({self.n})'

    @classmethod
    def from_i32(cls, n):
        return OperandEntry(convention.i32, num.int2i32(n))

    @classmethod
    def from_i64(cls, n):
        return OperandEntry(convention.i64, num.int2i64(n))

    @classmethod
    def from_f32(cls, n):
        return OperandEntry(convention.f32, n)

    @classmethod
    def from_f64(cls, n):
        return OperandEntry(convention.f64, n)


class OperandStack:
    def __init__(self):
        self.data: typing.List[OperandEntry] = [None for _ in range(1024)]
        self.i: int = -1

    def add(self, n: OperandEntry):
        self.i += 1
        self.data[self.i] = n

    def pop(self) -> OperandEntry:
        r = self.data[self.i]
        self.i -= 1
        return r

    def len(self) -> int:
        return self.i + 1

    def top(self) -> OperandEntry:
        return self.data[self.i]
