import io
import math

import wasmi.num as num


def read_f32(reader):
    if isinstance(reader, (bytes, bytearray)):
        reader = io.BytesIO(reader)
    return num.LittleEndian.f32(reader.read(4))


def read_f64(reader):
    if isinstance(reader, (bytes, bytearray)):
        reader = io.BytesIO(reader)
    return num.LittleEndian.f64(reader.read(8))


def read_leb(reader, maxbits=32, signed=False):
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
    x = num.int2u32(x)
    k = num.int2u32(k)
    n = 32
    s = k & (n - 1)
    return x << s | x >> (n - s)


def rotl_u64(x: int, k: int):
    x = num.int2u64(x)
    k = num.int2u64(k)
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
