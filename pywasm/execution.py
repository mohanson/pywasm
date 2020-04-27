import typing

from . import convention
from . import num
from . import structure


class Value:
    # Values are represented by themselves.
    def __init__(self):
        self.type: structure.ValueType = structure.ValueType()
        self.data: bytearray = bytearray(8)

    def __repr__(self):
        return f'{self.type} {self.val()}'

    def val(self) -> typing.Union[num.i32, num.i64, num.f32, num.f64]:
        return {
            convention.i32: self.i32,
            convention.i64: self.i64,
            convention.f32: self.f32,
            convention.f64: self.f64
        }[self.type]()

    def i32(self) -> num.i32:
        return num.LittleEndian.i32(self.data[0:4])

    def i64(self) -> num.i64:
        return num.LittleEndian.i64(self.data[0:8])

    def f32(self) -> num.f32:
        return num.LittleEndian.f32(self.data[0:4])

    def f64(self) -> num.f64:
        return num.LittleEndian.f64(self.data[0:8])

    @classmethod
    def from_i32(cls, n: num.i32):
        o = Value()
        o.type = structure.ValueType(convention.i32)
        o.data[0:4] = num.LittleEndian.pack_i32(n)
        return o

    @classmethod
    def from_i64(cls, n: num.i64):
        o = Value()
        o.type = structure.ValueType(convention.i64)
        o.data[0:8] = num.LittleEndian.pack_i64(n)
        return o

    @classmethod
    def from_f32(cls, n: num.f32):
        o = Value()
        o.type = structure.ValueType(convention.f32)
        o.data[0:4] = num.LittleEndian.pack_f32(n)
        return o

    @classmethod
    def from_f64(cls, n: num.f64):
        o = Value()
        o.type = structure.ValueType(convention.f64)
        o.data[0:8] = num.LittleEndian.pack_f64(n)
        return o


class AbstractMachine:

    def __init__(self):
        pass

    def instantiate(self, module: structure.Module):
        pass
