import typing

from . import binary
from . import leb128
from . import num

opcode: typing.Dict[int, typing.Tuple[str]] = {}


def op(code: int, name: str):
    opcode[code] = [name]
    return code


# control Instructions
unreachable = op(0x00, 'unreachable')
nop = op(0x01, 'nop')
block = op(0x02, 'block')
loop = op(0x03, 'loop')
if_ = op(0x04, 'if')
br = op(0x0c, 'br')
br_if = op(0x0d, 'br_if')
br_table = op(0x0e, 'br_table')
return_ = op(0x0f, 'return')
call = op(0x10, 'call')
call_indirect = op(0x11, 'call_indirect')
# parametric Instructions
drop = op(0x1a, 'drop')
select = op(0x1b, 'select')
# variable instructions
get_local = op(0x20, 'local.get')
set_local = op(0x21, 'local.set')
tee_local = op(0x22, 'local.tee')
get_global = op(0x23, 'global.get')
set_global = op(0x24, 'global.set')
# memory instructions
i32_load = op(0x28, 'i32.load')
i64_load = op(0x29, 'i64.load')
f32_load = op(0x2a, 'f32.load')
f64_load = op(0x2b, 'f64.load')
i32_load8_s = op(0x2c, 'i32.load8_s')
i32_load8_u = op(0x2d, 'i32.load8_u')
i32_load16_s = op(0x2e, 'i32.load16_s')
i32_load16_u = op(0x2f, 'i32.load16_u')
i64_load8_s = op(0x30, 'i64.load8_s')
i64_load8_u = op(0x31, 'i64.load8_u')
i64_load16_s = op(0x32, 'i64.load16_s')
i64_load16_u = op(0x33, 'i64.load16_u')
i64_load32_s = op(0x34, 'i64.load32_s')
i64_load32_u = op(0x35, 'i64.load32_u')
i32_store = op(0x36, 'i32.store')
i64_store = op(0x37, 'i64.store')
f32_store = op(0x38, 'f32.store')
f64_store = op(0x39, 'f64.store')
i32_store8 = op(0x3a, 'i32.store8')
i32_store16 = op(0x3b, 'i32.store16')
i64_store8 = op(0x3c, 'i64.store8')
i64_store16 = op(0x3d, 'i64.store16')
i64_store32 = op(0x3e, 'i64.store32')
current_memory = op(0x3f, 'memory.size')
grow_memory = op(0x40, 'memory.grow')
# numeric instructions
i32_const = op(0x41, 'i32.const')
i64_const = op(0x42, 'i64.const')
f32_const = op(0x43, 'f32.const')
f64_const = op(0x44, 'f64.const')
i32_eqz = op(0x45, 'i32.eqz')
i32_eq = op(0x46, 'i32.eq')
i32_ne = op(0x47, 'i32.ne')
i32_lts = op(0x48, 'i32.lt_s')
i32_ltu = op(0x49, 'i32.lt_u')
i32_gts = op(0x4a, 'i32.gt_s')
i32_gtu = op(0x4b, 'i32.gt_u')
i32_les = op(0x4c, 'i32.le_s')
i32_leu = op(0x4d, 'i32.le_u')
i32_ges = op(0x4e, 'i32.ge_s')
i32_geu = op(0x4f, 'i32.ge_u')
i64_eqz = op(0x50, 'i64.eqz')
i64_eq = op(0x51, 'i64.eq')
i64_ne = op(0x52, 'i64.ne')
i64_lts = op(0x53, 'i64.lt_s')
i64_ltu = op(0x54, 'i64.lt_u')
i64_gts = op(0x55, 'i64.gt_s')
i64_gtu = op(0x56, 'i64.gt_u')
i64_les = op(0x57, 'i64.le_s')
i64_leu = op(0x58, 'i64.le_u')
i64_ges = op(0x59, 'i64.ge_s')
i64_geu = op(0x5a, 'i64.ge_u')
f32_eq = op(0x5b, 'f32.eq')
f32_ne = op(0x5c, 'f32.ne')
f32_lt = op(0x5d, 'f32.lt')
f32_gt = op(0x5e, 'f32.gt')
f32_le = op(0x5f, 'f32.le')
f32_ge = op(0x60, 'f32.ge')
f64_eq = op(0x61, 'f64.eq')
f64_ne = op(0x62, 'f64.ne')
f64_lt = op(0x63, 'f64.lt')
f64_gt = op(0x64, 'f64.gt')
f64_le = op(0x65, 'f64.le')
f64_ge = op(0x66, 'f64.ge')
i32_clz = op(0x67, 'i32.clz')
i32_ctz = op(0x68, 'i32.ctz')
i32_popcnt = op(0x69, 'i32.popcnt')
i32_add = op(0x6a, 'i32.add')
i32_sub = op(0x6b, 'i32.sub')
i32_mul = op(0x6c, 'i32.mul')
i32_divs = op(0x6d, 'i32.div_s')
i32_divu = op(0x6e, 'i32.div_u')
i32_rems = op(0x6f, 'i32.rem_s')
i32_remu = op(0x70, 'i32.rem_u')
i32_and = op(0x71, 'i32.and')
i32_or = op(0x72, 'i32.or')
i32_xor = op(0x73, 'i32.xor')
i32_shl = op(0x74, 'i32.shl')
i32_shrs = op(0x75, 'i32.shr_s')
i32_shru = op(0x76, 'i32.shr_u')
i32_rotl = op(0x77, 'i32.rotl')
i32_rotr = op(0x78, 'i32.rotr')
i64_clz = op(0x79, 'i64.clz')
i64_ctz = op(0x7a, 'i64.ctz')
i64_popcnt = op(0x7b, 'i64.popcnt')
i64_add = op(0x7c, 'i64.add')
i64_sub = op(0x7d, 'i64.sub')
i64_mul = op(0x7e, 'i64.mul')
i64_divs = op(0x7f, 'i64.div_s')
i64_divu = op(0x80, 'i64.div_u')
i64_rems = op(0x81, 'i64.rem_s')
i64_remu = op(0x82, 'i64.rem_u')
i64_and = op(0x83, 'i64.and')
i64_or = op(0x84, 'i64.or')
i64_xor = op(0x85, 'i64.xor')
i64_shl = op(0x86, 'i64.shl')
i64_shrs = op(0x87, 'i64.shr_s')
i64_shru = op(0x88, 'i64.shr_u')
i64_rotl = op(0x89, 'i64.rotl')
i64_rotr = op(0x8a, 'i64.rotr')
f32_abs = op(0x8b, 'f32.abs')
f32_neg = op(0x8c, 'f32.neg')
f32_ceil = op(0x8d, 'f32.ceil')
f32_floor = op(0x8e, 'f32.floor')
f32_trunc = op(0x8f, 'f32.trunc')
f32_nearest = op(0x90, 'f32.nearest')
f32_sqrt = op(0x91, 'f32.sqrt')
f32_add = op(0x92, 'f32.add')
f32_sub = op(0x93, 'f32.sub')
f32_mul = op(0x94, 'f32.mul')
f32_div = op(0x95, 'f32.div')
f32_min = op(0x96, 'f32.min')
f32_max = op(0x97, 'f32.max')
f32_copysign = op(0x98, 'f32.copysign')
f64_abs = op(0x99, 'f64.abs')
f64_neg = op(0x9a, 'f64.neg')
f64_ceil = op(0x9b, 'f64.ceil')
f64_floor = op(0x9c, 'f64.floor')
f64_trunc = op(0x9d, 'f64.trunc')
f64_nearest = op(0x9e, 'f64.nearest')
f64_sqrt = op(0x9f, 'f64.sqrt')
f64_add = op(0xa0, 'f64.add')
f64_sub = op(0xa1, 'f64.sub')
f64_mul = op(0xa2, 'f64.mul')
f64_div = op(0xa3, 'f64.div')
f64_min = op(0xa4, 'f64.min')
f64_max = op(0xa5, 'f64.max')
f64_copysign = op(0xa6, 'f64.copysign')
i32_wrap_i64 = op(0xa7, 'i32.wrap_i64')
i32_trunc_sf32 = op(0xa8, 'i32.trunc_f32_s')
i32_trunc_uf32 = op(0xa9, 'i32.trunc_f32_u')
i32_trunc_sf64 = op(0xaa, 'i32.trunc_f64_s')
i32_trunc_uf64 = op(0xab, 'i32.trunc_f64_u')
i64_extend_si32 = op(0xac, 'i64.extend_i32_s')
i64_extend_ui32 = op(0xad, 'i64.extend_i32_u')
i64_trunc_sf32 = op(0xae, 'i64.trunc_f32_s')
i64_trunc_uf32 = op(0xaf, 'i64.trunc_f32_u')
i64_trunc_sf64 = op(0xb0, 'i64.trunc_f64_s')
i64_trunc_uf64 = op(0xb1, 'i64.trunc_f64_u')
f32_convert_si32 = op(0xb2, 'f32.convert_i32_s')
f32_convert_ui32 = op(0xb3, 'f32.convert_i32_u')
f32_convert_si64 = op(0xb4, 'f32.convert_i64_s')
f32_convert_ui64 = op(0xb5, 'f32.convert_i64_u')
f32_demote_f64 = op(0xb6, 'f32.demote_f64')
f64_convert_si32 = op(0xb7, 'f64.convert_i32_s')
f64_convert_ui32 = op(0xb8, 'f64.convert_i32_u')
f64_convert_si64 = op(0xb9, 'f64.convert_i64_s')
f64_convert_ui64 = op(0xba, 'f64.convert_i64_u')
f64_promote_f32 = op(0xbb, 'f64.promote_f32')
i32_reinterpret_f32 = op(0xbc, 'i32.reinterpret_f32')
i64_reinterpret_f64 = op(0xbd, 'i64.reinterpret_f64')
f32_reinterpret_i32 = op(0xbe, 'f32.reinterpret_i32')
f64_reinterpret_i64 = op(0xbf, 'f64.reinterpret_i64')


class Instruction:

    def __init__(self):
        self.opcode: int = 0x00
        self.fccode: int = 0x00
        self.args: typing.List[typing.Any] = []

    def __repr__(self):
        return f'{opcode[self.opcode][0]} {self.args}'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Instruction()
        o.opcode: int = ord(r.read(1))
        o.fccode: int = 0x00
        o.args = []
        if o.opcode in [block, loop]:
            block_type = binary.BlockType.from_reader(r)
            instr: typing.List[Instruction] = []
            while True:
                a = r.read(1)
                if a == 0x0b:
                    break
                r.seek(-1, 1)
                instr.append(Instruction.from_reader(r))
            o.args = [block_type, instr]
            return o
        if o.opcode == if_:
            block_type = binary.BlockType.from_reader(r)
            instr1: typing.List[Instruction] = []
            instr2: typing.List[Instruction] = []
            idx = 1
            while True:
                a = r.read(1)
                if a == 0x05:
                    idx = 2
                    continue
                if a == 0x0b:
                    break
                r.seek(-1, 1)
                if idx == 1:
                    instr1.append(Instruction.from_reader(r))
                else:
                    instr2.append(Instruction.from_reader(r))
            o.args = [block_type, instr1, instr2]
            return o
        if o.opcode in [br, br_if, call]:
            o.args = [leb128.u.decode_reader(r)[0]]
            return o
        if o.opcode == br_table:
            n = leb128.u.decode_reader(r)[0]
            a = [leb128.u.decode_reader(r)[0] for _ in range(n)]
            b = leb128.u.decode_reader(r)[0]
            o.args = [a, b]
            return o
        if o.opcode == call_indirect:
            o.args = [leb128.u.decode_reader(r)[0], r.read(1)]
            return o
        if o.opcode in [get_local, set_local, tee_local, get_global, set_global]:
            o.args = [leb128.u.decode_reader(r)[0]]
            return o
        if o.opcode in [
            i32_load,
            i64_load,
            f32_load,
            f64_load,
            i32_load8_s,
            i32_load8_u,
            i32_load16_s,
            i32_load16_u,
            i64_load8_s,
            i64_load8_u,
            i64_load16_s,
            i64_load16_u,
            i64_load32_s,
            i64_load32_u,
            i32_store,
            i64_store,
            f32_store,
            f64_store,
            i32_store8,
            i32_store16,
            i64_store8,
            i64_store16,
            i64_store32,
        ]:
            o.args = [leb128.u.decode_reader(r)[0] for _ in range(2)]
            return o
        if o.opcode in [current_memory, grow_memory]:
            o.args = [r.read(1) for _ in range(2)]
            return o
        if o.opcode == i32_const:
            o.args = [leb128.i.decode_reader(r)[0]]
            return o
        if o.opcode == i64_const:
            o.args = [leb128.i.decode_reader(r)[0]]
            return o
        if o.opcode == f32_const:
            o.args = [num.LittleEndian.f32(r.read(4))]
            return o
        if o.opcode == f64_const:
            o.args = [num.LittleEndian.f64(r.read(8))]
            return o
        return o
