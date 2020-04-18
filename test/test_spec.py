import json
import math
import os

import pywasm
from pywasm import num

switch = {
    'address.wasm': 1,
    'block.wasm': 1,
    'br.wasm': 1,
    'break-drop.wasm': 1,
    'br_if.wasm': 1,
    'br_table.wasm': 1,
    'call_indirect.wasm': 1,
    'endianness.wasm': 1,
    'fac.wasm': 1,
    'forward.wasm': 1,
    'get_local.wasm': 1,
    'globals.wasm': 1,
    'if.wasm': 1,
    'loop.wasm': 1,
    'memory_redundancy.wasm': 1,
    'nop.wasm': 1,
    'resizing.wasm': 1,
    'return.wasm': 1,
    'select.wasm': 1,
    'switch.wasm': 1,
    'tee_local.wasm': 1,
    'traps_int_div.wasm': 1,
    'traps_int_rem.wasm': 1,
    'traps_mem.wasm': 1,
    'unreachable.wasm': 0,
    'unwind.wasm': 1,
}


def parse_val(s: str):
    t, v = s.split(':')
    if t == 'i32' and v.startswith('0x'):
        return num.int2i32(int(v, 16))
    if t == 'i32':
        return num.int2i32(int(v))
    if t == 'i64' and v.startswith('0x'):
        return num.int2i64(int(v, 16))
    if t == 'i64':
        return num.int2i64(int(v))
    if t == 'f32' and v.startswith('0x'):
        return float.fromhex(v)
    if t == 'f32':
        return float(v)
    if t == 'f64' and v.startswith('0x'):
        return float.fromhex(v)
    if t == 'f64':
        return float(v)
    raise NotImplementedError


def test_spec():
    with open('./test/spec/modules.json', 'r') as f:
        data = json.load(f)
    for case in data:
        file = case['file']
        if file not in switch or switch[file] == 0:
            continue
        vm = pywasm.load(os.path.join('./test/spec/', file))
        for test in case['tests']:
            print(f'{file} {test}')
            function = test['function']
            args = [parse_val(e) for e in test['args']]
            if 'return' in test:
                if test['return'] is None:
                    assert vm.exec(function, args) is None
                    continue
                ret = parse_val(test['return'])
                # execution
                out = vm.exec(function, args)
                # assert
                if isinstance(ret, float):
                    if math.isnan(ret):
                        assert math.isnan(out)
                    else:
                        assert math.isclose(out, ret, rel_tol=1e-05)
                else:
                    assert out == ret
                continue
            if 'trap' in test:
                trap = test['trap']
                try:
                    vm.exec(function, args)
                except Exception as e:
                    assert str(e).split(':')[1] == trap.split(':')[1]
                else:
                    assert False
                continue
            raise NotImplementedError


test_spec()
