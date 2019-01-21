import json
import math
import os

import pywasm


def parse_vype(s: str):
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
        # vm = pywasm.AbstractMachine.open(os.path.join('./tests/spec/', file))
        for test in case['tests']:
            function = test['function']
            args = [parse_vype(e) for e in test['args']]
            if 'return' in test:
                rets = [parse_vype(e) for e in test['return']]
                print(f'{file} {function} {args} {rets}')
            if 'trap' in test:
                trap = test['trap']
                print(f'{file} {function} {args} {trap}')


            # if 'trap' in test:
            #     trap = test['trap']
            #     try:
            #         vm.exec(function, args)
            #     except Exception as e:
            #         print(f'{file} {function} {args}: {trap} == {e.message}', end='')
            #         assert e.message == trap.split(':')[1].strip()
            #         print(' (ok)')
            #     else:
            #         assert False
            #     continue
            # rets = None
            # if test.get('return', False):
            #     rets = parse_vype(test['return'])
            # r = vm.exec(function, args)
            # print(f'{file} {function} {args}: {rets} == {r}', end='')
            # if isinstance(r, float):
            #     assert abs(r - rets) < 0.005 or (math.isnan(r) and math.isnan(rets))
            #     print(' (ok)')
            #     continue
            # assert r == rets
            # print(' (ok)')


test_spec()
