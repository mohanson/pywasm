from pywasm import num


def read_count(reader, maxbits=32, signed=False) -> int:
    return num.leb(reader, maxbits, signed)[1]


def read_bytes(reader, maxbits=32, signed=False) -> bytearray:
    n = read_count(reader, maxbits, signed)
    return bytearray(reader.read(n))
