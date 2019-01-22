import os
import sys

sys.path.append(os.getcwd())
import pywasm

name = sys.argv[1]
path = os.path.join('examples', f'{name}.wasm')
wvm = pywasm.AbstractMachine.open(path)
r = wvm.exec(name, [int(i) for i in sys.argv[2:]])
print(r)
