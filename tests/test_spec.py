import json
import math
import os

import pywasm

switch = {
    'address.wasm': 1,
    'block.wasm': 1,
    'br.wasm': 1,
    'break-drop.wasm': 1,
    'br_if.wasm': 1,
    'br_table.wasm': 0,
    'call_indirect.wasm': 0,
    'endianness.wasm': 0,
    'fac.wasm': 0,
    'forward.wasm': 0,
    'get_local.wasm': 0,
    'globals.wasm': 0,
    'i32.wasm': 0,
    'if.wasm': 0,
    'loop.wasm': 0,
    'memory_redundancy.wasm': 0,
    'modules.json': 0,
    'names.wasm': 0,
    'nop.wasm': 0,
    'resizing.wasm': 0,
    'return.wasm': 0,
    'select.wasm': 0,
    'switch.wasm': 0,
    'tee_local.wasm': 0,
    'traps_int_div.wasm': 0,
    'traps_int_rem.wasm': 0,
    'traps_mem.wasm': 0,
    'unreachable.wasm': 0,
    'unwind.wasm': 0,
}


def parse_val(s: str):
    t, v = s.split(':')
    if t in ['i32', 'i64']:
        if v.startswith('0x'):
            return int(v, 16)
        return int(v)
    if t in ['f32', 'f64']:
        if v.startswith('0x'):
            return float.fromhex(v)
        return float(v)
    raise NotImplementedError


def test_spec():
    with open('./tests/spec/modules.json', 'r') as f:
        data = json.load(f)
    for case in data:
        file = case['file']
        if switch[file] == 0:
            continue
        vm = pywasm.AbstractMachine.open(os.path.join('./tests/spec/', file))
        for test in case['tests']:
            print(f'{file} {test}')
            function = test['function']
            args = [parse_val(e) for e in test['args']]
            if 'return' in test:
                if test['return'] is None:
                    assert vm.exec(function, args) == []
                    continue
                ret = parse_val(test['return'])
                # execution
                out = vm.exec(function, args)[0].n
                if isinstance(ret, float):
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
