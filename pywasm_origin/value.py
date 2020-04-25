# WebAssembly provides only four basic value types. These are integers and IEEE 754-2019 numbers, each in 32 and 64 bit
# width. 32 bit integers also serve as Booleans and as memory addresses. The usual operations on these types are
# available, including the full matrix of conversions between them. There is no distinction between signed and unsigned
# integer types. Instead, integers are interpreted by respective operations as either unsigned or signed in two’s
# complement representation.

import numpy

numpy.seterr(over='ignore')

i32 = numpy.int32
i64 = numpy.int64
u32 = numpy.uint32
u64 = numpy.uint64
f32 = numpy.float32
f64 = numpy.float64
