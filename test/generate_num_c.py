temp = """X Y_add(X a, X b) {
  return a + b;
}

X Y_sub(X a, X b) {
  return a - b;
}


X Y_mul(X a, X b) {
  return a * b;
}

X Y_div(X a, X b) {
  return a / b;
}"""


for i in [
    [['X', 'signed char'], ['Y', 'i8']],
    [['X', 'unsigned char'], ['Y', 'u8']],
    [['X', 'short'], ['Y', 'i16']],
    [['X', 'unsigned short'], ['Y', 'u16']],
    [['X', 'int'], ['Y', 'i32']],
    [['X', 'unsigned int'], ['Y', 'u32']],
    [['X', 'long long'], ['Y', 'i64']],
    [['X', 'unsigned long long'], ['Y', 'u64']],
    [['X', 'float'], ['Y', 'f32']],
    [['X', 'double'], ['Y', 'f64']],
]:
    a = temp
    for j in i:
        a = a.replace(j[0], j[1])
    print(a)
