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
