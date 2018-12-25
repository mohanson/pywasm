import struct
import typing
import io

I32_MAX = (1 << 31) - 1
I32_MIN = - (1 << 31)
I32_LEN = 1 << 31
I64_MAX = (1 << 63) - 1
I64_MIN = - (1 << 63)
I64_LEN = 1 << 64
U32_MAX = 1 << 32
U64_MAX = 1 << 64


def into_i32(n: int):
    if n > I32_MAX:
        return into_i32(n - I32_LEN)
    if n < I32_MIN:
        return into_i32(n + I32_LEN)
    return n


def into_i64(n: int):
    if n > I64_MAX:
        return into_i64(n - I64_LEN)
    if n < I64_MIN:
        return into_i64(n + I64_LEN)
    return n


def into_u32(n: int):
    if n > U32_MAX:
        return into_u32(n - U32_MAX)
    if n < 0:
        return into_u32(n + U32_MAX)
    return n


def into_u64(n: int):
    if n > U64_MAX:
        return into_u32(n - U64_MAX)
    if n < 0:
        return into_u32(n + U64_MAX)
    return n


def into_f32(n: float):
    if n > I32_MAX:
        return into_f32(n - I32_MAX)
    if n < 0:
        return into_f32(n + I32_MAX)
    return n


def into_f64(n: float):
    if n > I64_MAX:
        return into_f64(n - I64_MAX)
    if n < 0:
        return into_f64(n + I64_MAX)
    return n


def decode_u32(r: bytes):
    assert len(r) == 4
    return struct.unpack('<I', r)[0]


def decode_u64(r: bytes):
    assert len(r) == 8
    return struct.unpack('<I', r)[0]


def decode_u32_leb128(r: bytes):
    return read_u32_leb128(io.BytesIO(r))


def read_u32(r: typing.BinaryIO):
    data = r.read(4)
    assert len(data) == 4
    return decode_u32(data)


def read_u64(r: typing.BinaryIO):
    data = r.read(8)
    assert len(data) == 8
    return decode_u64(data)


def read_u32_leb128(r: typing.BinaryIO):
    vmask = [0xffffff80, 0xffffc000, 0xffe00000, 0xf0000000, 0]
    bmask = [0x40, 0x40, 0x40, 0x40, 0x8]
    v = 0
    n = 0
    for _ in range(0, 5):
        b = ord(r.read(1))
        tmp = b & 0x7f
        v = tmp << (n * 7) | v
        if (b & 0x80) != 0x80:
            if bmask[n] & tmp:
                v |= vmask[n]
            break
        n += 1
    if n == 4 and (tmp & 0xf0) != 0:
        return -1
    v = struct.unpack('i', struct.pack('I', v))[0]
    return n + 1, v
