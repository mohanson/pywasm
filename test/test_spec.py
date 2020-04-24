import json
import math
import os

import pywasm

num = pywasm.num

def parse_val(m):
    if m['type'] in ['i32', 'i64']:
        return int(m['value'])
    if m['type'] in ['f32', 'f64']:
        return float(m['value'])
    raise NotImplementedError

def case(path: str):
    case_name = os.path.basename(path)
    json_path = os.path.join(path, case_name + '.json')
    with open(json_path, 'r') as f:
        case_data = json.load(f)

    vm: pywasm.Runtime = None
    for e in case_data['commands']:
        print(e)
        if e['type'] == 'module':
            filename = e['filename']
            vm = pywasm.load(os.path.join(path, filename))
        # {'type': 'assert_return', 'line': 104, 'action': {'type': 'invoke', 'field': '8u_good1', 'args': [{'type': 'i32', 'value': '0'}]}, 'expected': [{'type': 'i32', 'value': '97'}]}
        elif e['type'] == 'assert_return':
            if e['action']['type'] == 'invoke':
                function_name = e['action']['field']
                args = [parse_val(i) for i in e['action']['args']]
                expect = [parse_val(i) for i in e['expected']]
                r = vm.exec(function_name, args)
                print(r, expect[0])
                assert r == expect[0]
            else:
                raise Exception
        elif e['type'] == 'assert_trap':
            pass
        elif e['type'] == 'assert_malformed':
            pass
        else:
            raise Exception


if __name__ == '__main__':
    case('./res/spectest/address')
