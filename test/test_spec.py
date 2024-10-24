import json
import math
import os
import typing
import glob

import pywasm


def parse_val(m):
    if m['type'] == 'i32':
        return pywasm.ValInst.from_i32(int(m['value']))
    if m['type'] == 'i64':
        return pywasm.ValInst.from_i64(int(m['value']))
    if m['type'] == 'f32':
        if m['value'] == 'nan:canonical':
            return pywasm.ValInst.from_f32_u32(0x7fc00000)
        if m['value'] == 'nan:arithmetic':
            return pywasm.ValInst.from_f32_u32(0x7fc00001)
        v = pywasm.ValInst.from_u32(int(m['value']))
        v.type = pywasm.ValType.f32()
        return v
    if m['type'] == 'f64':
        if m['value'] == 'nan:canonical':
            return pywasm.ValInst.from_f64_u64(0x7ff8000000000000)
        if m['value'] == 'nan:arithmetic':
            return pywasm.ValInst.from_f64_u64(0x7ff8000000000001)
        v = pywasm.ValInst.from_u64(int(m['value']))
        v.type = pywasm.ValType.f64()
        return v
    raise NotImplementedError


def asset_val(a, b):
    print('assert', a.data, b.data, a.into_auto(), b.into_auto())
    if b.type == pywasm.ValType.i32():
        assert a.type == pywasm.ValType.i32()
        assert a.data == b.data
        return
    if b.type == pywasm.ValType.i64():
        assert a.type == pywasm.ValType.i64()
        assert a.data == b.data
        return
    if b.type == pywasm.ValType.f32():
        assert a.type == pywasm.ValType.f32()
        if math.isnan(b.into_f32()):
            assert math.isnan(a.into_f32())
        elif math.isinf(b.into_f32()):
            assert math.isinf(a.into_f32()) or math.fabs(a.into_f32()) > +3.4e+38
        elif math.isinf(a.into_f32()):
            assert math.isinf(b.into_f32()) or math.fabs(b.into_f32()) > +3.4e+38
        else:
            assert math.isclose(a.into_f32(), b.into_f32())
        return
    if b.type == pywasm.ValType.f64():
        assert a.type == pywasm.ValType.f64()
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
    memory_type = pywasm.MemType(pywasm.Limits(1, 2))
    memory = pywasm.Memory(memory_type)

    table_type = pywasm.TableType(pywasm.ElemType.funcref(), pywasm.Limits(10, 20))
    table = pywasm.Table(table_type)

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


pywasm.log.lvl = 1


def parse_jval(j: typing.Dict[str, str]) -> pywasm.ValInst:
    match j['type']:
        case 'i32':
            return pywasm.ValInst.from_i32(int(j['value']))
        case 'i64':
            return pywasm.ValInst.from_i64(int(j['value']))
        case _:
            assert 0


# See https://github.com/WebAssembly/spec/tree/main/interpreter#spectest-host-module
imps = {
    'spectest': {
        'global_i32': 0,
        'global_i64': 0,
        'global_f32': 0.0,
        'global_f64': 0.0,
        'table': pywasm.TableInst(pywasm.TableType(pywasm.ElemType.funcref(), pywasm.Limits(10, 20))),
        'memory': pywasm.MemInst(pywasm.MemType(pywasm.Limits(1, 2))),
        'print_i32': lambda _, x: print(x),
        'print_i64': lambda _, x: print(x),
        'print_f32': lambda _, x: print(x),
        'print_f64': lambda _, x: print(x),
        'print_i32_f32': lambda _, x, y: print(x, y),
        'print_i64_f64': lambda _, x, y: print(x, y),
    }
}

for name in sorted(glob.glob('res/spectest/*.json')):
    with open(name) as f:
        suit = json.load(f)
    runtime = pywasm.Runtime()
    imodule: pywasm.ModuleInst
    for elem in suit['commands']:
        print(elem)
        match elem['type']:
            case 'assert_malformed':
                assert 1
            case 'assert_return':
                match elem['action']['type']:
                    case 'invoke':
                        name = elem['action']['field']
                        args = [parse_jval(e) for e in elem['action']['args']]
                        good = [parse_jval(e) for e in elem['expected']]
                        addr = [e for e in imodule.exps if e.name == name][0].data.data
                        rets = runtime.machine.invocate(addr, args)
                        assert rets == good, f'{rets}, {good}'
                    case _:
                        assert 0
            case 'assert_trap':
                match elem['action']['type']:
                    case 'invoke':
                        name = elem['action']['field']
                        args = [parse_jval(e) for e in elem['action']['args']]
                        good = elem['text']
                        addr = [e for e in imodule.exps if e.name == name][0].data.data
                        try:
                            runtime.machine.invocate(addr, args)
                        except Exception as e:
                            assert str(e) == 'pywasm: ' + good
                            runtime.machine.stack.frame.clear()
                            runtime.machine.stack.label.clear()
                            runtime.machine.stack.value.clear()
                    case _:
                        assert 0
            case 'module':
                imodule = runtime.instance_from_file(f'res/spectest/{elem['filename']}', imps)
            case _:
                assert 0
