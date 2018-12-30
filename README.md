# py-wasmi: A WebAssembly interpreter written in pure Python.

A WebAssembly interpreter written in pure Python.

WASM version: [WebAssembly Core Specification W3C Working Draft, 4 September 2018](https://www.w3.org/TR/2018/WD-wasm-core-1-20180904/)

Inspired by [warpy](https://github.com/kanaka/warpy) and [wagon](https://github.com/go-interpreter/wagon), but all the code is rewritten. Thanks open source author.

# Requirements
- py-wasmi has been tested and is known to run on Linux/Ubuntu, macOS and Windows(10). It will likely work fine on most OS.
- No any third party libraries.
- Python3.6 or newer.

# Installition

```sh
$ git clone https://github.com/mohanson/py-wasmi
$ cd py-wasmi && python3 main.py # Run quick test
```

**OR**

```sh
$ pip3 install wasmi # The version may be outdate.
```

# Example

py-wasmi is very simple to use. Write some c code belows:

```c
int add(int a, int b) {
    return a + b;
}
```

Generate `add.wasm` by [WasmFiddle](https://wasdk.github.io/WasmFiddle/), and then:

```py
import wasmi

path = './tests/data/add.wasm'

mod = wasmi.Mod.from_reader(open(path, 'rb'))
vm = wasmi.Vm(mod)
r = vm.exec('add', [40, 2])
print(r) # 42
```

# FAQ

Q: How is the py-wasmi performance? <br>
A: Very bad. Concise implementation for the wasm core specification.

# License

[WTFPL](https://choosealicense.com/licenses/wtfpl/)
