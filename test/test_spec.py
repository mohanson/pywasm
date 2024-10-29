import glob
import json
import math
import pywasm
import re
import typing


pywasm.log.lvl = 0
unittest_regex = 'res/spectest/.*.json'


def valj(j: typing.Dict[str, str]) -> pywasm.ValInst:
    match j['type']:
        case 'i32':
            return pywasm.ValInst.from_i32(int(j['value']))
        case 'i64':
            return pywasm.ValInst.from_i64(int(j['value']))
        case 'f32':
            match j['value']:
                case 'nan:canonical':
                    return pywasm.ValInst.from_f32_u32(0x7fc00000)
                case 'nan:arithmetic':
                    return pywasm.ValInst.from_f32_u32(0x7fc00001)
                case _:
                    return pywasm.ValInst.from_f32_u32(int(j['value']))
        case 'f64':
            match j['value']:
                case 'nan:canonical':
                    return pywasm.ValInst.from_f64_u64(0x7ff8000000000000)
                case 'nan:arithmetic':
                    return pywasm.ValInst.from_f64_u64(0x7ff8000000000001)
                case _:
                    return pywasm.ValInst.from_f64_u64(int(j['value']))
        case 'funcref':
            assert 0
        case 'externref':
            return pywasm.ValInst.from_ref(pywasm.core.ValType.ref_extern(), int(j['value']))
        case _:
            assert 0


def vale(a: pywasm.ValInst, b: pywasm.ValInst) -> bool:
    a = a.into_num()
    b = b.into_num()
    if isinstance(a, int):
        return a == b
    if isinstance(a, float):
        if math.isnan(a):
            return math.isnan(b)
        return math.isclose(a, b, rel_tol=1e-6)
    assert 0


def impi() -> typing.Dict[str, typing.Any]:
    # See https://github.com/WebAssembly/spec/blob/w3c-1.0/interpreter/host/spectest.ml
    return {
        'spectest': {
            'global_i32': 666,
            'global_i64': 666,
            'global_f32': 666.6,
            'global_f64': 666.6,
            'print': lambda m: None,
            'print_i32': lambda m, x: None,
            'print_i64': lambda m, x: None,
            'print_f32': lambda m, x: None,
            'print_f64': lambda m, x: None,
            'print_i32_f32': lambda m, x, y: None,
            'print_i64_f64': lambda m, x, y: None,
            'print_f32_f32': lambda m, x, y: None,
            'print_f64_f64': lambda m, x, y: None,
            'table': pywasm.TableInst(pywasm.TableType(pywasm.ValType.ref_func(), pywasm.Limits(10, 20))),
            'memory': pywasm.MemInst(pywasm.MemType(pywasm.Limits(1, 2))),
        }
    }


for name in sorted(glob.glob('res/spectest/*.json')):
    if not re.match(unittest_regex, name):
        continue
    with open(name) as f:
        suit = json.load(f)['commands']
    imps = impi()
    runtime = pywasm.Runtime()
    cmodule: pywasm.ModuleInst
    lmodule: pywasm.ModuleInst
    mmodule = {}
    for elem in suit:
        print(elem)
        match elem['type']:
            case 'action':
                match elem['action']['type']:
                    case 'invoke':
                        cmodule = lmodule
                        if 'module' in elem['action']:
                            cmodule = mmodule[elem['action']['module']]
                        name = elem['action']['field']
                        args = [valj(e) for e in elem['action']['args']]
                        good = [valj(e) for e in elem['expected']]
                        addr = [e for e in cmodule.exps if e.name == name][0].data.data
                        rets = runtime.machine.invocate(addr, args)
                        for a, b in zip(rets, good):
                            assert vale(a, b), f'{rets}, {good}'
                    case _:
                        assert 0
            case 'assert_exhaustion':
                assert 1
            case 'assert_invalid':
                assert 1
            case 'assert_malformed':
                assert 1
            case 'assert_return':
                match elem['action']['type']:
                    case 'get':
                        cmodule = lmodule
                        if 'module' in elem['action']:
                            cmodule = mmodule[elem['action']['module']]
                        good = [valj(e) for e in elem['expected']]
                        rets = runtime.exported_global(cmodule, elem['action']['field'])
                        assert vale(rets.data, good[0])
                    case 'invoke':
                        cmodule = lmodule
                        if 'module' in elem['action']:
                            cmodule = mmodule[elem['action']['module']]
                        name = elem['action']['field']
                        args = [valj(e) for e in elem['action']['args']]
                        good = [valj(e) for e in elem['expected']]
                        addr = [e for e in cmodule.exps if e.name == name][0].data.data
                        rets = runtime.machine.invocate(addr, args)
                        for a, b in zip(rets, good):
                            assert vale(a, b), f'{rets}, {good}'
                    case _:
                        assert 0
            case 'assert_trap':
                assert 1
            case 'assert_uninstantiable':
                try:
                    lmodule = runtime.instance_from_file(f'res/spectest/{elem['filename']}', imps)
                except Exception as e:
                    runtime.machine.stack.frame.clear()
                    runtime.machine.stack.label.clear()
                    runtime.machine.stack.value.clear()
            case 'assert_unlinkable':
                assert 1
            case 'module':
                lmodule = runtime.instance_from_file(f'res/spectest/{elem['filename']}', imps)
                if 'name' in elem:
                    mmodule[elem['name']] = lmodule
            case 'register':
                mmodule[elem['as']] = lmodule
                imps[elem['as']] = {}
                for e in lmodule.exps:
                    match e.data.kind:
                        case 0x00:
                            imps[elem['as']][e.name] = runtime.machine.store.func[e.data.data]
                        case 0x01:
                            imps[elem['as']][e.name] = runtime.machine.store.tabl[e.data.data]
                        case 0x02:
                            imps[elem['as']][e.name] = runtime.machine.store.mems[e.data.data]
                        case 0x03:
                            imps[elem['as']][e.name] = runtime.machine.store.glob[e.data.data]
            case _:
                assert 0
