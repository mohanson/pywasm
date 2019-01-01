import struct
import typing

import wasmi.common
import wasmi.opcodes


class Entry:
    def __init__(self, data: bytearray, kind: int):
        assert len(data) == 8
        self.data = data
        self.kind = kind

    def __repr__(self):
        return self.data.hex()

    @classmethod
    def from_i32(cls, n):
        data = struct.pack('>i', n)
        data = bytearray([0x00, 0x00, 0x00, 0x00]) + data
        return Entry(data, wasmi.opcodes.VALUE_TYPE_I32)

    @classmethod
    def from_i64(cls, n):
        data = struct.pack('>q', n)
        return Entry(data, wasmi.opcodes.VALUE_TYPE_I64)

    @classmethod
    def from_u32(cls, n):
        return cls.from_i32(wasmi.common.into_i32(n))

    @classmethod
    def from_u64(cls, n):
        return cls.from_i64(wasmi.common.into_i64(n))

    @classmethod
    def from_f32(cls, n):
        data = struct.pack('>f', n)
        data = bytearray([0x00, 0x00, 0x00, 0x00]) + data
        return Entry(data, wasmi.opcodes.VALUE_TYPE_F32)

    @classmethod
    def from_f64(cls, n):
        data = struct.pack('>d', n)
        return Entry(data, wasmi.opcodes.VALUE_TYPE_F64)

    @classmethod
    def from_val(cls, n, kind: int):
        if kind == wasmi.opcodes.VALUE_TYPE_I32:
            return cls.from_i32(n)
        if kind == wasmi.opcodes.VALUE_TYPE_I64:
            return cls.from_i64(n)
        if kind == wasmi.opcodes.VALUE_TYPE_F32:
            return cls.from_f32(n)
        if kind == wasmi.opcodes.VALUE_TYPE_F64:
            return cls.from_f64(n)
        raise NotImplementedError()

    def into_i32(self):
        return struct.unpack('>i', self.data[4:])[0]

    def into_i64(self):
        return struct.unpack('>q', self.data)[0]

    def into_u32(self):
        return wasmi.common.into_u32(self.into_i32())

    def into_u64(self):
        return wasmi.common.into_u64(self.into_i64())

    def into_f32(self):
        return struct.unpack('>f', self.data[4:])[0]

    def into_f64(self):
        return struct.unpack('>d', self.data)[0]

    def into_val(self):
        if self.kind == wasmi.opcodes.VALUE_TYPE_I32:
            return self.into_i32()
        if self.kind == wasmi.opcodes.VALUE_TYPE_I64:
            return self.into_i64()
        if self.kind == wasmi.opcodes.VALUE_TYPE_F32:
            return self.into_f32()
        if self.kind == wasmi.opcodes.VALUE_TYPE_F64:
            return self.into_f64()
        raise NotImplementedError()


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

    def add_i32(self, n):
        self.add(Entry.from_i32(wasmi.common.into_i32(n)))

    def add_i64(self, n):
        self.add(Entry.from_i64(wasmi.common.into_i64(n)))

    def add_u32(self, n):
        self.add(Entry.from_u32(wasmi.common.into_u32(n)))

    def add_u64(self, n):
        self.add(Entry.from_u64(wasmi.common.into_u64(n)))

    def add_f32(self, n):
        self.add(Entry.from_f32(wasmi.common.into_f32(n)))

    def add_f64(self, n):
        self.add(Entry.from_f64(wasmi.common.into_f64(n)))

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
