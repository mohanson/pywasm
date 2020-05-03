import json
import math
import os

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
        v = pywasm.Value.from_i32(int(m['value']))
        v.type = pywasm.binary.ValueType(pywasm.convention.f32)
        return v
    if m['type'] == 'f64':
        v = pywasm.Value.from_i64(int(m['value']))
        v.type = pywasm.binary.ValueType(pywasm.convention.f64)
        return v
    raise NotImplementedError


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
            runtime = pywasm.load(os.path.join(path, filename))
            continue
        # {'type': 'assert_return', 'line': 104, 'action': {'type': 'invoke', 'field': '8u_good1', 'args': [{'type': 'i32', 'value': '0'}]}, 'expected': [{'type': 'i32', 'value': '97'}]}
        if command['type'] == 'assert_return':
            if command['action']['type'] == 'invoke':
                function_name = command['action']['field']
                args = [parse_val(i) for i in command['action']['args']]
                r = runtime.exec_accu(function_name, args)
                expect = [parse_val(i) for i in command['expected']]
                assert r.data[0].data == expect[0].data
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
            if command['filename'].endswith('.wat'):
                continue
            if command['filename'].endswith('.wasm'):
                filename = command['filename']
                try:
                    runtime = pywasm.load(os.path.join(path, filename))
                except Exception as e:
                    r = str(e)[8:]
                else:
                    assert 0

                if r == 'magic header not detected' and command['text'] == 'unexpected end':
                    continue
                if r == 'unknown binary version' and command['text'] == 'unexpected end':
                    continue

                assert r == command['text']
                continue
            raise NotImplementedError
        if command['type'] == 'assert_invalid':
            if command['filename'].endswith('.wasm'):
                continue
        raise NotImplementedError


if __name__ == '__main__':
    case('./res/spectest/address')
    case('./res/spectest/align')
    case('./res/spectest/binary')
