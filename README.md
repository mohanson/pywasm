# py-wasmi: A WebAssembly interpreter written in pure Python.

A WebAssembly interpreter written in pure Python.

WASM version: [WebAssembly Core Specification W3C Working Draft, 4 September 2018](https://www.w3.org/TR/2018/WD-wasm-core-1-20180904/)

Get some helps from [warpy](https://github.com/kanaka/warpy) and [wagon](https://github.com/go-interpreter/wagon). Thanks open source authors.

# Requirements
- py-wasmi has been tested and is known to run on Linux/Ubuntu, macOS and Windows(10). It will likely work fine on most OS.
- No third party dependences.
- Python3.6 or newer.

# Installition

```sh
$ git clone https://github.com/mohanson/py-wasmi
# or
$ pip3 install wasmi

# run tests. py-wasmi has 100% passed all cases from official
python tests/test_spec.py
```

# Example

A few small examples have been provided in the `example` directory, you can try these examples quickly just:

```sh
$ cd py-wasmi
$ python examples add 40 2      => (i32.add) 42
$ python examples fib 10        => (10th of fibonacci) 55
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
mod = wasmi.Mod.from_reader(open(path, 'rb'))
vm = wasmi.Vm(mod)
r = vm.exec('fib', [10])
print(r) # 55
```

# FAQ

Q: How is the py-wasmi performance? <br>
A: Fine. But if you have strict requirements on speed, please use others such as `wasm-interp`.

# License

[WTFPL](https://choosealicense.com/licenses/wtfpl/)
