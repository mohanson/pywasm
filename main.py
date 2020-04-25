import pywasm

a = pywasm.structure.ValueType(0x7f)
print(a)
b = pywasm.structure.ResultType([a])
print(b)
