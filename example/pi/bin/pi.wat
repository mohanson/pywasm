(module $pi.wasm
  (type (;0;) (func (param i32) (result f64)))
  (type (;1;) (func (param f64 i32) (result f64)))
  (func $pi (type 0) (param i32) (result f64)
    (local f64 f64 f64 i32 f64)
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        br_if 0 (;@2;)
        f64.const 0x0p+0 (;=0;)
        local.set 1
        f64.const 0x1p+0 (;=1;)
        local.set 2
        br 1 (;@1;)
      end
      f64.const 0x0p+0 (;=0;)
      local.set 1
      f64.const 0x1.6a09e667f3bccp-1 (;=0.707107;)
      local.set 3
      f64.const 0x1p+0 (;=1;)
      local.set 2
      i32.const 1
      local.set 4
      loop  ;; label = @2
        local.get 2
        local.get 3
        f64.mul
        local.set 5
        local.get 1
        f64.const 0x1p+1 (;=2;)
        local.get 4
        i32.const 1
        i32.add
        local.tee 4
        call $__powidf2
        local.get 2
        local.get 3
        f64.add
        f64.const 0x1p-1 (;=0.5;)
        f64.mul
        local.tee 2
        local.get 2
        f64.mul
        local.get 5
        f64.sqrt
        local.tee 3
        local.get 3
        f64.mul
        f64.sub
        f64.mul
        f64.add
        local.set 1
        local.get 3
        local.set 3
        local.get 4
        local.get 0
        i32.le_u
        br_if 0 (;@2;)
      end
    end
    local.get 2
    local.get 2
    f64.mul
    f64.const 0x1p+2 (;=4;)
    f64.mul
    f64.const 0x1p+0 (;=1;)
    local.get 1
    f64.sub
    f64.div)
  (func $__powidf2 (type 1) (param f64 i32) (result f64)
    (local i32 f64 i32)
    local.get 0
    f64.const 0x1p+0 (;=1;)
    local.get 1
    local.get 1
    i32.const 31
    i32.shr_s
    local.tee 2
    i32.xor
    local.get 2
    i32.sub
    local.tee 2
    i32.const 1
    i32.and
    select
    local.set 3
    block  ;; label = @1
      local.get 2
      i32.const 2
      i32.lt_u
      br_if 0 (;@1;)
      loop  ;; label = @2
        local.get 3
        local.get 0
        local.get 0
        f64.mul
        local.tee 0
        f64.mul
        local.get 3
        local.get 2
        i32.const 2
        i32.and
        select
        local.set 3
        local.get 2
        i32.const 3
        i32.gt_u
        local.set 4
        local.get 2
        i32.const 1
        i32.shr_u
        local.set 2
        local.get 4
        br_if 0 (;@2;)
      end
    end
    f64.const 0x1p+0 (;=1;)
    local.get 3
    f64.div
    local.get 3
    local.get 1
    i32.const 0
    i32.lt_s
    select)
  (table (;0;) 1 1 funcref)
  (memory (;0;) 16)
  (global $__stack_pointer (mut i32) (i32.const 1048576))
  (global (;1;) i32 (i32.const 1048576))
  (global (;2;) i32 (i32.const 1048576))
  (export "memory" (memory 0))
  (export "pi" (func $pi))
  (export "__data_end" (global 1))
  (export "__heap_base" (global 2)))
