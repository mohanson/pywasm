#!/usr/bin/env python

INFO  = False   # informational logging
TRACE = False   # trace instructions/stacks
DEBUG = False   # verbose logging
#INFO  = True    # informational logging
#TRACE = True    # trace instructions/stacks
#DEBUG = True    # verbose logging
VALIDATE= True

import sys, os, math
IS_RPYTHON = sys.argv[0].endswith('rpython')

sys.path.append(os.path.abspath('./pypy2-v5.6.0-src'))
if IS_RPYTHON:
    # JIT Stuff
    from rpython.jit.codewriter.policy import JitPolicy
    def jitpolicy(driver):
        return JitPolicy()
    from rpython.rlib.jit import JitDriver, elidable, unroll_safe, promote

    from rpython.rtyper.lltypesystem import lltype
    from rpython.rtyper.lltypesystem.lloperation import llop
    from rpython.rlib.listsort import TimSort
    from rpython.rlib.rstruct.ieee import float_unpack, float_pack
    from rpython.rlib.rfloat import round_double
    from rpython.rlib.rarithmetic import (
            intmask, string_to_int)

    from pypy.objspace.std.objspace import StdObjSpace
    from pypy.objspace.std.floatobject import W_FloatObject
    _tmpspace = StdObjSpace()
    _tmpspace.call_function = lambda f, a: a


    class IntSort(TimSort):
        def lt(self, a, b):
            assert isinstance(a, int)
            assert isinstance(b, int)
            return a < b

    def do_sort(a):
        IntSort(a).sort()

    @elidable
    def unpack_f32(i32):
        return float_unpack(i32, 4)
    @elidable
    def unpack_f64(i64):
        return float_unpack(i64, 8)
    @elidable
    def pack_f32(f32):
        return float_pack(f32, 4)
    @elidable
    def pack_f64(f64):
        return float_pack(f64, 8)


    @elidable
    def fround(val, digits):
        return round_double(val, digits)

    @elidable
    def float_fromhex(s):
        fo = W_FloatObject.descr_fromhex(_tmpspace, None, s)
        return fo.floatval

else:
    import traceback
    import struct

    def elidable(f): return f
    def unroll_safe(f): return f
    def promote(x): pass

    def do_sort(a):
        a.sort()

    def unpack_f32(i32):
        return struct.unpack('f', struct.pack('i', i32))[0]
    def unpack_f64(i64):
        return struct.unpack('d', struct.pack('q', i64))[0]
    def pack_f32(f32):
        return struct.unpack('i', struct.pack('f', f32))[0]
    def pack_f64(f64):
        return struct.unpack('q', struct.pack('d', f64))[0]

    def intmask(i): return i

    def string_to_int(s, base=10): return int(s, base)

    def fround(val, digits):
        return round(val, digits)

    def float_fromhex(s):
        return float.fromhex(s)



######################################
# Basic low-level types/classes
######################################

class WAException(Exception):
    def __init__(self, message):
        self.message = message

class Type():
    def __init__(self, index, form, params, results):
        self.index = index
        self.form = form
        self.params = params
        self.results = results
        self.mask = 0x80

class Code():
    pass

class Block(Code):
    def __init__(self, kind, type, start):
        self.kind = kind # block opcode (0x00 for init_expr)
        self.type = type # value_type
        self.locals = []
        self.start = start
        self.end = 0
        self.else_addr = 0
        self.br_addr = 0

    def update(self, end, br_addr):
        self.end = end
        self.br_addr = br_addr

class Function(Code):
    def __init__(self, type, index):
        self.type = type # value_type
        self.index = index
        self.locals = []
        self.start = 0
        self.end = 0
        self.else_addr = 0
        self.br_addr = 0

    def update(self, locals, start, end):
        self.locals = locals
        self.start = start
        self.end = end
        self.br_addr = end

class FunctionImport(Code):
    def __init__(self, type, module, field):
        self.type = type  # value_type
        self.module = module
        self.field = field


######################################
# WebAssembly spec data
######################################

MAGIC = 0x6d736100
VERSION = 0x01  # MVP

STACK_SIZE     = 65536
CALLSTACK_SIZE = 8192

I32     = 0x7f  # -0x01
I64     = 0x7e  # -0x02
F32     = 0x7d  # -0x03
F64     = 0x7c  # -0x04
ANYFUNC = 0x70  # -0x10
FUNC    = 0x60  # -0x20
BLOCK   = 0x40  # -0x40

VALUE_TYPE = { I32     : 'i32',
               I64     : 'i64',
               F32     : 'f32',
               F64     : 'f64',
               ANYFUNC : 'anyfunc',
               FUNC    : 'func',
               BLOCK   : 'block_type' }

# Block types/signatures for blocks, loops, ifs
BLOCK_TYPE = { I32   : Type(-1, BLOCK, [], [I32]),
               I64   : Type(-1, BLOCK, [], [I64]),
               F32   : Type(-1, BLOCK, [], [F32]),
               F64   : Type(-1, BLOCK, [], [F64]),
               BLOCK : Type(-1, BLOCK, [], []) }


BLOCK_NAMES = { 0x00 : "fn",  # TODO: something else?
                0x02 : "block",
                0x03 : "loop",
                0x04 : "if",
                0x05 : "else" }


EXTERNAL_KIND_NAMES = { 0x0 : "Function",
                        0x1 : "Table",
                        0x2 : "Memory",
                        0x3 : "Global" }

#                 ID :  section name
SECTION_NAMES = { 0  : 'Custom',
                  1  : 'Type',
                  2  : 'Import',
                  3  : 'Function',
                  4  : 'Table',
                  5  : 'Memory',
                  6  : 'Global',
                  7  : 'Export',
                  8  : 'Start',
                  9  : 'Element',
                  10 : 'Code',
                  11 : 'Data' }

#      opcode  name              immediate(s)
OPERATOR_INFO = {
        # Control flow operators
        0x00 : ['unreachable',    ''],
        0x01 : ['nop',            ''],
        0x02 : ['block',          'block_type'],
        0x03 : ['loop',           'block_type'],
        0x04 : ['if',             'block_type'],
        0x05 : ['else',           ''],
        0x06 : ['RESERVED',       ''],
        0x07 : ['RESERVED',       ''],
        0x08 : ['RESERVED',       ''],
        0x09 : ['RESERVED',       ''],
        0x0a : ['RESERVED',       ''],
        0x0b : ['end',            ''],
        0x0c : ['br',             'varuint32'],
        0x0d : ['br_if',          'varuint32'],
        0x0e : ['br_table',       'br_table'],
        0x0f : ['return',         ''],

        # Call operators
        0x10 : ['call',           'varuint32'],
        0x11 : ['call_indirect',  'varuint32+varuint1'],

        0x12 : ['RESERVED',       ''],
        0x13 : ['RESERVED',       ''],
        0x14 : ['RESERVED',       ''],
        0x15 : ['RESERVED',       ''],
        0x16 : ['RESERVED',       ''],
        0x17 : ['RESERVED',       ''],
        0x18 : ['RESERVED',       ''],
        0x19 : ['RESERVED',       ''],

        # Parametric operators
        0x1a : ['drop',           ''],
        0x1b : ['select',         ''],

        0x1c : ['RESERVED',       ''],
        0x1d : ['RESERVED',       ''],
        0x1e : ['RESERVED',       ''],
        0x1f : ['RESERVED',       ''],

        # Variable access
        0x20 : ['get_local',      'varuint32'],
        0x21 : ['set_local',      'varuint32'],
        0x22 : ['tee_local',      'varuint32'],
        0x23 : ['get_global',     'varuint32'],
        0x24 : ['set_global',     'varuint32'],

        0x25 : ['RESERVED',       ''],
        0x26 : ['RESERVED',       ''],
        0x27 : ['RESERVED',       ''],

        # Memory-related operators
        0x28 : ['i32.load',       'memory_immediate'],
        0x29 : ['i64.load',       'memory_immediate'],
        0x2a : ['f32.load',       'memory_immediate'],
        0x2b : ['f64.load',       'memory_immediate'],
        0x2c : ['i32.load8_s',    'memory_immediate'],
        0x2d : ['i32.load8_u',    'memory_immediate'],
        0x2e : ['i32.load16_s',   'memory_immediate'],
        0x2f : ['i32.load16_u',   'memory_immediate'],
        0x30 : ['i64.load8_s',    'memory_immediate'],
        0x31 : ['i64.load8_u',    'memory_immediate'],
        0x32 : ['i64.load16_s',   'memory_immediate'],
        0x33 : ['i64.load16_u',   'memory_immediate'],
        0x34 : ['i64.load32_s',   'memory_immediate'],
        0x35 : ['i64.load32_u',   'memory_immediate'],
        0x36 : ['i32.store',      'memory_immediate'],
        0x37 : ['i64.store',      'memory_immediate'],
        0x38 : ['f32.store',      'memory_immediate'],
        0x39 : ['f64.store',      'memory_immediate'],
        0x3a : ['i32.store8',     'memory_immediate'],
        0x3b : ['i32.store16',    'memory_immediate'],
        0x3c : ['i64.store8',     'memory_immediate'],
        0x3d : ['i64.store16',    'memory_immediate'],
        0x3e : ['i64.store32',    'memory_immediate'],
        0x3f : ['current_memory', 'varuint1'],
        0x40 : ['grow_memory',    'varuint1'],

        # Constants
        0x41 : ['i32.const',      'varint32'],
        0x42 : ['i64.const',      'varint64'],
        0x43 : ['f32.const',      'uint32'],
        0x44 : ['f64.const',      'uint64'],

        # Comparison operators
        0x45 : ['i32.eqz',        ''],
        0x46 : ['i32.eq',         ''],
        0x47 : ['i32.ne',         ''],
        0x48 : ['i32.lt_s',       ''],
        0x49 : ['i32.lt_u',       ''],
        0x4a : ['i32.gt_s',       ''],
        0x4b : ['i32.gt_u',       ''],
        0x4c : ['i32.le_s',       ''],
        0x4d : ['i32.le_u',       ''],
        0x4e : ['i32.ge_s',       ''],
        0x4f : ['i32.ge_u',       ''],

        0x50 : ['i64.eqz',        ''],
        0x51 : ['i64.eq',         ''],
        0x52 : ['i64.ne',         ''],
        0x53 : ['i64.lt_s',       ''],
        0x54 : ['i64.lt_u',       ''],
        0x55 : ['i64.gt_s',       ''],
        0x56 : ['i64.gt_u',       ''],
        0x57 : ['i64.le_s',       ''],
        0x58 : ['i64.le_u',       ''],
        0x59 : ['i64.ge_s',       ''],
        0x5a : ['i64.ge_u',       ''],

        0x5b : ['f32.eq',         ''],
        0x5c : ['f32.ne',         ''],
        0x5d : ['f32.lt',         ''],
        0x5e : ['f32.gt',         ''],
        0x5f : ['f32.le',         ''],
        0x60 : ['f32.ge',         ''],

        0x61 : ['f64.eq',         ''],
        0x62 : ['f64.ne',         ''],
        0x63 : ['f64.lt',         ''],
        0x64 : ['f64.gt',         ''],
        0x65 : ['f64.le',         ''],
        0x66 : ['f64.ge',         ''],

        # Numeric operators
        0x67 : ['i32.clz',        ''],
        0x68 : ['i32.ctz',        ''],
        0x69 : ['i32.popcnt',     ''],
        0x6a : ['i32.add',        ''],
        0x6b : ['i32.sub',        ''],
        0x6c : ['i32.mul',        ''],
        0x6d : ['i32.div_s',      ''],
        0x6e : ['i32.div_u',      ''],
        0x6f : ['i32.rem_s',      ''],
        0x70 : ['i32.rem_u',      ''],
        0x71 : ['i32.and',        ''],
        0x72 : ['i32.or',         ''],
        0x73 : ['i32.xor',        ''],
        0x74 : ['i32.shl',        ''],
        0x75 : ['i32.shr_s',      ''],
        0x76 : ['i32.shr_u',      ''],
        0x77 : ['i32.rotl',       ''],
        0x78 : ['i32.rotr',       ''],

        0x79 : ['i64.clz',        ''],
        0x7a : ['i64.ctz',        ''],
        0x7b : ['i64.popcnt',     ''],
        0x7c : ['i64.add',        ''],
        0x7d : ['i64.sub',        ''],
        0x7e : ['i64.mul',        ''],
        0x7f : ['i64.div_s',      ''],
        0x80 : ['i64.div_u',      ''],
        0x81 : ['i64.rem_s',      ''],
        0x82 : ['i64.rem_u',      ''],
        0x83 : ['i64.and',        ''],
        0x84 : ['i64.or',         ''],
        0x85 : ['i64.xor',        ''],
        0x86 : ['i64.shl',        ''],
        0x87 : ['i64.shr_s',      ''],
        0x88 : ['i64.shr_u',      ''],
        0x89 : ['i64.rotl',       ''],
        0x8a : ['i64.rotr',       ''],

        0x8b : ['f32.abs',        ''],
        0x8c : ['f32.neg',        ''],
        0x8d : ['f32.ceil',       ''],
        0x8e : ['f32.floor',      ''],
        0x8f : ['f32.trunc',      ''],
        0x90 : ['f32.nearest',    ''],
        0x91 : ['f32.sqrt',       ''],
        0x92 : ['f32.add',        ''],
        0x93 : ['f32.sub',        ''],
        0x94 : ['f32.mul',        ''],
        0x95 : ['f32.div',        ''],
        0x96 : ['f32.min',        ''],
        0x97 : ['f32.max',        ''],
        0x98 : ['f32.copysign',   ''],

        0x99 : ['f64.abs',        ''],
        0x9a : ['f64.neg',        ''],
        0x9b : ['f64.ceil',       ''],
        0x9c : ['f64.floor',      ''],
        0x9d : ['f64.trunc',      ''],
        0x9e : ['f64.nearest',    ''],
        0x9f : ['f64.sqrt',       ''],
        0xa0 : ['f64.add',        ''],
        0xa1 : ['f64.sub',        ''],
        0xa2 : ['f64.mul',        ''],
        0xa3 : ['f64.div',        ''],
        0xa4 : ['f64.min',        ''],
        0xa5 : ['f64.max',        ''],
        0xa6 : ['f64.copysign',   ''],

        # Conversions
        0xa7 : ['i32.wrap/i64',        ''],
        0xa8 : ['i32.trunc_s/f32',     ''],
        0xa9 : ['i32.trunc_u/f32',     ''],
        0xaa : ['i32.trunc_s/f64',     ''],
        0xab : ['i32.trunc_u/f64',     ''],

        0xac : ['i64.extend_s/i32',    ''],
        0xad : ['i64.extend_u/i32',    ''],
        0xae : ['i64.trunc_s/f32',     ''],
        0xaf : ['i64.trunc_u/f32',     ''],
        0xb0 : ['i64.trunc_s/f64',     ''],
        0xb1 : ['i64.trunc_u/f64',     ''],

        0xb2 : ['f32.convert_s/i32',   ''],
        0xb3 : ['f32.convert_u/i32',   ''],
        0xb4 : ['f32.convert_s/i64',   ''],
        0xb5 : ['f32.convert_u/i64',   ''],
        0xb6 : ['f32.demote/f64',      ''],

        0xb7 : ['f64.convert_s/i32',   ''],
        0xb8 : ['f64.convert_u/i32',   ''],
        0xb9 : ['f64.convert_s/i64',   ''],
        0xba : ['f64.convert_u/i64',   ''],
        0xbb : ['f64.promote/f32',     ''],

        # Reinterpretations
        0xbc : ['i32.reinterpret/f32', ''],
        0xbd : ['i64.reinterpret/f64', ''],
        0xbe : ['f32.reinterpret/i32', ''],
        0xbf : ['f64.reinterpret/i64', ''],
        }

LOAD_SIZE = { 0x28 : 4,
              0x29 : 8,
              0x2a : 4,
              0x2b : 8,
              0x2c : 1,
              0x2d : 1,
              0x2e : 2,
              0x2f : 2,
              0x30 : 1,
              0x31 : 1,
              0x32 : 2,
              0x33 : 2,
              0x34 : 4,
              0x35 : 4,
              0x36 : 4,
              0x37 : 8,
              0x38 : 4,
              0x39 : 8,
              0x3a : 1,
              0x3b : 2,
              0x3c : 1,
              0x3d : 2,
              0x3e : 4,
              0x40 : 1,
              0x41 : 2,
              0x42 : 1,
              0x43 : 2,
              0x44 : 4 }


######################################
# General Functions
######################################

def info(str, end='\n'):
    if INFO:
        os.write(2, str + end)
        #if end == '': sys.stderr.flush()

def debug(str, end='\n'):
    if DEBUG:
        os.write(2, str + end)
        #if end == '': sys.stderr.flush()


# math functions

def unpack_nan32(i32):
    if IS_RPYTHON:
        return float_unpack(i32, 4)
    else:
        return struct.unpack('f', struct.pack('I', i32))[0]
def unpack_nan64(i64):
    if IS_RPYTHON:
        return float_unpack(i64, 8)
    else:
        return struct.unpack('d', struct.pack('Q', i64))[0]

@elidable
def parse_nan(type, arg):
    if   type == F32: v = unpack_nan32(0x7fc00000)
    else:             v = unpack_nan64(0x7ff8000000000000)
    return v

@elidable
def parse_number(type, arg):
    arg = "".join([c for c in arg if c != '_'])
    if   type == I32:
        if   arg[0:2] == '0x':   v = (I32, string_to_int(arg,16), 0.0)
        elif arg[0:3] == '-0x':  v = (I32, string_to_int(arg,16), 0.0)
        else:                    v = (I32, string_to_int(arg,10), 0.0)
    elif type == I64:
        if arg[0:2] == '0x':     v = (I64, string_to_int(arg,16), 0.0)
        elif arg[0:3] == '-0x':  v = (I64, string_to_int(arg,16), 0.0)
        else:                    v = (I64, string_to_int(arg,10), 0.0)
    elif type == F32:
        if   arg.find('nan')>=0: v = (F32, 0, parse_nan(type, arg))
        elif arg.find('inf')>=0: v = (F32, 0, float_fromhex(arg))
        elif arg[0:2] == '0x':   v = (F32, 0, float_fromhex(arg))
        elif arg[0:3] == '-0x':  v = (F32, 0, float_fromhex(arg))
        else:                    v = (F32, 0, float(arg))
    elif type == F64:
        if   arg.find('nan')>=0: v = (F64, 0, parse_nan(type, arg))
        elif arg.find('inf')>=0: v = (F64, 0, float_fromhex(arg))
        elif arg[0:2] == '0x':   v = (F64, 0, float_fromhex(arg))
        elif arg[0:3] == '-0x':  v = (F64, 0, float_fromhex(arg))
        else:                    v = (F64, 0, float(arg))
    else:
        raise Exception("invalid number %s" % arg)
    return v

# Integer division that rounds towards 0 (like C)
@elidable
def idiv_s(a,b):
    return a//b if a*b>0 else (a+(-a%b))//b

@elidable
def irem_s(a,b):
    return a%b if a*b>0 else -(-a%b)

#

@elidable
def rotl32(a,cnt):
    return (((a << (cnt % 0x20)) & 0xffffffff)
            | (a >> (0x20 - (cnt % 0x20))))

@elidable
def rotr32(a,cnt):
    return ((a >> (cnt % 0x20))
            | ((a << (0x20 - (cnt % 0x20))) & 0xffffffff))

@elidable
def rotl64(a,cnt):
    return (((a << (cnt % 0x40)) & 0xffffffffffffffff)
            | (a >> (0x40 - (cnt % 0x40))))

@elidable
def rotr64(a,cnt):
    return ((a >> (cnt % 0x40))
            | ((a << (0x40 - (cnt % 0x40))) & 0xffffffffffffffff))

@elidable
def bytes2uint8(b):
    return b[0]

@elidable
def bytes2int8(b):
    val = b[0]
    if val & 0x80:
        return val - 0x100
    else:
        return val

#

@elidable
def bytes2uint16(b):
    return (b[1]<<8) + b[0]

@elidable
def bytes2int16(b):
    val = (b[1]<<8) + b[0]
    if val & 0x8000:
        return val - 0x10000
    else:
        return val

#

@elidable
def bytes2uint32(b):
    return (b[3]<<24) + (b[2]<<16) + (b[1]<<8) + b[0]

@elidable
def uint322bytes(v):
    return [0xff & (v),
            0xff & (v>>8),
            0xff & (v>>16),
            0xff & (v>>24)]

@elidable
def bytes2int32(b):
    val = (b[3]<<24) + (b[2]<<16) + (b[1]<<8) + b[0]
    if val & 0x80000000:
        return val - 0x100000000
    else:
        return val

@elidable
def int2uint32(i):
    return i & 0xffffffff

@elidable
def int2int32(i):
    val = i & 0xffffffff
    if val & 0x80000000:
        return val - 0x100000000
    else:
        return val

#

@elidable
def bytes2uint64(b):
    return ((b[7]<<56) + (b[6]<<48) + (b[5]<<40) + (b[4]<<32) +
            (b[3]<<24) + (b[2]<<16) + (b[1]<<8) + b[0])

@elidable
def uint642bytes(v):
    return [0xff & (v),
            0xff & (v>>8),
            0xff & (v>>16),
            0xff & (v>>24),
            0xff & (v>>32),
            0xff & (v>>40),
            0xff & (v>>48),
            0xff & (v>>56)]

if IS_RPYTHON:
    @elidable
    def bytes2int64(b):
        return bytes2uint64(b)
else:
    def bytes2int64(b):
        val = ((b[7]<<56) + (b[6]<<48) + (b[5]<<40) + (b[4]<<32) +
                (b[3]<<24) + (b[2]<<16) + (b[1]<<8) + b[0])
        if val & 0x8000000000000000:
            return val - 0x10000000000000000
        else:
            return val

#

if IS_RPYTHON:
    @elidable
    def int2uint64(i):
        return intmask(i)
else:
    def int2uint64(i):
        return i & 0xffffffffffffffff

if IS_RPYTHON:
    @elidable
    def int2int64(i):
        return i
else:
    def int2int64(i):
        val = i & 0xffffffffffffffff
        if val & 0x8000000000000000:
            return val - 0x10000000000000000
        else:
            return val

# https://en.wikipedia.org/wiki/LEB128
@elidable
def read_LEB(bytes, pos, maxbits=32, signed=False):
    result = 0
    shift = 0

    bcnt = 0
    startpos = pos
    while True:
        byte = bytes[pos]
        pos += 1
        result |= ((byte & 0x7f)<<shift)
        shift +=7
        if (byte & 0x80) == 0:
            break
        # Sanity check length against maxbits
        bcnt += 1
        if bcnt > math.ceil(maxbits/7.0):
            raise Exception("Unsigned LEB at byte %s overflow" %
                    startpos)
    if signed and (shift < maxbits) and (byte & 0x40):
        # Sign extend
        result |= - (1 << shift)
    return (pos, result)

@elidable
def read_I32(bytes, pos):
    assert pos >= 0
    return bytes2uint32(bytes[pos:pos+4])

@elidable
def read_I64(bytes, pos):
    assert pos >= 0
    return bytes2uint64(bytes[pos:pos+8])

@elidable
def read_F32(bytes, pos):
    assert pos >= 0
    bits = bytes2int32(bytes[pos:pos+4])
    num = unpack_f32(bits)
    # fround hangs if called with nan
    if math.isnan(num): return num
    return fround(num, 5)

@elidable
def read_F64(bytes, pos):
    assert pos >= 0
    bits = bytes2int64(bytes[pos:pos+8])
    return unpack_f64(bits)

def write_I32(bytes, pos, ival):
    bytes[pos:pos+4] = uint322bytes(ival)

def write_I64(bytes, pos, ival):
    bytes[pos:pos+8] = uint642bytes(ival)

def write_F32(bytes, pos, fval):
    ival = intmask(pack_f32(fval))
    bytes[pos:pos+4] = uint322bytes(ival)

def write_F64(bytes, pos, fval):
    ival = intmask(pack_f64(fval))
    bytes[pos:pos+8] = uint642bytes(ival)


def value_repr(val):
    vt, ival, fval = val
    vtn = VALUE_TYPE[vt]
    if   vtn in ('i32', 'i64'):
        return "%s:%s" % (hex(ival), vtn)
    elif vtn in ('f32', 'f64'):
        if IS_RPYTHON:
            # TODO: fix this to be like python
            return "%f:%s" % (fval, vtn)
        else:
            str = "%.7g" % fval
            if str.find('.') < 0:
                return "%f:%s" % (fval, vtn)
            else:
                return "%s:%s" % (str, vtn)
    else:
        raise Exception("unknown value type %s" % vtn)

def type_repr(t):
    return "<index: %s, form: %s, params: %s, results: %s, mask: %s>" % (
            t.index, VALUE_TYPE[t.form],
            [VALUE_TYPE[p] for p in t.params],
            [VALUE_TYPE[r] for r in t.results], hex(t.mask))

def export_repr(e):
    return "<kind: %s, field: '%s', index: 0x%x>" % (
            EXTERNAL_KIND_NAMES[e.kind], e.field, e.index)

def func_repr(f):
    if isinstance(f, FunctionImport):
        return "<type: 0x%x, import: '%s.%s'>" % (
                f.type.index, f.module, f.field)
    else:
        return "<type: 0x%x, locals: %s, start: 0x%x, end: 0x%x>" % (
                f.type.index, [VALUE_TYPE[p] for p in f.locals],
                f.start, f.end)

def block_repr(block):
    if isinstance(block, Block):
        return "%s<0/0->%d>" % (
                BLOCK_NAMES[block.kind],
                len(block.type.results))
    elif isinstance(block, Function):
        return "fn%d<%d/%d->%d>" % (
                block.index, len(block.type.params),
                len(block.locals), len(block.type.results))

def stack_repr(sp, fp, stack):
    res = []
    for i in range(sp+1):
        if i == fp:
            res.append("*")
        res.append(value_repr(stack[i]))
    return "[" + " ".join(res) + "]"

def callstack_repr(csp, bs):
    return "[" + " ".join(["%s(sp:%d/fp:%d/ra:0x%x)" % (
        block_repr(bs[i][0]),bs[i][1],bs[i][2],bs[i][3])
                           for i in range(csp+1)]) + "]"

def dump_stacks(sp, stack, fp, csp, callstack):
    debug("      * stack:     %s" % (
        stack_repr(sp, fp, stack)))
    debug("      * callstack: %s" % (
        callstack_repr(csp, callstack)))

def byte_code_repr(bytes):
    res = []
    for val in bytes:
        if val < 16:
            res.append("%x" % val)
        else:
            res.append("%x" % val)
    return "[" + ",".join(res) + "]"

def skip_immediates(code, pos):
    opcode = code[pos]
    pos += 1
    vals = []
    imtype = OPERATOR_INFO[opcode][1]
    if   'varuint1' == imtype:
        pos, v = read_LEB(code, pos, 1)
        vals.append(v)
    elif 'varint32' == imtype:
        pos, v = read_LEB(code, pos, 32)
        vals.append(v)
    elif 'varuint32' == imtype:
        pos, v = read_LEB(code, pos, 32)
        vals.append(v)
    elif 'varuint32+varuint1' == imtype:
        pos, v = read_LEB(code, pos, 32)
        vals.append(v)
        pos, v = read_LEB(code, pos, 1)
        vals.append(v)
    elif 'varint64' == imtype:
        pos, v = read_LEB(code, pos, 64)
        vals.append(v)
    elif 'varuint64' == imtype:
        pos, v = read_LEB(code, pos, 64)
        vals.append(v)
    elif 'uint32' == imtype:
        vals.append(read_F32(code, pos))
        pos += 4
    elif 'uint64' == imtype:
        vals.append(read_F64(code, pos))
        pos += 8
    elif 'block_type' == imtype:
        pos, v = read_LEB(code, pos, 7)  # block type signature
        vals.append(v)
    elif 'memory_immediate' == imtype:
        pos, v = read_LEB(code, pos, 32)  # flags
        vals.append(v)
        pos, v = read_LEB(code, pos, 32)  # offset
        vals.append(v)
    elif 'br_table' == imtype:
        pos, count = read_LEB(code, pos, 32)  # target count
        vals.append(count)
        for i in range(count):
            pos, v = read_LEB(code, pos, 32)  # target
            vals.append(v)
        pos, v = read_LEB(code, pos, 32)  # default target
        vals.append(v)
    elif '' == imtype:
        pass # no immediates
    else:
        raise Exception("unknown immediate type %s" % imtype)
    return pos, vals

def find_blocks(code, start, end, block_map):
    pos = start

    # stack of blocks with current at top: (opcode, pos) tuples
    opstack = []

    #
    # Build the map of blocks
    #
    opcode = 0
    while pos <= end:
        opcode = code[pos]
        #debug("0x%x: %s, opstack: %s" % (
        #    pos, OPERATOR_INFO[opcode][0],
        #    ["%d,%s,0x%x" % (o,s.index,p) for o,s,p in opstack]))
        if   0x02 <= opcode <= 0x04:  # block, loop, if
            block = Block(opcode, BLOCK_TYPE[code[pos+1]], pos)
            opstack.append(block)
            block_map[pos] = block
        elif 0x05 == opcode:  # mark else positions
            assert opstack[-1].kind == 0x04, "else not matched with if"
            opstack[-1].else_addr = pos+1
        elif 0x0b == opcode:  # end
            if pos == end: break
            block = opstack.pop()
            if block.kind == 0x03:  # loop: label after start
                block.update(pos, block.start+2)
            else:  # block/if: label at end
                block.update(pos, pos)
        pos, _ = skip_immediates(code, pos)

    assert opcode == 0xb, "function block did not end with 0xb"
    assert len(opstack) == 0, "function ended in middle of block"

    #debug("block_map: %s" % block_map)
    return block_map

@unroll_safe
def pop_block(stack, callstack, sp, fp, csp):
    block, orig_sp, orig_fp, ra = callstack[csp]
    csp -= 1
    t = block.type

    # Validate return value if there is one
    if VALIDATE:
        if len(t.results) > 1:
            raise Exception("multiple return values unimplemented")
        if len(t.results) > sp+1:
            raise Exception("stack underflow")

    if len(t.results) == 1:
        # Restore main value stack, saving top return value
        save = stack[sp]
        sp -= 1
        if save[0] != t.results[0]:
            raise WAException("call signature mismatch: %s != %s (%s)" % (
                VALUE_TYPE[t.results[0]], VALUE_TYPE[save[0]],
                value_repr(save)))

        # Restore value stack to original size prior to call/block
        if orig_sp < sp:
            sp = orig_sp

        # Put back return value if we have one
        sp += 1
        stack[sp] = save
    else:
        # Restore value stack to original size prior to call/block
        if orig_sp < sp:
            sp = orig_sp

    return block, ra, sp, orig_fp, csp

@unroll_safe
def do_call(stack, callstack, sp, fp, csp, func, pc, indirect=False):

    # Push block, stack size and return address onto callstack
    t = func.type
    csp += 1
    callstack[csp] = (func, sp-len(t.params), fp, pc)

    # Update the pos/instruction counter to the function
    pc = func.start

    if TRACE:
        info("  Calling function 0x%x, start: 0x%x, end: 0x%x, %d locals, %d params, %d results" % (
            func.index, func.start, func.end,
            len(func.locals), len(t.params), len(t.results)))

    # set frame pointer to include parameters
    fp = sp - len(t.params) + 1

    # push locals (dropping extras)
    for lidx in range(len(func.locals)):
        ltype = func.locals[lidx]
        sp += 1
        stack[sp] = (ltype, 0, 0.0)

    return pc, sp, fp, csp


@unroll_safe
def do_call_import(stack, sp, memory, import_function, func):
    t = func.type

    args = []
    for idx in range(len(t.params)-1, -1, -1):
        arg = stack[sp]
        sp -= 1
        args.append(arg)
#        if VALIDATE:
#            # make sure args match type signature
#            ptype = t.params[idx]
#            if ptype != arg[0]:
#                raise WAException("call signature mismatch: %s != %s" % (
#                    VALUE_TYPE[ptype], VALUE_TYPE[arg[0]]))

    # Workaround rpython failure to identify type
    results = [(0, 0, 0.0)]
    results.pop()
    args.reverse()
    results.extend(import_function(func.module, func.field, memory, args))

    # make sure returns match type signature
    for idx, rtype in enumerate(t.results):
        if idx < len(results):
            res = results[idx]
            if rtype != res[0]:
                raise Exception("return signature mismatch")
            sp += 1
            stack[sp] = res
        else:
            raise Exception("return signature mismatch")
    return sp


# Main loop/JIT

def get_location_str(opcode, pc, code, function, table, block_map):
    return "0x%x %s(0x%x)" % (
            pc, OPERATOR_INFO[opcode][0], opcode)

@elidable
def get_block(block_map, pc):
    return block_map[pc]

@elidable
def get_function(function, fidx):
    return function[fidx]

@elidable
def bound_violation(opcode, addr, pages):
    return addr < 0 or addr+LOAD_SIZE[opcode] > pages*(2**16)

@elidable
def get_from_table(table, tidx, table_index):
    tbl = table[tidx]
    if table_index < 0 or table_index >= len(tbl):
        raise WAException("undefined element")
    return tbl[table_index]

if IS_RPYTHON:
    # greens/reds must be sorted: ints, refs, floats
    jitdriver = JitDriver(
            greens=['opcode', 'pc',
                    'code', 'function', 'table', 'block_map'],
            reds=['sp', 'fp', 'csp',
                  'module', 'memory', 'stack', 'callstack'],
            get_printable_location=get_location_str)

def interpret_mvp(module,
        # Greens
        pc, code, function, table, block_map,
        # Reds
        memory, sp, stack, fp, csp, callstack):

    while pc < len(code):
        opcode = code[pc]
        if IS_RPYTHON:
            jitdriver.jit_merge_point(
                    # Greens
                    opcode=opcode,
                    pc=pc,
                    code=code,
                    function=function,
                    table=table,
                    block_map=block_map,
                    # Reds
                    sp=sp, fp=fp, csp=csp,
                    module=module, memory=memory,
                    stack=stack, callstack=callstack)

        cur_pc = pc
        pc += 1

        if TRACE:
            dump_stacks(sp, stack, fp, csp, callstack)
            _, immediates = skip_immediates(code, cur_pc)
            info("    0x%x <0x%x/%s%s%s>" % (
                cur_pc, opcode, OPERATOR_INFO[opcode][0],
                " " if immediates else "",
                ",".join(["0x%x" % i for i in immediates])))

        #
        # Control flow operators
        #
        if   0x00 == opcode:  # unreachable
            raise WAException("unreachable")
        elif 0x01 == opcode:  # nop
            pass
        elif 0x02 == opcode:  # block
            pc, ignore = read_LEB(code, pc, 32) # ignore block_type
            block = get_block(block_map, cur_pc)
            csp += 1
            callstack[csp] = (block, sp, fp, 0)
            if TRACE: debug("      - block: %s" % block_repr(block))
        elif 0x03 == opcode:  # loop
            pc, ignore = read_LEB(code, pc, 32) # ignore block_type
            block = get_block(block_map, cur_pc)
            csp += 1
            callstack[csp] = (block, sp, fp, 0)
            if TRACE: debug("      - block: %s" % block_repr(block))
        elif 0x04 == opcode:  # if
            pc, ignore = read_LEB(code, pc, 32) # ignore block_type
            block = get_block(block_map, cur_pc)
            csp += 1
            callstack[csp] = (block, sp, fp, 0)
            cond = stack[sp]
            sp -= 1
            if not cond[1]:  # if false (I32)
                # branch to else block or after end of if
                if block.else_addr == 0:
                    # no else block so pop if block and skip end
                    csp -= 1
                    pc = block.br_addr+1
                else:
                    pc = block.else_addr
            if TRACE:
                debug("      - cond: %s jump to 0x%x, block: %s" % (
                    value_repr(cond), pc, block_repr(block)))
        elif 0x05 == opcode:  # else
            block = callstack[csp][0]
            pc = block.br_addr
            if TRACE:
                debug("      - of %s jump to 0x%x" % (
                    block_repr(block), pc))
        elif 0x0b == opcode:  # end
            block, ra, sp, fp, csp = pop_block(stack, callstack, sp,
                    fp, csp)
            if TRACE: debug("      - of %s" % block_repr(block))
            if isinstance(block, Function):
                # Return to return address
                pc = ra
                if csp == -1:
                    # Return to top-level, ignoring return_addr
                    return pc, sp, fp, csp
                else:
                    if TRACE:
                        info("  Returning from function 0x%x to 0x%x" % (
                            block.index, pc))
            elif isinstance(block, Block) and block.kind == 0x00:
                # this is an init_expr
                return pc, sp, fp, csp
            else:
                pass # end of block/loop/if, keep going
        elif 0x0c == opcode:  # br
            pc, br_depth = read_LEB(code, pc, 32)
            csp -= br_depth
            block, _, _, _ = callstack[csp]
            pc = block.br_addr # set to end for pop_block
            if TRACE: debug("      - to: 0x%x" % pc)
        elif 0x0d == opcode:  # br_if
            pc, br_depth = read_LEB(code, pc, 32)
            cond = stack[sp]
            sp -= 1
            if cond[1]:  # I32
                csp -= br_depth
                block, _, _, _ = callstack[csp]
                pc = block.br_addr # set to end for pop_block
            if TRACE:
                debug("      - cond: %s, to: 0x%x" % (cond[1], pc))
        elif 0x0e == opcode:  # br_table
            pc, target_count = read_LEB(code, pc, 32)
            depths = []
            for c in range(target_count):
                pc, depth = read_LEB(code, pc, 32)
                depths.append(depth)
            pc, br_depth = read_LEB(code, pc, 32) # default
            expr = stack[sp]
            sp -= 1
            if VALIDATE: assert expr[0] == I32
            didx = expr[1]  # I32
            if didx >= 0 and didx < len(depths):
                br_depth = depths[didx]
            csp -= br_depth
            block, _, _, _ = callstack[csp]
            pc = block.br_addr # set to end for pop_block
            if TRACE:
                debug("      - depths: %s, didx: %d, to: 0x%x" % (
                    depths, didx, pc))
        elif 0x0f == opcode:  # return
            # Pop blocks until reach Function signature
            while csp >= 0:
                if isinstance(callstack[csp][0], Function): break
                # We don't use pop_block because the end opcode
                # handler will do this for us and catch the return
                # value properly.
                block = callstack[csp]
                csp -= 1
            if VALIDATE: assert csp >= 0
            block = callstack[csp][0]
            if VALIDATE: assert isinstance(block, Function)
            # Set instruction pointer to end of function
            # The actual pop_block and return is handled by handling
            # the end opcode
            pc = block.end
            if TRACE: debug("      - to 0x%x" % pc)

        #
        # Call operators
        #
        elif 0x10 == opcode:  # call
            pc, fidx = read_LEB(code, pc, 32)
            func = get_function(function, fidx)

            if isinstance(func, FunctionImport):
                t = func.type
                if TRACE:
                    debug("      - calling import %s.%s(%s)" % (
                        func.module, func.field,
                        ",".join([VALUE_TYPE[a] for a in t.params])))
                sp = do_call_import(stack, sp, memory,
                        module.import_function, func)
            elif isinstance(func, Function):
                pc, sp, fp, csp = do_call(stack, callstack, sp, fp,
                        csp, func, pc)
                if TRACE: debug("      - calling function fidx: %d"
                                " at: 0x%x" % (fidx, pc))
        elif 0x11 == opcode:  # call_indirect
            pc, tidx = read_LEB(code, pc, 32)
            pc, reserved = read_LEB(code, pc, 1)
            type_index_val = stack[sp]
            sp -= 1
            if VALIDATE: assert type_index_val[0] == I32
            table_index = int(type_index_val[1])  # I32
            promote(table_index)
            fidx = get_from_table(table, ANYFUNC, table_index)
            promote(fidx)
            if VALIDATE: assert csp < CALLSTACK_SIZE, "call stack exhausted"
            func = get_function(function, fidx)
            if VALIDATE and func.type.mask != module.type[tidx].mask:
                raise WAException("indirect call type mismatch (call type %s and function type %s differ" % (func.type.index, tidx))
            pc, sp, fp, csp = do_call(stack, callstack, sp, fp, csp,
                    func, pc, True)
            if TRACE:
                debug("      - table idx: 0x%x, tidx: 0x%x,"
                      " calling function fidx: 0x%x at 0x%x" % (
                          table_index, tidx, fidx, pc))

        #
        # Parametric operators
        #
        elif 0x1a == opcode:  # drop
            if TRACE: debug("      - dropping: %s" % value_repr(stack[sp]))
            sp -= 1
        elif 0x1b == opcode:  # select
            cond, a, b = stack[sp], stack[sp-1], stack[sp-2]
            sp -= 2
            if cond[1]:  # I32
                stack[sp] = b
            else:
                stack[sp] = a
            if TRACE:
                debug("      - cond: 0x%x, selected: %s" % (
                    cond[1], value_repr(stack[sp])))

        #
        # Variable access
        #
        elif 0x20 == opcode:  # get_local
            pc, arg = read_LEB(code, pc, 32)
            sp += 1
            stack[sp] = stack[fp+arg]
            if TRACE: debug("      - got %s" % value_repr(stack[sp]))
        elif 0x21 == opcode:  # set_local
            pc, arg = read_LEB(code, pc, 32)
            val = stack[sp]
            sp -= 1
            stack[fp+arg] = val
            if TRACE: debug("      - to %s" % value_repr(val))
        elif 0x22 == opcode:  # tee_local
            pc, arg = read_LEB(code, pc, 32)
            val = stack[sp] # like set_local but do not pop
            stack[fp+arg] = val
            if TRACE: debug("      - to %s" % value_repr(val))
        elif 0x23 == opcode:  # get_global
            pc, gidx = read_LEB(code, pc, 32)
            sp += 1
            stack[sp] = module.global_list[gidx]
            if TRACE: debug("      - got %s" % value_repr(stack[sp]))
        elif 0x24 == opcode:  # set_global
            pc, gidx = read_LEB(code, pc, 32)
            val = stack[sp]
            sp -= 1
            module.global_list[gidx] = val
            if TRACE: debug("      - to %s" % value_repr(val))

        #
        # Memory-related operators
        #

        # Memory load operators
        elif 0x28 <= opcode <= 0x35:
            pc, flags = read_LEB(code, pc, 32)
            pc, offset = read_LEB(code, pc, 32)
            addr_val = stack[sp]
            sp -= 1
            if flags != 2:
                if TRACE:
                    info("      - unaligned load - flags: 0x%x,"
                         " offset: 0x%x, addr: 0x%x" % (
                             flags, offset, addr_val[1]))
            addr = addr_val[1] + offset
            if bound_violation(opcode, addr, memory.pages):
                raise WAException("out of bounds memory access")
            assert addr >= 0
            if   0x28 == opcode:  # i32.load
                res = (I32, bytes2uint32(memory.bytes[addr:addr+4]), 0.0)
            elif 0x29 == opcode:  # i64.load
                res = (I64, bytes2uint64(memory.bytes[addr:addr+8]), 0.0)
            elif 0x2a == opcode:  # f32.load
                res = (F32, 0, read_F32(memory.bytes, addr))
            elif 0x2b == opcode:  # f64.load
                res = (F64, 0, read_F64(memory.bytes, addr))
            elif 0x2c == opcode:  # i32.load8_s
                res = (I32, bytes2int8(memory.bytes[addr:addr+1]), 0.0)
            elif 0x2d == opcode:  # i32.load8_u
                res = (I32, memory.bytes[addr], 0.0)
            elif 0x2e == opcode:  # i32.load16_s
                res = (I32, bytes2int16(memory.bytes[addr:addr+2]), 0.0)
            elif 0x2f == opcode:  # i32.load16_u
                res = (I32, bytes2uint16(memory.bytes[addr:addr+2]), 0.0)
            elif 0x30 == opcode:  # i64.load8_s
                res = (I64, bytes2int8(memory.bytes[addr:addr+1]), 0.0)
            elif 0x31 == opcode:  # i64.load8_u
                res = (I64, memory.bytes[addr], 0.0)
            elif 0x32 == opcode:  # i64.load16_s
                res = (I64, bytes2int16(memory.bytes[addr:addr+2]), 0.0)
            elif 0x33 == opcode:  # i64.load16_u
                res = (I64, bytes2uint16(memory.bytes[addr:addr+2]), 0.0)
            elif 0x34 == opcode:  # i64.load32_s
                res = (I64, bytes2int32(memory.bytes[addr:addr+4]), 0.0)
            elif 0x35 == opcode:  # i64.load32_u
                res = (I64, bytes2uint32(memory.bytes[addr:addr+4]), 0.0)
            else:
                raise WAException("%s(0x%x) unimplemented" % (
                    OPERATOR_INFO[opcode][0], opcode))
            sp += 1
            stack[sp] = res

        # Memory store operators
        elif 0x36 <= opcode <= 0x3e:
            pc, flags = read_LEB(code, pc, 32)
            pc, offset = read_LEB(code, pc, 32)
            val = stack[sp]
            sp -= 1
            addr_val = stack[sp]
            sp -= 1
            if flags != 2:
                if TRACE:
                    info("      - unaligned store - flags: 0x%x,"
                         " offset: 0x%x, addr: 0x%x, val: 0x%x" % (
                             flags, offset, addr_val[1], val[1]))
            addr = addr_val[1] + offset
            if bound_violation(opcode, addr, memory.pages):
                raise WAException("out of bounds memory access")
            assert addr >= 0
            if   0x36 == opcode:  # i32.store
                write_I32(memory.bytes, addr, val[1])
            elif 0x37 == opcode:  # i64.store
                write_I64(memory.bytes, addr, val[1])
            elif 0x38 == opcode:  # f32.store
                write_F32(memory.bytes, addr, val[2])
            elif 0x39 == opcode:  # f64.store
                write_F64(memory.bytes, addr, val[2])
            elif 0x3a == opcode:  # i32.store8
                memory.bytes[addr] = val[1] & 0xff
            elif 0x3b == opcode:  # i32.store16
                memory.bytes[addr]   =  val[1] & 0x00ff
                memory.bytes[addr+1] = (val[1] & 0xff00)>>8
            elif 0x3c == opcode:  # i64.store8
                memory.bytes[addr]   =  val[1] & 0xff
            elif 0x3d == opcode:  # i64.store16
                memory.bytes[addr]   =  val[1] & 0x00ff
                memory.bytes[addr+1] = (val[1] & 0xff00)>>8
            elif 0x3e == opcode:  # i64.store32
                memory.bytes[addr]   =  val[1] & 0x000000ff
                memory.bytes[addr+1] = (val[1] & 0x0000ff00)>>8
                memory.bytes[addr+2] = (val[1] & 0x00ff0000)>>16
                memory.bytes[addr+3] = (val[1] & 0xff000000)>>24
            else:
                raise WAException("%s(0x%x) unimplemented" % (
                    OPERATOR_INFO[opcode][0], opcode))

        # Memory size operators
        elif 0x3f == opcode:  # current_memory
            pc, reserved = read_LEB(code, pc, 1)
            sp += 1
            stack[sp] = (I32, module.memory.pages, 0.0)
            if TRACE:
                debug("      - current 0x%x" % module.memory.pages)
        elif 0x40 == opcode:  # grow_memory
            pc, reserved = read_LEB(code, pc, 1)
            prev_size = module.memory.pages
            delta = stack[sp][1]  # I32
            module.memory.grow(delta)
            stack[sp] = (I32, prev_size, 0.0)
            debug("      - delta 0x%x, prev: 0x%x" % (
                delta, prev_size))

        #
        # Constants
        #
        elif 0x41 == opcode:  # i32.const
            pc, val = read_LEB(code, pc, 32, signed=True)
            sp += 1
            stack[sp] = (I32, val, 0.0)
            if TRACE: debug("      - %s" % value_repr(stack[sp]))
        elif 0x42 == opcode:  # i64.const
            pc, val = read_LEB(code, pc, 64, signed=True)
            sp += 1
            stack[sp] = (I64, val, 0.0)
            if TRACE: debug("      - %s" % value_repr(stack[sp]))
        elif 0x43 == opcode:  # f32.const
            sp += 1
            stack[sp] = (F32, 0, read_F32(code, pc))
            pc += 4
            if TRACE: debug("      - %s" % value_repr(stack[sp]))
        elif 0x44 == opcode:  # f64.const
            sp += 1
            stack[sp] = (F64, 0, read_F64(code, pc))
            pc += 8
            if TRACE: debug("      - %s" % value_repr(stack[sp]))

        #
        # Comparison operators
        #

        # unary
        elif opcode in [0x45, 0x50]:
            a = stack[sp]
            sp -= 1
            if   0x45 == opcode: # i32.eqz
                if VALIDATE: assert a[0] == I32
                res = (I32, a[1] == 0, 0.0)
            elif 0x50 == opcode: # i64.eqz
                if VALIDATE: assert a[0] == I64
                res = (I32, a[1] == 0, 0.0)
            else:
                raise WAException("%s(0x%x) unimplemented" % (
                    OPERATOR_INFO[opcode][0], opcode))
            if TRACE:
                debug("      - (%s) = %s" % (
                    value_repr(a), value_repr(res)))
            sp += 1
            stack[sp] = res

        # binary
        elif 0x46 <= opcode <= 0x66:
            a, b = stack[sp-1], stack[sp]
            sp -= 2
            if   0x46 == opcode: # i32.eq
                if VALIDATE: assert a[0] == I32 and b[0] == I32
                res = (I32, a[1] == b[1], 0.0)
            elif 0x47 == opcode: # i32.ne
                if VALIDATE: assert a[0] == I32 and b[0] == I32
                res = (I32, a[1] != b[1], 0.0)
            elif 0x48 == opcode: # i32.lt_s
                if VALIDATE: assert a[0] == I32 and b[0] == I32
                res = (I32, int2int32(a[1]) < int2int32(b[1]), 0.0)
            elif 0x49 == opcode: # i32.lt_u
                if VALIDATE: assert a[0] == I32 and b[0] == I32
                res = (I32, int2uint32(a[1]) < int2uint32(b[1]), 0.0)
            elif 0x4a == opcode: # i32.gt_s
                if VALIDATE: assert a[0] == I32 and b[0] == I32
                res = (I32, int2int32(a[1]) > int2int32(b[1]), 0.0)
            elif 0x4b == opcode: # i32.gt_u
                if VALIDATE: assert a[0] == I32 and b[0] == I32
                res = (I32, int2uint32(a[1]) > int2uint32(b[1]), 0.0)
            elif 0x4c == opcode: # i32.le_s
                if VALIDATE: assert a[0] == I32 and b[0] == I32
                res = (I32, int2int32(a[1]) <= int2int32(b[1]), 0.0)
            elif 0x4d == opcode: # i32.le_u
                if VALIDATE: assert a[0] == I32 and b[0] == I32
                res = (I32, int2uint32(a[1]) <= int2uint32(b[1]), 0.0)
            elif 0x4e == opcode: # i32.ge_s
                if VALIDATE: assert a[0] == I32 and b[0] == I32
                res = (I32, int2int32(a[1]) >= int2int32(b[1]), 0.0)
            elif 0x4f == opcode: # i32.ge_u
                if VALIDATE: assert a[0] == I32 and b[0] == I32
                res = (I32, int2uint32(a[1]) >= int2uint32(b[1]), 0.0)
            elif 0x51 == opcode: # i64.eq
                if VALIDATE: assert a[0] == I64 and b[0] == I64
                res = (I32, a[1] == b[1], 0.0)
            elif 0x52 == opcode: # i64.ne
                if VALIDATE: assert a[0] == I64 and b[0] == I64
                res = (I32, a[1] != b[1], 0.0)
            elif 0x53 == opcode: # i64.lt_s
                if VALIDATE: assert a[0] == I64 and b[0] == I64
                res = (I32, int2int64(a[1]) < int2int64(b[1]), 0.0)
            elif 0x54 == opcode: # i64.lt_u
                if VALIDATE: assert a[0] == I64 and b[0] == I64
                res = (I32, int2uint64(a[1]) < int2uint64(b[1]), 0.0)
            elif 0x55 == opcode: # i64.gt_s
                if VALIDATE: assert a[0] == I64 and b[0] == I64
                res = (I32, int2int64(a[1]) > int2int64(b[1]), 0.0)
            elif 0x56 == opcode: # i64.gt_u
                if VALIDATE: assert a[0] == I64 and b[0] == I64
                res = (I32, int2uint64(a[1]) > int2uint64(b[1]), 0.0)
            elif 0x57 == opcode: # i64.le_s
                if VALIDATE: assert a[0] == I64 and b[0] == I64
                res = (I32, int2int64(a[1]) <= int2int64(b[1]), 0.0)
            elif 0x58 == opcode: # i64.le_u
                if VALIDATE: assert a[0] == I64 and b[0] == I64
                res = (I32, int2uint64(a[1]) <= int2uint64(b[1]), 0.0)
            elif 0x59 == opcode: # i64.ge_s
                if VALIDATE: assert a[0] == I64 and b[0] == I64
                res = (I32, int2int64(a[1]) >= int2int64(b[1]), 0.0)
            elif 0x5a == opcode: # i64.ge_u
                if VALIDATE: assert a[0] == I64 and b[0] == I64
                res = (I32, int2uint64(a[1]) >= int2uint64(b[1]), 0.0)
            elif 0x5b == opcode: # f32.eq
                if VALIDATE: assert a[0] == F32 and b[0] == F32
                res = (I32, a[2] == b[2], 0.0)
            elif 0x5c == opcode: # f32.ne
                if VALIDATE: assert a[0] == F32 and b[0] == F32
                res = (I32, a[2] != b[2], 0.0)
            elif 0x5d == opcode: # f32.lt
                if VALIDATE: assert a[0] == F32 and b[0] == F32
                res = (I32, a[2] < b[2], 0.0)
            elif 0x5e == opcode: # f32.gt
                if VALIDATE: assert a[0] == F32 and b[0] == F32
                res = (I32, a[2] > b[2], 0.0)
            elif 0x5f == opcode: # f32.le
                if VALIDATE: assert a[0] == F32 and b[0] == F32
                res = (I32, a[2] <= b[2], 0.0)
            elif 0x60 == opcode: # f32.ge
                if VALIDATE: assert a[0] == F32 and b[0] == F32
                res = (I32, a[2] >= b[2], 0.0)
            elif 0x61 == opcode: # f64.eq
                if VALIDATE: assert a[0] == F64 and b[0] == F64
                res = (I32, a[2] == b[2], 0.0)
            elif 0x62 == opcode: # f64.ne
                if VALIDATE: assert a[0] == F64 and b[0] == F64
                res = (I32, a[2] != b[2], 0.0)
            elif 0x63 == opcode: # f64.lt
                if VALIDATE: assert a[0] == F64 and b[0] == F64
                res = (I32, a[2] < b[2], 0.0)
            elif 0x64 == opcode: # f64.gt
                if VALIDATE: assert a[0] == F64 and b[0] == F64
                res = (I32, a[2] > b[2], 0.0)
            elif 0x65 == opcode: # f64.le
                if VALIDATE: assert a[0] == F64 and b[0] == F64
                res = (I32, a[2] <= b[2], 0.0)
            elif 0x66 == opcode: # f64.ge
                if VALIDATE: assert a[0] == F64 and b[0] == F64
                res = (I32, a[2] >= b[2], 0.0)
            else:
                raise WAException("%s(0x%x) unimplemented" % (
                    OPERATOR_INFO[opcode][0], opcode))
            if TRACE:
                debug("      - (%s, %s) = %s" % (
                    value_repr(a), value_repr(b), value_repr(res)))
            sp += 1
            stack[sp] = res

        #
        # Numeric operators
        #

        # unary
        elif opcode in [0x67, 0x68, 0x69, 0x79, 0x7a, 0x7b, 0x8b,
                        0x8c, 0x8d, 0x8e, 0x8f, 0x90, 0x91, 0x99,
                        0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f]:
            a = stack[sp]
            sp -= 1
            if   0x67 == opcode: # i32.clz
                if VALIDATE: assert a[0] == I32
                count = 0
                val = a[1]
                while count < 32 and (val & 0x80000000) == 0:
                    count += 1
                    val = val * 2
                res = (I32, count, 0.0)
            elif 0x68 == opcode: # i32.ctz
                if VALIDATE: assert a[0] == I32
                count = 0
                val = a[1]
                while count < 32 and (val % 2) == 0:
                    count += 1
                    val = val / 2
                res = (I32, count, 0.0)
            elif 0x69 == opcode: # i32.popcnt
                if VALIDATE: assert a[0] == I32
                count = 0
                val = a[1]
                for i in range(32):
                    if 0x1 & val:
                        count += 1
                    val = val / 2
                res = (I32, count, 0.0)
            elif 0x79 == opcode: # i64.clz
                if VALIDATE: assert a[0] == I64
                val = a[1]
                if val < 0:
                    res = (I64, 0, 0.0)
                else:
                    count = 1
                    while count < 64 and (val & 0x4000000000000000) == 0:
                        count += 1
                        val = val * 2
                    res = (I64, count, 0.0)
            elif 0x7a == opcode: # i64.ctz
                if VALIDATE: assert a[0] == I64
                count = 0
                val = a[1]
                while count < 64 and (val % 2) == 0:
                    count += 1
                    val = val / 2
                res = (I64, count, 0.0)
            elif 0x7b == opcode: # i64.popcnt
                if VALIDATE: assert a[0] == I64
                count = 0
                val = a[1]
                for i in range(64):
                    if 0x1 & val:
                        count += 1
                    val = val / 2
                res = (I64, count, 0.0)
            elif 0x8b == opcode: # f32.abs
                if VALIDATE: assert a[0] == F32
                res = (F32, 0, abs(a[2]))
            elif 0x8c == opcode: # f32.neg
                if VALIDATE: assert a[0] == F32
                res = (F32, 0, -a[2])
            elif 0x8d == opcode: # f32.ceil
                if VALIDATE: assert a[0] == F32
                res = (F32, 0, math.ceil(a[2]))
            elif 0x8e == opcode: # f32.floor
                if VALIDATE: assert a[0] == F32
                res = (F32, 0, math.floor(a[2]))
            elif 0x8f == opcode: # f32.trunc
                if VALIDATE: assert a[0] == F32
                if math.isinf(a[2]):
                    res = (F32, 0, a[2])
                elif a[2] > 0:
                    res = (F32, 0, math.floor(a[2]))
                else:
                    res = (F32, 0, math.ceil(a[2]))
            elif 0x90 == opcode: # f32.nearest
                if VALIDATE: assert a[0] == F32
                if a[2] <= 0.0:
                    res = (F32, 0, math.ceil(a[2]))
                else:
                    res = (F32, 0, math.floor(a[2]))
            elif 0x91 == opcode: # f32.sqrt
                if VALIDATE: assert a[0] == F32
                res = (F32, 0, math.sqrt(a[2]))
            elif 0x99 == opcode: # f64.abs
                if VALIDATE: assert a[0] == F64
                res = (F64, 0, abs(a[2]))
            elif  0x9a == opcode: # f64.neg
                if VALIDATE: assert a[0] == F64
                res = (F64, 0, -a[2])
            elif 0x9b == opcode: # f64.ceil
                if VALIDATE: assert a[0] == F64
                res = (F64, 0, math.ceil(a[2]))
            elif 0x9c == opcode: # f64.floor
                if VALIDATE: assert a[0] == F64
                res = (F64, 0, math.floor(a[2]))
            elif 0x9d == opcode: # f64.trunc
                if VALIDATE: assert a[0] == F64
                if math.isinf(a[2]):
                    res = (F64, 0, a[2])
                elif a[2] > 0:
                    res = (F64, 0, math.floor(a[2]))
                else:
                    res = (F64, 0, math.ceil(a[2]))
            elif 0x9e == opcode: # f64.nearest
                if VALIDATE: assert a[0] == F64
                if a[2] <= 0.0:
                    res = (F64, 0, math.ceil(a[2]))
                else:
                    res = (F64, 0, math.floor(a[2]))
            elif  0x9f == opcode: # f64.sqrt
                if VALIDATE: assert a[0] == F64
                res = (F64, 0, math.sqrt(a[2]))
            else:
                raise WAException("%s(0x%x) unimplemented" % (
                    OPERATOR_INFO[opcode][0], opcode))
            if TRACE:
                debug("      - (%s) = %s" % (
                    value_repr(a), value_repr(res)))
            sp += 1
            stack[sp] = res

        # i32 binary
        elif 0x6a <= opcode <= 0x78:
            a, b = stack[sp-1], stack[sp]
            sp -= 2
            if VALIDATE: assert a[0] == I32 and b[0] == I32
            if   0x6a == opcode: # i32.add
                res = (I32, int2int32(a[1] + b[1]), 0.0)
            elif 0x6b == opcode: # i32.sub
                res = (I32, a[1] - b[1], 0.0)
            elif 0x6c == opcode: # i32.mul
                res = (I32, int2int32(a[1] * b[1]), 0.0)
            elif 0x6d == opcode: # i32.div_s
                if b[1] == 0:
                    raise WAException("integer divide by zero")
                elif a[1] == 0x80000000 and b[1] == -1:
                    raise WAException("integer overflow")
                else:
                    res = (I32, idiv_s(int2int32(a[1]), int2int32(b[1])), 0.0)
            elif 0x6e == opcode: # i32.div_u
                if b[1] == 0:
                    raise WAException("integer divide by zero")
                else:
                    res = (I32, int2uint32(a[1]) / int2uint32(b[1]), 0.0)
            elif 0x6f == opcode: # i32.rem_s
                if b[1] == 0:
                    raise WAException("integer divide by zero")
                else:
                    res = (I32, irem_s(int2int32(a[1]), int2int32(b[1])), 0.0)
            elif 0x70 == opcode: # i32.rem_u
                if b[1] == 0:
                    raise WAException("integer divide by zero")
                else:
                    res = (I32, int2uint32(a[1]) % int2uint32(b[1]), 0.0)
            elif 0x71 == opcode: # i32.and
                res = (I32, a[1] & b[1], 0.0)
            elif 0x72 == opcode: # i32.or
                res = (I32, a[1] | b[1], 0.0)
            elif 0x73 == opcode: # i32.xor
                res = (I32, a[1] ^ b[1], 0.0)
            elif 0x74 == opcode: # i32.shl
                res = (I32, a[1] << (b[1] % 0x20), 0.0)
            elif 0x75 == opcode: # i32.shr_s
                res = (I32, int2int32(a[1]) >> (b[1] % 0x20), 0.0)
            elif 0x76 == opcode: # i32.shr_u
                res = (I32, int2uint32(a[1]) >> (b[1] % 0x20), 0.0)
            elif 0x77 == opcode: # i32.rotl
                res = (I32, rotl32(a[1], b[1]), 0.0)
            elif 0x78 == opcode: # i32.rotr
                res = (I32, rotr32(a[1], b[1]), 0.0)
            else:
                raise WAException("%s(0x%x) unimplemented" % (
                    OPERATOR_INFO[opcode][0], opcode))
            if TRACE:
                debug("      - (%s, %s) = %s" % (
                    value_repr(a), value_repr(b), value_repr(res)))
            sp += 1
            stack[sp] = res

        # i64 binary
        elif 0x7c <= opcode <= 0x8a:
            a, b = stack[sp-1], stack[sp]
            sp -= 2
            if VALIDATE: assert a[0] == I64 and b[0] == I64
            if   0x7c == opcode: # i64.add
                res = (I64, int2int64(a[1] + b[1]), 0.0)
            elif 0x7d == opcode: # i64.sub
                res = (I64, a[1] - b[1], 0.0)
            elif 0x7e == opcode: # i64.mul
                res = (I64, int2int64(a[1] * b[1]), 0.0)
            elif 0x7f == opcode: # i64.div_s
                if b[1] == 0:
                    raise WAException("integer divide by zero")
#                elif a[1] == 0x8000000000000000 and b[1] == -1:
#                    raise WAException("integer overflow")
                else:
                    res = (I64, idiv_s(int2int64(a[1]), int2int64(b[1])), 0.0)
            elif 0x80 == opcode: # i64.div_u
                if b[1] == 0:
                    raise WAException("integer divide by zero")
                else:
                    if a[1] < 0 and b[1] > 0:
                        res = (I64, int2uint64(-a[1]) / int2uint64(b[1]), 0.0)
                    elif a[1] > 0 and b[1] < 0:
                        res = (I64, int2uint64(a[1]) / int2uint64(-b[1]), 0.0)
                    else:
                        res = (I64, int2uint64(a[1]) / int2uint64(b[1]), 0.0)
            elif 0x81 == opcode: # i64.rem_s
                if b[1] == 0:
                    raise WAException("integer divide by zero")
                else:
                    res = (I64, irem_s(int2int64(a[1]), int2int64(b[1])), 0.0)
            elif 0x82 == opcode: # i64.rem_u
                if b[1] == 0:
                    raise WAException("integer divide by zero")
                else:
                    res = (I64, int2uint64(a[1]) % int2uint64(b[1]), 0.0)
            elif 0x83 == opcode: # i64.and
                res = (I64, a[1] & b[1], 0.0)
            elif 0x84 == opcode: # i64.or
                res = (I64, a[1] | b[1], 0.0)
            elif 0x85 == opcode: # i64.xor
                res = (I64, a[1] ^ b[1], 0.0)
            elif 0x86 == opcode: # i64.shl
                res = (I64, a[1] << (b[1] % 0x40), 0.0)
            elif 0x87 == opcode: # i64.shr_s
                res = (I64, int2int64(a[1]) >> (b[1] % 0x40), 0.0)
            elif 0x88 == opcode: # i64.shr_u
                res = (I64, int2uint64(a[1]) >> (b[1] % 0x40), 0.0)
#            elif 0x89 == opcode: # i64.rotl
#                res = (I64, rotl64(a[1], b[1]), 0.0)
#            elif 0x8a == opcode: # i64.rotr
#                res = (I64, rotr64(a[1], b[1]), 0.0)
            else:
                raise WAException("%s(0x%x) unimplemented" % (
                    OPERATOR_INFO[opcode][0], opcode))
            if TRACE:
                debug("      - (%s, %s) = %s" % (
                    value_repr(a), value_repr(b), value_repr(res)))
            sp += 1
            stack[sp] = res

        # f32 binary operations
        elif 0x92 <= opcode <= 0x98:
            a, b = stack[sp-1], stack[sp]
            sp -= 2
            if VALIDATE: assert a[0] == F32 and b[0] == F32
            if   0x92 == opcode: # f32.add
                res = (F32, 0, a[2] + b[2])
            elif 0x93 == opcode: # f32.sub
                res = (F32, 0, a[2] - b[2])
            elif 0x94 == opcode: # f32.mul
                res = (F32, 0, a[2] * b[2])
            elif 0x95 == opcode: # f32.div
                res = (F32, 0, a[2] / b[2])
            elif 0x96 == opcode: # f32.min
                if a[2] < b[2]:
                    res = (F32, 0, a[2])
                else:
                    res = (F32, 0, b[2])
            elif 0x97 == opcode: # f32.max
                if a[2] == b[2] == 0.0:
                    res = (F32, 0, 0.0)
                elif a[2] > b[2]:
                    res = (F32, 0, a[2])
                else:
                    res = (F32, 0, b[2])
            elif 0x98 == opcode: # f32.copysign
                if b[2] > 0:
                    res = (F32, 0, abs(a[2]))
                else:
                    res = (F32, 0, -abs(a[2]))
            else:
                raise WAException("%s(0x%x) unimplemented" % (
                    OPERATOR_INFO[opcode][0], opcode))
            if TRACE:
                debug("      - (%s, %s) = %s" % (
                    value_repr(a), value_repr(b), value_repr(res)))
            sp += 1
            stack[sp] = res

        # f64 binary operations
        elif 0xa0 <= opcode <= 0xa6:
            a, b = stack[sp-1], stack[sp]
            sp -= 2
            if VALIDATE: assert a[0] == F64 and b[0] == F64
            if   0xa0 == opcode: # f64.add
                res = (F64, 0, a[2] + b[2])
            elif 0xa1 == opcode: # f64.sub
                res = (F64, 0, a[2] - b[2])
            elif 0xa2 == opcode: # f64.mul
                res = (F64, 0, a[2] * b[2])
            elif 0xa3 == opcode: # f64.div
                if b[2] == 0.0:
                    aneg = str(a[2])[0] == '-'
                    bneg = str(b[2])[0] == '-'
                    if (aneg and not bneg) or (not aneg and bneg):
                        res = (F64, 0, float_fromhex('-inf'))
                    else:
                        res = (F64, 0, float_fromhex('inf'))
                else:
                    res = (F64, 0, a[2] / b[2])
            elif 0xa4 == opcode: # f64.min
                if a[2] < b[2]:
                    res = (F64, 0, a[2])
# Adding the 0.0 checks causes this error during compilation:
#   File "/opt/pypy/rpython/jit/codewriter/assembler.py", line 230, in check_result
#       assert self.count_regs['int'] + len(self.constants_i) <= 256

#                elif b[2] == 0.0:
#                    if str(a[2])[0] == '-':
#                        res = (F64, 0, a[2])
#                    else:
#                        res = (F64, 0, b[2])
                else:
                    res = (F64, 0, b[2])
            elif 0xa5 == opcode: # f64.max
                if a[2] > b[2]:
                    res = (F64, 0, a[2])
#                elif b[2] == 0.0:
#                    if str(a[2])[0] == '-':
#                        res = (F64, 0, b[2])
#                    else:
#                        res = (F64, 0, a[2])
                else:
                    res = (F64, 0, b[2])
            elif 0xa6 == opcode: # f64.copysign
                if b[2] > 0:
                    res = (F64, 0, abs(a[2]))
                else:
                    res = (F64, 0, -abs(a[2]))
            else:
                raise WAException("%s(0x%x) unimplemented" % (
                    OPERATOR_INFO[opcode][0], opcode))
            if TRACE:
                debug("      - (%s, %s) = %s" % (
                    value_repr(a), value_repr(b), value_repr(res)))
            sp += 1
            stack[sp] = res

        ## conversion operations
        elif 0xa7 <= opcode <= 0xbb:
            a = stack[sp]
            sp -= 1

            # conversion operations
            if   0xa7 == opcode: # i32.wrap/i64
                if VALIDATE: assert a[0] == I64
                res = (I32, int2int32(a[1]), 0.0)
            elif 0xa8 == opcode: # i32.trunc_s/f32
                if VALIDATE: assert a[0] == F32
                if math.isnan(a[2]):
                    raise WAException("invalid conversion to integer")
                elif a[2] > 2147483647.0:
                    raise WAException("integer overflow")
                elif a[2] < -2147483648.0:
                    raise WAException("integer overflow")
                res = (I32, int(a[2]), 0.0)
#            elif 0xa9 == opcode: # i32.trunc_u/f32
#                if VALIDATE: assert a[0] == F32
#                if math.isnan(a[2]):
#                    raise WAException("invalid conversion to integer")
#                elif a[2] > 4294967295.0:
#                    raise WAException("integer overflow")
#                elif a[2] <= -1.0:
#                    raise WAException("integer overflow")
#                res = (I32, int(a[2]), 0.0)
#            elif 0xaa == opcode: # i32.trunc_s/f64
#                if VALIDATE: assert a[0] == F64
#                if math.isnan(a[2]):
#                    raise WAException("invalid conversion to integer")
#                elif a[2] > 2**31-1:
#                    raise WAException("integer overflow")
#                elif a[2] < -2**31:
#                    raise WAException("integer overflow")
#                res = (I32, int(a[2]), 0.0)
#            elif 0xab == opcode: # i32.trunc_u/f64
#                if VALIDATE: assert a[0] == F64
#                debug("*** a[2]: %s" % a[2])
#                if math.isnan(a[2]):
#                    raise WAException("invalid conversion to integer")
#                elif a[2] > 2**32-1:
#                    raise WAException("integer overflow")
#                elif a[2] <= -1.0:
#                    raise WAException("integer overflow")
#                res = (I32, int(a[2]), 0.0)
            elif 0xac == opcode: # i64.extend_s/i32
                if VALIDATE: assert a[0] == I32
                res = (I64, int2int32(a[1]), 0.0)
            elif 0xad == opcode: # i64.extend_u/i32
                if VALIDATE: assert a[0] == I32
                res = (I64, intmask(a[1]), 0.0)
#            elif 0xae == opcode: # i64.trunc_s/f32
#                if VALIDATE: assert a[0] == F32
#                if math.isnan(a[2]):
#                    raise WAException("invalid conversion to integer")
#                elif a[2] > 2**63-1:
#                    raise WAException("integer overflow")
#                elif a[2] < -2**63:
#                    raise WAException("integer overflow")
#                res = (I64, int(a[2]), 0.0)
#            elif 0xaf == opcode: # i64.trunc_u/f32
#                if VALIDATE: assert a[0] == F32
#                if math.isnan(a[2]):
#                    raise WAException("invalid conversion to integer")
#                elif a[2] > 2**63-1:
#                    raise WAException("integer overflow")
#                elif a[2] <= -1.0:
#                    raise WAException("integer overflow")
#                res = (I64, int(a[2]), 0.0)
            elif 0xb0 == opcode: # i64.trunc_s/f64
                if VALIDATE: assert a[0] == F64
                if math.isnan(a[2]):
                    raise WAException("invalid conversion to integer")
#                elif a[2] > 2**63-1:
#                    raise WAException("integer overflow")
#                elif a[2] < -2**63:
#                    raise WAException("integer overflow")
                res = (I64, int(a[2]), 0.0)
            elif 0xb1 == opcode: # i64.trunc_u/f64
                if VALIDATE: assert a[0] == F64
                if math.isnan(a[2]):
                    raise WAException("invalid conversion to integer")
#                elif a[2] > 2**63-1:
#                    raise WAException("integer overflow")
                elif a[2] <= -1.0:
                    raise WAException("integer overflow")
                res = (I64, int(a[2]), 0.0)
            elif 0xb2 == opcode: # f32.convert_s/i32
                if VALIDATE: assert a[0] == I32
                res = (F32, 0, float(a[1]))
            elif 0xb3 == opcode: # f32.convert_u/i32
                if VALIDATE: assert a[0] == I32
                res = (F32, 0, float(int2uint32(a[1])))
            elif 0xb4 == opcode: # f32.convert_s/i64
                if VALIDATE: assert a[0] == I64
                res = (F32, 0, float(a[1]))
            elif 0xb5 == opcode: # f32.convert_u/i64
                if VALIDATE: assert a[0] == I64
                res = (F32, 0, float(int2uint64(a[1])))
#            elif 0xb6 == opcode: # f32.demote/f64
#                if VALIDATE: assert a[0] == F64
#                res = (F32, 0, unpack_f32(pack_f32(a[2])))
            elif 0xb7 == opcode: # f64.convert_s/i32
                if VALIDATE: assert a[0] == I32
                res = (F64, 0, float(a[1]))
            elif 0xb8 == opcode: # f64.convert_u/i32
                if VALIDATE: assert a[0] == I32
                res = (F64, 0, float(int2uint32(a[1])))
            elif 0xb9 == opcode: # f64.convert_s/i64
                if VALIDATE: assert a[0] == I64
                res = (F64, 0, float(a[1]))
            elif 0xba == opcode: # f64.convert_u/i64
                if VALIDATE: assert a[0] == I64
                res = (F64, 0, float(int2uint64(a[1])))
            elif 0xbb == opcode: # f64.promote/f32
                if VALIDATE: assert a[0] == F32
                res = (F64, 0, a[2])
            else:
                raise WAException("%s(0x%x) unimplemented" % (
                    OPERATOR_INFO[opcode][0], opcode))
            if TRACE:
                debug("      - (%s) = %s" % (
                    value_repr(a), value_repr(res)))
            sp += 1
            stack[sp] = res

        ## reinterpretations
        elif 0xbc <= opcode <= 0xbf:
            a = stack[sp]
            sp -= 1

            if   0xbc == opcode: # i32.reinterpret/f32
                if VALIDATE: assert a[0] == F32
                res = (I32, intmask(pack_f32(a[2])), 0.0)
            elif 0xbd == opcode: # i64.reinterpret/f64
                if VALIDATE: assert a[0] == F64
                res = (I64, intmask(pack_f64(a[2])), 0.0)
#            elif 0xbe == opcode: # f32.reinterpret/i32
#                if VALIDATE: assert a[0] == I32
#                res = (F32, 0, unpack_f32(int2int32(a[1])))
            elif 0xbf == opcode: # f64.reinterpret/i64
                if VALIDATE: assert a[0] == I64
                res = (F64, 0, unpack_f64(int2int64(a[1])))
            else:
                raise WAException("%s(0x%x) unimplemented" % (
                    OPERATOR_INFO[opcode][0], opcode))
            if TRACE:
                debug("      - (%s) = %s" % (
                    value_repr(a), value_repr(res)))
            sp += 1
            stack[sp] = res

        else:
            raise WAException("unrecognized opcode 0x%x" % opcode)

    return pc, sp, fp, csp


######################################
# Higher level classes
######################################

class Reader():
    def __init__(self, bytes):
        self.bytes = bytes
        self.pos = 0

    def read_byte(self):
        b = self.bytes[self.pos]
        self.pos += 1
        return b

    def read_word(self):
        w = bytes2uint32(self.bytes[self.pos:self.pos+4])
        self.pos += 4
        return w

    def read_bytes(self, cnt):
        if VALIDATE: assert cnt >= 0
        if VALIDATE: assert self.pos >= 0
        bytes = self.bytes[self.pos:self.pos+cnt]
        self.pos += cnt
        return bytes

    def read_LEB(self, maxbits=32, signed=False):
        [self.pos, result] = read_LEB(self.bytes, self.pos,
                maxbits, signed)
        return result

    def eof(self):
        return self.pos >= len(self.bytes)

class Memory():
    def __init__(self, pages=1, bytes=[]):
        debug("memory pages: %d" % pages)
        self.pages = pages
        self.bytes = bytes + ([0]*((pages*(2**16))-len(bytes)))
        #self.bytes = [0]*(pages*(2**16))

    def grow(self, pages):
        self.pages += int(pages)
        self.bytes = self.bytes + ([0]*(int(pages)*(2**16)))

    def read_byte(self, pos):
        b = self.bytes[pos]
        return b

    def write_byte(self, pos, val):
        self.bytes[pos] = val


class Import():
    def __init__(self, module, field, kind, type=0,
            element_type=0, initial=0, maximum=0, global_type=0,
            mutability=0):
        self.module = module
        self.field = field
        self.kind = kind
        self.type = type # Function
        self.element_type = element_type # Table
        self.initial = initial # Table & Memory
        self.maximum = maximum # Table & Memory

        self.global_type = global_type # Global
        self.mutability = mutability # Global

class Export():
    def __init__(self, field, kind, index):
        self.field = field
        self.kind = kind
        self.index = index


class Module():
    def __init__(self, data, import_value, import_function, memory=None):
        assert isinstance(data, str)
        self.data = data
        self.rdr = Reader([ord(b) for b in data])
        self.import_value = import_value
        self.import_function = import_function

        # Sections
        self.type = []
        self.import_list = []
        self.function = []
        self.fn_import_cnt = 0
        self.table = {ANYFUNC: []}
        self.export_list = []
        self.export_map = {}
        self.global_list = []

        if memory:
            self.memory = memory
        else:
            self.memory = Memory(1)  # default to 1 page

        # block/loop/if blocks {start addr: Block, ...}
        self.block_map = {}

        # Execution state
        self.sp = -1
        self.fp = -1
        self.stack = [(0x00, 0, 0.0)] * STACK_SIZE
        self.csp = -1
        block = Block(0x00, BLOCK_TYPE[I32], 0)
        self.callstack = [(block, -1, -1, 0)] * CALLSTACK_SIZE
        self.start_function = -1

        self.read_magic()
        self.read_version()
        self.read_sections()

        self.dump()

        # Run the start function if set
        if self.start_function >= 0:
            fidx = self.start_function
            func = self.function[fidx]
            info("Running start function 0x%x" % fidx)
            if TRACE:
                dump_stacks(self.sp, self.stack, self.fp, self.csp,
                        self.callstack)
            if isinstance(func, FunctionImport):
                sp = do_call_import(self.stack, self.sp, self.memory,
                        self.import_function, func)
            elif isinstance(func, Function):
                self.rdr.pos, self.sp, self.fp, self.csp = do_call(
                        self.stack, self.callstack, self.sp, self.fp,
                        self.csp, func, len(self.rdr.bytes))
            self.interpret()

    def dump(self):
        #debug("raw module data: %s" % self.data)
        debug("module bytes: %s" % byte_code_repr(self.rdr.bytes))
        info("")

        info("Types:")
        for i, t in enumerate(self.type):
            info("  0x%x %s" % (i, type_repr(t)))

        info("Imports:")
        for i, imp in enumerate(self.import_list):
            if imp.kind == 0x0:  # Function
                info("  0x%x [type: %d, '%s.%s', kind: %s (%d)]" % (
                    i, imp.type, imp.module, imp.field,
                    EXTERNAL_KIND_NAMES[imp.kind], imp.kind))
            elif imp.kind in [0x1,0x2]:  # Table & Memory
                info("  0x%x ['%s.%s', kind: %s (%d), initial: %d, maximum: %d]" % (
                    i, imp.module, imp.field,
                    EXTERNAL_KIND_NAMES[imp.kind], imp.kind,
                    imp.initial, imp.maximum))
            elif imp.kind == 0x3:  # Global
                info("  0x%x ['%s.%s', kind: %s (%d), type: %d, mutability: %d]" % (
                    i, imp.module, imp.field,
                    EXTERNAL_KIND_NAMES[imp.kind], imp.kind,
                    imp.type, imp.mutability))

        info("Functions:")
        for i, f in enumerate(self.function):
            info("  0x%x %s" % (i, func_repr(f)))

        info("Tables:")
        for t, entries in self.table.items():
            info("  0x%x -> [%s]" % (t,",".join([hex(e) for e in entries])))

        def hexpad(x, cnt):
            s = "%x" % x
            return '0' * (cnt-len(s)) + s

        info("Memory:")
        if self.memory.pages > 0:
            for r in range(10):
                info("  0x%s [%s]" % (hexpad(r*16,3),
                    ",".join([hexpad(b,2) for b in self.memory.bytes[r*16:r*16+16]])))

        info("Global:")
        for i, g in enumerate(self.global_list):
            info("  0x%s [%s]" % (i, value_repr(g)))

        info("Exports:")
        for i, e in enumerate(self.export_list):
            info("  0x%x %s" % (i, export_repr(e)))
        info("")

        bl = self.block_map
        block_keys = bl.keys()
        do_sort(block_keys)
        info("block_map: %s" % (
            ["%s[0x%x->0x%x]" % (block_repr(bl[k]), bl[k].start, bl[k].end)
             for k in block_keys]))
        info("")


    ## Wasm top-level readers

    def read_magic(self):
        magic = self.rdr.read_word()
        if magic != MAGIC:
            raise Exception("Wanted magic 0x%x, got 0x%x" % (
                MAGIC, magic))

    def read_version(self):
        self.version = self.rdr.read_word()
        if self.version != VERSION:
            raise Exception("Wanted version 0x%x, got 0x%x" % (
                VERSION, self.version))

    def read_section(self):
        cur_pos = self.rdr.pos
        id = self.rdr.read_LEB(7)
        name = SECTION_NAMES[id]
        length = self.rdr.read_LEB(32)
        debug("parsing %s(%d), section start: 0x%x, payload start: 0x%x, length: 0x%x bytes" % (
            name, id, cur_pos, self.rdr.pos, length))
        if   "Type" == name:     self.parse_Type(length)
        elif "Import" == name:   self.parse_Import(length)
        elif "Function" == name: self.parse_Function(length)
        elif "Table" == name:    self.parse_Table(length)
        elif "Memory" == name:   self.parse_Memory(length)
        elif "Global" == name:   self.parse_Global(length)
        elif "Export" == name:   self.parse_Export(length)
        elif "Start" == name:    self.parse_Start(length)
        elif "Element" == name:  self.parse_Element(length)
        elif "Code" == name:     self.parse_Code(length)
        elif "Data" == name:     self.parse_Data(length)
        else:                    self.rdr.read_bytes(length)

    def read_sections(self):
        while not self.rdr.eof():
            self.read_section()

    ## Wasm section handlers

    def parse_Type(self, length):
        count = self.rdr.read_LEB(32)
        for c in range(count):
            form = self.rdr.read_LEB(7)
            params = []
            results = []
            param_count = self.rdr.read_LEB(32)
            for pc in range(param_count):
                params.append(self.rdr.read_LEB(32))
            result_count = self.rdr.read_LEB(32)
            for rc in range(result_count):
                results.append(self.rdr.read_LEB(32))
            tidx = len(self.type)
            t = Type(tidx, form, params, results)
            self.type.append(t)

            # calculate a unique type mask
            t.mask = 0x80
            if result_count == 1:
                t.mask |= 0x80 - results[0]
            t.mask = t.mask << 4
            for p in params:
                t.mask = t.mask << 4
                t.mask |= 0x80 - p

            debug("  parsed type: %s" % type_repr(t))


    def parse_Import(self, length):
        count = self.rdr.read_LEB(32)
        for c in range(count):
            module_len = self.rdr.read_LEB(32)
            module_bytes = self.rdr.read_bytes(module_len)
            module = "".join([chr(f) for f in module_bytes])

            field_len = self.rdr.read_LEB(32)
            field_bytes = self.rdr.read_bytes(field_len)
            field = "".join([chr(f) for f in field_bytes])

            kind = self.rdr.read_byte()

            if kind == 0x0:  # Function
                type_index = self.rdr.read_LEB(32)
                type = self.type[type_index]
                imp = Import(module, field, kind, type=type_index)
                self.import_list.append(imp)
                func = FunctionImport(type, module, field)
                self.function.append(func)
                self.fn_import_cnt += 1
            elif kind in [0x1,0x2]:  # Table & Memory
                if kind == 0x1:
                    etype = self.rdr.read_LEB(7) # TODO: ignore?
                flags = self.rdr.read_LEB(32)
                initial = self.rdr.read_LEB(32)
                if flags & 0x1:
                    maximum = self.rdr.read_LEB(32)
                else:
                    maximum = 0
                self.import_list.append(Import(module, field, kind,
                    initial=initial, maximum=maximum))
            elif kind == 0x3:  # Global
                type = self.rdr.read_byte()
                mutability = self.rdr.read_LEB(1)
                self.global_list.append(self.import_value(module, field))

    def parse_Function(self, length):
        count = self.rdr.read_LEB(32)
        for c in range(count):
            type = self.type[self.rdr.read_LEB(32)]
            idx = len(self.function)
            self.function.append(Function(type, idx))

    def parse_Table(self, length):
        count = self.rdr.read_LEB(32)
        assert count == 1

        initial = 1
        for c in range(count):
            type = self.rdr.read_LEB(7)
            assert type == ANYFUNC
            flags = self.rdr.read_LEB(1) # TODO: fix for MVP
            initial = self.rdr.read_LEB(32) # TODO: fix for MVP
            if flags & 0x1:
                maximum = self.rdr.read_LEB(32)
            else:
                maximum = initial

            self.table[type] = [0] * initial

    def parse_Memory(self, length):
        count = self.rdr.read_LEB(32)
        assert count <= 1  # MVP
        flags = self.rdr.read_LEB(32)  # TODO: fix for MVP
        initial = self.rdr.read_LEB(32)
        if flags & 0x1:
            maximum = self.rdr.read_LEB(32)
        else:
            maximum = 0
        self.memory = Memory(initial)

    def parse_Global(self, length):
        count = self.rdr.read_LEB(32)
        for c in range(count):
            content_type = self.rdr.read_LEB(7)
            mutable = self.rdr.read_LEB(1)
#            print("global: content_type: %s, BLOCK_TYPE: %s, mutable: %s"
#                    % (VALUE_TYPE[content_type],
#                        type_repr(BLOCK_TYPE[content_type]),
#                        mutable))
            # Run the init_expr
            block = Block(0x00, BLOCK_TYPE[content_type], self.rdr.pos)
            self.csp += 1
            self.callstack[self.csp] = (block, self.sp, self.fp, 0)
            # WARNING: running code here to get offset!
            self.interpret()  # run iter_expr
            init_val = self.stack[self.sp]
#            print("init_val: %s" % value_repr(init_val))
            self.sp -= 1
            assert content_type == init_val[0]
            self.global_list.append(init_val)

    def parse_Export(self, length):
        count = self.rdr.read_LEB(32)
        for c in range(count):
            field_len = self.rdr.read_LEB(32)
            field_bytes = self.rdr.read_bytes(field_len)
            field = "".join([chr(f) for f in field_bytes])
            kind = self.rdr.read_byte()
            index = self.rdr.read_LEB(32)
            exp = Export(field, kind, index)
            self.export_list.append(exp)
            debug("  parsed export: %s" % export_repr(exp))
            self.export_map[field] = exp

    def parse_Start(self, length):
        fidx = self.rdr.read_LEB(32)
        self.start_function = fidx

    def parse_Element(self, length):
        start = self.rdr.pos
        count = self.rdr.read_LEB(32)

        for c in range(count):
            index = self.rdr.read_LEB(32)
            assert index == 0  # Only 1 default table in MVP

            # Run the init_expr
            block = Block(0x00, BLOCK_TYPE[I32], self.rdr.pos)
            self.csp += 1
            self.callstack[self.csp] = (block, self.sp, self.fp, 0)
            # WARNING: running code here to get offset!
            self.interpret()  # run iter_expr
            offset_val = self.stack[self.sp]
            self.sp -= 1
            assert offset_val[0] == I32
            offset = int(offset_val[1])

            num_elem = self.rdr.read_LEB(32)
            self.table[ANYFUNC] = [0] * (offset + num_elem)
            table = self.table[ANYFUNC]
            for n in range(num_elem):
                fidx = self.rdr.read_LEB(32)
                table[offset+n] = fidx

        assert self.rdr.pos == start+length

    def parse_Code_body(self, idx):
        body_size = self.rdr.read_LEB(32)
        payload_start = self.rdr.pos
        #debug("body_size %d" % body_size)
        local_count = self.rdr.read_LEB(32)
        #debug("local_count %d" % local_count)
        locals = []
        for l in range(local_count):
            count = self.rdr.read_LEB(32)
            type = self.rdr.read_LEB(7)
            for c in range(count):
                locals.append(type)
        # TODO: simplify this calculation and find_blocks
        start = self.rdr.pos
        self.rdr.read_bytes(body_size - (self.rdr.pos-payload_start)-1)
        end = self.rdr.pos
        debug("  find_blocks idx: %d, start: 0x%x, end: 0x%x" % (idx, start, end))
        self.rdr.read_bytes(1)
        func = self.function[idx]
        assert isinstance(func,Function)
        func.update(locals, start, end)
        self.block_map = find_blocks(
                self.rdr.bytes, start, end, self.block_map)

    def parse_Code(self, length):
        body_count = self.rdr.read_LEB(32)
        for idx in range(body_count):
            self.parse_Code_body(idx + self.fn_import_cnt)

    def parse_Data(self, length):
        seg_count = self.rdr.read_LEB(32)
        for seg in range(seg_count):
            index = self.rdr.read_LEB(32)
            assert index == 0  # Only 1 default memory in MVP

            # Run the init_expr
            block = Block(0x00, BLOCK_TYPE[I32], self.rdr.pos)
            self.csp += 1
            self.callstack[self.csp] = (block, self.sp, self.fp, 0)
            # WARNING: running code here to get offset!
            self.interpret()  # run iter_expr
            offset_val = self.stack[self.sp]
            self.sp -= 1
            assert offset_val[0] == I32
            offset = int(offset_val[1])

            size = self.rdr.read_LEB(32)
            for addr in range(offset, offset+size, 1):
                self.memory.bytes[addr] = self.rdr.read_byte()

    def interpret(self):
        self.rdr.pos, self.sp, self.fp, self.csp = interpret_mvp(self,
                # Greens
                self.rdr.pos, self.rdr.bytes, self.function,
                self.table, self.block_map,
                # Reds
                self.memory, self.sp, self.stack, self.fp, self.csp,
                self.callstack)


    def run(self, fname, args, print_return=False):
        # Reset stacks
        self.sp  = -1
        self.fp  = -1
        self.csp = -1

        fidx = self.export_map[fname].index

        # Check arg type
        tparams = self.function[fidx].type.params
        for idx, arg in enumerate(args):
            assert tparams[idx] == arg[0], "arg type mismatch %s != %s" % (tparams[idx], arg[0])
            self.sp += 1
            self.stack[self.sp] = arg

        info("Running function '%s' (0x%x)" % (fname, fidx))
        if TRACE:
            dump_stacks(self.sp, self.stack, self.fp, self.csp,
                    self.callstack)
        self.rdr.pos, self.sp, self.fp, self.csp = do_call(
                self.stack, self.callstack, self.sp, self.fp,
                self.csp, self.function[fidx], 0)

        self.interpret()
        if TRACE:
            dump_stacks(self.sp, self.stack, self.fp, self.csp,
                    self.callstack)

        targs = [value_repr(a) for a in args]
        if self.sp >= 0:
            ret = self.stack[self.sp]
            self.sp -= 1
            info("%s(%s) = %s" % (fname, ", ".join(targs), value_repr(ret)))
            if print_return:
                print(value_repr(ret))
        else:
            info("%s(%s)" % (fname, ", ".join(targs)))
        return 0

######################################
# Imported functions points
######################################


def readline(prompt):
    res = ''
    os.write(1, prompt)
    while True:
        buf = os.read(0, 255)
        if not buf: raise EOFError()
        res += buf
        if res[-1] == '\n': return res[:-1]

def get_string(mem, addr):
    slen = 0
    assert addr >= 0
    while mem.bytes[addr+slen] != 0: slen += 1
    #slen = mem.bytes.index(0, addr) - addr
    bytes = mem.bytes[addr:addr+slen]
    return "".join([chr(b) for b in bytes])

def put_string(mem, addr, str):
    pos = addr
    for i in range(len(str)):
        mem.bytes[pos] = ord(str[i])
        pos += 1
    mem.bytes[pos] = 0 # zero terminated
    return pos

#
# Imports (global values and functions)

IMPORT_VALUES = {
    "spectest.global_i32": (I32, 666, 666.6),
    "env.memoryBase":      (I32, 0, 0.0),
    "env.stdout":          (I32, 0, 0.0)
}

def import_value(module, field):
    iname = "%s.%s" % (module, field)
    #return (I32, 377, 0.0)
    if iname in IMPORT_VALUES:
        return IMPORT_VALUES[iname]
    else:
        raise Exception("global import %s not found" % (iname))

def spectest_print(mem, args):
    if len(args) == 0: return []
    assert len(args) == 1
    assert args[0][0] == I32
    val = args[0][1]
    res = ""
    while val > 0:
        res = res + chr(val & 0xff)
        val = val>>8
    print("%s '%s'" % (value_repr(args[0]), res))
    return []

def env_fputs(mem, args):
    os.write(1, get_string(mem, args[0][1]))
    return [(I32, 1, 1.0)]

def env_readline(mem, args):
    prompt = get_string(mem, args[0][1])
    buf = args[1][1]        # I32
    max_length = args[2][1] # I32

    try:
        str = readline(prompt)
        max_length -= 1
        assert max_length >= 0
        str = str[0:max_length]
        put_string(mem, buf, str)
        return [(I32, buf, 0.0)]
    except EOFError:
        return [(I32, 0, 0.0)]

def env_read_file(mem, args):
    path = get_string(mem, args[0][1])
    buf = args[1][1]
    content = open(path).read()
    slen = put_string(mem, buf, content)
    return [(I32, slen, 0.0)]


def import_function(module, field, mem, args):
    fname = "%s.%s" % (module, field)
#    return [(I32, 378, 0.0)]
    if fname in ["spectest.print", "spectest.print_i32"]:
        return spectest_print(mem, args)
    elif fname == "env.fputs":
        return env_fputs(mem, args)
    elif fname == "env.readline":
        return env_readline(mem, args)
    elif fname == "env.read_file":
        return env_read_file(mem, args)
    else:
        raise Exception("function import %s not found" % (fname))

def parse_command(module, args):
    fname = args[0]
    args = args[1:]
    run_args = []
    fidx = module.export_map[fname].index
    tparams = module.function[fidx].type.params
    for idx, arg in enumerate(args):
        arg = args[idx].lower()
        assert isinstance(arg, str)
        run_args.append(parse_number(tparams[idx], arg))
    return fname, run_args


######################################
# Entry points
######################################

def entry_point(argv):
    try:
        # Argument handling
        repl = False
        argv_mode = False
        memory_pages = 1
        fname = None
        args = []
        run_args = []
        idx = 1
        while idx < len(argv):
            arg = argv[idx]
            idx += 1
            if arg == "--repl":
                repl = True
            elif arg == "--argv":
                argv_mode = True
                memory_pages = 256
            elif arg == "--memory-pages":
                memory_pages = int(argv[idx])
                idx += 1
            elif arg == "--":
                continue
            else:
                args.append(arg)
        wasm = open(args[0]).read()
        args = args[1:]

        #

        mem = Memory(memory_pages)

        if argv_mode:
            # Convert args into C argv style array of strings and
            # store at the beginning of memory. This must be before
            # the module is initialized so that we can properly set
            # the memoryBase global before it is imported.
            fname = "_main"
            args.insert(0, argv[0])
            string_next = (len(args) + 1) * 4
            for i, arg in enumerate(args):
                slen = put_string(mem, string_next, arg)
                write_I32(mem.bytes, i*4, string_next) # zero terminated
                string_next += slen

            # Set memoryBase to next 64-bit aligned address
            string_next += (8 - (string_next % 8))
            IMPORT_VALUES['env.memoryBase'] = (I32, string_next, 0.0)

            run_args = [(I32, len(args), 0.0), (I32, 0, 0.0)]

        m = Module(wasm, import_value, import_function, mem)

        if '__post_instantiate' in m.export_map:
            m.run('__post_instantiate', [])

        if not repl:
            # Convert args to expected numeric type. This must be
            # after the module is initialized so that we know what
            # types the arguments are
            fname, run_args = parse_command(m, args)

            # Invoke one function and exit
            try:
                return m.run(fname, run_args, not argv_mode)
            except WAException as e:
                if not IS_RPYTHON:
                    os.write(2, "".join(traceback.format_exception(*sys.exc_info())))
                os.write(2, "%s\n" % e.message)
                return 1
        else:
            # Simple REPL
            while True:
                try:
                    line = readline("webassembly> ")
                    if line == "": continue

                    fname, run_args = parse_command(m, line.split(' '))
                    res = m.run(fname, run_args, True)
                    if not res == 0:
                        return res

                except WAException as e:
                    os.write(2, "Exception: %s\n" % e.message)
                except EOFError as e:
                    break

    except WAException as e:
        if IS_RPYTHON:
            llop.debug_print_traceback(lltype.Void)
            os.write(2, "Exception: %s\n" % e)
        else:
            os.write(2, "".join(traceback.format_exception(*sys.exc_info())))
            os.write(2, "Exception: %s\n" % e.message)
    except Exception as e:
        if IS_RPYTHON:
            llop.debug_print_traceback(lltype.Void)
            os.write(2, "Exception: %s\n" % e)
        else:
            os.write(2, "".join(traceback.format_exception(*sys.exc_info())))
        return 1

    return 0

# _____ Define and setup target ___
def target(*args):
    return entry_point

# Just run entry_point if not RPython compilation
if not IS_RPYTHON and __name__ == '__main__':
    sys.exit(entry_point(sys.argv))

