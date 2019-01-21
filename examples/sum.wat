(module
 (table 0 anyfunc)
 (memory $0 1)
 (export "memory" (memory $0))
 (export "sum" (func $sum))
 (func $sum (; 0 ;) (param $0 i32) (result i32)
  (block $label$0
   (br_if $label$0
    (i32.lt_s
     (get_local $0)
     (i32.const 1)
    )
   )
   (return
    (i32.add
     (i32.add
      (i32.wrap/i64
       (i64.shr_u
        (i64.mul
         (i64.extend_u/i32
          (i32.add
           (get_local $0)
           (i32.const -1)
          )
         )
         (i64.extend_u/i32
          (i32.add
           (get_local $0)
           (i32.const -2)
          )
         )
        )
        (i64.const 1)
       )
      )
      (get_local $0)
     )
     (i32.const -1)
    )
   )
  )
  (i32.const 0)
 )
)
