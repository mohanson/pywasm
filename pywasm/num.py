import io
import math
import struct

u8 = i8 = u16 = i16 = u32 = i32 = u64 = i64 = int
f32 = f64 = float


def int2u8(i: int) -> u8:
    return i & 0xff


def int2i8(i: int) -> i8:
    i = i & 0xff
    if i & 0x80:
        return i - 0x100
    return i


def int2u16(i: int) -> u16:
    return i & 0xffff


def int2i16(i: int) -> i16:
    i = i & 0xffff
    if i & 0x8000:
        return i - 0x10000
    return i


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


def i322f32(i: i32) -> f32:
    i = int2i32(i)
    return struct.unpack('<f', struct.pack('<i', i))[0]


def f322i32(f: f32) -> i32:
    return struct.unpack('<i', struct.pack('<f', f))[0]


def i642f64(i: i64) -> f64:
    i = int2i64(i)
    return struct.unpack('<d', struct.pack('<q', i))[0]


def f642i64(f: f64) -> i64:
    return struct.unpack('<q', struct.pack('<d', f))[0]


class LittleEndian:
    @staticmethod
    def u8(r: bytes):
        return struct.unpack('<B', r)[0]

    @staticmethod
    def i8(r: bytes):
        return struct.unpack('<b', r)[0]

    @staticmethod
    def u16(r: bytes):
        return struct.unpack('<H', r)[0]

    @staticmethod
    def i16(r: bytes):
        return struct.unpack('<h', r)[0]

    @staticmethod
    def u32(r: bytes):
        return struct.unpack('<I', r)[0]

    @staticmethod
    def i32(r: bytes):
        return struct.unpack('<i', r)[0]

    @staticmethod
    def u64(r: bytes):
        return struct.unpack('<Q', r)[0]

    @staticmethod
    def i64(r: bytes):
        return struct.unpack('<q', r)[0]

    @staticmethod
    def f32(r: bytes):
        return struct.unpack('<f', r)[0]

    @staticmethod
    def f64(r: bytes):
        return struct.unpack('<d', r)[0]

    @staticmethod
    def pack_u8(n: u8):
        return struct.pack('<B', n)

    @staticmethod
    def pack_i8(n: i8):
        return struct.pack('<b', n)

    @staticmethod
    def pack_u16(n: u16):
        return struct.pack('<H', n)

    @staticmethod
    def pack_i16(n: i16):
        return struct.pack('<h', n)

    @staticmethod
    def pack_u32(n: u32):
        return struct.pack('<I', n)

    @staticmethod
    def pack_i32(n: i32):
        return struct.pack('<i', n)

    @staticmethod
    def pack_u64(n: u64):
        return struct.pack('<Q', n)

    @staticmethod
    def pack_i64(n: i64):
        return struct.pack('<q', n)

    @staticmethod
    def pack_f32(n: f32):
        return struct.pack('<f', n)

    @staticmethod
    def pack_f64(n: f64):
        return struct.pack('<d', n)


class BigEndian:
    @staticmethod
    def u8(r: bytes):
        return struct.unpack('>B', r)[0]

    @staticmethod
    def i8(r: bytes):
        return struct.unpack('>b', r)[0]

    @staticmethod
    def u16(r: bytes):
        return struct.unpack('>H', r)[0]

    @staticmethod
    def i16(r: bytes):
        return struct.unpack('>h', r)[0]

    @staticmethod
    def u32(r: bytes):
        return struct.unpack('>I', r)[0]

    @staticmethod
    def i32(r: bytes):
        return struct.unpack('>i', r)[0]

    @staticmethod
    def u64(r: bytes):
        return struct.unpack('>Q', r)[0]

    @staticmethod
    def i64(r: bytes):
        return struct.unpack('>q', r)[0]

    @staticmethod
    def f32(r: bytes):
        return struct.unpack('>f', r)[0]

    @staticmethod
    def f64(r: bytes):
        return struct.unpack('>d', r)[0]

    @staticmethod
    def pack_u8(n: u8):
        return struct.pack('>B', n)

    @staticmethod
    def pack_i8(n: i8):
        return struct.pack('>b', n)

    @staticmethod
    def pack_u16(n: u16):
        return struct.pack('>H', n)

    @staticmethod
    def pack_i16(n: i16):
        return struct.pack('>h', n)

    @staticmethod
    def pack_u32(n: u32):
        return struct.pack('>I', n)

    @staticmethod
    def pack_i32(n: i32):
        return struct.pack('>i', n)

    @staticmethod
    def pack_u64(n: u64):
        return struct.pack('>Q', n)

    @staticmethod
    def pack_i64(n: i64):
        return struct.pack('>q', n)

    @staticmethod
    def pack_f32(n: f32):
        return struct.pack('>f', n)

    @staticmethod
    def pack_f64(n: f64):
        return struct.pack('>d', n)


def leb(reader, maxbits=32, signed=False):
    if isinstance(reader, (bytes, bytearray)):
        reader = io.BytesIO(reader)
    r = 0
    s = 0
    b = 0
    i = 0
    a = bytearray()
    while True:
        byte = ord(reader.read(1))
        i += 1
        a.append(byte)
        r |= ((byte & 0x7f) << s)
        s += 7
        if (byte & 0x80) == 0:
            break
        b += 1
        assert b <= math.ceil(maxbits / 7.0)
    if signed and (s < maxbits) and (byte & 0x40):
        r |= - (1 << s)
    return (i, r, a)


def rotl_u32(x: int, k: int):
    x = int2u32(x)
    k = int2u32(k)
    n = 32
    s = k & (n - 1)
    return x << s | x >> (n - s)


def rotl_u64(x: int, k: int):
    x = int2u64(x)
    k = int2u64(k)
    n = 64
    s = k & (n - 1)
    return x << s | x >> (n - s)


def rotr_u32(x: int, k: int):
    return rotl_u32(x, -k)


def rotr_u64(x: int, k: int):
    return rotl_u64(x, -k)


def idiv_s(a, b):
    return a // b if a * b > 0 else (a + (-a % b)) // b


def irem_s(a, b):
    return a % b if a * b > 0 else -(-a % b)
