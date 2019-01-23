# pywasm: A WebAssembly interpreter written in pure Python.

[![Build Status](https://travis-ci.org/mohanson/pywasm.svg?branch=master)](https://travis-ci.org/mohanson/pywasm)

A WebAssembly interpreter written in pure Python. JIT used.

Current specification wasm version is: [WebAssembly Core Specification W3C Working Draft, 4 September 2018](https://www.w3.org/TR/2018/WD-wasm-core-1-20180904/). Just like Firefox or Chrome does.

# Installation

```sh
$ pip3 install pywasm
```

# Example

Some examples have been provided in the `examples` directory, you can try these examples quickly just:

```sh
$ cd pywasm
$ python3 examples add 40 2      => (i32.add) 42
$ python3 examples fib 10        => (10th of fibonacci) 55
```

With detailed, take `./examples/fib.wasm` as an example, write some c code belows:

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
import pywasm

vm = pywasm.VirtualMachine.open('./examples/fib.wasm')
r = vm.exec('fib', [10])
print(r) # 55
```

# FAQ

Q: How is the pywasm performance? <br>
A: Fine. Almost the same as ocaml.

# Thanks

- [wagon](https://github.com/go-interpreter/wagon), The author is very kind
- [warpy](https://github.com/kanaka/warpy)

# License

[WTFPL](./LICENSE)
