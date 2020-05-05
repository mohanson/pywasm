import json
import math
import os
import typing

import pywasm

num = pywasm.num


def parse_val(m):
    if m['type'] == 'i32':
        return pywasm.Value.from_i32(num.int2i32(int(m['value'])))
    if m['type'] == 'i64':
        return pywasm.Value.from_i64(num.int2i64(int(m['value'])))
    if m['type'] == 'f32':
        if m['value'].startswith('nan'):
            return pywasm.Value.from_f32(float('nan'))
        v = pywasm.Value.from_u32(int(m['value']))
        v.type = pywasm.binary.ValueType(pywasm.convention.f32)
        return v
    if m['type'] == 'f64':
        if m['value'].startswith('nan'):
            return pywasm.Value.from_f64(float('nan'))
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
            'print_i32': lambda _, x: None,
            'global_i32': 666,
            'table': table,
            'memory': memory,
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
        # {'type': 'assert_return', 'line': 104, 'action': {'type': 'invoke', 'field': '8u_good1', 'args': [{'type': 'i32', 'value': '0'}]}, 'expected': [{'type': 'i32', 'value': '97'}]}
        elif command['type'] == 'assert_return':
            if command['action']['type'] == 'invoke':
                function_name = command['action']['field']
                args = [parse_val(i) for i in command['action']['args']]
                r = runtime.exec_accu(function_name, args)
                expect = [parse_val(i) for i in command['expected']]
                for i in range(len(expect)):
                    if math.isnan(expect[i].val()):
                        assert math.isnan(r.data[i].val())
                    else:
                        assert r.data[i].data == expect[i].data
            else:
                raise NotImplementedError
        elif command['type'] == 'assert_trap':
            if command['action']['type'] == 'invoke':
                function_name = command['action']['field']
                args = [parse_val(i) for i in command['action']['args']]
                try:
                    r = runtime.exec_accu(function_name, args)
                except Exception as e:
                    r = str(e)[8:]
                expect = command['text']
                assert r == expect
            else:
                raise NotImplementedError
        elif command['type'] == 'assert_malformed':
            continue
        elif command['type'] == 'assert_invalid':
            continue
        elif command['type'] == 'assert_unlinkable':
            continue
        elif command['type'] == 'register':
            return
        elif command['type'] == 'action':
            if command['action']['type'] == 'invoke':
                function_name = command['action']['field']
                args = [parse_val(i) for i in command['action']['args']]
                runtime.exec_accu(function_name, args)
            else:
                raise NotImplementedError
        elif command['type'] == 'assert_exhaustion':
            continue
        else:
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
    case('./res/spectest/endianness')
    # [TODO] case('./res/spectest/exports')
    # [TODO] case('./res/spectest/f32')
    case('./res/spectest/f32_bitwise')
    case('./res/spectest/f32_cmp')
    # [TODO] case('./res/spectest/f64')
    case('./res/spectest/f64_bitwise')
    case('./res/spectest/f64_cmp')
    # [TODO] case('./res/spectest/float_exprs')
    # [TODO] case('./res/spectest/float_literals')
    # [TODO] case('./res/spectest/float_memory')
    # [TODO] case('./res/spectest/float_misc')
    case('./res/spectest/forward')
    case('./res/spectest/func_ptrs')
    case('./res/spectest/global')
    case('./res/spectest/globals')
    case('./res/spectest/imports')
    case('./res/spectest/inline-module')
    case('./res/spectest/int_exprs')
    case('./res/spectest/int_literals')
    case('./res/spectest/labels')
    case('./res/spectest/left-to-right')
    # [TODO] case('./res/spectest/linking')
    case('./res/spectest/load')
    case('./res/spectest/local_get')
    case('./res/spectest/local_set')
    case('./res/spectest/local_tee')
    case('./res/spectest/memory')
    case('./res/spectest/memory_grow')
    case('./res/spectest/memory_redundancy')
    case('./res/spectest/memory_size')
    case('./res/spectest/memory_trap')
    case('./res/spectest/names')
    case('./res/spectest/nop')
    case('./res/spectest/return')
    case('./res/spectest/select')
    # [TODO] case('./res/spectest/skip-stack-guard-page')
    case('./res/spectest/stack')
    # [TODO] case('./res/spectest/start')
    case('./res/spectest/store')
    case('./res/spectest/switch')
    case('./res/spectest/table')
    case('./res/spectest/token')
    case('./res/spectest/traps')
    case('./res/spectest/type')
    case('./res/spectest/typecheck')
    case('./res/spectest/unreachable')
    case('./res/spectest/unreached-invalid')
    case('./res/spectest/unwind')
    case('./res/spectest/utf8-custom-section-id')
    case('./res/spectest/utf8-import-field')
    case('./res/spectest/utf8-import-module')
    case('./res/spectest/utf8-invalid-encoding')
