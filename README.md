# pywasm: A WebAssembly interpreter written in pure Python.

[![Build Status](https://travis-ci.org/mohanson/pywasm.svg?branch=master)](https://travis-ci.org/mohanson/pywasm)

A WebAssembly interpreter written in pure Python. JIT used.

Current specification wasm version is: [WebAssembly Core Specification W3C Working Draft, 4 September 2018](https://www.w3.org/TR/2018/WD-wasm-core-1-20180904/). Just like Firefox or Chrome does.

# Installation

```sh
$ pip3 install pywasm
```

# Example

A few small examples have been provided in the `examples` directory, you can try these examples quickly just:

```sh
$ cd pywasm
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

```
            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

 Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>

 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT THE FUCK YOU WANT TO.
```
