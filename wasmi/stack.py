import struct
import typing

import wasmi.common


class Entry:
    def __init__(self, data: bytes):
        assert len(data) == 8
        self.data = data

    def __repr__(self):
        return self.data.hex()

    @classmethod
    def from_u32(cls, n):
        data = struct.pack('<I', n)
        data = data + bytearray([0x00, 0x00, 0x00, 0x00])
        return Entry(data)

    @classmethod
    def from_u64(cls, n):
        data = struct.pack('<Q', n)
        return Entry(data)

    @classmethod
    def from_i32(cls, n):
        data = struct.pack('<i', n)
        data = data + bytearray([0x00, 0x00, 0x00, 0x00])
        return Entry(data)

    @classmethod
    def from_i64(cls, n):
        data = struct.pack('<q', n)
        return Entry(data)

    @classmethod
    def from_f32(cls, n):
        data = struct.pack('<f', n)
        data = data + bytearray([0x00, 0x00, 0x00, 0x00])
        return Entry(data)

    @classmethod
    def from_f64(cls, n):
        data = struct.pack('<d', n)
        data = data + bytearray([0x00, 0x00, 0x00, 0x00])
        return Entry(data)

    def into_u32(self):
        return struct.unpack('<I', self.data[:4])[0]

    def into_u64(self):
        return struct.unpack('<W', self.data)[0]

    def into_i32(self):
        return struct.unpack('<i', self.data[:4])[0]

    def into_i64(self):
        return struct.unpack('<q', self.data)[0]

    def into_f32(self):
        return struct.unpack('<f', self.data[:4])[0]

    def into_f64(self):
        return struct.unpack('<d', self.data)[0]


class Stack:
    def __init__(self):
        self.data: typing.List[Entry] = []

    def add(self, n: Entry):
        self.data.append(n)

    def pop(self) -> Entry:
        return self.data.pop()

    def add_i32(self, n):
        self.add(Entry.from_i32(wasmi.common.into_i32(n)))

    def pop_i32(self):
        return self.pop().into_i32()

    def add_i64(self, n):
        self.add(Entry.from_i64(wasmi.common.into_i64(n)))

    def pop_i64(self):
        return self.pop().into_i64()

    def add_u32(self, n):
        self.add(Entry.from_u32(wasmi.common.into_u32(n)))

    def pop_u32(self):
        return self.pop().into_u32()

    def add_u64(self, n):
        self.add(Entry.from_u64(wasmi.common.into_u64(n)))

    def pop_u64(self):
        return self.pop().into_u64()

    def add_f32(self, n):
        self.add(Entry.from_f32(wasmi.common.into_f32(n)))

    def pop_f32(self):
        return self.pop().into_f32()

    def add_f64(self, n):
        self.add(Entry.from_f64(wasmi.common.into_f64(n)))

    def pop_f64(self):
        return self.pop().into_f64()
