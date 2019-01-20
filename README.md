# py-wasmi: A WebAssembly interpreter written in pure Python.

[![Build Status](https://travis-ci.org/mohanson/py-wasmi.svg?branch=master)](https://travis-ci.org/mohanson/py-wasmi)

A WebAssembly interpreter written in pure Python.

WASM version: [WebAssembly Core Specification W3C Working Draft, 4 September 2018](https://www.w3.org/TR/2018/WD-wasm-core-1-20180904/)

Get some helps from [warpy](https://github.com/kanaka/warpy) and [wagon](https://github.com/go-interpreter/wagon). Thanks open source authors.

# Requirements
- py-wasmi has been tested and is known to run on Linux/Ubuntu, macOS and Windows(10). It will likely work fine on most OS.
- No third party dependencies.
- Python 3.6 or newer.

# Installation

```sh
$ git clone https://github.com/mohanson/py-wasmi && python3 setup.py install
# or
$ pip3 install wasmi

# run tests. py-wasmi has 100% passed all cases from official spec
python3 tests/test_spec.py
```

# Example

A few small examples have been provided in the `examples` directory, you can try these examples quickly just:

```sh
$ cd py-wasmi
$ python3 examples add 40 2      => (i32.add) 42
$ python3 examples fib 10        => (10th of fibonacci) 55
```

With detailed, we use `./examples/fib.wasm` as an example, write some c code belows:

```c
int fib(int n) {
    if (n <= 1) {
        return n;
    }
    return fib(n - 1) + fib(n - 2);
}
```

Generate `fib.wasm` by [WasmFiddle](https://wasdk.github.io/WasmFiddle/), and then:

```py
import wasmi

path = './examples/fib.wasm'
mod = wasmi.Module.open(path)
vm = wasmi.Vm(mod)
r = vm.exec('fib', [10])
print(r) # 55
```

# FAQ

Q: How is the py-wasmi performance? <br>
A: Fine. But if you have strict requirements on speed, please use others such as `wasm-interp`.

# License

[WTFPL](https://choosealicense.com/licenses/wtfpl/)
