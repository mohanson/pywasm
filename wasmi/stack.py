import struct
import typing


class Stack:
    def __init__(self):
        self.data: typing.List[bytes] = []

    def push(self, n: bytes):
        assert len(n) == 8
        self.data.append(n)

    def pop(self) -> bytes:
        return self.data.pop()

    def push_i32(self, n):
        self.data.append(struct.pack('<i', n))

    def pop_i32(self):
        return struct.unpack('<i', self.data.pop())[0]

    def push_i64(self, n):
        self.data.append(struct.pack('<q', n))

    def pop_i64(self):
        return struct.unpack('<q', self.data.pop())[0]

    def push_u32(self, n):
        self.data.append(struct.pack('<I', n))

    def pop_u32(self):
        return struct.unpack('<I', self.data.pop())[0]

    def push_u64(self, n):
        self.data.append(struct.pack('<Q', n))

    def pop_u64(self):
        return struct.unpack('<Q', self.data.pop())[0]

    def push_f32(self, n):
        self.data.append(struct.pack('<f', n))

    def get_f32(self, n):
        return struct.unpack('<f', self.data.pop())[0]

    def push_f64(self, n):
        self.data.append(struct.pack('<d', n))

    def get_f64(self, n):
        return struct.unpack('<d', self.data.pop())[0]
