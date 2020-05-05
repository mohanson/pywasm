i32 = 0x7f
i64 = 0x7e
f32 = 0x7d
f64 = 0x7c

funcref = 0x70
sign = 0x60

const = 0x00
var = 0x01

empty = 0x40

extern_function = 0x00
extern_table = 0x01
extern_memory = 0x02
extern_global = 0x03

custom_section = 0x00
type_section = 0x01
import_section = 0x02
function_section = 0x03
table_section = 0x04
memory_section = 0x05
global_section = 0x06
export_section = 0x07
start_section = 0x08
element_section = 0x09
code_section = 0x0a
data_section = 0x0b

memory_page_size = 64 * 1024
memory_page = 2**16
call_stack_depth = 128

f32_nan_canonical = 0x7fc00000
f64_nan_canonical = 0x7ff8000000000000
