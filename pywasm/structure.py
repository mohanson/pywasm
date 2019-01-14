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
