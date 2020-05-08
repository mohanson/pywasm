import struct

import numpy


numpy.seterr(all='ignore')

i32 = i64 = int
u32 = u64 = int
f32 = numpy.float32
f64 = numpy.float64


def int2u32(i: int) -> u32:
    return i & 0xffffffff


def int2i32(i: int) -> i32:
    i = i & 0xffffffff
    if i & 0x80000000:
        return i - 0x100000000
    return i


def int2u64(i: int) -> u64:
    return i & 0xffffffffffffffff


def int2i64(i: int) -> i64:
    i = i & 0xffffffffffffffff
    if i & 0x8000000000000000:
        return i - 0x10000000000000000
    return i


class LittleEndian:

    @staticmethod
    def i8(r: bytes):
        return struct.unpack('<b', r)[0]

    @staticmethod
    def i16(r: bytes):
        return struct.unpack('<h', r)[0]

    @staticmethod
    def i32(r: bytes):
        return struct.unpack('<i', r)[0]

    @staticmethod
    def i64(r: bytes):
        return struct.unpack('<q', r)[0]

    @staticmethod
    def u8(r: bytes):
        return struct.unpack('<B', r)[0]

    @staticmethod
    def u16(r: bytes):
        return struct.unpack('<H', r)[0]

    @staticmethod
    def u32(r: bytes):
        return struct.unpack('<I', r)[0]

    @staticmethod
    def u64(r: bytes):
        return struct.unpack('<Q', r)[0]

    @staticmethod
    def f32(r: bytes):
        return numpy.frombuffer(r, f32)[0]

    @staticmethod
    def f64(r: bytes):
        return numpy.frombuffer(r, f64)[0]

    @staticmethod
    def pack_i8(n: i8):
        return struct.pack('<b', n)

    @staticmethod
    def pack_i16(n: i16):
        return struct.pack('<h', n)

    @staticmethod
    def pack_i32(n: i32):
        return struct.pack('<i', n)

    @staticmethod
    def pack_i64(n: i64):
        return struct.pack('<q', n)

    @staticmethod
    def pack_u8(n: u8):
        return struct.pack('<B', n)

    @staticmethod
    def pack_u16(n: u16):
        return struct.pack('<H', n)

    @staticmethod
    def pack_u32(n: u32):
        return struct.pack('<I', n)

    @staticmethod
    def pack_u64(n: u64):
        return struct.pack('<Q', n)

    @staticmethod
    def pack_f32(n: f32):
        return n.tobytes()

    @staticmethod
    def pack_f64(n: f64):
        return n.tobytes()
