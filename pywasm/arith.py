class I:
    def __init__(self, blen: int) -> None:
        self.bits_length = blen * 8
        self.byte_length = blen
        self.mask = (1 << self.bits_length) - 1
        self.mask_sign = 1 << (self.bits_length - 1)
        self.max = (1 << (self.bits_length - 1)) - 1
        self.min = -1 << (self.bits_length - 1)

    def from_bytearray(self, data: bytearray) -> int:
        assert len(data) == self.byte_length
        return int.from_bytes(data, 'little', signed=True)

    def into_bytearray(self, n: int) -> bytearray:
        return bytearray(n.to_bytes(self.byte_length, 'little', signed=True))

    def fit(self, n: int) -> int:
        n = n & self.mask
        n = n - ((n & self.mask_sign) << 1)
        return n

    def add(self, a: int, b: int) -> int:
        return self.fit(a + b)

    def sub(self, a: int, b: int) -> int:
        return self.fit(a - b)

    def mul(self, a: int, b: int) -> int:
        return self.fit(a * b)

    def div(self, a: int, b: int) -> int:
        assert a != self.min or b != -1
        # Python's default division of integers is return the floor (towards negative infinity) with no
        # ability to change that. You can read the BDFL's reason why.
        # See: https://python-history.blogspot.com/2010/08/why-pythons-integer-division-floors.html
        # But in webassembly, it requires do truncation towards zero.
        return a // b if a * b > 0 else (a + (-a % b)) // b

    def rem(self, a: int, b: int) -> int:
        return a % b if a * b > 0 else -(-a % b)

    def shl(self, a: int, b: int) -> int:
        return self.fit(a << (b & (self.bits_length - 1)))

    def shr(self, a: int, b: int) -> int:
        return self.fit(a >> (b & (self.bits_length - 1)))

    def rotl(self, a: int, b: int) -> int:
        b = b % self.bits_length
        return self.fit(((a << b) & self.mask) | (a >> (self.bits_length - b)))

    def rotr(self, a: int, b: int) -> int:
        b = b % self.bits_length
        return self.fit((a >> b) | ((a << (self.bits_length - b)) & self.mask))

    def clz(self, a: int) -> int:
        b = 0
        for _ in range(self.bits_length):
            if a & self.mask_sign != 0:
                break
            b += 1
            a = a << 1
        return b

    def ctz(self, a: int) -> int:
        b = 0
        for _ in range(self.bits_length):
            if a & 1 != 0:
                break
            b += 1
            a = a >> 1
        return b

    def popcnt(self, a: int) -> int:
        b = 0
        for _ in range(self.bits_length):
            if a & 1 != 0:
                b += 1
            a = a >> 1
        return b


class U:
    def __init__(self, blen: int) -> None:
        self.bits_length = blen * 8
        self.byte_length = blen
        self.mask = (1 << self.bits_length) - 1
        self.mask_sign = 1 << (self.bits_length - 1)
        self.max = self.mask
        self.min = 0

    def from_bytearray(self, data: bytearray) -> int:
        assert len(data) == self.byte_length
        return int.from_bytes(data, 'little', signed=False)

    def into_bytearray(self, n: int) -> bytearray:
        return bytearray(n.to_bytes(self.byte_length, 'little', signed=False))

    def fit(self, n: int) -> int:
        return n & self.mask

    def add(self, a: int, b: int) -> int:
        return self.fit(a + b)

    def sub(self, a: int, b: int) -> int:
        return self.fit(a - b)

    def mul(self, a: int, b: int) -> int:
        return self.fit(a * b)

    def div(self, a: int, b: int) -> int:
        return a // b

    def rem(self, a: int, b: int) -> int:
        return a % b

    def shl(self, a: int, b: int) -> int:
        return self.fit(a << (b & (self.bits_length - 1)))

    def shr(self, a: int, b: int) -> int:
        return self.fit(a >> (b & (self.bits_length - 1)))

    def rotl(self, a: int, b: int) -> int:
        b = b % self.bits_length
        return ((a << b) & self.mask) | (a >> (self.bits_length - b))

    def rotr(self, a: int, b: int) -> int:
        b = b % self.bits_length
        return (a >> b) | ((a << (self.bits_length - b)) & self.mask)

    def clz(self, a: int) -> int:
        b = 0
        for _ in range(self.bits_length):
            if a & self.mask_sign != 0:
                break
            b += 1
            a = a << 1
        return b

    def ctz(self, a: int) -> int:
        b = 0
        for _ in range(self.bits_length):
            if a & 1 != 0:
                break
            b += 1
            a = a >> 1
        return b

    def popcnt(self, a: int) -> int:
        b = 0
        for _ in range(self.bits_length):
            if a & 1 != 0:
                b += 1
            a = a >> 1
        return b


i32 = I(4)
i64 = I(8)
u32 = U(4)
u64 = U(8)
