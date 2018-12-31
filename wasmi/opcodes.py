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
I32_LOAD_8s = 0x2c
I32_LOAD_8u = 0x2d
I32_LOAD_16s = 0x2e
I32_LOAD_16u = 0x2f
I64_LOAD_8s = 0x30
I64_LOAD_8u = 0x31
I64_LOAD_16s = 0x32
I64_LOAD_16u = 0x33
I64_LOAD_32s = 0x34
I64_LOAD_32u = 0x35
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
OP_INFO[UNREACHABLE] = ('UNREACHABLE', [], 0)
OP_INFO[NOP] = ('NOP', [], 0)
OP_INFO[BLOCK] = ('BLOCK', [1], 0)
OP_INFO[LOOP] = ('LOOP', [1], 0)
OP_INFO[IF] = ('IF', [1], 0)
OP_INFO[ELSE] = ('ELSE', [], 0)
OP_INFO[END] = ('END', [], 0)
OP_INFO[BR] = ('BR', [32], 0)
OP_INFO[BR_IF] = ('BR_IF', [32], 0)
OP_INFO[BR_TABLE] = ('BR_TABLE', [32, 255, 32], 0)
OP_INFO[RETURN] = ('RETURN', [], 0)
OP_INFO[CALL] = ('CALL', [32], 0)
OP_INFO[CALL_INDIRECT] = ('CALL_INDIRECT', [32, 1], 0)
OP_INFO[DROP] = ('DROP', [], 0)
OP_INFO[SELECT] = ('SELECT', [], 0)
OP_INFO[GET_LOCAL] = ('GET_LOCAL', [32], 0)
OP_INFO[SET_LOCAL] = ('SET_LOCAL', [32], 0)
OP_INFO[TEE_LOCAL] = ('TEE_LOCAL', [32], 0)
OP_INFO[GET_GLOBAL] = ('GET_GLOBAL', [32], 0)
OP_INFO[SET_GLOBAL] = ('SET_GLOBAL', [32], 0)
OP_INFO[I32_LOAD] = ('I32_LOAD', [32, 32], 4)
OP_INFO[I64_LOAD] = ('I64_LOAD', [32, 32], 8)
OP_INFO[F32_LOAD] = ('F32_LOAD', [32, 32], 4)
OP_INFO[F64_LOAD] = ('F64_LOAD', [32, 32], 8)
OP_INFO[I32_LOAD_8s] = ('I32_LOAD_8s', [32, 32], 1)
OP_INFO[I32_LOAD_8u] = ('I32_LOAD_8u', [32, 32], 1)
OP_INFO[I32_LOAD_16s] = ('I32_LOAD_16s', [32, 32], 2)
OP_INFO[I32_LOAD_16u] = ('I32_LOAD_16u', [32, 32], 2)
OP_INFO[I64_LOAD_8s] = ('I64_LOAD_8s', [32, 32], 1)
OP_INFO[I64_LOAD_8u] = ('I64_LOAD_8u', [32, 32], 1)
OP_INFO[I64_LOAD_16s] = ('I64_LOAD_16s', [32, 32], 2)
OP_INFO[I64_LOAD_16u] = ('I64_LOAD_16u', [32, 32], 2)
OP_INFO[I64_LOAD_32s] = ('I64_LOAD_32s', [32, 32], 4)
OP_INFO[I64_LOAD_32u] = ('I64_LOAD_32u', [32, 32], 4)
OP_INFO[I32_STORE] = ('I32_STORE', [32, 32], 4)
OP_INFO[I64_STORE] = ('I64_STORE', [32, 32], 8)
OP_INFO[F32_STORE] = ('F32_STORE', [32, 32], 4)
OP_INFO[F64_STORE] = ('F64_STORE', [32, 32], 8)
OP_INFO[I32_STORE8] = ('I32_STORE8', [32, 32], 0)
OP_INFO[I32_STORE16] = ('I32_STORE16', [32, 32], 0)
OP_INFO[I64_STORE8] = ('I64_STORE8', [32, 32], 0)
OP_INFO[I64_STORE16] = ('I64_STORE16', [32, 32], 0)
OP_INFO[I64_STORE32] = ('I64_STORE32', [32, 32], 0)
OP_INFO[CURRENT_MEMORY] = ('CURRENT_MEMORY', [1], 0)
OP_INFO[GROW_MEMORY] = ('GROW_MEMORY', [1], 1)
OP_INFO[I32_CONST] = ('I32_CONST', [32], 2)
OP_INFO[I64_CONST] = ('I64_CONST', [64], 1)
OP_INFO[F32_CONST] = ('F32_CONST', [32], 2)
OP_INFO[F64_CONST] = ('F64_CONST', [64], 4)
OP_INFO[I32_EQZ] = ('I32_EQZ', [], 0)
OP_INFO[I32_EQ] = ('I32_EQ', [], 0)
OP_INFO[I32_NE] = ('I32_NE', [], 0)
OP_INFO[I32_LTS] = ('I32_LTS', [], 0)
OP_INFO[I32_LTU] = ('I32_LTU', [], 0)
OP_INFO[I32_GTS] = ('I32_GTS', [], 0)
OP_INFO[I32_GTU] = ('I32_GTU', [], 0)
OP_INFO[I32_LES] = ('I32_LES', [], 0)
OP_INFO[I32_LEU] = ('I32_LEU', [], 0)
OP_INFO[I32_GES] = ('I32_GES', [], 0)
OP_INFO[I32_GEU] = ('I32_GEU', [], 0)
OP_INFO[I64_EQZ] = ('I64_EQZ', [], 0)
OP_INFO[I64_EQ] = ('I64_EQ', [], 0)
OP_INFO[I64_NE] = ('I64_NE', [], 0)
OP_INFO[I64_LTS] = ('I64_LTS', [], 0)
OP_INFO[I64_LTU] = ('I64_LTU', [], 0)
OP_INFO[I64_GTS] = ('I64_GTS', [], 0)
OP_INFO[I64_GTU] = ('I64_GTU', [], 0)
OP_INFO[I64_LES] = ('I64_LES', [], 0)
OP_INFO[I64_LEU] = ('I64_LEU', [], 0)
OP_INFO[I64_GES] = ('I64_GES', [], 0)
OP_INFO[I64_GEU] = ('I64_GEU', [], 0)
OP_INFO[F32_EQ] = ('F32_EQ', [], 0)
OP_INFO[F32_NE] = ('F32_NE', [], 0)
OP_INFO[F32_LT] = ('F32_LT', [], 0)
OP_INFO[F32_GT] = ('F32_GT', [], 0)
OP_INFO[F32_LE] = ('F32_LE', [], 0)
OP_INFO[F32_GE] = ('F32_GE', [], 0)
OP_INFO[F64_EQ] = ('F64_EQ', [], 0)
OP_INFO[F64_NE] = ('F64_NE', [], 0)
OP_INFO[F64_LT] = ('F64_LT', [], 0)
OP_INFO[F64_GT] = ('F64_GT', [], 0)
OP_INFO[F64_LE] = ('F64_LE', [], 0)
OP_INFO[F64_GE] = ('F64_GE', [], 0)
OP_INFO[I32_CLZ] = ('I32_CLZ', [], 0)
OP_INFO[I32_CTZ] = ('I32_CTZ', [], 0)
OP_INFO[I32_POPCNT] = ('I32_POPCNT', [], 0)
OP_INFO[I32_ADD] = ('I32_ADD', [], 0)
OP_INFO[I32_SUB] = ('I32_SUB', [], 0)
OP_INFO[I32_MUL] = ('I32_MUL', [], 0)
OP_INFO[I32_DIVS] = ('I32_DIVS', [], 0)
OP_INFO[I32_DIVU] = ('I32_DIVU', [], 0)
OP_INFO[I32_REMS] = ('I32_REMS', [], 0)
OP_INFO[I32_REMU] = ('I32_REMU', [], 0)
OP_INFO[I32_AND] = ('I32_AND', [], 0)
OP_INFO[I32_OR] = ('I32_OR', [], 0)
OP_INFO[I32_XOR] = ('I32_XOR', [], 0)
OP_INFO[I32_SHL] = ('I32_SHL', [], 0)
OP_INFO[I32_SHRS] = ('I32_SHRS', [], 0)
OP_INFO[I32_SHRU] = ('I32_SHRU', [], 0)
OP_INFO[I32_ROTL] = ('I32_ROTL', [], 0)
OP_INFO[I32_ROTR] = ('I32_ROTR', [], 0)
OP_INFO[I64_CLZ] = ('I64_CLZ', [], 0)
OP_INFO[I64_CTZ] = ('I64_CTZ', [], 0)
OP_INFO[I64_POPCNT] = ('I64_POPCNT', [], 0)
OP_INFO[I64_ADD] = ('I64_ADD', [], 0)
OP_INFO[I64_SUB] = ('I64_SUB', [], 0)
OP_INFO[I64_MUL] = ('I64_MUL', [], 0)
OP_INFO[I64_DIVS] = ('I64_DIVS', [], 0)
OP_INFO[I64_DIVU] = ('I64_DIVU', [], 0)
OP_INFO[I64_REMS] = ('I64_REMS', [], 0)
OP_INFO[I64_REMU] = ('I64_REMU', [], 0)
OP_INFO[I64_AND] = ('I64_AND', [], 0)
OP_INFO[I64_OR] = ('I64_OR', [], 0)
OP_INFO[I64_XOR] = ('I64_XOR', [], 0)
OP_INFO[I64_SHL] = ('I64_SHL', [], 0)
OP_INFO[I64_SHRS] = ('I64_SHRS', [], 0)
OP_INFO[I64_SHRU] = ('I64_SHRU', [], 0)
OP_INFO[I64_ROTL] = ('I64_ROTL', [], 0)
OP_INFO[I64_ROTR] = ('I64_ROTR', [], 0)
OP_INFO[F32_ABS] = ('F32_ABS', [], 0)
OP_INFO[F32_NEG] = ('F32_NEG', [], 0)
OP_INFO[F32_CEIL] = ('F32_CEIL', [], 0)
OP_INFO[F32_FLOOR] = ('F32_FLOOR', [], 0)
OP_INFO[F32_TRUNC] = ('F32_TRUNC', [], 0)
OP_INFO[F32_NEAREST] = ('F32_NEAREST', [], 0)
OP_INFO[F32_SQRT] = ('F32_SQRT', [], 0)
OP_INFO[F32_ADD] = ('F32_ADD', [], 0)
OP_INFO[F32_SUB] = ('F32_SUB', [], 0)
OP_INFO[F32_MUL] = ('F32_MUL', [], 0)
OP_INFO[F32_DIV] = ('F32_DIV', [], 0)
OP_INFO[F32_MIN] = ('F32_MIN', [], 0)
OP_INFO[F32_MAX] = ('F32_MAX', [], 0)
OP_INFO[F32_COPYSIGN] = ('F32_COPYSIGN', [], 0)
OP_INFO[F64_ABS] = ('F64_ABS', [], 0)
OP_INFO[F64_NEG] = ('F64_NEG', [], 0)
OP_INFO[F64_CEIL] = ('F64_CEIL', [], 0)
OP_INFO[F64_FLOOR] = ('F64_FLOOR', [], 0)
OP_INFO[F64_TRUNC] = ('F64_TRUNC', [], 0)
OP_INFO[F64_NEAREST] = ('F64_NEAREST', [], 0)
OP_INFO[F64_SQRT] = ('F64_SQRT', [], 0)
OP_INFO[F64_ADD] = ('F64_ADD', [], 0)
OP_INFO[F64_SUB] = ('F64_SUB', [], 0)
OP_INFO[F64_MUL] = ('F64_MUL', [], 0)
OP_INFO[F64_DIV] = ('F64_DIV', [], 0)
OP_INFO[F64_MIN] = ('F64_MIN', [], 0)
OP_INFO[F64_MAX] = ('F64_MAX', [], 0)
OP_INFO[F64_COPYSIGN] = ('F64_COPYSIGN', [], 0)
OP_INFO[I32_WRAP_I64] = ('I32_WRAP_I64', [], 0)
OP_INFO[I32_TRUNC_SF32] = ('I32_TRUNC_SF32', [], 0)
OP_INFO[I32_TRUNC_UF32] = ('I32_TRUNC_UF32', [], 0)
OP_INFO[I32_TRUNC_SF64] = ('I32_TRUNC_SF64', [], 0)
OP_INFO[I32_TRUNC_UF64] = ('I32_TRUNC_UF64', [], 0)
OP_INFO[I64_EXTEND_SI32] = ('I64_EXTEND_SI32', [], 0)
OP_INFO[I64_EXTEND_UI32] = ('I64_EXTEND_UI32', [], 0)
OP_INFO[I64_TRUNC_SF32] = ('I64_TRUNC_SF32', [], 0)
OP_INFO[I64_TRUNC_UF32] = ('I64_TRUNC_UF32', [], 0)
OP_INFO[I64_TRUNC_SF64] = ('I64_TRUNC_SF64', [], 0)
OP_INFO[I64_TRUNC_UF64] = ('I64_TRUNC_UF64', [], 0)
OP_INFO[F32_CONVERT_SI32] = ('F32_CONVERT_SI32', [], 0)
OP_INFO[F32_CONVERT_UI32] = ('F32_CONVERT_UI32', [], 0)
OP_INFO[F32_CONVERT_SI64] = ('F32_CONVERT_SI64', [], 0)
OP_INFO[F32_CONVERT_UI64] = ('F32_CONVERT_UI64', [], 0)
OP_INFO[F32_DEMOTE_F64] = ('F32_DEMOTE_F64', [], 0)
OP_INFO[F64_CONVERT_SI32] = ('F64_CONVERT_SI32', [], 0)
OP_INFO[F64_CONVERT_UI32] = ('F64_CONVERT_UI32', [], 0)
OP_INFO[F64_CONVERT_SI64] = ('F64_CONVERT_SI64', [], 0)
OP_INFO[F64_CONVERT_UI64] = ('F64_CONVERT_UI64', [], 0)
OP_INFO[F64_PROMOTE_F32] = ('F64_PROMOTE_F32', [], 0)
OP_INFO[I32_REINTERPRET_F32] = ('I32_REINTERPRET_F32', [], 0)
OP_INFO[I64_REINTERPRET_F64] = ('I64_REINTERPRET_F64', [], 0)
OP_INFO[F32_REINTERPRET_I32] = ('F32_REINTERPRET_I32', [], 0)
OP_INFO[F64_REINTERPRET_I64] = ('F64_REINTERPRET_I64', [], 0)

VALUE_TYPE_I32 = 0x7f
VALUE_TYPE_I64 = 0x7e
VALUE_TYPE_F32 = 0x7d
VALUE_TYPE_F64 = 0x7c
VALUE_TYPE_ANYFUNC = 0x70
VALUE_TYPE_FUNC = 0x60
VALUE_TYPE_BLOCK = 0x40

VALUE_TYPE_NAME = {}
VALUE_TYPE_NAME[VALUE_TYPE_I32] = 'VALUE_TYPE_I32'
VALUE_TYPE_NAME[VALUE_TYPE_I64] = 'VALUE_TYPE_I64'
VALUE_TYPE_NAME[VALUE_TYPE_F32] = 'VALUE_TYPE_F32'
VALUE_TYPE_NAME[VALUE_TYPE_F64] = 'VALUE_TYPE_F64'
VALUE_TYPE_NAME[VALUE_TYPE_ANYFUNC] = 'VALUE_TYPE_ANYFUNC'
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
