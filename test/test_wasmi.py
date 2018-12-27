import random

import wasmi
import wasmi.common


def test_common():
    for i in range(wasmi.common.I8_MIN, wasmi.common.I8_MAX + 1):
        assert wasmi.common.into_i8(i) == i
    for i in range(wasmi.common.I8_MIN - wasmi.common.I8_LEN, wasmi.common.I8_MAX + 1 - wasmi.common.I8_LEN):
        assert wasmi.common.into_i8(i) == i + 256
    for i in range(wasmi.common.I8_MIN + wasmi.common.I8_LEN, wasmi.common.I8_MAX + 1 + wasmi.common.I8_LEN):
        assert wasmi.common.into_i8(i) == i - 256
    for i in range(wasmi.common.I8_MIN - 2 * wasmi.common.I8_LEN, wasmi.common.I8_MAX + 1 - 2 * wasmi.common.I8_LEN):
        assert wasmi.common.into_i8(i) == i + 2 * 256
    for i in range(wasmi.common.I8_MIN + 2 * wasmi.common.I8_LEN, wasmi.common.I8_MAX + 1 + 2 * wasmi.common.I8_LEN):
        assert wasmi.common.into_i8(i) == i - 2 * 256


def test_num():
    with open('./test/data/num.wasm', 'rb') as f:
        mod = wasmi.Mod.from_reader(f)
    vm = wasmi.Vm(mod)

    for _ in range(16):
        a = wasmi.common.into_i8(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i8(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('i8_add', [a, b]) == wasmi.common.into_i8(a + b)
    for _ in range(16):
        a = wasmi.common.into_i8(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i8(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('i8_sub', [a, b]) == wasmi.common.into_i8(a - b)
    for _ in range(16):
        a = wasmi.common.into_i8(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i8(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('i8_mul', [a, b]) == wasmi.common.into_i8(a * b)
    for _ in range(16):
        a = wasmi.common.into_i8(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i8(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        if b == 0:
            b = 1
        assert vm.exec('i8_div', [a, b]) == wasmi.common.into_i8(a // b)

    for _ in range(16):
        a = wasmi.common.into_i16(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i16(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('i16_add', [a, b]) == wasmi.common.into_i16(a + b)
    for _ in range(16):
        a = wasmi.common.into_i16(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i16(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('i16_sub', [a, b]) == wasmi.common.into_i16(a - b)
    for _ in range(16):
        a = wasmi.common.into_i16(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i16(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('i16_mul', [a, b]) == wasmi.common.into_i16(a * b)
    for _ in range(16):
        a = wasmi.common.into_i16(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i16(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        if b == 0:
            b = 1
        assert vm.exec('i16_div', [a, b]) == wasmi.common.into_i16(a // b)

    for _ in range(16):
        a = wasmi.common.into_i32(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i32(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('i32_add', [a, b]) == wasmi.common.into_i32(a + b)
    for _ in range(16):
        a = wasmi.common.into_i32(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i32(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('i32_sub', [a, b]) == wasmi.common.into_i32(a - b)
    for _ in range(16):
        a = wasmi.common.into_i32(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i32(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('i32_mul', [a, b]) == wasmi.common.into_i32(a * b)
    for _ in range(16):
        a = wasmi.common.into_i32(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i32(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        if b == 0:
            b = 1
        assert vm.exec('i32_div', [a, b]) == wasmi.common.into_i32(a // b)

    for _ in range(16):
        a = wasmi.common.into_i64(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i64(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('i64_add', [a, b]) == wasmi.common.into_i64(a + b)
    for _ in range(16):
        a = wasmi.common.into_i64(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i64(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('i64_sub', [a, b]) == wasmi.common.into_i64(a - b)
    for _ in range(16):
        a = wasmi.common.into_i64(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i64(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('i64_mul', [a, b]) == wasmi.common.into_i64(a * b)
    for _ in range(16):
        a = wasmi.common.into_i64(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i64(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        if b == 0:
            b = 1
        assert vm.exec('i64_div', [a, b]) == wasmi.common.into_i64(a // b)

    for _ in range(16):
        a = wasmi.common.into_u8(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_u8(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('u8_add', [a, b]) == wasmi.common.into_u8(a + b)
    for _ in range(16):
        a = wasmi.common.into_u8(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_u8(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('u8_sub', [a, b]) == wasmi.common.into_u8(a - b)
    for _ in range(16):
        a = wasmi.common.into_u8(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_u8(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('u8_mul', [a, b]) == wasmi.common.into_u8(a * b)
    for _ in range(16):
        a = wasmi.common.into_u8(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_u8(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        if b == 0:
            b = 1
        assert vm.exec('u8_div', [a, b]) == wasmi.common.into_u8(a // b)

    for _ in range(16):
        a = wasmi.common.into_u16(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_u16(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('u16_add', [a, b]) == wasmi.common.into_u16(a + b)
    for _ in range(16):
        a = wasmi.common.into_u16(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_u16(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('u16_sub', [a, b]) == wasmi.common.into_u16(a - b)
    for _ in range(16):
        a = wasmi.common.into_u16(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_u16(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('u16_mul', [a, b]) == wasmi.common.into_u16(a * b)
    for _ in range(16):
        a = wasmi.common.into_u16(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_u16(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        if b == 0:
            b = 1
        assert vm.exec('u16_div', [a, b]) == wasmi.common.into_u16(a // b)

    for _ in range(16):
        a = wasmi.common.into_i32(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i32(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('u32_add', [a, b]) == wasmi.common.into_i32(a + b)
    for _ in range(16):
        a = wasmi.common.into_i32(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i32(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('u32_sub', [a, b]) == wasmi.common.into_i32(a - b)
    for _ in range(16):
        a = wasmi.common.into_i32(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i32(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('u32_mul', [a, b]) == wasmi.common.into_i32(a * b)
    for _ in range(16):
        a = wasmi.common.into_i32(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i32(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        if b == 0:
            b = 1
        assert vm.exec('u32_div', [a, b]) == wasmi.common.into_u32(a) // wasmi.common.into_u32(b)

    for _ in range(16):
        a = wasmi.common.into_i64(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i64(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('u64_add', [a, b]) == wasmi.common.into_i64(a + b)
    for _ in range(16):
        a = wasmi.common.into_i64(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i64(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('u64_sub', [a, b]) == wasmi.common.into_i64(a - b)
    for _ in range(16):
        a = wasmi.common.into_i64(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i64(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        assert vm.exec('u64_mul', [a, b]) == wasmi.common.into_i64(a * b)
    for _ in range(16):
        a = wasmi.common.into_i64(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        b = wasmi.common.into_i64(random.randint(wasmi.common.I64_MIN, wasmi.common.I64_MAX))
        if b == 0:
            b = 1
        assert vm.exec('u64_div', [a, b]) == wasmi.common.into_u64(a) // wasmi.common.into_u64(b)
