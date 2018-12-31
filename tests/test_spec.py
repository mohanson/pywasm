import json
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
            'address.wasm',
            'block.wasm',
            'fac.wasm',
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
            rets = parse_vype(test['return']) if test['return'] else None
            r = vm.exec(function, args)
            print(f'{file} {function} {args}: {rets} == {r}')
            assert r == rets


test_spec()
