i32 = 0x7f
i64 = 0x7e
f32 = 0x7d
f64 = 0x7c

empty = 0x40
funcref = 0x70

const = 0x00
var = 0x01

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

# valtype = {i32, i64, f32, f64}
# blocktype = {empty, *valtype}
# elemtype = {funcref}
# mut = {const, var}
# section = {
#     custom_section,
#     type_section,
#     import_section,
#     function_section,
#     table_section,
#     memory_section,
#     global_section,
#     export_section,
#     start_section,
#     element_section,
#     code_section,
#     data_section,
# }
# extern_type = {extern_function, extern_table, extern_memory, extern_global}
