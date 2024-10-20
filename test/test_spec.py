import json
import math
import os
import typing

import pywasm


def parse_val(m):
    if m['type'] == 'i32':
        return pywasm.Val.from_i32(int(m['value']))
    if m['type'] == 'i64':
        return pywasm.Val.from_i64(int(m['value']))
    if m['type'] == 'f32':
        if m['value'] == 'nan:canonical':
            return pywasm.Val.from_f32_u32(0x7fc00000)
        if m['value'] == 'nan:arithmetic':
            return pywasm.Val.from_f32_u32(0x7fc00001)
        v = pywasm.Val.from_u32(int(m['value']))
        v.type = pywasm.core.ValType.f32()
        return v
    if m['type'] == 'f64':
        if m['value'] == 'nan:canonical':
            return pywasm.Val.from_f64_u64(0x7ff8000000000000)
        if m['value'] == 'nan:arithmetic':
            return pywasm.Val.from_f64_u64(0x7ff8000000000001)
        v = pywasm.Val.from_u64(int(m['value']))
        v.type = pywasm.core.ValType.f64()
        return v
    raise NotImplementedError


def asset_val(a, b):
    print('assert', a.data, b.data, a.into_auto(), b.into_auto())
    if b.type == pywasm.core.ValType.i32():
        assert a.type == pywasm.core.ValType.i32()
        assert a.data == b.data
        return
    if b.type == pywasm.core.ValType.i64():
        assert a.type == pywasm.core.ValType.i64()
        assert a.data == b.data
        return
    if b.type == pywasm.core.ValType.f32():
        assert a.type == pywasm.core.ValType.f32()
        if math.isnan(b.into_f32()):
            assert math.isnan(a.into_f32())
        elif math.isinf(b.into_f32()):
            assert math.isinf(a.into_f32()) or math.fabs(a.into_f32()) > +3.4e+38
        elif math.isinf(a.into_f32()):
            assert math.isinf(b.into_f32()) or math.fabs(b.into_f32()) > +3.4e+38
        else:
            assert math.isclose(a.into_f32(), b.into_f32())
        return
    if b.type == pywasm.core.ValType.f64():
        assert a.type == pywasm.core.ValType.f64()
        if math.isnan(b.into_f64()):
            assert math.isnan(a.into_f64())
        elif math.isinf(b.into_f64()):
            assert math.isinf(a.into_f64()) or math.fabs(a.into_f64()) > +1.7e+308
        elif math.isinf(a.into_f64()):
            assert math.isinf(b.into_f64()) or math.fabs(b.into_f64()) > +1.7e+308
        else:
            assert math.isclose(a.into_f64(), b.into_f64())
        return
    raise Exception


def imps() -> typing.Dict:
    memory_type = pywasm.core.MemType(pywasm.Limits(1, 2))
    memory = pywasm.Memory(memory_type)

    limits = pywasm.Limits(10, 20)
    table = pywasm.Table(pywasm.FunctionAddress,  limits)

    return {
        'spectest': {
            'print_i32': lambda _, x: None,
            'print': lambda _: None,
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
                    asset_val(r.data[i], expect[i])
            else:
                raise NotImplementedError
        elif command['type'] in ['assert_trap', 'assert_exhaustion']:
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
        elif command['type'] == 'assert_uninstantiable':
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
    case('./res/spectest/f32')
    case('./res/spectest/f32_bitwise')
    case('./res/spectest/f32_cmp')
    case('./res/spectest/f64')
    case('./res/spectest/f64_bitwise')
    case('./res/spectest/f64_cmp')
    case('./res/spectest/float_exprs')
    case('./res/spectest/float_literals')
    case('./res/spectest/float_memory')
    case('./res/spectest/float_misc')
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
    case('./res/spectest/linking')
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
    case('./res/spectest/skip-stack-guard-page')
    case('./res/spectest/stack')
    case('./res/spectest/start')
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
    case('./res/regression/rsh')
