import typing

import wasmi.opcodes as opcodes
import wasmi.num as num


class Entry:
    def __init__(self, valtype: int, n):
        self.valtype = valtype
        self.n = n

    def __repr__(self):
        return f'{opcodes.VALTYPE_INFO[self.valtype]}({self.n})'

    @classmethod
    def from_i32(cls, n):
        return Entry(opcodes.VALTYPE_I32, num.int2i32(n))

    @classmethod
    def from_i64(cls, n):
        return Entry(opcodes.VALTYPE_I64, num.int2i64(n))

    @classmethod
    def from_f32(cls, n):
        return Entry(opcodes.VALTYPE_F32, n)

    @classmethod
    def from_f64(cls, n):
        return Entry(opcodes.VALTYPE_F64, n)

    def into_i32(self):
        return self.n

    def into_i64(self):
        return self.n

    def into_u32(self):
        return num.int2u32(self.n)

    def into_u64(self):
        return num.int2u64(self.n)

    def into_f32(self):
        return self.n

    def into_f64(self):
        return self.n


class Stack:
    def __init__(self):
        self.data: typing.List[Entry] = [None for _ in range(1024)]
        self.i: int = -1

    def add(self, n: Entry):
        self.i += 1
        self.data[self.i] = n

    def pop(self) -> Entry:
        r = self.data[self.i]
        self.i -= 1
        return r

    def len(self) -> int:
        return self.i + 1

    def top(self) -> Entry:
        return self.data[self.i]

    def add_i32(self, n):
        self.add(Entry.from_i32(n))

    def add_i64(self, n):
        self.add(Entry.from_i64(n))

    def add_f32(self, n):
        self.add(Entry.from_f32(n))

    def add_f64(self, n):
        self.add(Entry.from_f64(n))

    def pop_i32(self):
        return self.pop().into_i32()

    def pop_i64(self):
        return self.pop().into_i64()

    def pop_u32(self):
        return self.pop().into_u32()

    def pop_u64(self):
        return self.pop().into_u64()

    def pop_f32(self):
        return self.pop().into_f32()

    def pop_f64(self):
        return self.pop().into_f64()
