import struct
import typing
import io

I8_MAX = (1 << 7) - 1
I8_MIN = - (1 << 7)
I8_LEN = 1 << 8
I16_MAX = (1 << 15) - 1
I16_MIN = - (1 << 15)
I16_LEN = 1 << 16
I32_MAX = (1 << 31) - 1
I32_MIN = - (1 << 31)
I32_LEN = 1 << 32
I64_MAX = (1 << 63) - 1
I64_MIN = - (1 << 63)
I64_LEN = 1 << 64
U8_MAX = (1 << 8) - 1
U8_LEN = 1 << 8
U16_MAX = (1 << 16) - 1
U16_LEN = 1 << 16
U32_MAX = (1 << 32) - 1
U32_LEN = 1 << 32
U64_MAX = (1 << 64) - 1
U64_LEN = 1 << 64


def into_i8(n: int):
    if n > I8_MAX:
        i = (n - I8_MAX - 1) // I8_LEN + 1
        return n - i * I8_LEN
    if n < I8_MIN:
        i = (I8_MIN - n - 1) // I8_LEN + 1
        return n + i * I8_LEN
    return n


def into_i16(n: int):
    if n > I16_MAX:
        i = (n - I16_MAX - 1) // I16_LEN + 1
        return n - i * I16_LEN
    if n < I16_MIN:
        i = (I16_MIN - n - 1) // I16_LEN + 1
        return n + i * I16_LEN
    return n


def into_i32(n: int):
    if n > I32_MAX:
        i = (n - I32_MAX - 1) // I32_LEN + 1
        return n - i * I32_LEN
    if n < I32_MIN:
        i = (I32_MIN - n - 1) // I32_LEN + 1
        return n + i * I32_LEN
    return n


def into_i64(n: int):
    if n > I64_MAX:
        i = (n - I64_MAX - 1) // I64_LEN + 1
        return n - i * I64_LEN
    if n < I64_MIN:
        i = (I64_MIN - n - 1) // I64_LEN + 1
        return n + i * I64_LEN
    return n


def into_u8(n: int):
    if n > U8_MAX or n < 0:
        return n % U8_LEN
    return n


def into_u16(n: int):
    if n > U16_MAX or n < 0:
        return n % U16_LEN
    return n


def into_u32(n: int):
    if n > U32_MAX or n < 0:
        return n % U32_LEN
    return n


def into_u64(n: int):
    if n > U64_MAX or n < 0:
        return n % U64_LEN
    return n


def into_f32(n: float):
    return n


def into_f64(n: float):
    return n


def decode_i8(r: bytes):
    assert len(r) == 1
    return struct.unpack('<b', r)[0]


def decode_i16(r: bytes):
    assert len(r) == 2
    return struct.unpack('<h', r)[0]


def decode_i32(r: bytes):
    assert len(r) == 4
    return struct.unpack('<i', r)[0]


def decode_i64(r: bytes):
    assert len(r) == 8
    return struct.unpack('<q', r)[0]


def decode_u8(r: bytes):
    assert len(r) == 1
    return struct.unpack('<B', r)[0]


def decode_u16(r: bytes):
    assert len(r) == 2
    return struct.unpack('<H', r)[0]


def decode_u32(r: bytes):
    assert len(r) == 4
    return struct.unpack('<I', r)[0]


def decode_u64(r: bytes):
    assert len(r) == 8
    return struct.unpack('<Q', r)[0]


def decode_f32(r: bytes):
    assert len(r) == 4
    return struct.unpack('<f', r)[0]


def decode_f64(r: bytes):
    assert len(r) == 8
    return struct.unpack('<d', r)[0]


def encode_i8(r: int):
    return struct.pack('<b', r)


def encode_i16(r: int):
    return struct.pack('<h', r)


def encode_i32(r: int):
    return struct.pack('<i', r)


def encode_i64(r: int):
    return struct.pack('<q', r)


def encode_u8(r: int):
    return struct.pack('<B', r)


def encode_u16(r: int):
    return struct.pack('<H', r)


def encode_u32(r: int):
    return struct.pack('<I', r)


def encode_u64(r: int):
    return struct.pack('<Q', r)


def encode_f32(r: float):
    return struct.pack('<f', r)


def encode_f64(r: float):
    return struct.pack('<d', r)


def decode_i32_leb128(r: bytes):
    n, i, c = decode_u32_leb128(r)
    return n, into_i32(i), c


def decode_i64_leb128(r: bytes):
    n, i, c = decode_u64_leb128(r)
    return n, into_i64(i), c


def decode_u32_leb128(r: bytes):
    return read_u32_leb128(io.BytesIO(r))


def decode_u64_leb128(r: bytes):
    return read_u64_leb128(io.BytesIO(r))


def read_u32(r: typing.BinaryIO):
    data = r.read(4)
    assert len(data) == 4
    return decode_u32(data)


def read_u64(r: typing.BinaryIO):
    data = r.read(8)
    assert len(data) == 8
    return decode_u64(data)


def read_u32_leb128(r: typing.BinaryIO):
    v = 0
    n = 0
    a = bytearray()
    for _ in range(0, 9):
        b = ord(r.read(1))
        a.append(b)
        tmp = b & 0x7f
        v = tmp << (n * 7) | v
        if (b & 0x80) != 0x80:
            break
        n += 1
    if n == 4 and (tmp & 0xf0) != 0:
        return -1
    return n + 1, v, a


def read_u64_leb128(r: typing.BinaryIO):
    v = 0
    n = 0
    a = bytearray()
    for _ in range(0, 9):
        b = ord(r.read(1))
        a.append(b)
        tmp = b & 0x7f
        v = tmp << (n * 7) | v
        if (b & 0x80) != 0x80:
            break
        n += 1
    if n == 8 and (tmp & 0xf0) != 0:
        return -1
    return n + 1, v, a


def rotl_u32(x: int, k: int):
    x = into_u32(x)
    k = into_u32(k)
    n = 32
    s = k & (n - 1)
    return x << s | x >> (n - s)


def rotl_u64(x: int, k: int):
    x = into_u64(x)
    k = into_u64(k)
    n = 64
    s = k & (n - 1)
    return x << s | x >> (n - s)


def rotr_u32(x: int, k: int):
    return rotl_u32(x, -k)


def rotr_u64(x: int, k: int):
    return rotl_u64(x, -k)


def fmth(n: int, l: int):
    a = hex(n)
    return a[2:].rjust(l, '0')


def idiv_s(a, b):
    return a // b if a * b > 0 else (a + (-a % b)) // b


def irem_s(a, b):
    return a % b if a * b > 0 else -(-a % b)
