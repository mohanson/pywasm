import wasmi
import wasmi.core
import wasmi.leb128
import io
import struct
import typing

with open('./data/add.wasm', 'rb') as f:
    mod = wasmi.core.Mod.from_byte(f.read())
