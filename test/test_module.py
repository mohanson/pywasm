import json
import pathlib

import wasmi

path_wagon = r"C:\Users\mohan\go\src\github.com\go-interpreter\wagon"

def test_module():
    path_test = pathlib.Path(path_wagon).joinpath('exec', 'testdata')
    path_json = path_test.joinpath('modules.json')
    with path_json.open('rb') as f:
        data = json.load(f)
    for i, case in enumerate(data):
        if i != 1:
            continue
        file = case['file']
        file = path_test.joinpath(file)
        for test in case['tests']:
            func = test['function']
            fret = test['return']
            t, v = fret.split(':')
            print(file, func, t, v)
            with file.open('rb') as f:
                mod = wasmi.Mod.from_reader(f)
            vm = wasmi.Vm(mod)
            r = vm.exec(func, [])
