import typing

from pywasm import common
from pywasm import convention
from pywasm import log
from pywasm import num


class FunctionType:
    # Function types are encoded by the byte 0x60 followed by the respective vectors of parameter and result types.
    #
    # functype ::= 0x60 t1∗:vec(valtype) t2∗:vec(valtype) ⇒ [t1∗] → [t2∗]
    def __init__(self):
        self.args: typing.List[int]
        self.rets: typing.List[int]

    def __repr__(self):
        args = [convention.valtype[i][0] for i in self.args]
        rets = [convention.valtype[i][0] for i in self.rets]
        return f'FuncType<args={args} rets={rets}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = FunctionType()
        assert ord(r.read(1)) == 0x60
        o.args = common.read_bytes(r)
        o.rets = common.read_bytes(r)
        return o


class ResultType:
    # Result types classify the result of executing instructions or blocks, which is a sequence of values written with
    # brackets.
    #
    # resulttype ::= [valtype?]
    pass


class Limits:
    # Limits are encoded with a preceding flag indicating whether a maximum is present.
    #
    # limits ::= 0x00  n:u32        ⇒ {min n,max ϵ}
    #          | 0x01  n:u32  m:u32 ⇒ {min n,max m}
    def __init__(self):
        self.minimum: int
        self.maximum: int

    def __repr__(self):
        return f'Limits<minimum={self.minimum} maximum={self.maximum}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = Limits()
        flag = ord(r.read(1))
        o.minimum = common.read_count(r)
        o.maximum = common.read_count(r) if flag else None
        return o


class MemoryType:
    # Memory types classify linear memories and their size range.
    #
    # memtype ::= limits
    #
    # The limits constrain the minimum and optionally the maximum size of a memory. The limits are given in units of
    # page size.
    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        return Limits.from_reader(r)


class TableType:
    # Table types classify tables over elements of element types within a size range.
    #
    # tabletype :: =limits elemtype
    # elemtype ::= funcref
    #
    # Like memories, tables are constrained by limits for their minimum and optionally maximum size. The limits are
    # given in numbers of entries. The element type funcref is the infinite union of all function types. A table of that
    # type thus contains references to functions of heterogeneous type.

    def __init__(self):
        self.limits: Limits
        self.elemtype: int

    def __repr__(self):
        return f'TableType<limits={self.limits} elemtype={convention.elemtype[self.elemtype]}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = TableType()
        o.elemtype = ord(r.read(1))
        o.limits = Limits.from_reader(r)
        return o


class GlobalType:
    # Global types are encoded by their value type and a flag for their
    # mutability.
    #
    # globaltype ::= t:valtype m:mut ⇒ m t
    # mut ::= 0x00 ⇒ const
    #       | 0x01 ⇒ var
    def __init__(self):
        self.valtype: int
        self.mut: bool

    def __repr__(self):
        return f'GlobalType<valtype={convention.valtype[self.valtype]} mut={self.mut}>'

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        o = GlobalType()
        o.valtype = ord(r.read(1))
        o.mut = ord(r.read(1)) == 1
        return o


class ExternalType:
    # External types classify imports and external values with their respective types.
    #
    # externtype ::= func functype | table tabletype | mem memtype | global globaltype
    pass


class Expression:
    # Function bodies, initialization values for globals, and offsets of element or data segments are given as
    # expressions, which are sequences of instructions terminated by an end marker.
    #
    # expr ::= instr∗ end
    #
    # In some places, validation restricts expressions to be constant, which limits the set of allowable instructions.

    def __init__(self):
        self.data: bytearray

    def __repr__(self):
        return f'Expression<data={self.data.hex()}>'

    @classmethod
    def skip(cls, opcode: int, r: typing.BinaryIO):
        data = bytearray()
        for e in convention.opcodes[opcode][1]:
            if e == 'leb_1':
                data.extend(num.leb(r, 1)[2])
            elif e == 'leb_7':
                data.extend(num.leb(r, 7)[2])
            elif e == 'leb_32':
                data.extend(num.leb(r, 32)[2])
            elif e == 'leb_64':
                data.extend(num.leb(r, 64)[2])
            elif e == 'bit_32':
                data.extend(r.read(4))
            elif e == 'bit_64':
                data.extend(r.read(8))
            elif e == 'leb_32xleb_32':
                _, c, a = num.leb(r, 32)
                data.extend(a)
                for _ in range(c):
                    data.extend(num.leb(r, 32)[2])
            else:
                log.panicln('pywasm: invalid code size')
        return data

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        data = bytearray()
        d = 1
        for _ in range(1 << 32):
            op = ord(r.read(1))
            data.append(op)
            if op in [convention.block, convention.loop, convention.if_]:
                d += 1
            elif op == convention.end:
                d -= 1
                if not d:
                    break
            else:
                continue
            data.extend(cls.skip(op, r))
        o = Expression()
        o.data = data
        return o


class Function:
    # The funcs component of a module defines a vector of functions with the following structure:
    #
    # func ::= {type typeidx, locals vec(valtype), body expr}
    pass


class Table:
    # The tables component of a module defines a vector of tables described by their table type:
    #
    # table ::= {type tabletype}
    pass


class Memory:
    # The mems component of a module defines a vector of linear memories (or memories for short) as described by their
    # memory type:
    #
    # mem ::= {type memtype}
    pass


class Global:
    # The globals component of a module defines a vector of global variables (or globals for short):
    #
    # global ::= {type globaltype, init expr}
    pass


class ElementSegment:
    # The initial contents of a table is uninitialized. The elem component of a module defines a vector of element
    # segments that initialize a subrange of a table, at a given offset, from a static vector of elements.
    #
    # elem ::= {table tableidx, offset expr, init vec(funcidx)}
    #
    # The offset is given by a constant expression.
    pass


class DataSegment:
    # The initial contents of a memory are zero-valued bytes. The data component of a module defines a vector of data
    # segments that initialize a range of memory, at a given offset, with a static vector of bytes.
    #
    # data::={data memidx,offset expr,init vec(byte)}
    #
    # The offset is given by a constant expression.
    pass


class StartFunction:
    # The start component of a module declares the function index of a start function that is automatically invoked
    # when the module is instantiated, after tables and memories have been initialized.
    #
    # start ::= {func funcidx}
    pass


class Export:
    # The exports component of a module defines a set of exports that become accessible to the host environment once
    # the module has been instantiated.
    #
    # export ::= {name name, desc exportdesc}
    # exportdesc ::= func funcidx | table tableidx | mem memidx | global globalidx
    #
    # Each export is labeled by a unique name. Exportable definitions are functions, tables, memories, and globals,
    # which are referenced through a respective descriptor.
    pass


class Import:
    # The imports component of a module defines a set of imports that are required for instantiation.
    #
    # import ::= {module name, name name, desc importdesc}
    # importdesc ::= func typeidx | table tabletype | mem memtype | global globaltype
    #
    # Each import is labeled by a two-level name space, consisting of a module name and a name for an entity within
    # that module. Importable definitions are functions, tables, memories, and globals. Each import is specified by a
    # descriptor with a respective type that a definition provided during instantiation is required to match. Every
    # import defines an index in the respective index space. In each index space, the indices of imports go before the
    # first index of any definition contained in the module itself.
    pass


class Module:
    def __init__(self):
        pass

    def __repr__(self):
        pass

    @classmethod
    def open(cls, file: str):
        with open(file, 'rb') as f:
            return cls.from_reader(f)

    @classmethod
    def from_reader(cls, r: typing.BinaryIO):
        if list(r.read(4)) != [0x00, 0x61, 0x73, 0x6d]:
            log.panicln('pywasm: invalid magic number')
        if list(r.read(4)) != [0x01, 0x00, 0x00, 0x00]:
            log.panicln('pywasm: invalid version')
