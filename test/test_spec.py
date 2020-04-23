import json
import math
import os

import pywasm
from pywasm import num


def case(path: str):
    case_name = os.path.basename(path)
    json_path = os.path.join(path, case_name + '.json')
    with open(json_path, 'r') as f:
        case_data = json.load(f)
    for e in case_data['commands']:
        print(e)
        if e['type'] == 'module':
            print(e)
            continue
        if e['type'] == 'assert_return':
            print(e)
            continue
        if e['type'] == 'assert_trap':
            print(e)
            continue
        if e['type'] == 'assert_malformed':
            print(e)
            continue


case('./test/spec/address')
