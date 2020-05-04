import json
import math
import os
import typing

import pywasm

num = pywasm.num


def int2i32(i: int) -> int:
    i = i & 0xffffffff
    if i & 0x80000000:
        return i - 0x100000000
    return i


def int2i64(i: int) -> int:
    i = i & 0xffffffffffffffff
    if i & 0x8000000000000000:
        return i - 0x10000000000000000
    return i


def parse_val(m):
    if m['type'] == 'i32':
        return pywasm.Value.from_i32(int2i32(int(m['value'])))
    if m['type'] == 'i64':
        return pywasm.Value.from_i64(int2i64(int(m['value'])))
    if m['type'] == 'f32':
        v = pywasm.Value.from_u32(int(m['value']))
        v.type = pywasm.binary.ValueType(pywasm.convention.f32)
        return v
    if m['type'] == 'f64':
        v = pywasm.Value.from_u64(int(m['value']))
        v.type = pywasm.binary.ValueType(pywasm.convention.f64)
        return v
    raise NotImplementedError


def imps() -> typing.Dict:
    limits = pywasm.Limits()
    limits.n = 1
    limits.m = 2
    memory_type = pywasm.binary.MemoryType()
    memory_type.limits = limits
    memory = pywasm.Memory(memory_type)

    limits = pywasm.Limits()
    limits.n = 10
    limits.m = 20
    table = pywasm.Table(pywasm.FunctionAddress,  limits)

    return {
        'spectest': {
            'print_i32': lambda _: None,
            'global_i32': 666,
            'table': table,
            'memory': memory,
        },
        'module1': {
            'shared-table': table,
        }
    }


def case(path: str):
    case_name = os.path.basename(path)
    json_path = os.path.join(path, case_name + '.json')
    with open(json_path, 'r') as f:
        case_data = json.load(f)

    runtime: pywasm.Runtime = None
    for command in case_data['commands']:
        print(command)
        if command['type'] == 'module':
            filename = command['filename']
            runtime = pywasm.load(os.path.join(path, filename), imps())
            continue
        # {'type': 'assert_return', 'line': 104, 'action': {'type': 'invoke', 'field': '8u_good1', 'args': [{'type': 'i32', 'value': '0'}]}, 'expected': [{'type': 'i32', 'value': '97'}]}
        if command['type'] == 'assert_return':
            if command['action']['type'] == 'invoke':
                function_name = command['action']['field']
                args = [parse_val(i) for i in command['action']['args']]
                r = runtime.exec_accu(function_name, args)
                expect = [parse_val(i) for i in command['expected']]
                for i in range(len(expect)):
                    assert r.data[i].data == expect[i].data
                continue
            raise NotImplementedError
        if command['type'] == 'assert_trap':
            if command['action']['type'] == 'invoke':
                function_name = command['action']['field']
                args = [parse_val(i) for i in command['action']['args']]
                try:
                    r = runtime.exec_accu(function_name, args)
                except Exception as e:
                    r = str(e)[8:]
                expect = command['text']
                assert r == expect
                continue
            raise NotImplementedError
        if command['type'] == 'assert_malformed':
            # if command['filename'].endswith('.wat'):
            #     continue
            # if command['filename'].endswith('.wasm'):
            #     filename = command['filename']
            #     try:
            #         runtime = pywasm.load(os.path.join(path, filename), imps)
            #     except Exception as e:
            #         r = str(e)
            #     else:
            #         r = ''

            #     if r == 'pywasm: magic header not detected' and command['text'] == 'unexpected end':
            #         continue
            #     if r == 'pywasm: unknown binary version' and command['text'] == 'unexpected end':
            #         continue
            #     if r == 'ord() expected a character, but string of length 0 found' and command['text'] == 'unexpected end of section or function':
            #         continue
            #     if r == 'ord() expected a character, but string of length 0 found' and command['text'] == 'unexpected end':
            #         continue
            #     if r == 'ord() expected a character, but string of length 0 found' and command['text'] == 'integer representation too long':
            #         continue
            #     if r == '' and command['text'] == 'integer representation too long':
            #         continue

            #     assert r[8:] == command['text']
            #     continue
            continue
        if command['type'] == 'assert_invalid':
            continue
        if command['type'] == 'assert_unlinkable':
            continue
        if command['type'] == 'register':
            continue
        raise NotImplementedError


if __name__ == '__main__':
    case('./res/spectest/address')
    case('./res/spectest/align')
    case('./res/spectest/binary')
    case('./res/spectest/binary-leb128')
    case('./res/spectest/br_if')
    case('./res/spectest/br_table')
    case('./res/spectest/break-drop')
    case('./res/spectest/comments')
    case('./res/spectest/const')
    case('./res/spectest/custom')
    case('./res/spectest/data')
    case('./res/spectest/elem')
    # case('./res/spectest/endianness')
    # case('./res/spectest/exports')
    # case('./res/spectest/f32')
    # case('./res/spectest/f32_bitwise')
    # case('./res/spectest/f32_cmp')
    # case('./res/spectest/f64')
    # case('./res/spectest/f64_bitwise')
    # case('./res/spectest/f64_cmp')
    # case('./res/spectest/float_exprs')
    # case('./res/spectest/float_literals')
    # case('./res/spectest/float_memory')
    # case('./res/spectest/float_misc')
    # case('./res/spectest/forward')
    # case('./res/spectest/func_ptrs')
    # case('./res/spectest/global')
    # case('./res/spectest/globals')
    # case('./res/spectest/imports')
    # case('./res/spectest/inline-module')
    # case('./res/spectest/int_exprs')
    # case('./res/spectest/int_literals')
    # case('./res/spectest/labels')
    # case('./res/spectest/left-to-right')
    # case('./res/spectest/linking')
    # case('./res/spectest/load')
    # case('./res/spectest/local_get')
    # case('./res/spectest/local_set')
    # case('./res/spectest/local_tee')
    # case('./res/spectest/memory')
    # case('./res/spectest/memory_grow')
    # case('./res/spectest/memory_redundancy')
    # case('./res/spectest/memory_size')
    # case('./res/spectest/memory_trap')
    # case('./res/spectest/names')
    # case('./res/spectest/nop')
    # case('./res/spectest/return')
    # case('./res/spectest/select')
    # case('./res/spectest/skip-stack-guard-page')
    # case('./res/spectest/stack')
    # case('./res/spectest/start')
    # case('./res/spectest/store')
    # case('./res/spectest/switch')
    # case('./res/spectest/table')
    # case('./res/spectest/token')
    # case('./res/spectest/traps')
    # case('./res/spectest/type')
    # case('./res/spectest/typecheck')
    # case('./res/spectest/unreachable')
    # case('./res/spectest/unreached-invalid')
    # case('./res/spectest/unwind')
    # case('./res/spectest/utf8-custom-section-id')
    # case('./res/spectest/utf8-import-field')
    # case('./res/spectest/utf8-import-module')
    # case('./res/spectest/utf8-invalid-encoding')
