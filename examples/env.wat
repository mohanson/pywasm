(module
 (type $FUNCSIG$ii (func (param i32) (result i32)))
 (import "env" "fib" (func $fib (param i32) (result i32)))
 (table 0 anyfunc)
 (memory $0 1)
 (export "memory" (memory $0))
 (export "get" (func $get))
 (func $get (; 1 ;) (param $0 i32) (result i32)
  (call $fib
   (get_local $0)
  )
 )
)
