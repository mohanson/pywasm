import json
import math
import os

import wasmi


def parse_vype(s: str):
    t, v = s.split(':')
    if t in ['i32', 'i64']:
        if v.startswith('0x'):
            return int(v, 16)
        return int(v)
    if t in ['f32', 'f64']:
        return float(v)
    raise NotImplementedError


def test_spec():
    with open('./tests/spec/modules.json', 'r') as f:
        data = json.load(f)
    for case in data:
        file = case['file']
        if file not in [
            # 'address.wasm',
            # 'block.wasm',
            # 'fac.wasm',
            # 'br.wasm',
            # 'br_if.wasm',
            # 'br_table.wasm',
            # 'break-drop.wasm',
            'call_indirect.wasm',
            # 'switch.wasm',
            # 'unreachable.wasm',
            # 'unwind.wasm',
            # 'traps_mem.wasm',
            # 'traps_int_div.wasm',
            # 'traps_int_rem.wasm',
            # 'if.wasm',
            # 'globals.wasm',
            # 'loop.wasm',
            # 'nop.wasm',
            # 'tee_local.wasm',
            # 'forward.wasm',
            # 'get_local.wasm',
            # 'resizing.wasm',
            # 'select.wasm',
            # "memory_redundancy.wasm",
            # "endianness.wasm",
            # "return.wasm",
        ]:
            continue
        with open(os.path.join('./tests/spec/', file), 'rb') as f:
            mod = wasmi.Mod.from_reader(f)
        vm = wasmi.Vm(mod)
        for test in case['tests']:
            function = test['function']
            args = [parse_vype(e) for e in test['args']]
            if 'trap' in test:
                trap = test['trap']
                try:
                    vm.exec(function, args)
                except wasmi.error.WAException as e:
                    print(f'{file} {function} {args}: {trap} == {e.message}')
                    assert e.message == trap.split(':')[1].strip()
                else:
                    assert False
                continue
            rets = None
            if test.get('return', False):
                rets = parse_vype(test['return'])
            r = vm.exec(function, args)
            print(f'{file} {function} {args}: {rets} == {r}')
            if isinstance(r, float):
                assert abs(r - rets) < 0.005 or (math.isnan(r) and math.isnan(rets))
                continue
            assert r == rets


test_spec()
