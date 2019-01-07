UNREACHABLE = 0x00
NOP = 0x01
BLOCK = 0x02
LOOP = 0x03
IF = 0x04
ELSE = 0x05
END = 0x0b
BR = 0x0c
BR_IF = 0x0d
BR_TABLE = 0x0e
RETURN = 0x0f

CALL = 0x10
CALL_INDIRECT = 0x11

DROP = 0x1a
SELECT = 0x1b

GET_LOCAL = 0x20
SET_LOCAL = 0x21
TEE_LOCAL = 0x22
GET_GLOBAL = 0x23
SET_GLOBAL = 0x24

I32_LOAD = 0x28
I64_LOAD = 0x29
F32_LOAD = 0x2a
F64_LOAD = 0x2b
I32_LOAD8_S = 0x2c
I32_LOAD8_U = 0x2d
I32_LOAD16_S = 0x2e
I32_LOAD16_U = 0x2f
I64_LOAD8_S = 0x30
I64_LOAD8_U = 0x31
I64_LOAD16_S = 0x32
I64_LOAD16_U = 0x33
I64_LOAD32_S = 0x34
I64_LOAD32_U = 0x35
I32_STORE = 0x36
I64_STORE = 0x37
F32_STORE = 0x38
F64_STORE = 0x39
I32_STORE8 = 0x3a
I32_STORE16 = 0x3b
I64_STORE8 = 0x3c
I64_STORE16 = 0x3d
I64_STORE32 = 0x3e
CURRENT_MEMORY = 0x3f
GROW_MEMORY = 0x40

I32_CONST = 0x41
I64_CONST = 0x42
F32_CONST = 0x43
F64_CONST = 0x44

I32_EQZ = 0x45
I32_EQ = 0x46
I32_NE = 0x47
I32_LTS = 0x48
I32_LTU = 0x49
I32_GTS = 0x4a
I32_GTU = 0x4b
I32_LES = 0x4c
I32_LEU = 0x4d
I32_GES = 0x4e
I32_GEU = 0x4f
I64_EQZ = 0x50
I64_EQ = 0x51
I64_NE = 0x52
I64_LTS = 0x53
I64_LTU = 0x54
I64_GTS = 0x55
I64_GTU = 0x56
I64_LES = 0x57
I64_LEU = 0x58
I64_GES = 0x59
I64_GEU = 0x5a
F32_EQ = 0x5b
F32_NE = 0x5c
F32_LT = 0x5d
F32_GT = 0x5e
F32_LE = 0x5f
F32_GE = 0x60
F64_EQ = 0x61
F64_NE = 0x62
F64_LT = 0x63
F64_GT = 0x64
F64_LE = 0x65
F64_GE = 0x66

I32_CLZ = 0x67
I32_CTZ = 0x68
I32_POPCNT = 0x69
I32_ADD = 0x6a
I32_SUB = 0x6b
I32_MUL = 0x6c
I32_DIVS = 0x6d
I32_DIVU = 0x6e
I32_REMS = 0x6f
I32_REMU = 0x70
I32_AND = 0x71
I32_OR = 0x72
I32_XOR = 0x73
I32_SHL = 0x74
I32_SHRS = 0x75
I32_SHRU = 0x76
I32_ROTL = 0x77
I32_ROTR = 0x78
I64_CLZ = 0x79
I64_CTZ = 0x7a
I64_POPCNT = 0x7b
I64_ADD = 0x7c
I64_SUB = 0x7d
I64_MUL = 0x7e
I64_DIVS = 0x7f
I64_DIVU = 0x80
I64_REMS = 0x81
I64_REMU = 0x82
I64_AND = 0x83
I64_OR = 0x84
I64_XOR = 0x85
I64_SHL = 0x86
I64_SHRS = 0x87
I64_SHRU = 0x88
I64_ROTL = 0x89
I64_ROTR = 0x8a
F32_ABS = 0x8b
F32_NEG = 0x8c
F32_CEIL = 0x8d
F32_FLOOR = 0x8e
F32_TRUNC = 0x8f
F32_NEAREST = 0x90
F32_SQRT = 0x91
F32_ADD = 0x92
F32_SUB = 0x93
F32_MUL = 0x94
F32_DIV = 0x95
F32_MIN = 0x96
F32_MAX = 0x97
F32_COPYSIGN = 0x98
F64_ABS = 0x99
F64_NEG = 0x9a
F64_CEIL = 0x9b
F64_FLOOR = 0x9c
F64_TRUNC = 0x9d
F64_NEAREST = 0x9e
F64_SQRT = 0x9f
F64_ADD = 0xa0
F64_SUB = 0xa1
F64_MUL = 0xa2
F64_DIV = 0xa3
F64_MIN = 0xa4
F64_MAX = 0xa5
F64_COPYSIGN = 0xa6

I32_WRAP_I64 = 0xa7
I32_TRUNC_SF32 = 0xa8
I32_TRUNC_UF32 = 0xa9
I32_TRUNC_SF64 = 0xaa
I32_TRUNC_UF64 = 0xab
I64_EXTEND_SI32 = 0xac
I64_EXTEND_UI32 = 0xad
I64_TRUNC_SF32 = 0xae
I64_TRUNC_UF32 = 0xaf
I64_TRUNC_SF64 = 0xb0
I64_TRUNC_UF64 = 0xb1
F32_CONVERT_SI32 = 0xb2
F32_CONVERT_UI32 = 0xb3
F32_CONVERT_SI64 = 0xb4
F32_CONVERT_UI64 = 0xb5
F32_DEMOTE_F64 = 0xb6
F64_CONVERT_SI32 = 0xb7
F64_CONVERT_UI32 = 0xb8
F64_CONVERT_SI64 = 0xb9
F64_CONVERT_UI64 = 0xba
F64_PROMOTE_F32 = 0xbb

I32_REINTERPRET_F32 = 0xbc
I64_REINTERPRET_F64 = 0xbd
F32_REINTERPRET_I32 = 0xbe
F64_REINTERPRET_I64 = 0xbf

OP_INFO = {}
OP_INFO[UNREACHABLE] = ('unreachable', [], 0)
OP_INFO[NOP] = ('nop', [], 0)
OP_INFO[BLOCK] = ('block', ['leb_7'], 0)
OP_INFO[LOOP] = ('loop', ['leb_7'], 0)
OP_INFO[IF] = ('if', ['leb_7'], 0)
OP_INFO[ELSE] = ('else', [], 0)
OP_INFO[END] = ('end', [], 0)
OP_INFO[BR] = ('br', ['leb_32'], 0)
OP_INFO[BR_IF] = ('br_if', ['leb_32'], 0)
OP_INFO[BR_TABLE] = ('br_table', ['leb_32xleb_32', 'leb_32'], 0)
OP_INFO[RETURN] = ('return', [], 0)
OP_INFO[CALL] = ('call', ['leb_32'], 0)
OP_INFO[CALL_INDIRECT] = ('call_indirect', ['leb_32', 'leb_1'], 0)
OP_INFO[DROP] = ('drop', [], 0)
OP_INFO[SELECT] = ('select', [], 0)
OP_INFO[GET_LOCAL] = ('local.get', ['leb_32'], 0)
OP_INFO[SET_LOCAL] = ('local.set', ['leb_32'], 0)
OP_INFO[TEE_LOCAL] = ('local.tee', ['leb_32'], 0)
OP_INFO[GET_GLOBAL] = ('global.get', ['leb_32'], 0)
OP_INFO[SET_GLOBAL] = ('global.set', ['leb_32'], 0)
OP_INFO[I32_LOAD] = ('i32.load', ['leb_32', 'leb_32'], 4)
OP_INFO[I64_LOAD] = ('i64.load', ['leb_32', 'leb_32'], 8)
OP_INFO[F32_LOAD] = ('f32.load', ['leb_32', 'leb_32'], 4)
OP_INFO[F64_LOAD] = ('f64.load', ['leb_32', 'leb_32'], 8)
OP_INFO[I32_LOAD8_S] = ('i32.load8_s', ['leb_32', 'leb_32'], 1)
OP_INFO[I32_LOAD8_U] = ('i32.load8_u', ['leb_32', 'leb_32'], 1)
OP_INFO[I32_LOAD16_S] = ('i32.load16_s', ['leb_32', 'leb_32'], 2)
OP_INFO[I32_LOAD16_U] = ('i32.load16_u', ['leb_32', 'leb_32'], 2)
OP_INFO[I64_LOAD8_S] = ('i64.load8_s', ['leb_32', 'leb_32'], 1)
OP_INFO[I64_LOAD8_U] = ('i64.load8_u', ['leb_32', 'leb_32'], 1)
OP_INFO[I64_LOAD16_S] = ('i64.load16_s', ['leb_32', 'leb_32'], 2)
OP_INFO[I64_LOAD16_U] = ('i64.load16_u', ['leb_32', 'leb_32'], 2)
OP_INFO[I64_LOAD32_S] = ('i64.load32_s', ['leb_32', 'leb_32'], 4)
OP_INFO[I64_LOAD32_U] = ('i64.load32_u', ['leb_32', 'leb_32'], 4)
OP_INFO[I32_STORE] = ('i32.store', ['leb_32', 'leb_32'], 4)
OP_INFO[I64_STORE] = ('i64.store', ['leb_32', 'leb_32'], 8)
OP_INFO[F32_STORE] = ('f32.store', ['leb_32', 'leb_32'], 4)
OP_INFO[F64_STORE] = ('f64.store', ['leb_32', 'leb_32'], 8)
OP_INFO[I32_STORE8] = ('i32.store8', ['leb_32', 'leb_32'], 1)
OP_INFO[I32_STORE16] = ('i32.store16', ['leb_32', 'leb_32'], 2)
OP_INFO[I64_STORE8] = ('i64.store8', ['leb_32', 'leb_32'], 1)
OP_INFO[I64_STORE16] = ('i64.store16', ['leb_32', 'leb_32'], 2)
OP_INFO[I64_STORE32] = ('i64.store32', ['leb_32', 'leb_32'], 4)
OP_INFO[CURRENT_MEMORY] = ('memory.size', ['leb_1'], 0)
OP_INFO[GROW_MEMORY] = ('memory.grow', ['leb_1'], 1)
OP_INFO[I32_CONST] = ('i32.const', ['leb_32'], 2)
OP_INFO[I64_CONST] = ('i64.const', ['leb_64'], 1)
OP_INFO[F32_CONST] = ('f32.const', ['bit_32'], 2)
OP_INFO[F64_CONST] = ('f64.const', ['bit_64'], 4)
OP_INFO[I32_EQZ] = ('i32.eqz', [], 0)
OP_INFO[I32_EQ] = ('i32.eq', [], 0)
OP_INFO[I32_NE] = ('i32.ne', [], 0)
OP_INFO[I32_LTS] = ('i32.lt_s', [], 0)
OP_INFO[I32_LTU] = ('i32.lt_u', [], 0)
OP_INFO[I32_GTS] = ('i32.gt_s', [], 0)
OP_INFO[I32_GTU] = ('i32.gt_u', [], 0)
OP_INFO[I32_LES] = ('i32.le_s', [], 0)
OP_INFO[I32_LEU] = ('i32.le_u', [], 0)
OP_INFO[I32_GES] = ('i32.ge_s', [], 0)
OP_INFO[I32_GEU] = ('i32.ge_u', [], 0)
OP_INFO[I64_EQZ] = ('i64.eqz', [], 0)
OP_INFO[I64_EQ] = ('i64.eq', [], 0)
OP_INFO[I64_NE] = ('i64.ne', [], 0)
OP_INFO[I64_LTS] = ('i64.lt_s', [], 0)
OP_INFO[I64_LTU] = ('i64.lt_u', [], 0)
OP_INFO[I64_GTS] = ('i64.gt_s', [], 0)
OP_INFO[I64_GTU] = ('i64.gt_u', [], 0)
OP_INFO[I64_LES] = ('i64.le_s', [], 0)
OP_INFO[I64_LEU] = ('i64.le_u', [], 0)
OP_INFO[I64_GES] = ('i64.ge_s', [], 0)
OP_INFO[I64_GEU] = ('i64.ge_u', [], 0)
OP_INFO[F32_EQ] = ('f32.eq', [], 0)
OP_INFO[F32_NE] = ('f32.ne', [], 0)
OP_INFO[F32_LT] = ('f32.lt', [], 0)
OP_INFO[F32_GT] = ('f32.gt', [], 0)
OP_INFO[F32_LE] = ('f32.le', [], 0)
OP_INFO[F32_GE] = ('f32.ge', [], 0)
OP_INFO[F64_EQ] = ('f64.eq', [], 0)
OP_INFO[F64_NE] = ('f64.ne', [], 0)
OP_INFO[F64_LT] = ('f64.lt', [], 0)
OP_INFO[F64_GT] = ('f64.gt', [], 0)
OP_INFO[F64_LE] = ('f64.le', [], 0)
OP_INFO[F64_GE] = ('f64.ge', [], 0)
OP_INFO[I32_CLZ] = ('i32.clz', [], 0)
OP_INFO[I32_CTZ] = ('i32.ctz', [], 0)
OP_INFO[I32_POPCNT] = ('i32.popcnt', [], 0)
OP_INFO[I32_ADD] = ('i32.add', [], 0)
OP_INFO[I32_SUB] = ('i32.sub', [], 0)
OP_INFO[I32_MUL] = ('i32.mul', [], 0)
OP_INFO[I32_DIVS] = ('i32.div_s', [], 0)
OP_INFO[I32_DIVU] = ('i32.div_u', [], 0)
OP_INFO[I32_REMS] = ('i32.rem_s', [], 0)
OP_INFO[I32_REMU] = ('i32.rem_u', [], 0)
OP_INFO[I32_AND] = ('i32.and', [], 0)
OP_INFO[I32_OR] = ('i32.or', [], 0)
OP_INFO[I32_XOR] = ('i32.xor', [], 0)
OP_INFO[I32_SHL] = ('i32.shl', [], 0)
OP_INFO[I32_SHRS] = ('i32.shr_s', [], 0)
OP_INFO[I32_SHRU] = ('i32.shr_u', [], 0)
OP_INFO[I32_ROTL] = ('i32.rotl', [], 0)
OP_INFO[I32_ROTR] = ('i32.rotr', [], 0)
OP_INFO[I64_CLZ] = ('i64.clz', [], 0)
OP_INFO[I64_CTZ] = ('i64.ctz', [], 0)
OP_INFO[I64_POPCNT] = ('i64.popcnt', [], 0)
OP_INFO[I64_ADD] = ('i64.add', [], 0)
OP_INFO[I64_SUB] = ('i64.sub', [], 0)
OP_INFO[I64_MUL] = ('i64.mul', [], 0)
OP_INFO[I64_DIVS] = ('i64.div_s', [], 0)
OP_INFO[I64_DIVU] = ('i64.div_u', [], 0)
OP_INFO[I64_REMS] = ('i64.rem_s', [], 0)
OP_INFO[I64_REMU] = ('i64.rem_u', [], 0)
OP_INFO[I64_AND] = ('i64.and', [], 0)
OP_INFO[I64_OR] = ('i64.or', [], 0)
OP_INFO[I64_XOR] = ('i64.xor', [], 0)
OP_INFO[I64_SHL] = ('i64.shl', [], 0)
OP_INFO[I64_SHRS] = ('i64.shr_s', [], 0)
OP_INFO[I64_SHRU] = ('i64.shr_u', [], 0)
OP_INFO[I64_ROTL] = ('i64.rotl', [], 0)
OP_INFO[I64_ROTR] = ('i64.rotr', [], 0)
OP_INFO[F32_ABS] = ('f32.abs', [], 0)
OP_INFO[F32_NEG] = ('f32.neg', [], 0)
OP_INFO[F32_CEIL] = ('f32.ceil', [], 0)
OP_INFO[F32_FLOOR] = ('f32.floor', [], 0)
OP_INFO[F32_TRUNC] = ('f32.trunc', [], 0)
OP_INFO[F32_NEAREST] = ('f32.nearest', [], 0)
OP_INFO[F32_SQRT] = ('f32.sqrt', [], 0)
OP_INFO[F32_ADD] = ('f32.add', [], 0)
OP_INFO[F32_SUB] = ('f32.sub', [], 0)
OP_INFO[F32_MUL] = ('f32.mul', [], 0)
OP_INFO[F32_DIV] = ('f32.div', [], 0)
OP_INFO[F32_MIN] = ('f32.min', [], 0)
OP_INFO[F32_MAX] = ('f32.max', [], 0)
OP_INFO[F32_COPYSIGN] = ('f32.copysign', [], 0)
OP_INFO[F64_ABS] = ('f64.abs', [], 0)
OP_INFO[F64_NEG] = ('f64.neg', [], 0)
OP_INFO[F64_CEIL] = ('f64.ceil', [], 0)
OP_INFO[F64_FLOOR] = ('f64.floor', [], 0)
OP_INFO[F64_TRUNC] = ('f64.trunc', [], 0)
OP_INFO[F64_NEAREST] = ('f64.nearest', [], 0)
OP_INFO[F64_SQRT] = ('f64.sqrt', [], 0)
OP_INFO[F64_ADD] = ('f64.add', [], 0)
OP_INFO[F64_SUB] = ('f64.sub', [], 0)
OP_INFO[F64_MUL] = ('f64.mul', [], 0)
OP_INFO[F64_DIV] = ('f64.div', [], 0)
OP_INFO[F64_MIN] = ('f64.min', [], 0)
OP_INFO[F64_MAX] = ('f64.max', [], 0)
OP_INFO[F64_COPYSIGN] = ('f64.copysign', [], 0)
OP_INFO[I32_WRAP_I64] = ('i32.wrap_i64', [], 0)
OP_INFO[I32_TRUNC_SF32] = ('i32.trunc_f32_s', [], 0)
OP_INFO[I32_TRUNC_UF32] = ('i32.trunc_f32_u', [], 0)
OP_INFO[I32_TRUNC_SF64] = ('i32.trunc_f64_s', [], 0)
OP_INFO[I32_TRUNC_UF64] = ('i32.trunc_f64_u', [], 0)
OP_INFO[I64_EXTEND_SI32] = ('i64.extend_i32_s', [], 0)
OP_INFO[I64_EXTEND_UI32] = ('i64.extend_i32_u', [], 0)
OP_INFO[I64_TRUNC_SF32] = ('i64.trunc_f32_s', [], 0)
OP_INFO[I64_TRUNC_UF32] = ('i64.trunc_f32_u', [], 0)
OP_INFO[I64_TRUNC_SF64] = ('i64.trunc_f64_s', [], 0)
OP_INFO[I64_TRUNC_UF64] = ('i64.trunc_f64_u', [], 0)
OP_INFO[F32_CONVERT_SI32] = ('f32.convert_i32_s', [], 0)
OP_INFO[F32_CONVERT_UI32] = ('f32.convert_i32_u', [], 0)
OP_INFO[F32_CONVERT_SI64] = ('f32.convert_i64_s', [], 0)
OP_INFO[F32_CONVERT_UI64] = ('f32.convert_i64_u', [], 0)
OP_INFO[F32_DEMOTE_F64] = ('f32.demote_f64', [], 0)
OP_INFO[F64_CONVERT_SI32] = ('f64.convert_i32_s', [], 0)
OP_INFO[F64_CONVERT_UI32] = ('f64.convert_i32_u', [], 0)
OP_INFO[F64_CONVERT_SI64] = ('f64.convert_i64_s', [], 0)
OP_INFO[F64_CONVERT_UI64] = ('f64.convert_i64_u', [], 0)
OP_INFO[F64_PROMOTE_F32] = ('f64.promote_f32', [], 0)
OP_INFO[I32_REINTERPRET_F32] = ('i32.reinterpret_f32', [], 0)
OP_INFO[I64_REINTERPRET_F64] = ('i64.reinterpret.f64', [], 0)
OP_INFO[F32_REINTERPRET_I32] = ('f32.reinterpret.i32', [], 0)
OP_INFO[F64_REINTERPRET_I64] = ('f64.reinterpret.i64', [], 0)

VALUE_TYPE_I32 = 0x7f
VALUE_TYPE_I64 = 0x7e
VALUE_TYPE_F32 = 0x7d
VALUE_TYPE_F64 = 0x7c
VALUE_TYPE_FUNCREF = 0x70
VALUE_TYPE_FUNC = 0x60
VALUE_TYPE_BLOCK = 0x40

VALUE_TYPE_NAME = {}
VALUE_TYPE_NAME[VALUE_TYPE_I32] = 'VALUE_TYPE_I32'
VALUE_TYPE_NAME[VALUE_TYPE_I64] = 'VALUE_TYPE_I64'
VALUE_TYPE_NAME[VALUE_TYPE_F32] = 'VALUE_TYPE_F32'
VALUE_TYPE_NAME[VALUE_TYPE_F64] = 'VALUE_TYPE_F64'
VALUE_TYPE_NAME[VALUE_TYPE_FUNCREF] = 'VALUE_TYPE_FUNCREF'
VALUE_TYPE_NAME[VALUE_TYPE_FUNC] = 'VALUE_TYPE_FUNC'
VALUE_TYPE_NAME[VALUE_TYPE_BLOCK] = 'VALUE_TYPE_BLOCK'

EXTERNAL_FUNCTION = 0x00
EXTERNAL_TABLE = 0x01
EXTERNAL_MEMORY = 0x02
EXTERNAL_GLOBAL = 0x03

EXTERNAL_NAME = {}
EXTERNAL_NAME[EXTERNAL_FUNCTION] = 'EXTERNAL_FUNCTION'
EXTERNAL_NAME[EXTERNAL_TABLE] = 'EXTERNAL_TABLE'
EXTERNAL_NAME[EXTERNAL_MEMORY] = 'EXTERNAL_MEMORY'
EXTERNAL_NAME[EXTERNAL_GLOBAL] = 'EXTERNAL_GLOBAL'

SECTION_ID_UNKNOWN = 0
SECTION_ID_TYPE = 1
SECTION_ID_IMPORT = 2
SECTION_ID_FUNCTION = 3
SECTION_ID_TABLE = 4
SECTION_ID_MEMORY = 5
SECTION_ID_GLOBAL = 6
SECTION_ID_EXPORT = 7
SECTION_ID_START = 8
SECTION_ID_ELEMENT = 9
SECTION_ID_CODE = 10
SECTION_ID_DATA = 11

SECTION_NAME = {}
SECTION_NAME[SECTION_ID_UNKNOWN] = 'SECTION_ID_UNKNOWN'
SECTION_NAME[SECTION_ID_TYPE] = 'SECTION_ID_TYPE'
SECTION_NAME[SECTION_ID_IMPORT] = 'SECTION_ID_IMPORT'
SECTION_NAME[SECTION_ID_FUNCTION] = 'SECTION_ID_FUNCTION'
SECTION_NAME[SECTION_ID_TABLE] = 'SECTION_ID_TABLE'
SECTION_NAME[SECTION_ID_MEMORY] = 'SECTION_ID_MEMORY'
SECTION_NAME[SECTION_ID_GLOBAL] = 'SECTION_ID_GLOBAL'
SECTION_NAME[SECTION_ID_EXPORT] = 'SECTION_ID_EXPORT'
SECTION_NAME[SECTION_ID_START] = 'SECTION_ID_START'
SECTION_NAME[SECTION_ID_ELEMENT] = 'SECTION_ID_ELEMENT'
SECTION_NAME[SECTION_ID_CODE] = 'SECTION_ID_CODE'
SECTION_NAME[SECTION_ID_DATA] = 'SECTION_ID_DATA'
