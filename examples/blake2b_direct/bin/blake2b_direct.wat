(module $blake2b_direct.wasm
  (type (;0;) (func (param i32 i32)))
  (type (;1;) (func (param i32 i32 i32) (result i32)))
  (type (;2;) (func (param i32 i32) (result i32)))
  (type (;3;) (func (param i32) (result i32)))
  (type (;4;) (func (param i32 i32 i32)))
  (type (;5;) (func (param i32 i32 i32 i32) (result i32)))
  (type (;6;) (func (param i32 i32 i64 i64 i64 i64)))
  (type (;7;) (func (param i32 i32 i32 i32 i32)))
  (type (;8;) (func (param i32)))
  (type (;9;) (func (param i32 i32 i32 i32)))
  (type (;10;) (func (param i32 i32 i32 i32 i32 i32) (result i32)))
  (type (;11;) (func (param i32 i32 i32 i32 i32) (result i32)))
  (func $_ZN69_$LT$core..alloc..layout..LayoutError$u20$as$u20$core..fmt..Debug$GT$3fmt17h10f1d925090e4d42E (type 2) (param i32 i32) (result i32)
    local.get 1
    i32.const 1048576
    i32.const 11
    call $_ZN4core3fmt9Formatter9write_str17h4abba99f2e253f35E)
  (func $alloc (type 3) (param i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    block  ;; label = @1
      local.get 0
      i32.const 0
      i32.lt_s
      br_if 0 (;@1;)
      i32.const 0
      i32.load8_u offset=1050065
      drop
      local.get 0
      i32.const 1
      call $__rust_alloc
      local.set 0
      local.get 1
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 0
      return
    end
    i32.const 1048604
    i32.const 43
    local.get 1
    i32.const 15
    i32.add
    i32.const 1048588
    i32.const 1048660
    call $_ZN4core6result13unwrap_failed17he8f1ea0683e142ebE
    unreachable)
  (func $alloc_zeroed (type 3) (param i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    block  ;; label = @1
      local.get 0
      i32.const 0
      i32.lt_s
      br_if 0 (;@1;)
      i32.const 0
      i32.load8_u offset=1050065
      drop
      local.get 0
      i32.const 1
      call $__rust_alloc_zeroed
      local.set 0
      local.get 1
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 0
      return
    end
    i32.const 1048604
    i32.const 43
    local.get 1
    i32.const 15
    i32.add
    i32.const 1048588
    i32.const 1048676
    call $_ZN4core6result13unwrap_failed17he8f1ea0683e142ebE
    unreachable)
  (func $blake2b (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 624
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    i32.const 68
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 60
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 52
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 44
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 36
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 28
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 20
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 84
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 92
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 100
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 108
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 116
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 124
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 132
    i32.add
    i32.const 0
    i32.store align=2
    local.get 2
    i64.const 0
    i64.store offset=12 align=2
    local.get 2
    i64.const 0
    i64.store offset=76 align=2
    local.get 2
    i32.const 16842752
    i32.store offset=8 align=2
    local.get 2
    i32.const 8
    i32.add
    i32.const 64
    call $_ZN8blake2ya7blake2b7Param2b6digest17hec12fe20cb3aec71E
    local.get 2
    i32.const 496
    i32.add
    local.get 2
    i32.const 8
    i32.add
    i32.const 128
    call $memcpy
    drop
    local.get 2
    i32.const 136
    i32.add
    local.get 2
    i32.const 496
    i32.add
    call $_ZN8blake2ya7blake2b7blake2b17h53e64c235e511c3eE
    local.get 2
    i32.const 136
    i32.add
    local.get 0
    local.get 1
    call $_ZN8blake2ya7blake2b7Blake2b6update17h23a8d8fd43871b5bE
    local.get 2
    i32.const 496
    i32.add
    i32.const 56
    i32.add
    local.tee 0
    i64.const 0
    i64.store
    local.get 2
    i32.const 496
    i32.add
    i32.const 48
    i32.add
    local.tee 3
    i64.const 0
    i64.store
    local.get 2
    i32.const 496
    i32.add
    i32.const 40
    i32.add
    local.tee 4
    i64.const 0
    i64.store
    local.get 2
    i32.const 496
    i32.add
    i32.const 32
    i32.add
    local.tee 5
    i64.const 0
    i64.store
    local.get 2
    i32.const 496
    i32.add
    i32.const 24
    i32.add
    local.tee 6
    i64.const 0
    i64.store
    local.get 2
    i32.const 496
    i32.add
    i32.const 16
    i32.add
    local.tee 7
    i64.const 0
    i64.store
    local.get 2
    i32.const 496
    i32.add
    i32.const 8
    i32.add
    local.tee 8
    i64.const 0
    i64.store
    local.get 2
    i64.const 0
    i64.store offset=496
    local.get 2
    i32.const 136
    i32.add
    local.get 2
    i32.const 496
    i32.add
    i32.const 64
    call $_ZN8blake2ya7blake2b7Blake2b6digest17h76838ece2e04fba6E
    i32.const 0
    i32.load8_u offset=1050065
    drop
    i32.const 64
    i32.const 1
    call $__rust_alloc
    local.tee 1
    i32.const 56
    i32.add
    local.get 0
    i64.load
    i64.store align=1
    local.get 1
    i32.const 48
    i32.add
    local.get 3
    i64.load
    i64.store align=1
    local.get 1
    i32.const 40
    i32.add
    local.get 4
    i64.load
    i64.store align=1
    local.get 1
    i32.const 32
    i32.add
    local.get 5
    i64.load
    i64.store align=1
    local.get 1
    i32.const 24
    i32.add
    local.get 6
    i64.load
    i64.store align=1
    local.get 1
    i32.const 16
    i32.add
    local.get 7
    i64.load
    i64.store align=1
    local.get 1
    i32.const 8
    i32.add
    local.get 8
    i64.load
    i64.store align=1
    local.get 1
    local.get 2
    i64.load offset=496
    i64.store align=1
    local.get 2
    i32.const 624
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $dealloc (type 0) (param i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      local.get 1
      i32.const 0
      i32.lt_s
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      i32.const 1
      call $__rust_dealloc
      local.get 2
      i32.const 16
      i32.add
      global.set $__stack_pointer
      return
    end
    i32.const 1048604
    i32.const 43
    local.get 2
    i32.const 15
    i32.add
    i32.const 1048588
    i32.const 1048692
    call $_ZN4core6result13unwrap_failed17he8f1ea0683e142ebE
    unreachable)
  (func $__rust_alloc (type 2) (param i32 i32) (result i32)
    (local i32)
    local.get 0
    local.get 1
    call $__rdl_alloc
    local.set 2
    local.get 2
    return)
  (func $__rust_dealloc (type 4) (param i32 i32 i32)
    local.get 0
    local.get 1
    local.get 2
    call $__rdl_dealloc
    return)
  (func $__rust_realloc (type 5) (param i32 i32 i32 i32) (result i32)
    (local i32)
    local.get 0
    local.get 1
    local.get 2
    local.get 3
    call $__rdl_realloc
    local.set 4
    local.get 4
    return)
  (func $__rust_alloc_zeroed (type 2) (param i32 i32) (result i32)
    (local i32)
    local.get 0
    local.get 1
    call $__rdl_alloc_zeroed
    local.set 2
    local.get 2
    return)
  (func $__rust_alloc_error_handler (type 0) (param i32 i32)
    local.get 0
    local.get 1
    call $__rg_oom
    return)
  (func $_ZN8blake2ya7blake2b6reduce17hce9cc40fc7481622E (type 6) (param i32 i32 i64 i64 i64 i64)
    (local i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64 i64)
    local.get 0
    local.get 1
    i64.load offset=64
    local.tee 6
    local.get 0
    i64.load offset=32
    local.tee 7
    local.get 0
    i64.load
    local.tee 8
    i64.add
    local.get 1
    i64.load
    local.tee 9
    i64.add
    local.tee 10
    local.get 1
    i64.load offset=8
    local.tee 11
    i64.add
    local.get 10
    local.get 2
    i64.xor
    i64.const 5840696475078001361
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 12
    i64.const 7640891576956012808
    i64.add
    local.tee 13
    local.get 7
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 14
    i64.add
    local.tee 15
    i64.add
    local.get 0
    i64.load offset=40
    local.tee 16
    local.get 0
    i64.load offset=8
    local.tee 17
    i64.add
    local.get 1
    i64.load offset=16
    local.tee 2
    i64.add
    local.tee 18
    local.get 1
    i64.load offset=24
    local.tee 10
    i64.add
    local.get 18
    local.get 3
    i64.xor
    i64.const -7276294671716946913
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 3
    i64.const -4942790177534073029
    i64.add
    local.tee 18
    local.get 16
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 19
    i64.add
    local.tee 20
    local.get 3
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 21
    local.get 18
    i64.add
    local.tee 22
    local.get 19
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 23
    i64.add
    local.tee 24
    local.get 1
    i64.load offset=72
    local.tee 3
    i64.add
    local.get 24
    local.get 0
    i64.load offset=56
    local.tee 25
    local.get 0
    i64.load offset=24
    local.tee 26
    i64.add
    local.get 1
    i64.load offset=48
    local.tee 18
    i64.add
    local.tee 27
    local.get 1
    i64.load offset=56
    local.tee 19
    i64.add
    local.get 27
    local.get 5
    i64.xor
    i64.const 6620516959819538809
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 5
    i64.const -6534734903238641935
    i64.add
    local.tee 28
    local.get 25
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 29
    i64.add
    local.tee 30
    local.get 5
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 31
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 32
    local.get 0
    i64.load offset=48
    local.tee 27
    local.get 0
    i64.load offset=16
    local.tee 33
    i64.add
    local.get 1
    i64.load offset=32
    local.tee 5
    i64.add
    local.tee 34
    local.get 1
    i64.load offset=40
    local.tee 24
    i64.add
    local.get 34
    local.get 4
    i64.xor
    i64.const 2270897969802886507
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 4
    i64.const 4354685564936845355
    i64.add
    local.tee 34
    local.get 27
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 35
    i64.add
    local.tee 36
    local.get 4
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 37
    local.get 34
    i64.add
    local.tee 34
    i64.add
    local.tee 38
    local.get 23
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 23
    i64.add
    local.tee 39
    local.get 1
    i64.load offset=112
    local.tee 4
    i64.add
    local.get 30
    local.get 15
    local.get 12
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 15
    local.get 13
    i64.add
    local.tee 40
    local.get 14
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 13
    i64.add
    local.get 4
    i64.add
    local.tee 14
    local.get 1
    i64.load offset=120
    local.tee 12
    i64.add
    local.get 14
    local.get 37
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 14
    local.get 22
    i64.add
    local.tee 22
    local.get 13
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 13
    i64.add
    local.tee 30
    local.get 14
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 37
    local.get 22
    i64.add
    local.tee 22
    local.get 13
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 41
    i64.add
    local.tee 42
    local.get 1
    i64.load offset=80
    local.tee 13
    i64.add
    local.get 42
    local.get 13
    local.get 20
    i64.add
    local.get 34
    local.get 35
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 20
    i64.add
    local.tee 34
    local.get 1
    i64.load offset=88
    local.tee 14
    i64.add
    local.get 34
    local.get 15
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 15
    local.get 31
    local.get 28
    i64.add
    local.tee 28
    i64.add
    local.tee 31
    local.get 20
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 34
    i64.add
    local.tee 35
    local.get 15
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 43
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 42
    local.get 1
    i64.load offset=96
    local.tee 15
    local.get 36
    i64.add
    local.get 28
    local.get 29
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 28
    i64.add
    local.tee 29
    local.get 1
    i64.load offset=104
    local.tee 20
    i64.add
    local.get 29
    local.get 21
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 21
    local.get 40
    i64.add
    local.tee 29
    local.get 28
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 28
    i64.add
    local.tee 36
    local.get 21
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 21
    local.get 29
    i64.add
    local.tee 29
    i64.add
    local.tee 40
    local.get 41
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 41
    i64.add
    local.tee 44
    local.get 42
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 42
    local.get 40
    i64.add
    local.tee 40
    local.get 41
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 41
    local.get 24
    i64.add
    local.get 30
    local.get 20
    i64.add
    local.get 29
    local.get 28
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 28
    i64.add
    local.tee 29
    local.get 18
    i64.add
    local.get 29
    local.get 39
    local.get 32
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 30
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 29
    local.get 43
    local.get 31
    i64.add
    local.tee 31
    i64.add
    local.tee 32
    local.get 28
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 28
    i64.add
    local.tee 39
    i64.add
    local.tee 43
    local.get 10
    i64.add
    local.get 43
    local.get 36
    local.get 3
    i64.add
    local.get 31
    local.get 34
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 31
    i64.add
    local.tee 34
    local.get 12
    i64.add
    local.get 34
    local.get 37
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 34
    local.get 30
    local.get 38
    i64.add
    local.tee 30
    i64.add
    local.tee 36
    local.get 31
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 31
    i64.add
    local.tee 37
    local.get 34
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 34
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 38
    local.get 35
    local.get 5
    i64.add
    local.get 30
    local.get 23
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 23
    i64.add
    local.tee 30
    local.get 6
    i64.add
    local.get 30
    local.get 21
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 21
    local.get 22
    i64.add
    local.tee 22
    local.get 23
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 23
    i64.add
    local.tee 30
    local.get 21
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 21
    local.get 22
    i64.add
    local.tee 22
    i64.add
    local.tee 35
    local.get 41
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 41
    i64.add
    local.tee 43
    local.get 12
    i64.add
    local.get 37
    local.get 14
    i64.add
    local.get 39
    local.get 29
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 29
    local.get 32
    i64.add
    local.tee 32
    local.get 28
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 28
    i64.add
    local.tee 37
    local.get 19
    i64.add
    local.get 37
    local.get 21
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 21
    local.get 40
    i64.add
    local.tee 37
    local.get 28
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 28
    i64.add
    local.tee 39
    local.get 21
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 21
    local.get 37
    i64.add
    local.tee 37
    local.get 28
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 28
    i64.add
    local.tee 40
    local.get 20
    i64.add
    local.get 40
    local.get 44
    local.get 11
    i64.add
    local.get 22
    local.get 23
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 22
    i64.add
    local.tee 23
    local.get 15
    i64.add
    local.get 23
    local.get 29
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 23
    local.get 34
    local.get 36
    i64.add
    local.tee 29
    i64.add
    local.tee 34
    local.get 22
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 22
    i64.add
    local.tee 36
    local.get 23
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 23
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 40
    local.get 30
    local.get 9
    i64.add
    local.get 29
    local.get 31
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 29
    i64.add
    local.tee 30
    local.get 2
    i64.add
    local.get 30
    local.get 42
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 30
    local.get 32
    i64.add
    local.tee 31
    local.get 29
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 29
    i64.add
    local.tee 32
    local.get 30
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 30
    local.get 31
    i64.add
    local.tee 31
    i64.add
    local.tee 42
    local.get 28
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 28
    i64.add
    local.tee 44
    local.get 3
    i64.add
    local.get 36
    local.get 14
    i64.add
    local.get 43
    local.get 38
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 36
    local.get 35
    i64.add
    local.tee 35
    local.get 41
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 38
    i64.add
    local.tee 41
    local.get 6
    i64.add
    local.get 41
    local.get 30
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 30
    local.get 37
    i64.add
    local.tee 37
    local.get 38
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 38
    i64.add
    local.tee 41
    local.get 30
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 30
    local.get 37
    i64.add
    local.tee 37
    local.get 38
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 38
    i64.add
    local.tee 43
    local.get 5
    i64.add
    local.get 43
    local.get 39
    local.get 24
    i64.add
    local.get 31
    local.get 29
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 29
    i64.add
    local.tee 31
    local.get 2
    i64.add
    local.get 31
    local.get 36
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 31
    local.get 23
    local.get 34
    i64.add
    local.tee 23
    i64.add
    local.tee 34
    local.get 29
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 29
    i64.add
    local.tee 36
    local.get 31
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 31
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 39
    local.get 32
    local.get 15
    i64.add
    local.get 23
    local.get 22
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 22
    i64.add
    local.tee 23
    local.get 9
    i64.add
    local.get 23
    local.get 21
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 21
    local.get 35
    i64.add
    local.tee 23
    local.get 22
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 22
    i64.add
    local.tee 32
    local.get 21
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 21
    local.get 23
    i64.add
    local.tee 23
    i64.add
    local.tee 35
    local.get 38
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 38
    i64.add
    local.tee 43
    local.get 14
    i64.add
    local.get 36
    local.get 19
    i64.add
    local.get 44
    local.get 40
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 36
    local.get 42
    i64.add
    local.tee 40
    local.get 28
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 28
    i64.add
    local.tee 42
    local.get 11
    i64.add
    local.get 42
    local.get 21
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 21
    local.get 37
    i64.add
    local.tee 37
    local.get 28
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 28
    i64.add
    local.tee 42
    local.get 21
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 21
    local.get 37
    i64.add
    local.tee 37
    local.get 28
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 28
    i64.add
    local.tee 44
    local.get 4
    i64.add
    local.get 44
    local.get 41
    local.get 13
    i64.add
    local.get 23
    local.get 22
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 22
    i64.add
    local.tee 23
    local.get 4
    i64.add
    local.get 23
    local.get 36
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 23
    local.get 31
    local.get 34
    i64.add
    local.tee 31
    i64.add
    local.tee 34
    local.get 22
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 22
    i64.add
    local.tee 36
    local.get 23
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 23
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 41
    local.get 32
    local.get 10
    i64.add
    local.get 31
    local.get 29
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 29
    i64.add
    local.tee 31
    local.get 18
    i64.add
    local.get 31
    local.get 30
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 30
    local.get 40
    i64.add
    local.tee 31
    local.get 29
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 29
    i64.add
    local.tee 32
    local.get 30
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 30
    local.get 31
    i64.add
    local.tee 31
    i64.add
    local.tee 40
    local.get 28
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 28
    i64.add
    local.tee 44
    local.get 12
    i64.add
    local.get 36
    local.get 19
    i64.add
    local.get 43
    local.get 39
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 36
    local.get 35
    i64.add
    local.tee 35
    local.get 38
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 38
    i64.add
    local.tee 39
    local.get 3
    i64.add
    local.get 39
    local.get 30
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 30
    local.get 37
    i64.add
    local.tee 37
    local.get 38
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 38
    i64.add
    local.tee 39
    local.get 30
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 30
    local.get 37
    i64.add
    local.tee 37
    local.get 38
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 38
    i64.add
    local.tee 43
    local.get 6
    i64.add
    local.get 43
    local.get 42
    local.get 20
    i64.add
    local.get 31
    local.get 29
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 29
    i64.add
    local.tee 31
    local.get 15
    i64.add
    local.get 31
    local.get 36
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 31
    local.get 23
    local.get 34
    i64.add
    local.tee 23
    i64.add
    local.tee 34
    local.get 29
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 29
    i64.add
    local.tee 36
    local.get 31
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 31
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 42
    local.get 32
    local.get 10
    i64.add
    local.get 23
    local.get 22
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 22
    i64.add
    local.tee 23
    local.get 11
    i64.add
    local.get 23
    local.get 21
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 21
    local.get 35
    i64.add
    local.tee 23
    local.get 22
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 22
    i64.add
    local.tee 32
    local.get 21
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 21
    local.get 23
    i64.add
    local.tee 23
    i64.add
    local.tee 35
    local.get 38
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 38
    i64.add
    local.tee 43
    local.get 13
    i64.add
    local.get 36
    local.get 5
    i64.add
    local.get 44
    local.get 41
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 36
    local.get 40
    i64.add
    local.tee 40
    local.get 28
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 28
    i64.add
    local.tee 41
    local.get 9
    i64.add
    local.get 41
    local.get 21
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 21
    local.get 37
    i64.add
    local.tee 37
    local.get 28
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 28
    i64.add
    local.tee 41
    local.get 21
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 21
    local.get 37
    i64.add
    local.tee 37
    local.get 28
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 28
    i64.add
    local.tee 44
    local.get 12
    i64.add
    local.get 44
    local.get 39
    local.get 2
    i64.add
    local.get 23
    local.get 22
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 22
    i64.add
    local.tee 23
    local.get 18
    i64.add
    local.get 23
    local.get 36
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 23
    local.get 31
    local.get 34
    i64.add
    local.tee 31
    i64.add
    local.tee 34
    local.get 22
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 22
    i64.add
    local.tee 36
    local.get 23
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 23
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 39
    local.get 32
    local.get 24
    i64.add
    local.get 31
    local.get 29
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 29
    i64.add
    local.tee 31
    local.get 13
    i64.add
    local.get 31
    local.get 30
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 30
    local.get 40
    i64.add
    local.tee 31
    local.get 29
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 29
    i64.add
    local.tee 32
    local.get 30
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 30
    local.get 31
    i64.add
    local.tee 31
    i64.add
    local.tee 40
    local.get 28
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 28
    i64.add
    local.tee 44
    local.get 10
    i64.add
    local.get 36
    local.get 3
    i64.add
    local.get 43
    local.get 42
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 36
    local.get 35
    i64.add
    local.tee 35
    local.get 38
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 38
    i64.add
    local.tee 42
    local.get 9
    i64.add
    local.get 42
    local.get 30
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 30
    local.get 37
    i64.add
    local.tee 37
    local.get 38
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 38
    i64.add
    local.tee 42
    local.get 30
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 30
    local.get 37
    i64.add
    local.tee 37
    local.get 38
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 38
    i64.add
    local.tee 43
    local.get 20
    i64.add
    local.get 43
    local.get 41
    local.get 2
    i64.add
    local.get 31
    local.get 29
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 29
    i64.add
    local.tee 31
    local.get 5
    i64.add
    local.get 31
    local.get 36
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 31
    local.get 23
    local.get 34
    i64.add
    local.tee 23
    i64.add
    local.tee 34
    local.get 29
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 29
    i64.add
    local.tee 36
    local.get 31
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 31
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 41
    local.get 32
    local.get 24
    i64.add
    local.get 23
    local.get 22
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 22
    i64.add
    local.tee 23
    local.get 19
    i64.add
    local.get 23
    local.get 21
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 21
    local.get 35
    i64.add
    local.tee 23
    local.get 22
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 22
    i64.add
    local.tee 32
    local.get 21
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 21
    local.get 23
    i64.add
    local.tee 23
    i64.add
    local.tee 35
    local.get 38
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 38
    i64.add
    local.tee 43
    local.get 6
    i64.add
    local.get 36
    local.get 18
    i64.add
    local.get 44
    local.get 39
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 36
    local.get 40
    i64.add
    local.tee 39
    local.get 28
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 28
    i64.add
    local.tee 40
    local.get 6
    i64.add
    local.get 40
    local.get 21
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 21
    local.get 37
    i64.add
    local.tee 37
    local.get 28
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 28
    i64.add
    local.tee 40
    local.get 21
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 21
    local.get 37
    i64.add
    local.tee 37
    local.get 28
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 28
    i64.add
    local.tee 44
    local.get 10
    i64.add
    local.get 44
    local.get 42
    local.get 4
    i64.add
    local.get 23
    local.get 22
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 22
    i64.add
    local.tee 23
    local.get 11
    i64.add
    local.get 23
    local.get 36
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 23
    local.get 31
    local.get 34
    i64.add
    local.tee 31
    i64.add
    local.tee 34
    local.get 22
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 22
    i64.add
    local.tee 36
    local.get 23
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 23
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 42
    local.get 32
    local.get 14
    i64.add
    local.get 31
    local.get 29
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 29
    i64.add
    local.tee 31
    local.get 15
    i64.add
    local.get 31
    local.get 30
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 30
    local.get 39
    i64.add
    local.tee 31
    local.get 29
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 29
    i64.add
    local.tee 32
    local.get 30
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 30
    local.get 31
    i64.add
    local.tee 31
    i64.add
    local.tee 39
    local.get 28
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 28
    i64.add
    local.tee 44
    local.get 11
    i64.add
    local.get 36
    local.get 2
    i64.add
    local.get 43
    local.get 41
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 36
    local.get 35
    i64.add
    local.tee 35
    local.get 38
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 38
    i64.add
    local.tee 41
    local.get 15
    i64.add
    local.get 41
    local.get 30
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 30
    local.get 37
    i64.add
    local.tee 37
    local.get 38
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 38
    i64.add
    local.tee 41
    local.get 30
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 30
    local.get 37
    i64.add
    local.tee 37
    local.get 38
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 38
    i64.add
    local.tee 43
    local.get 3
    i64.add
    local.get 43
    local.get 40
    local.get 9
    i64.add
    local.get 31
    local.get 29
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 29
    i64.add
    local.tee 31
    local.get 14
    i64.add
    local.get 31
    local.get 36
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 31
    local.get 23
    local.get 34
    i64.add
    local.tee 23
    i64.add
    local.tee 34
    local.get 29
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 29
    i64.add
    local.tee 36
    local.get 31
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 31
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 40
    local.get 32
    local.get 18
    i64.add
    local.get 23
    local.get 22
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 22
    i64.add
    local.tee 23
    local.get 13
    i64.add
    local.get 23
    local.get 21
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 21
    local.get 35
    i64.add
    local.tee 23
    local.get 22
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 22
    i64.add
    local.tee 32
    local.get 21
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 21
    local.get 23
    i64.add
    local.tee 23
    i64.add
    local.tee 35
    local.get 38
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 38
    i64.add
    local.tee 43
    local.get 5
    i64.add
    local.get 36
    local.get 12
    i64.add
    local.get 44
    local.get 42
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 36
    local.get 39
    i64.add
    local.tee 39
    local.get 28
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 28
    i64.add
    local.tee 42
    local.get 4
    i64.add
    local.get 42
    local.get 21
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 21
    local.get 37
    i64.add
    local.tee 37
    local.get 28
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 28
    i64.add
    local.tee 42
    local.get 21
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 21
    local.get 37
    i64.add
    local.tee 37
    local.get 28
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 28
    i64.add
    local.tee 44
    local.get 13
    i64.add
    local.get 44
    local.get 41
    local.get 5
    i64.add
    local.get 23
    local.get 22
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 22
    i64.add
    local.tee 23
    local.get 20
    i64.add
    local.get 23
    local.get 36
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 23
    local.get 31
    local.get 34
    i64.add
    local.tee 31
    i64.add
    local.tee 34
    local.get 22
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 22
    i64.add
    local.tee 36
    local.get 23
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 23
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 41
    local.get 32
    local.get 19
    i64.add
    local.get 31
    local.get 29
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 29
    i64.add
    local.tee 31
    local.get 24
    i64.add
    local.get 31
    local.get 30
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 30
    local.get 39
    i64.add
    local.tee 31
    local.get 29
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 29
    i64.add
    local.tee 32
    local.get 30
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 30
    local.get 31
    i64.add
    local.tee 31
    i64.add
    local.tee 39
    local.get 28
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 28
    i64.add
    local.tee 44
    local.get 6
    i64.add
    local.get 36
    local.get 15
    i64.add
    local.get 43
    local.get 40
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 36
    local.get 35
    i64.add
    local.tee 35
    local.get 38
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 38
    i64.add
    local.tee 40
    local.get 24
    i64.add
    local.get 40
    local.get 30
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 30
    local.get 37
    i64.add
    local.tee 37
    local.get 38
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 38
    i64.add
    local.tee 40
    local.get 30
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 30
    local.get 37
    i64.add
    local.tee 37
    local.get 38
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 38
    i64.add
    local.tee 43
    local.get 14
    i64.add
    local.get 43
    local.get 42
    local.get 4
    i64.add
    local.get 31
    local.get 29
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 29
    i64.add
    local.tee 31
    local.get 20
    i64.add
    local.get 31
    local.get 36
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 31
    local.get 23
    local.get 34
    i64.add
    local.tee 23
    i64.add
    local.tee 34
    local.get 29
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 29
    i64.add
    local.tee 36
    local.get 31
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 31
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 42
    local.get 32
    local.get 11
    i64.add
    local.get 23
    local.get 22
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 22
    i64.add
    local.tee 23
    local.get 12
    i64.add
    local.get 21
    local.get 23
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 21
    local.get 35
    i64.add
    local.tee 23
    local.get 22
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 22
    i64.add
    local.tee 32
    local.get 21
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 21
    local.get 23
    i64.add
    local.tee 23
    i64.add
    local.tee 35
    local.get 38
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 38
    i64.add
    local.tee 43
    local.get 10
    i64.add
    local.get 36
    local.get 3
    i64.add
    local.get 44
    local.get 41
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 36
    local.get 39
    i64.add
    local.tee 39
    local.get 28
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 28
    i64.add
    local.tee 41
    local.get 2
    i64.add
    local.get 41
    local.get 21
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 21
    local.get 37
    i64.add
    local.tee 37
    local.get 28
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 28
    i64.add
    local.tee 41
    local.get 21
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 21
    local.get 37
    i64.add
    local.tee 37
    local.get 28
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 28
    i64.add
    local.tee 44
    local.get 3
    i64.add
    local.get 44
    local.get 40
    local.get 9
    i64.add
    local.get 23
    local.get 22
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 22
    i64.add
    local.tee 23
    local.get 19
    i64.add
    local.get 36
    local.get 23
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 23
    local.get 31
    local.get 34
    i64.add
    local.tee 31
    i64.add
    local.tee 34
    local.get 22
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 22
    i64.add
    local.tee 36
    local.get 23
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 23
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 40
    local.get 32
    local.get 18
    i64.add
    local.get 31
    local.get 29
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 29
    i64.add
    local.tee 31
    local.get 10
    i64.add
    local.get 31
    local.get 30
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 30
    local.get 39
    i64.add
    local.tee 31
    local.get 29
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 29
    i64.add
    local.tee 32
    local.get 30
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 30
    local.get 31
    i64.add
    local.tee 31
    i64.add
    local.tee 39
    local.get 28
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 28
    i64.add
    local.tee 44
    local.get 2
    i64.add
    local.get 36
    local.get 20
    i64.add
    local.get 43
    local.get 42
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 36
    local.get 35
    i64.add
    local.tee 35
    local.get 38
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 38
    i64.add
    local.tee 42
    local.get 14
    i64.add
    local.get 42
    local.get 30
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 30
    local.get 37
    i64.add
    local.tee 37
    local.get 38
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 38
    i64.add
    local.tee 42
    local.get 30
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 30
    local.get 37
    i64.add
    local.tee 37
    local.get 38
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 38
    i64.add
    local.tee 43
    local.get 13
    i64.add
    local.get 43
    local.get 41
    local.get 15
    i64.add
    local.get 31
    local.get 29
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 29
    i64.add
    local.tee 31
    local.get 11
    i64.add
    local.get 31
    local.get 36
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 31
    local.get 23
    local.get 34
    i64.add
    local.tee 23
    i64.add
    local.tee 34
    local.get 29
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 29
    i64.add
    local.tee 36
    local.get 31
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 31
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 41
    local.get 32
    local.get 19
    i64.add
    local.get 23
    local.get 22
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 22
    i64.add
    local.tee 23
    local.get 4
    i64.add
    local.get 21
    local.get 23
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 21
    local.get 35
    i64.add
    local.tee 23
    local.get 22
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 22
    i64.add
    local.tee 32
    local.get 21
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 21
    local.get 23
    i64.add
    local.tee 23
    i64.add
    local.tee 35
    local.get 38
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 38
    i64.add
    local.tee 43
    local.get 9
    i64.add
    local.get 36
    local.get 6
    i64.add
    local.get 44
    local.get 40
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 36
    local.get 39
    i64.add
    local.tee 39
    local.get 28
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 28
    i64.add
    local.tee 40
    local.get 18
    i64.add
    local.get 40
    local.get 21
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 21
    local.get 37
    i64.add
    local.tee 37
    local.get 28
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 28
    i64.add
    local.tee 40
    local.get 21
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 21
    local.get 37
    i64.add
    local.tee 37
    local.get 28
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 28
    i64.add
    local.tee 44
    local.get 6
    i64.add
    local.get 44
    local.get 42
    local.get 24
    i64.add
    local.get 23
    local.get 22
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 22
    i64.add
    local.tee 23
    local.get 9
    i64.add
    local.get 36
    local.get 23
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 23
    local.get 31
    local.get 34
    i64.add
    local.tee 31
    i64.add
    local.tee 34
    local.get 22
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 22
    i64.add
    local.tee 36
    local.get 23
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 23
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 42
    local.get 32
    local.get 12
    i64.add
    local.get 31
    local.get 29
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 29
    i64.add
    local.tee 31
    local.get 5
    i64.add
    local.get 31
    local.get 30
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 30
    local.get 39
    i64.add
    local.tee 31
    local.get 29
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 29
    i64.add
    local.tee 32
    local.get 30
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 30
    local.get 31
    i64.add
    local.tee 31
    i64.add
    local.tee 39
    local.get 28
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 28
    i64.add
    local.tee 44
    local.get 13
    i64.add
    local.get 36
    local.get 18
    i64.add
    local.get 43
    local.get 41
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 36
    local.get 35
    i64.add
    local.tee 35
    local.get 38
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 38
    i64.add
    local.tee 41
    local.get 12
    i64.add
    local.get 41
    local.get 30
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 30
    local.get 37
    i64.add
    local.tee 37
    local.get 38
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 38
    i64.add
    local.tee 41
    local.get 30
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 30
    local.get 37
    i64.add
    local.tee 37
    local.get 38
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 38
    i64.add
    local.tee 43
    local.get 24
    i64.add
    local.get 43
    local.get 40
    local.get 14
    i64.add
    local.get 31
    local.get 29
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 29
    i64.add
    local.tee 31
    local.get 10
    i64.add
    local.get 31
    local.get 36
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 31
    local.get 23
    local.get 34
    i64.add
    local.tee 23
    i64.add
    local.tee 34
    local.get 29
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 29
    i64.add
    local.tee 36
    local.get 31
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 31
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 40
    local.get 32
    local.get 4
    i64.add
    local.get 23
    local.get 22
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 22
    i64.add
    local.tee 23
    local.get 3
    i64.add
    local.get 21
    local.get 23
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 21
    local.get 35
    i64.add
    local.tee 23
    local.get 22
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 22
    i64.add
    local.tee 32
    local.get 21
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 21
    local.get 23
    i64.add
    local.tee 23
    i64.add
    local.tee 35
    local.get 38
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 38
    i64.add
    local.tee 43
    local.get 11
    i64.add
    local.get 36
    local.get 11
    i64.add
    local.get 44
    local.get 42
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 36
    local.get 39
    i64.add
    local.tee 39
    local.get 28
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 28
    i64.add
    local.tee 42
    local.get 5
    i64.add
    local.get 42
    local.get 21
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 21
    local.get 37
    i64.add
    local.tee 37
    local.get 28
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 28
    i64.add
    local.tee 42
    local.get 21
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 21
    local.get 37
    i64.add
    local.tee 37
    local.get 28
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 28
    i64.add
    local.tee 44
    local.get 24
    i64.add
    local.get 44
    local.get 41
    local.get 15
    i64.add
    local.get 23
    local.get 22
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 22
    i64.add
    local.tee 23
    local.get 2
    i64.add
    local.get 36
    local.get 23
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 23
    local.get 31
    local.get 34
    i64.add
    local.tee 31
    i64.add
    local.tee 34
    local.get 22
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 22
    i64.add
    local.tee 36
    local.get 23
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 23
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 41
    local.get 32
    local.get 20
    i64.add
    local.get 31
    local.get 29
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 29
    i64.add
    local.tee 31
    local.get 19
    i64.add
    local.get 31
    local.get 30
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 30
    local.get 39
    i64.add
    local.tee 31
    local.get 29
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 29
    i64.add
    local.tee 32
    local.get 30
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 30
    local.get 31
    i64.add
    local.tee 31
    i64.add
    local.tee 39
    local.get 28
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 28
    i64.add
    local.tee 44
    local.get 20
    i64.add
    local.get 36
    local.get 13
    i64.add
    local.get 43
    local.get 40
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 36
    local.get 35
    i64.add
    local.tee 35
    local.get 38
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 38
    i64.add
    local.tee 40
    local.get 2
    i64.add
    local.get 40
    local.get 30
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 30
    local.get 37
    i64.add
    local.tee 37
    local.get 38
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 38
    i64.add
    local.tee 40
    local.get 30
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 30
    local.get 37
    i64.add
    local.tee 37
    local.get 38
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 38
    i64.add
    local.tee 43
    local.get 9
    i64.add
    local.get 43
    local.get 42
    local.get 19
    i64.add
    local.get 31
    local.get 29
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 29
    i64.add
    local.tee 31
    local.get 18
    i64.add
    local.get 31
    local.get 36
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 31
    local.get 23
    local.get 34
    i64.add
    local.tee 23
    i64.add
    local.tee 34
    local.get 29
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 29
    i64.add
    local.tee 36
    local.get 31
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 31
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 42
    local.get 32
    local.get 6
    i64.add
    local.get 23
    local.get 22
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 22
    i64.add
    local.tee 23
    local.get 5
    i64.add
    local.get 21
    local.get 23
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 21
    local.get 35
    i64.add
    local.tee 23
    local.get 22
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 22
    i64.add
    local.tee 32
    local.get 21
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 21
    local.get 23
    i64.add
    local.tee 23
    i64.add
    local.tee 35
    local.get 38
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 38
    i64.add
    local.tee 43
    local.get 18
    i64.add
    local.get 36
    local.get 10
    i64.add
    local.get 44
    local.get 41
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 36
    local.get 39
    i64.add
    local.tee 39
    local.get 28
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 28
    i64.add
    local.tee 41
    local.get 15
    i64.add
    local.get 41
    local.get 21
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 21
    local.get 37
    i64.add
    local.tee 37
    local.get 28
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 28
    i64.add
    local.tee 41
    local.get 21
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 21
    local.get 37
    i64.add
    local.tee 37
    local.get 28
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 28
    i64.add
    local.tee 44
    local.get 19
    i64.add
    local.get 44
    local.get 40
    local.get 12
    i64.add
    local.get 23
    local.get 22
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 22
    i64.add
    local.tee 23
    local.get 14
    i64.add
    local.get 36
    local.get 23
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 23
    local.get 31
    local.get 34
    i64.add
    local.tee 31
    i64.add
    local.tee 34
    local.get 22
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 22
    i64.add
    local.tee 36
    local.get 23
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 23
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 40
    local.get 32
    local.get 3
    i64.add
    local.get 31
    local.get 29
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 29
    i64.add
    local.tee 31
    local.get 4
    i64.add
    local.get 31
    local.get 30
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 30
    local.get 39
    i64.add
    local.tee 31
    local.get 29
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 29
    i64.add
    local.tee 32
    local.get 30
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 30
    local.get 31
    i64.add
    local.tee 31
    i64.add
    local.tee 39
    local.get 28
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 28
    i64.add
    local.tee 44
    local.get 4
    i64.add
    local.get 36
    local.get 9
    i64.add
    local.get 43
    local.get 42
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 36
    local.get 35
    i64.add
    local.tee 35
    local.get 38
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 38
    i64.add
    local.tee 42
    local.get 11
    i64.add
    local.get 42
    local.get 30
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 30
    local.get 37
    i64.add
    local.tee 37
    local.get 38
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 38
    i64.add
    local.tee 42
    local.get 30
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 30
    local.get 37
    i64.add
    local.tee 37
    local.get 38
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 38
    i64.add
    local.tee 43
    local.get 12
    i64.add
    local.get 43
    local.get 41
    local.get 5
    i64.add
    local.get 31
    local.get 29
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 29
    i64.add
    local.tee 31
    local.get 24
    i64.add
    local.get 31
    local.get 36
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 31
    local.get 23
    local.get 34
    i64.add
    local.tee 23
    i64.add
    local.tee 34
    local.get 29
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 29
    i64.add
    local.tee 36
    local.get 31
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 31
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 41
    local.get 32
    local.get 2
    i64.add
    local.get 23
    local.get 22
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 22
    i64.add
    local.tee 23
    local.get 10
    i64.add
    local.get 21
    local.get 23
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 21
    local.get 35
    i64.add
    local.tee 23
    local.get 22
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 22
    i64.add
    local.tee 32
    local.get 21
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 21
    local.get 23
    i64.add
    local.tee 23
    i64.add
    local.tee 35
    local.get 38
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 38
    i64.add
    local.tee 43
    local.get 20
    i64.add
    local.get 36
    local.get 15
    i64.add
    local.get 44
    local.get 40
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 36
    local.get 39
    i64.add
    local.tee 39
    local.get 28
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 28
    i64.add
    local.tee 40
    local.get 20
    i64.add
    local.get 40
    local.get 21
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 20
    local.get 37
    i64.add
    local.tee 21
    local.get 28
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 28
    i64.add
    local.tee 37
    local.get 20
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 20
    local.get 21
    i64.add
    local.tee 21
    local.get 28
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 28
    i64.add
    local.tee 40
    local.get 18
    i64.add
    local.get 40
    local.get 42
    local.get 6
    i64.add
    local.get 23
    local.get 22
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 18
    i64.add
    local.tee 22
    local.get 3
    i64.add
    local.get 36
    local.get 22
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 22
    local.get 31
    local.get 34
    i64.add
    local.tee 23
    i64.add
    local.tee 31
    local.get 18
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 18
    i64.add
    local.tee 34
    local.get 22
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 22
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 36
    local.get 32
    local.get 13
    i64.add
    local.get 23
    local.get 29
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 23
    i64.add
    local.tee 29
    local.get 14
    i64.add
    local.get 29
    local.get 30
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 29
    local.get 39
    i64.add
    local.tee 30
    local.get 23
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 23
    i64.add
    local.tee 32
    local.get 29
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 29
    local.get 30
    i64.add
    local.tee 30
    i64.add
    local.tee 39
    local.get 28
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 28
    i64.add
    local.tee 40
    local.get 24
    i64.add
    local.get 34
    local.get 4
    i64.add
    local.get 43
    local.get 41
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 24
    local.get 35
    i64.add
    local.tee 4
    local.get 38
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 34
    i64.add
    local.tee 35
    local.get 13
    i64.add
    local.get 35
    local.get 29
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 13
    local.get 21
    i64.add
    local.tee 21
    local.get 34
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 29
    i64.add
    local.tee 34
    local.get 13
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 13
    local.get 21
    i64.add
    local.tee 21
    local.get 29
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 29
    i64.add
    local.tee 35
    local.get 10
    i64.add
    local.get 35
    local.get 37
    local.get 3
    i64.add
    local.get 30
    local.get 23
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 10
    i64.add
    local.tee 3
    local.get 12
    i64.add
    local.get 3
    local.get 24
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 3
    local.get 22
    local.get 31
    i64.add
    local.tee 24
    i64.add
    local.tee 12
    local.get 10
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 10
    i64.add
    local.tee 22
    local.get 3
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 3
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 23
    local.get 32
    local.get 5
    i64.add
    local.get 24
    local.get 18
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 18
    i64.add
    local.tee 5
    local.get 6
    i64.add
    local.get 20
    local.get 5
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 6
    local.get 4
    i64.add
    local.tee 5
    local.get 18
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 18
    i64.add
    local.tee 24
    local.get 6
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 6
    local.get 5
    i64.add
    local.tee 5
    i64.add
    local.tee 4
    local.get 29
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 20
    i64.add
    local.tee 29
    local.get 26
    i64.xor
    local.get 24
    local.get 9
    i64.add
    local.get 3
    local.get 12
    i64.add
    local.tee 9
    local.get 10
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 10
    i64.add
    local.tee 3
    local.get 2
    i64.add
    local.get 3
    local.get 13
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 2
    local.get 40
    local.get 36
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 3
    local.get 39
    i64.add
    local.tee 24
    i64.add
    local.tee 12
    local.get 10
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 10
    i64.add
    local.tee 13
    local.get 2
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 2
    local.get 12
    i64.add
    local.tee 12
    i64.xor
    i64.store offset=24
    local.get 0
    local.get 8
    local.get 15
    local.get 34
    local.get 11
    i64.add
    local.get 5
    local.get 18
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 11
    i64.add
    local.tee 18
    i64.add
    local.get 3
    local.get 18
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 3
    local.get 9
    i64.add
    local.tee 9
    local.get 11
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 11
    i64.add
    local.tee 18
    i64.xor
    local.get 19
    local.get 22
    local.get 14
    i64.add
    local.get 24
    local.get 28
    i64.xor
    i64.const 1
    i64.rotl
    local.tee 5
    i64.add
    local.tee 24
    i64.add
    local.get 24
    local.get 6
    i64.xor
    i64.const 32
    i64.rotl
    local.tee 6
    local.get 21
    i64.add
    local.tee 19
    local.get 5
    i64.xor
    i64.const 40
    i64.rotl
    local.tee 5
    i64.add
    local.tee 24
    local.get 6
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 6
    local.get 19
    i64.add
    local.tee 19
    i64.xor
    i64.store
    local.get 0
    local.get 33
    local.get 18
    local.get 3
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 3
    local.get 9
    i64.add
    local.tee 9
    i64.xor
    local.get 24
    i64.xor
    i64.store offset=16
    local.get 0
    local.get 13
    local.get 17
    i64.xor
    local.get 29
    local.get 23
    i64.xor
    i64.const 48
    i64.rotl
    local.tee 18
    local.get 4
    i64.add
    local.tee 24
    i64.xor
    i64.store offset=8
    local.get 0
    local.get 25
    local.get 19
    local.get 5
    i64.xor
    i64.const 1
    i64.rotl
    i64.xor
    local.get 3
    i64.xor
    i64.store offset=56
    local.get 0
    local.get 27
    local.get 12
    local.get 10
    i64.xor
    i64.const 1
    i64.rotl
    i64.xor
    local.get 18
    i64.xor
    i64.store offset=48
    local.get 0
    local.get 16
    local.get 9
    local.get 11
    i64.xor
    i64.const 1
    i64.rotl
    i64.xor
    local.get 6
    i64.xor
    i64.store offset=40
    local.get 0
    local.get 7
    local.get 24
    local.get 20
    i64.xor
    i64.const 1
    i64.rotl
    i64.xor
    local.get 2
    i64.xor
    i64.store offset=32)
  (func $_ZN8blake2ya7blake2b7Param2b6digest17hec12fe20cb3aec71E (type 0) (param i32 i32)
    block  ;; label = @1
      local.get 1
      i32.const -1
      i32.add
      i32.const 255
      i32.and
      i32.const 64
      i32.lt_u
      br_if 0 (;@1;)
      i32.const 1048803
      i32.const 35
      i32.const 1048840
      call $_ZN4core9panicking5panic17hb7d13004db45f2e3E
      unreachable
    end
    local.get 0
    local.get 1
    i32.store8)
  (func $_ZN8blake2ya7blake2b7Blake2b6update17h23a8d8fd43871b5bE (type 4) (param i32 i32 i32)
    (local i32 i32 i32 i32 i64 i64 i32 i32)
    global.get $__stack_pointer
    i32.const 128
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  i32.const 128
                  local.get 0
                  i32.load offset=352
                  local.tee 4
                  i32.sub
                  local.tee 5
                  local.get 2
                  i32.ge_u
                  br_if 0 (;@7;)
                  local.get 4
                  br_if 1 (;@6;)
                  i32.const 0
                  local.set 4
                  local.get 2
                  local.set 6
                  br 4 (;@3;)
                end
                local.get 4
                local.get 2
                i32.add
                local.tee 5
                local.get 4
                i32.lt_u
                br_if 1 (;@5;)
                local.get 5
                i32.const 128
                i32.gt_u
                br_if 2 (;@4;)
                local.get 0
                local.get 4
                i32.add
                local.get 1
                local.get 2
                call $memcpy
                drop
                local.get 0
                i32.load offset=352
                local.get 2
                i32.add
                local.set 6
                br 4 (;@2;)
              end
              block  ;; label = @6
                local.get 4
                i32.const 128
                i32.gt_u
                br_if 0 (;@6;)
                local.get 0
                local.get 4
                i32.add
                local.get 1
                local.get 5
                call $memcpy
                drop
                local.get 0
                local.get 0
                i64.load offset=320
                local.tee 7
                i64.const 128
                i64.add
                local.tee 8
                i64.store offset=320
                local.get 0
                local.get 0
                i64.load offset=328
                local.get 7
                i64.const -129
                i64.gt_u
                i64.extend_i32_u
                i64.add
                local.tee 7
                i64.store offset=328
                local.get 3
                local.get 0
                i64.load offset=120
                i64.store offset=120
                local.get 3
                local.get 0
                i64.load offset=112
                i64.store offset=112
                local.get 3
                local.get 0
                i64.load offset=104
                i64.store offset=104
                local.get 3
                local.get 0
                i64.load offset=96
                i64.store offset=96
                local.get 3
                local.get 0
                i64.load offset=88
                i64.store offset=88
                local.get 3
                local.get 0
                i64.load offset=80
                i64.store offset=80
                local.get 3
                local.get 0
                i64.load offset=72
                i64.store offset=72
                local.get 3
                local.get 0
                i64.load offset=64
                i64.store offset=64
                local.get 3
                local.get 0
                i64.load offset=56
                i64.store offset=56
                local.get 3
                local.get 0
                i64.load offset=48
                i64.store offset=48
                local.get 3
                local.get 0
                i64.load offset=40
                i64.store offset=40
                local.get 3
                local.get 0
                i64.load offset=32
                i64.store offset=32
                local.get 3
                local.get 0
                i64.load offset=24
                i64.store offset=24
                local.get 3
                local.get 0
                i64.load offset=16
                i64.store offset=16
                local.get 3
                local.get 0
                i64.load offset=8
                i64.store offset=8
                local.get 3
                local.get 0
                i64.load
                i64.store
                local.get 0
                i32.const 256
                i32.add
                local.get 3
                local.get 8
                local.get 7
                local.get 0
                i64.load offset=336
                local.get 0
                i64.load offset=344
                call $_ZN8blake2ya7blake2b6reduce17hce9cc40fc7481622E
                local.get 2
                i32.const 128
                local.get 0
                i32.load offset=352
                i32.sub
                local.tee 4
                i32.sub
                local.set 6
                br 3 (;@3;)
              end
              local.get 4
              i32.const 128
              i32.const 1048920
              call $_ZN4core5slice5index26slice_start_index_len_fail17h6ba96fe804246016E
              unreachable
            end
            local.get 4
            local.get 5
            i32.const 1048936
            call $_ZN4core5slice5index22slice_index_order_fail17h45c0711bdbeba6b0E
            unreachable
          end
          local.get 5
          i32.const 128
          i32.const 1048936
          call $_ZN4core5slice5index24slice_end_index_len_fail17hddeff0f8fd5a93e3E
          unreachable
        end
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 6
                i32.const -1
                i32.add
                local.tee 5
                i32.const 128
                i32.lt_u
                br_if 0 (;@6;)
                local.get 0
                i32.const 256
                i32.add
                local.set 9
                local.get 5
                i32.const 7
                i32.shr_u
                local.set 10
                local.get 6
                local.get 5
                i32.const -128
                i32.and
                i32.sub
                local.set 6
                loop  ;; label = @7
                  local.get 4
                  i32.const 128
                  i32.add
                  local.set 5
                  local.get 4
                  i32.const -129
                  i32.gt_u
                  br_if 2 (;@5;)
                  local.get 5
                  local.get 2
                  i32.gt_u
                  br_if 3 (;@4;)
                  local.get 0
                  local.get 1
                  local.get 4
                  i32.add
                  i32.const 128
                  call $memcpy
                  local.tee 4
                  local.get 4
                  i64.load offset=320
                  local.tee 7
                  i64.const 128
                  i64.add
                  local.tee 8
                  i64.store offset=320
                  local.get 4
                  local.get 4
                  i64.load offset=328
                  local.get 7
                  i64.const -129
                  i64.gt_u
                  i64.extend_i32_u
                  i64.add
                  local.tee 7
                  i64.store offset=328
                  local.get 3
                  local.get 4
                  i64.load offset=120
                  i64.store offset=120
                  local.get 3
                  local.get 4
                  i64.load offset=112
                  i64.store offset=112
                  local.get 3
                  local.get 4
                  i64.load offset=104
                  i64.store offset=104
                  local.get 3
                  local.get 4
                  i64.load offset=96
                  i64.store offset=96
                  local.get 3
                  local.get 4
                  i64.load offset=88
                  i64.store offset=88
                  local.get 3
                  local.get 4
                  i64.load offset=80
                  i64.store offset=80
                  local.get 3
                  local.get 4
                  i64.load offset=72
                  i64.store offset=72
                  local.get 3
                  local.get 4
                  i64.load offset=64
                  i64.store offset=64
                  local.get 3
                  local.get 4
                  i64.load offset=56
                  i64.store offset=56
                  local.get 3
                  local.get 4
                  i64.load offset=48
                  i64.store offset=48
                  local.get 3
                  local.get 4
                  i64.load offset=40
                  i64.store offset=40
                  local.get 3
                  local.get 4
                  i64.load offset=32
                  i64.store offset=32
                  local.get 3
                  local.get 4
                  i64.load offset=24
                  i64.store offset=24
                  local.get 3
                  local.get 4
                  i64.load offset=16
                  i64.store offset=16
                  local.get 3
                  local.get 4
                  i64.load offset=8
                  i64.store offset=8
                  local.get 3
                  local.get 4
                  i64.load
                  i64.store
                  local.get 9
                  local.get 3
                  local.get 8
                  local.get 7
                  local.get 4
                  i64.load offset=336
                  local.get 4
                  i64.load offset=344
                  call $_ZN8blake2ya7blake2b6reduce17hce9cc40fc7481622E
                  local.get 5
                  local.set 4
                  local.get 10
                  i32.const -1
                  i32.add
                  local.tee 10
                  br_if 0 (;@7;)
                end
                block  ;; label = @7
                  local.get 6
                  i32.const 129
                  i32.ge_u
                  br_if 0 (;@7;)
                  local.get 5
                  local.set 4
                  br 4 (;@3;)
                end
                local.get 6
                i32.const 128
                i32.const 1048856
                call $_ZN4core5slice5index24slice_end_index_len_fail17hddeff0f8fd5a93e3E
                unreachable
              end
              local.get 4
              local.get 2
              i32.le_u
              br_if 2 (;@3;)
              local.get 4
              local.get 2
              i32.const 1048888
              call $_ZN4core5slice5index26slice_start_index_len_fail17h6ba96fe804246016E
              unreachable
            end
            local.get 4
            local.get 5
            i32.const 1048904
            call $_ZN4core5slice5index22slice_index_order_fail17h45c0711bdbeba6b0E
            unreachable
          end
          local.get 5
          local.get 2
          i32.const 1048904
          call $_ZN4core5slice5index24slice_end_index_len_fail17hddeff0f8fd5a93e3E
          unreachable
        end
        local.get 6
        local.get 2
        local.get 4
        i32.sub
        local.tee 5
        i32.ne
        br_if 1 (;@1;)
        local.get 0
        local.get 1
        local.get 4
        i32.add
        local.get 6
        call $memcpy
        drop
      end
      local.get 0
      local.get 6
      i32.store offset=352
      local.get 3
      i32.const 128
      i32.add
      global.set $__stack_pointer
      return
    end
    local.get 6
    local.get 5
    i32.const 1048872
    call $_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$15copy_from_slice17len_mismatch_fail17h0920f35544df82f7E
    unreachable)
  (func $_ZN8blake2ya7blake2b7Blake2b6digest17h76838ece2e04fba6E (type 4) (param i32 i32 i32)
    (local i32 i32 i64 i64)
    global.get $__stack_pointer
    i32.const 128
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          i32.load offset=352
          local.tee 4
          i32.const 128
          i32.gt_u
          br_if 0 (;@3;)
          i64.const 128
          local.set 5
          block  ;; label = @4
            local.get 4
            i32.const 128
            i32.eq
            br_if 0 (;@4;)
            local.get 0
            local.get 4
            i32.add
            i32.const 0
            i32.const 128
            local.get 4
            i32.sub
            call $memset
            drop
            local.get 0
            i64.load32_u offset=352
            local.set 5
          end
          local.get 0
          i64.const -1
          i64.store offset=336
          local.get 0
          local.get 0
          i64.load offset=320
          local.tee 6
          local.get 5
          i64.add
          local.tee 5
          i64.store offset=320
          local.get 0
          local.get 0
          i64.load offset=328
          local.get 5
          local.get 6
          i64.lt_u
          i64.extend_i32_u
          i64.add
          local.tee 6
          i64.store offset=328
          local.get 3
          local.get 0
          i64.load offset=120
          i64.store offset=120
          local.get 3
          local.get 0
          i64.load offset=112
          i64.store offset=112
          local.get 3
          local.get 0
          i64.load offset=104
          i64.store offset=104
          local.get 3
          local.get 0
          i64.load offset=96
          i64.store offset=96
          local.get 3
          local.get 0
          i64.load offset=88
          i64.store offset=88
          local.get 3
          local.get 0
          i64.load offset=80
          i64.store offset=80
          local.get 3
          local.get 0
          i64.load offset=72
          i64.store offset=72
          local.get 3
          local.get 0
          i64.load offset=64
          i64.store offset=64
          local.get 3
          local.get 0
          i64.load offset=56
          i64.store offset=56
          local.get 3
          local.get 0
          i64.load offset=48
          i64.store offset=48
          local.get 3
          local.get 0
          i64.load offset=40
          i64.store offset=40
          local.get 3
          local.get 0
          i64.load offset=32
          i64.store offset=32
          local.get 3
          local.get 0
          i64.load offset=24
          i64.store offset=24
          local.get 3
          local.get 0
          i64.load offset=16
          i64.store offset=16
          local.get 3
          local.get 0
          i64.load offset=8
          i64.store offset=8
          local.get 3
          local.get 0
          i64.load
          i64.store
          local.get 0
          i32.const 256
          i32.add
          local.get 3
          local.get 5
          local.get 6
          i64.const -1
          local.get 0
          i64.load offset=344
          call $_ZN8blake2ya7blake2b6reduce17hce9cc40fc7481622E
          local.get 3
          local.get 0
          i64.load offset=312
          i64.store offset=56
          local.get 3
          local.get 0
          i64.load offset=304
          i64.store offset=48
          local.get 3
          local.get 0
          i64.load offset=296
          i64.store offset=40
          local.get 3
          local.get 0
          i64.load offset=288
          i64.store offset=32
          local.get 3
          local.get 0
          i64.load offset=280
          i64.store offset=24
          local.get 3
          local.get 0
          i64.load offset=272
          i64.store offset=16
          local.get 3
          local.get 0
          i64.load offset=264
          i64.store offset=8
          local.get 3
          local.get 0
          i64.load offset=256
          i64.store
          local.get 0
          i32.load8_u offset=128
          local.tee 0
          i32.const 65
          i32.ge_u
          br_if 1 (;@2;)
          local.get 0
          local.get 2
          i32.ne
          br_if 2 (;@1;)
          local.get 1
          local.get 3
          local.get 2
          call $memcpy
          drop
          local.get 3
          i32.const 128
          i32.add
          global.set $__stack_pointer
          return
        end
        local.get 4
        i32.const 128
        i32.const 1048984
        call $_ZN4core5slice5index26slice_start_index_len_fail17h6ba96fe804246016E
        unreachable
      end
      local.get 0
      i32.const 64
      i32.const 1048952
      call $_ZN4core5slice5index24slice_end_index_len_fail17hddeff0f8fd5a93e3E
      unreachable
    end
    local.get 2
    local.get 0
    i32.const 1048968
    call $_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$15copy_from_slice17len_mismatch_fail17h0920f35544df82f7E
    unreachable)
  (func $_ZN8blake2ya7blake2b7blake2b17h53e64c235e511c3eE (type 0) (param i32 i32)
    (local i32 i64)
    global.get $__stack_pointer
    i32.const 496
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    i32.const 8
    i32.add
    i32.const 0
    i32.const 128
    call $memset
    drop
    local.get 2
    i32.const 360
    i32.add
    i32.const 0
    i32.store
    local.get 2
    i32.const 352
    i32.add
    i64.const 0
    i64.store
    local.get 2
    i32.const 344
    i32.add
    i64.const 0
    i64.store
    local.get 2
    i32.const 336
    i32.add
    i64.const 0
    i64.store
    local.get 2
    i64.const 0
    i64.store offset=328
    local.get 2
    i32.const 8
    i32.add
    i32.const 128
    i32.add
    local.get 1
    i32.const 128
    call $memcpy
    drop
    local.get 2
    local.get 2
    i64.load offset=192
    i64.const 6620516959819538809
    i64.xor
    i64.store offset=320
    local.get 2
    local.get 2
    i64.load offset=184
    i64.const 2270897969802886507
    i64.xor
    i64.store offset=312
    local.get 2
    local.get 2
    i64.load offset=176
    i64.const -7276294671716946913
    i64.xor
    i64.store offset=304
    local.get 2
    local.get 2
    i64.load offset=168
    i64.const 5840696475078001361
    i64.xor
    i64.store offset=296
    local.get 2
    local.get 2
    i64.load offset=160
    i64.const -6534734903238641935
    i64.xor
    i64.store offset=288
    local.get 2
    local.get 2
    i64.load offset=152
    i64.const 4354685564936845355
    i64.xor
    i64.store offset=280
    local.get 2
    local.get 2
    i64.load offset=144
    i64.const -4942790177534073029
    i64.xor
    i64.store offset=272
    local.get 2
    local.get 2
    i64.load offset=136
    local.tee 3
    i64.const 7640891576956012808
    i64.xor
    i64.store offset=264
    block  ;; label = @1
      local.get 3
      i64.const 65280
      i64.and
      i64.eqz
      br_if 0 (;@1;)
      local.get 2
      i32.const 368
      i32.add
      i32.const 120
      i32.add
      i64.const 0
      i64.store
      local.get 2
      i32.const 368
      i32.add
      i32.const 112
      i32.add
      i64.const 0
      i64.store
      local.get 2
      i32.const 368
      i32.add
      i32.const 104
      i32.add
      i64.const 0
      i64.store
      local.get 2
      i32.const 368
      i32.add
      i32.const 96
      i32.add
      i64.const 0
      i64.store
      local.get 2
      i32.const 368
      i32.add
      i32.const 88
      i32.add
      i64.const 0
      i64.store
      local.get 2
      i32.const 368
      i32.add
      i32.const 80
      i32.add
      i64.const 0
      i64.store
      local.get 2
      i32.const 368
      i32.add
      i32.const 72
      i32.add
      i64.const 0
      i64.store
      local.get 2
      i32.const 376
      i32.add
      local.get 1
      i32.const 72
      i32.add
      i64.load align=1
      i64.store
      local.get 2
      i32.const 384
      i32.add
      local.get 1
      i32.const 80
      i32.add
      i64.load align=1
      i64.store
      local.get 2
      i32.const 392
      i32.add
      local.get 1
      i32.const 88
      i32.add
      i64.load align=1
      i64.store
      local.get 2
      i32.const 400
      i32.add
      local.get 1
      i32.const 96
      i32.add
      i64.load align=1
      i64.store
      local.get 2
      i32.const 408
      i32.add
      local.get 1
      i32.const 104
      i32.add
      i64.load align=1
      i64.store
      local.get 2
      i32.const 416
      i32.add
      local.get 1
      i32.const 112
      i32.add
      i64.load align=1
      i64.store
      local.get 2
      i32.const 424
      i32.add
      local.get 1
      i32.const 120
      i32.add
      i64.load align=1
      i64.store
      local.get 2
      i64.const 0
      i64.store offset=432
      local.get 2
      local.get 1
      i64.load offset=64 align=1
      i64.store offset=368
      local.get 2
      i32.const 8
      i32.add
      local.get 2
      i32.const 368
      i32.add
      i32.const 128
      call $_ZN8blake2ya7blake2b7Blake2b6update17h23a8d8fd43871b5bE
    end
    local.get 0
    local.get 2
    i32.const 8
    i32.add
    i32.const 360
    call $memcpy
    drop
    local.get 2
    i32.const 496
    i32.add
    global.set $__stack_pointer)
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17he16a8fb985669180E (type 0) (param i32 i32)
    local.get 0
    i64.const -35709768343126598
    i64.store offset=8
    local.get 0
    i64.const 8228273777720398407
    i64.store)
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17he4d2fe6d646ce06fE (type 0) (param i32 i32)
    local.get 0
    i64.const 7199936582794304877
    i64.store offset=8
    local.get 0
    i64.const -5076933981314334344
    i64.store)
  (func $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hb98692ab7fe6ab7fE (type 7) (param i32 i32 i32 i32 i32)
    (local i32 i32 i32 i32 i64)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          local.get 2
          i32.add
          local.tee 2
          local.get 1
          i32.ge_u
          br_if 0 (;@3;)
          i32.const 0
          local.set 6
          br 1 (;@2;)
        end
        i32.const 0
        local.set 6
        block  ;; label = @3
          local.get 3
          local.get 4
          i32.add
          i32.const -1
          i32.add
          i32.const 0
          local.get 3
          i32.sub
          i32.and
          i64.extend_i32_u
          i32.const 8
          i32.const 4
          local.get 4
          i32.const 1
          i32.eq
          select
          local.tee 7
          local.get 0
          i32.load
          local.tee 1
          i32.const 1
          i32.shl
          local.tee 8
          local.get 2
          local.get 8
          local.get 2
          i32.gt_u
          select
          local.tee 2
          local.get 7
          local.get 2
          i32.gt_u
          select
          local.tee 7
          i64.extend_i32_u
          i64.mul
          local.tee 9
          i64.const 32
          i64.shr_u
          i32.wrap_i64
          i32.eqz
          br_if 0 (;@3;)
          br 1 (;@2;)
        end
        local.get 9
        i32.wrap_i64
        local.tee 8
        i32.const -2147483648
        local.get 3
        i32.sub
        i32.gt_u
        br_if 0 (;@2;)
        i32.const 0
        local.set 2
        block  ;; label = @3
          local.get 1
          i32.eqz
          br_if 0 (;@3;)
          local.get 5
          local.get 1
          local.get 4
          i32.mul
          i32.store offset=28
          local.get 5
          local.get 0
          i32.load offset=4
          i32.store offset=20
          local.get 3
          local.set 2
        end
        local.get 5
        local.get 2
        i32.store offset=24
        local.get 5
        i32.const 8
        i32.add
        local.get 3
        local.get 8
        local.get 5
        i32.const 20
        i32.add
        call $_ZN5alloc7raw_vec11finish_grow17hbeceac32ae425d3fE
        local.get 5
        i32.load offset=8
        i32.const 1
        i32.ne
        br_if 1 (;@1;)
        local.get 5
        i32.load offset=16
        local.set 2
        local.get 5
        i32.load offset=12
        local.set 6
      end
      local.get 6
      local.get 2
      i32.const 1049168
      call $_ZN5alloc7raw_vec12handle_error17hcd6c5f33527353caE
      unreachable
    end
    local.get 5
    i32.load offset=12
    local.set 3
    local.get 0
    local.get 7
    i32.store
    local.get 0
    local.get 3
    i32.store offset=4
    local.get 5
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN4core3fmt5Write9write_fmt17h6206e68e5ed68901E (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.const 1049184
    local.get 1
    call $_ZN4core3fmt5write17h2db157f4177a0bcdE)
  (func $_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h754849e789348a4dE (type 8) (param i32)
    (local i32)
    block  ;; label = @1
      local.get 0
      i32.load
      local.tee 1
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      i32.load offset=4
      local.get 1
      i32.const 1
      call $__rust_dealloc
    end)
  (func $_ZN4core3ptr77drop_in_place$LT$std..panicking..begin_panic_handler..FormatStringPayload$GT$17hb1289cf6f1496592E (type 8) (param i32)
    (local i32)
    block  ;; label = @1
      local.get 0
      i32.load
      local.tee 1
      i32.const -2147483648
      i32.or
      i32.const -2147483648
      i32.eq
      br_if 0 (;@1;)
      local.get 0
      i32.load offset=4
      local.get 1
      i32.const 1
      call $__rust_dealloc
    end)
  (func $_ZN4core5panic12PanicPayload6as_str17had35548f12cb95a5E (type 0) (param i32 i32)
    local.get 0
    i32.const 0
    i32.store)
  (func $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$10write_char17hb8fbefe4b2d7bfd9E (type 2) (param i32 i32) (result i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.const 128
        i32.lt_u
        br_if 0 (;@2;)
        local.get 2
        i32.const 0
        i32.store offset=12
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            i32.const 2048
            i32.lt_u
            br_if 0 (;@4;)
            block  ;; label = @5
              local.get 1
              i32.const 65536
              i32.lt_u
              br_if 0 (;@5;)
              local.get 2
              local.get 1
              i32.const 63
              i32.and
              i32.const 128
              i32.or
              i32.store8 offset=15
              local.get 2
              local.get 1
              i32.const 18
              i32.shr_u
              i32.const 240
              i32.or
              i32.store8 offset=12
              local.get 2
              local.get 1
              i32.const 6
              i32.shr_u
              i32.const 63
              i32.and
              i32.const 128
              i32.or
              i32.store8 offset=14
              local.get 2
              local.get 1
              i32.const 12
              i32.shr_u
              i32.const 63
              i32.and
              i32.const 128
              i32.or
              i32.store8 offset=13
              i32.const 4
              local.set 1
              br 2 (;@3;)
            end
            local.get 2
            local.get 1
            i32.const 63
            i32.and
            i32.const 128
            i32.or
            i32.store8 offset=14
            local.get 2
            local.get 1
            i32.const 12
            i32.shr_u
            i32.const 224
            i32.or
            i32.store8 offset=12
            local.get 2
            local.get 1
            i32.const 6
            i32.shr_u
            i32.const 63
            i32.and
            i32.const 128
            i32.or
            i32.store8 offset=13
            i32.const 3
            local.set 1
            br 1 (;@3;)
          end
          local.get 2
          local.get 1
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.store8 offset=13
          local.get 2
          local.get 1
          i32.const 6
          i32.shr_u
          i32.const 192
          i32.or
          i32.store8 offset=12
          i32.const 2
          local.set 1
        end
        block  ;; label = @3
          local.get 0
          i32.load
          local.get 0
          i32.load offset=8
          local.tee 3
          i32.sub
          local.get 1
          i32.ge_u
          br_if 0 (;@3;)
          local.get 0
          local.get 3
          local.get 1
          i32.const 1
          i32.const 1
          call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hb98692ab7fe6ab7fE
          local.get 0
          i32.load offset=8
          local.set 3
        end
        local.get 0
        i32.load offset=4
        local.get 3
        i32.add
        local.get 2
        i32.const 12
        i32.add
        local.get 1
        call $memcpy
        drop
        local.get 0
        local.get 3
        local.get 1
        i32.add
        i32.store offset=8
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 0
        i32.load offset=8
        local.tee 3
        local.get 0
        i32.load
        i32.ne
        br_if 0 (;@2;)
        local.get 0
        i32.const 1049076
        call $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$8grow_one17h57212a4e3c838e92E
      end
      local.get 0
      i32.load offset=4
      local.get 3
      i32.add
      local.get 1
      i32.store8
      local.get 0
      local.get 3
      i32.const 1
      i32.add
      i32.store offset=8
    end
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    i32.const 0)
  (func $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$9write_str17h7abd7ca86aa58925E (type 1) (param i32 i32 i32) (result i32)
    (local i32)
    block  ;; label = @1
      local.get 0
      i32.load
      local.get 0
      i32.load offset=8
      local.tee 3
      i32.sub
      local.get 2
      i32.ge_u
      br_if 0 (;@1;)
      local.get 0
      local.get 3
      local.get 2
      i32.const 1
      i32.const 1
      call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hb98692ab7fe6ab7fE
      local.get 0
      i32.load offset=8
      local.set 3
    end
    local.get 0
    i32.load offset=4
    local.get 3
    i32.add
    local.get 1
    local.get 2
    call $memcpy
    drop
    local.get 0
    local.get 3
    local.get 2
    i32.add
    i32.store offset=8
    i32.const 0)
  (func $_ZN5alloc7raw_vec11finish_grow17hbeceac32ae425d3fE (type 9) (param i32 i32 i32 i32)
    (local i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 2
        i32.const 0
        i32.lt_s
        br_if 0 (;@2;)
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 3
              i32.load offset=4
              i32.eqz
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 3
                i32.load offset=8
                local.tee 4
                br_if 0 (;@6;)
                block  ;; label = @7
                  local.get 2
                  br_if 0 (;@7;)
                  local.get 1
                  local.set 3
                  br 4 (;@3;)
                end
                i32.const 0
                i32.load8_u offset=1050065
                drop
                br 2 (;@4;)
              end
              local.get 3
              i32.load
              local.get 4
              local.get 1
              local.get 2
              call $__rust_realloc
              local.set 3
              br 2 (;@3;)
            end
            block  ;; label = @5
              local.get 2
              br_if 0 (;@5;)
              local.get 1
              local.set 3
              br 2 (;@3;)
            end
            i32.const 0
            i32.load8_u offset=1050065
            drop
          end
          local.get 2
          local.get 1
          call $__rust_alloc
          local.set 3
        end
        block  ;; label = @3
          local.get 3
          i32.eqz
          br_if 0 (;@3;)
          local.get 0
          local.get 2
          i32.store offset=8
          local.get 0
          local.get 3
          i32.store offset=4
          local.get 0
          i32.const 0
          i32.store
          return
        end
        local.get 0
        local.get 2
        i32.store offset=8
        local.get 0
        local.get 1
        i32.store offset=4
        br 1 (;@1;)
      end
      local.get 0
      i32.const 0
      i32.store offset=4
    end
    local.get 0
    i32.const 1
    i32.store)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$12unlink_chunk17h0d0f475ea8907bb5E (type 0) (param i32 i32)
    (local i32 i32 i32 i32)
    local.get 0
    i32.load offset=12
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          i32.const 256
          i32.lt_u
          br_if 0 (;@3;)
          local.get 0
          i32.load offset=24
          local.set 3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 2
                local.get 0
                i32.ne
                br_if 0 (;@6;)
                local.get 0
                i32.const 20
                i32.const 16
                local.get 0
                i32.load offset=20
                local.tee 2
                select
                i32.add
                i32.load
                local.tee 1
                br_if 1 (;@5;)
                i32.const 0
                local.set 2
                br 2 (;@4;)
              end
              local.get 0
              i32.load offset=8
              local.tee 1
              local.get 2
              i32.store offset=12
              local.get 2
              local.get 1
              i32.store offset=8
              br 1 (;@4;)
            end
            local.get 0
            i32.const 20
            i32.add
            local.get 0
            i32.const 16
            i32.add
            local.get 2
            select
            local.set 4
            loop  ;; label = @5
              local.get 4
              local.set 5
              local.get 1
              local.tee 2
              i32.const 20
              i32.add
              local.get 2
              i32.const 16
              i32.add
              local.get 2
              i32.load offset=20
              local.tee 1
              select
              local.set 4
              local.get 2
              i32.const 20
              i32.const 16
              local.get 1
              select
              i32.add
              i32.load
              local.tee 1
              br_if 0 (;@5;)
            end
            local.get 5
            i32.const 0
            i32.store
          end
          local.get 3
          i32.eqz
          br_if 2 (;@1;)
          block  ;; label = @4
            local.get 0
            i32.load offset=28
            i32.const 2
            i32.shl
            i32.const 1050088
            i32.add
            local.tee 1
            i32.load
            local.get 0
            i32.eq
            br_if 0 (;@4;)
            local.get 3
            i32.const 16
            i32.const 20
            local.get 3
            i32.load offset=16
            local.get 0
            i32.eq
            select
            i32.add
            local.get 2
            i32.store
            local.get 2
            i32.eqz
            br_if 3 (;@1;)
            br 2 (;@2;)
          end
          local.get 1
          local.get 2
          i32.store
          local.get 2
          br_if 1 (;@2;)
          i32.const 0
          i32.const 0
          i32.load offset=1050500
          i32.const -2
          local.get 0
          i32.load offset=28
          i32.rotl
          i32.and
          i32.store offset=1050500
          br 2 (;@1;)
        end
        block  ;; label = @3
          local.get 2
          local.get 0
          i32.load offset=8
          local.tee 4
          i32.eq
          br_if 0 (;@3;)
          local.get 4
          local.get 2
          i32.store offset=12
          local.get 2
          local.get 4
          i32.store offset=8
          return
        end
        i32.const 0
        i32.const 0
        i32.load offset=1050496
        i32.const -2
        local.get 1
        i32.const 3
        i32.shr_u
        i32.rotl
        i32.and
        i32.store offset=1050496
        return
      end
      local.get 2
      local.get 3
      i32.store offset=24
      block  ;; label = @2
        local.get 0
        i32.load offset=16
        local.tee 1
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        local.get 1
        i32.store offset=16
        local.get 1
        local.get 2
        i32.store offset=24
      end
      local.get 0
      i32.load offset=20
      local.tee 1
      i32.eqz
      br_if 0 (;@1;)
      local.get 2
      local.get 1
      i32.store offset=20
      local.get 1
      local.get 2
      i32.store offset=24
      return
    end)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17ha03e82fa7bdf8a33E (type 0) (param i32 i32)
    (local i32 i32)
    local.get 0
    local.get 1
    i32.add
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load offset=4
        local.tee 3
        i32.const 1
        i32.and
        br_if 0 (;@2;)
        local.get 3
        i32.const 2
        i32.and
        i32.eqz
        br_if 1 (;@1;)
        local.get 0
        i32.load
        local.tee 3
        local.get 1
        i32.add
        local.set 1
        block  ;; label = @3
          local.get 0
          local.get 3
          i32.sub
          local.tee 0
          i32.const 0
          i32.load offset=1050512
          i32.ne
          br_if 0 (;@3;)
          local.get 2
          i32.load offset=4
          i32.const 3
          i32.and
          i32.const 3
          i32.ne
          br_if 1 (;@2;)
          i32.const 0
          local.get 1
          i32.store offset=1050504
          local.get 2
          local.get 2
          i32.load offset=4
          i32.const -2
          i32.and
          i32.store offset=4
          local.get 0
          local.get 1
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 2
          local.get 1
          i32.store
          br 2 (;@1;)
        end
        local.get 0
        local.get 3
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$12unlink_chunk17h0d0f475ea8907bb5E
      end
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 2
              i32.load offset=4
              local.tee 3
              i32.const 2
              i32.and
              br_if 0 (;@5;)
              local.get 2
              i32.const 0
              i32.load offset=1050516
              i32.eq
              br_if 2 (;@3;)
              local.get 2
              i32.const 0
              i32.load offset=1050512
              i32.eq
              br_if 3 (;@2;)
              local.get 2
              local.get 3
              i32.const -8
              i32.and
              local.tee 3
              call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$12unlink_chunk17h0d0f475ea8907bb5E
              local.get 0
              local.get 3
              local.get 1
              i32.add
              local.tee 1
              i32.const 1
              i32.or
              i32.store offset=4
              local.get 0
              local.get 1
              i32.add
              local.get 1
              i32.store
              local.get 0
              i32.const 0
              i32.load offset=1050512
              i32.ne
              br_if 1 (;@4;)
              i32.const 0
              local.get 1
              i32.store offset=1050504
              return
            end
            local.get 2
            local.get 3
            i32.const -2
            i32.and
            i32.store offset=4
            local.get 0
            local.get 1
            i32.const 1
            i32.or
            i32.store offset=4
            local.get 0
            local.get 1
            i32.add
            local.get 1
            i32.store
          end
          block  ;; label = @4
            local.get 1
            i32.const 256
            i32.lt_u
            br_if 0 (;@4;)
            local.get 0
            local.get 1
            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17ha51abd6cd7031e06E
            return
          end
          local.get 1
          i32.const 248
          i32.and
          i32.const 1050232
          i32.add
          local.set 2
          block  ;; label = @4
            block  ;; label = @5
              i32.const 0
              i32.load offset=1050496
              local.tee 3
              i32.const 1
              local.get 1
              i32.const 3
              i32.shr_u
              i32.shl
              local.tee 1
              i32.and
              br_if 0 (;@5;)
              i32.const 0
              local.get 3
              local.get 1
              i32.or
              i32.store offset=1050496
              local.get 2
              local.set 1
              br 1 (;@4;)
            end
            local.get 2
            i32.load offset=8
            local.set 1
          end
          local.get 2
          local.get 0
          i32.store offset=8
          local.get 1
          local.get 0
          i32.store offset=12
          local.get 0
          local.get 2
          i32.store offset=12
          local.get 0
          local.get 1
          i32.store offset=8
          return
        end
        i32.const 0
        local.get 0
        i32.store offset=1050516
        i32.const 0
        i32.const 0
        i32.load offset=1050508
        local.get 1
        i32.add
        local.tee 1
        i32.store offset=1050508
        local.get 0
        local.get 1
        i32.const 1
        i32.or
        i32.store offset=4
        local.get 0
        i32.const 0
        i32.load offset=1050512
        i32.ne
        br_if 1 (;@1;)
        i32.const 0
        i32.const 0
        i32.store offset=1050504
        i32.const 0
        i32.const 0
        i32.store offset=1050512
        return
      end
      i32.const 0
      local.get 0
      i32.store offset=1050512
      i32.const 0
      i32.const 0
      i32.load offset=1050504
      local.get 1
      i32.add
      local.tee 1
      i32.store offset=1050504
      local.get 0
      local.get 1
      i32.const 1
      i32.or
      i32.store offset=4
      local.get 0
      local.get 1
      i32.add
      local.get 1
      i32.store
      return
    end)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17ha51abd6cd7031e06E (type 0) (param i32 i32)
    (local i32 i32 i32 i32)
    i32.const 0
    local.set 2
    block  ;; label = @1
      local.get 1
      i32.const 256
      i32.lt_u
      br_if 0 (;@1;)
      i32.const 31
      local.set 2
      local.get 1
      i32.const 16777215
      i32.gt_u
      br_if 0 (;@1;)
      local.get 1
      i32.const 6
      local.get 1
      i32.const 8
      i32.shr_u
      i32.clz
      local.tee 2
      i32.sub
      i32.shr_u
      i32.const 1
      i32.and
      local.get 2
      i32.const 1
      i32.shl
      i32.sub
      i32.const 62
      i32.add
      local.set 2
    end
    local.get 0
    i64.const 0
    i64.store offset=16 align=4
    local.get 0
    local.get 2
    i32.store offset=28
    local.get 2
    i32.const 2
    i32.shl
    i32.const 1050088
    i32.add
    local.set 3
    block  ;; label = @1
      i32.const 0
      i32.load offset=1050500
      i32.const 1
      local.get 2
      i32.shl
      local.tee 4
      i32.and
      br_if 0 (;@1;)
      local.get 3
      local.get 0
      i32.store
      local.get 0
      local.get 3
      i32.store offset=24
      local.get 0
      local.get 0
      i32.store offset=12
      local.get 0
      local.get 0
      i32.store offset=8
      i32.const 0
      i32.const 0
      i32.load offset=1050500
      local.get 4
      i32.or
      i32.store offset=1050500
      return
    end
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          i32.load
          local.tee 4
          i32.load offset=4
          i32.const -8
          i32.and
          local.get 1
          i32.ne
          br_if 0 (;@3;)
          local.get 4
          local.set 2
          br 1 (;@2;)
        end
        local.get 1
        i32.const 0
        i32.const 25
        local.get 2
        i32.const 1
        i32.shr_u
        i32.sub
        local.get 2
        i32.const 31
        i32.eq
        select
        i32.shl
        local.set 3
        loop  ;; label = @3
          local.get 4
          local.get 3
          i32.const 29
          i32.shr_u
          i32.const 4
          i32.and
          i32.add
          i32.const 16
          i32.add
          local.tee 5
          i32.load
          local.tee 2
          i32.eqz
          br_if 2 (;@1;)
          local.get 3
          i32.const 1
          i32.shl
          local.set 3
          local.get 2
          local.set 4
          local.get 2
          i32.load offset=4
          i32.const -8
          i32.and
          local.get 1
          i32.ne
          br_if 0 (;@3;)
        end
      end
      local.get 2
      i32.load offset=8
      local.tee 3
      local.get 0
      i32.store offset=12
      local.get 2
      local.get 0
      i32.store offset=8
      local.get 0
      i32.const 0
      i32.store offset=24
      local.get 0
      local.get 2
      i32.store offset=12
      local.get 0
      local.get 3
      i32.store offset=8
      return
    end
    local.get 5
    local.get 0
    i32.store
    local.get 0
    local.get 4
    i32.store offset=24
    local.get 0
    local.get 0
    i32.store offset=12
    local.get 0
    local.get 0
    i32.store offset=8)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$4free17hbb624227e39e47e9E (type 8) (param i32)
    (local i32 i32 i32 i32 i32)
    local.get 0
    i32.const -8
    i32.add
    local.tee 1
    local.get 0
    i32.const -4
    i32.add
    i32.load
    local.tee 2
    i32.const -8
    i32.and
    local.tee 0
    i32.add
    local.set 3
    block  ;; label = @1
      block  ;; label = @2
        local.get 2
        i32.const 1
        i32.and
        br_if 0 (;@2;)
        local.get 2
        i32.const 2
        i32.and
        i32.eqz
        br_if 1 (;@1;)
        local.get 1
        i32.load
        local.tee 2
        local.get 0
        i32.add
        local.set 0
        block  ;; label = @3
          local.get 1
          local.get 2
          i32.sub
          local.tee 1
          i32.const 0
          i32.load offset=1050512
          i32.ne
          br_if 0 (;@3;)
          local.get 3
          i32.load offset=4
          i32.const 3
          i32.and
          i32.const 3
          i32.ne
          br_if 1 (;@2;)
          i32.const 0
          local.get 0
          i32.store offset=1050504
          local.get 3
          local.get 3
          i32.load offset=4
          i32.const -2
          i32.and
          i32.store offset=4
          local.get 1
          local.get 0
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 3
          local.get 0
          i32.store
          return
        end
        local.get 1
        local.get 2
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$12unlink_chunk17h0d0f475ea8907bb5E
      end
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 3
                  i32.load offset=4
                  local.tee 2
                  i32.const 2
                  i32.and
                  br_if 0 (;@7;)
                  local.get 3
                  i32.const 0
                  i32.load offset=1050516
                  i32.eq
                  br_if 2 (;@5;)
                  local.get 3
                  i32.const 0
                  i32.load offset=1050512
                  i32.eq
                  br_if 3 (;@4;)
                  local.get 3
                  local.get 2
                  i32.const -8
                  i32.and
                  local.tee 2
                  call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$12unlink_chunk17h0d0f475ea8907bb5E
                  local.get 1
                  local.get 2
                  local.get 0
                  i32.add
                  local.tee 0
                  i32.const 1
                  i32.or
                  i32.store offset=4
                  local.get 1
                  local.get 0
                  i32.add
                  local.get 0
                  i32.store
                  local.get 1
                  i32.const 0
                  i32.load offset=1050512
                  i32.ne
                  br_if 1 (;@6;)
                  i32.const 0
                  local.get 0
                  i32.store offset=1050504
                  return
                end
                local.get 3
                local.get 2
                i32.const -2
                i32.and
                i32.store offset=4
                local.get 1
                local.get 0
                i32.const 1
                i32.or
                i32.store offset=4
                local.get 1
                local.get 0
                i32.add
                local.get 0
                i32.store
              end
              local.get 0
              i32.const 256
              i32.lt_u
              br_if 2 (;@3;)
              local.get 1
              local.get 0
              call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17ha51abd6cd7031e06E
              i32.const 0
              local.set 1
              i32.const 0
              i32.const 0
              i32.load offset=1050536
              i32.const -1
              i32.add
              local.tee 0
              i32.store offset=1050536
              local.get 0
              br_if 4 (;@1;)
              block  ;; label = @6
                i32.const 0
                i32.load offset=1050224
                local.tee 0
                i32.eqz
                br_if 0 (;@6;)
                i32.const 0
                local.set 1
                loop  ;; label = @7
                  local.get 1
                  i32.const 1
                  i32.add
                  local.set 1
                  local.get 0
                  i32.load offset=8
                  local.tee 0
                  br_if 0 (;@7;)
                end
              end
              i32.const 0
              local.get 1
              i32.const 4095
              local.get 1
              i32.const 4095
              i32.gt_u
              select
              i32.store offset=1050536
              return
            end
            i32.const 0
            local.get 1
            i32.store offset=1050516
            i32.const 0
            i32.const 0
            i32.load offset=1050508
            local.get 0
            i32.add
            local.tee 0
            i32.store offset=1050508
            local.get 1
            local.get 0
            i32.const 1
            i32.or
            i32.store offset=4
            block  ;; label = @5
              local.get 1
              i32.const 0
              i32.load offset=1050512
              i32.ne
              br_if 0 (;@5;)
              i32.const 0
              i32.const 0
              i32.store offset=1050504
              i32.const 0
              i32.const 0
              i32.store offset=1050512
            end
            local.get 0
            i32.const 0
            i32.load offset=1050528
            local.tee 4
            i32.le_u
            br_if 3 (;@1;)
            i32.const 0
            i32.load offset=1050516
            local.tee 0
            i32.eqz
            br_if 3 (;@1;)
            i32.const 0
            local.set 2
            i32.const 0
            i32.load offset=1050508
            local.tee 5
            i32.const 41
            i32.lt_u
            br_if 2 (;@2;)
            i32.const 1050216
            local.set 1
            loop  ;; label = @5
              block  ;; label = @6
                local.get 1
                i32.load
                local.tee 3
                local.get 0
                i32.gt_u
                br_if 0 (;@6;)
                local.get 0
                local.get 3
                local.get 1
                i32.load offset=4
                i32.add
                i32.lt_u
                br_if 4 (;@2;)
              end
              local.get 1
              i32.load offset=8
              local.set 1
              br 0 (;@5;)
            end
          end
          i32.const 0
          local.get 1
          i32.store offset=1050512
          i32.const 0
          i32.const 0
          i32.load offset=1050504
          local.get 0
          i32.add
          local.tee 0
          i32.store offset=1050504
          local.get 1
          local.get 0
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 1
          local.get 0
          i32.add
          local.get 0
          i32.store
          return
        end
        local.get 0
        i32.const 248
        i32.and
        i32.const 1050232
        i32.add
        local.set 3
        block  ;; label = @3
          block  ;; label = @4
            i32.const 0
            i32.load offset=1050496
            local.tee 2
            i32.const 1
            local.get 0
            i32.const 3
            i32.shr_u
            i32.shl
            local.tee 0
            i32.and
            br_if 0 (;@4;)
            i32.const 0
            local.get 2
            local.get 0
            i32.or
            i32.store offset=1050496
            local.get 3
            local.set 0
            br 1 (;@3;)
          end
          local.get 3
          i32.load offset=8
          local.set 0
        end
        local.get 3
        local.get 1
        i32.store offset=8
        local.get 0
        local.get 1
        i32.store offset=12
        local.get 1
        local.get 3
        i32.store offset=12
        local.get 1
        local.get 0
        i32.store offset=8
        return
      end
      block  ;; label = @2
        i32.const 0
        i32.load offset=1050224
        local.tee 1
        i32.eqz
        br_if 0 (;@2;)
        i32.const 0
        local.set 2
        loop  ;; label = @3
          local.get 2
          i32.const 1
          i32.add
          local.set 2
          local.get 1
          i32.load offset=8
          local.tee 1
          br_if 0 (;@3;)
        end
      end
      i32.const 0
      local.get 2
      i32.const 4095
      local.get 2
      i32.const 4095
      i32.gt_u
      select
      i32.store offset=1050536
      local.get 5
      local.get 4
      i32.le_u
      br_if 0 (;@1;)
      i32.const 0
      i32.const -1
      i32.store offset=1050528
    end)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17hd2421ed15302c503E (type 3) (param i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i64)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 0
                    i32.const 245
                    i32.lt_u
                    br_if 0 (;@8;)
                    block  ;; label = @9
                      local.get 0
                      i32.const -65587
                      i32.lt_u
                      br_if 0 (;@9;)
                      i32.const 0
                      local.set 0
                      br 8 (;@1;)
                    end
                    local.get 0
                    i32.const 11
                    i32.add
                    local.tee 2
                    i32.const -8
                    i32.and
                    local.set 3
                    i32.const 0
                    i32.load offset=1050500
                    local.tee 4
                    i32.eqz
                    br_if 4 (;@4;)
                    i32.const 31
                    local.set 5
                    block  ;; label = @9
                      local.get 0
                      i32.const 16777204
                      i32.gt_u
                      br_if 0 (;@9;)
                      local.get 3
                      i32.const 6
                      local.get 2
                      i32.const 8
                      i32.shr_u
                      i32.clz
                      local.tee 0
                      i32.sub
                      i32.shr_u
                      i32.const 1
                      i32.and
                      local.get 0
                      i32.const 1
                      i32.shl
                      i32.sub
                      i32.const 62
                      i32.add
                      local.set 5
                    end
                    i32.const 0
                    local.get 3
                    i32.sub
                    local.set 2
                    block  ;; label = @9
                      local.get 5
                      i32.const 2
                      i32.shl
                      i32.const 1050088
                      i32.add
                      i32.load
                      local.tee 6
                      br_if 0 (;@9;)
                      i32.const 0
                      local.set 0
                      i32.const 0
                      local.set 7
                      br 2 (;@7;)
                    end
                    i32.const 0
                    local.set 0
                    local.get 3
                    i32.const 0
                    i32.const 25
                    local.get 5
                    i32.const 1
                    i32.shr_u
                    i32.sub
                    local.get 5
                    i32.const 31
                    i32.eq
                    select
                    i32.shl
                    local.set 8
                    i32.const 0
                    local.set 7
                    loop  ;; label = @9
                      block  ;; label = @10
                        local.get 6
                        local.tee 6
                        i32.load offset=4
                        i32.const -8
                        i32.and
                        local.tee 9
                        local.get 3
                        i32.lt_u
                        br_if 0 (;@10;)
                        local.get 9
                        local.get 3
                        i32.sub
                        local.tee 9
                        local.get 2
                        i32.ge_u
                        br_if 0 (;@10;)
                        local.get 9
                        local.set 2
                        local.get 6
                        local.set 7
                        local.get 9
                        br_if 0 (;@10;)
                        i32.const 0
                        local.set 2
                        local.get 6
                        local.set 7
                        local.get 6
                        local.set 0
                        br 4 (;@6;)
                      end
                      local.get 6
                      i32.load offset=20
                      local.tee 9
                      local.get 0
                      local.get 9
                      local.get 6
                      local.get 8
                      i32.const 29
                      i32.shr_u
                      i32.const 4
                      i32.and
                      i32.add
                      i32.const 16
                      i32.add
                      i32.load
                      local.tee 6
                      i32.ne
                      select
                      local.get 0
                      local.get 9
                      select
                      local.set 0
                      local.get 8
                      i32.const 1
                      i32.shl
                      local.set 8
                      local.get 6
                      i32.eqz
                      br_if 2 (;@7;)
                      br 0 (;@9;)
                    end
                  end
                  block  ;; label = @8
                    i32.const 0
                    i32.load offset=1050496
                    local.tee 6
                    i32.const 16
                    local.get 0
                    i32.const 11
                    i32.add
                    i32.const 504
                    i32.and
                    local.get 0
                    i32.const 11
                    i32.lt_u
                    select
                    local.tee 3
                    i32.const 3
                    i32.shr_u
                    local.tee 2
                    i32.shr_u
                    local.tee 0
                    i32.const 3
                    i32.and
                    i32.eqz
                    br_if 0 (;@8;)
                    block  ;; label = @9
                      block  ;; label = @10
                        local.get 0
                        i32.const -1
                        i32.xor
                        i32.const 1
                        i32.and
                        local.get 2
                        i32.add
                        local.tee 8
                        i32.const 3
                        i32.shl
                        local.tee 3
                        i32.const 1050232
                        i32.add
                        local.tee 0
                        local.get 3
                        i32.const 1050240
                        i32.add
                        i32.load
                        local.tee 2
                        i32.load offset=8
                        local.tee 7
                        i32.eq
                        br_if 0 (;@10;)
                        local.get 7
                        local.get 0
                        i32.store offset=12
                        local.get 0
                        local.get 7
                        i32.store offset=8
                        br 1 (;@9;)
                      end
                      i32.const 0
                      local.get 6
                      i32.const -2
                      local.get 8
                      i32.rotl
                      i32.and
                      i32.store offset=1050496
                    end
                    local.get 2
                    i32.const 8
                    i32.add
                    local.set 0
                    local.get 2
                    local.get 3
                    i32.const 3
                    i32.or
                    i32.store offset=4
                    local.get 2
                    local.get 3
                    i32.add
                    local.tee 3
                    local.get 3
                    i32.load offset=4
                    i32.const 1
                    i32.or
                    i32.store offset=4
                    br 7 (;@1;)
                  end
                  local.get 3
                  i32.const 0
                  i32.load offset=1050504
                  i32.le_u
                  br_if 3 (;@4;)
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        local.get 0
                        br_if 0 (;@10;)
                        i32.const 0
                        i32.load offset=1050500
                        local.tee 0
                        i32.eqz
                        br_if 6 (;@4;)
                        local.get 0
                        i32.ctz
                        i32.const 2
                        i32.shl
                        i32.const 1050088
                        i32.add
                        i32.load
                        local.tee 7
                        i32.load offset=4
                        i32.const -8
                        i32.and
                        local.get 3
                        i32.sub
                        local.set 2
                        local.get 7
                        local.set 6
                        loop  ;; label = @11
                          block  ;; label = @12
                            local.get 7
                            i32.load offset=16
                            local.tee 0
                            br_if 0 (;@12;)
                            local.get 7
                            i32.load offset=20
                            local.tee 0
                            br_if 0 (;@12;)
                            local.get 6
                            i32.load offset=24
                            local.set 5
                            block  ;; label = @13
                              block  ;; label = @14
                                block  ;; label = @15
                                  local.get 6
                                  i32.load offset=12
                                  local.tee 0
                                  local.get 6
                                  i32.ne
                                  br_if 0 (;@15;)
                                  local.get 6
                                  i32.const 20
                                  i32.const 16
                                  local.get 6
                                  i32.load offset=20
                                  local.tee 0
                                  select
                                  i32.add
                                  i32.load
                                  local.tee 7
                                  br_if 1 (;@14;)
                                  i32.const 0
                                  local.set 0
                                  br 2 (;@13;)
                                end
                                local.get 6
                                i32.load offset=8
                                local.tee 7
                                local.get 0
                                i32.store offset=12
                                local.get 0
                                local.get 7
                                i32.store offset=8
                                br 1 (;@13;)
                              end
                              local.get 6
                              i32.const 20
                              i32.add
                              local.get 6
                              i32.const 16
                              i32.add
                              local.get 0
                              select
                              local.set 8
                              loop  ;; label = @14
                                local.get 8
                                local.set 9
                                local.get 7
                                local.tee 0
                                i32.const 20
                                i32.add
                                local.get 0
                                i32.const 16
                                i32.add
                                local.get 0
                                i32.load offset=20
                                local.tee 7
                                select
                                local.set 8
                                local.get 0
                                i32.const 20
                                i32.const 16
                                local.get 7
                                select
                                i32.add
                                i32.load
                                local.tee 7
                                br_if 0 (;@14;)
                              end
                              local.get 9
                              i32.const 0
                              i32.store
                            end
                            local.get 5
                            i32.eqz
                            br_if 4 (;@8;)
                            block  ;; label = @13
                              local.get 6
                              i32.load offset=28
                              i32.const 2
                              i32.shl
                              i32.const 1050088
                              i32.add
                              local.tee 7
                              i32.load
                              local.get 6
                              i32.eq
                              br_if 0 (;@13;)
                              local.get 5
                              i32.const 16
                              i32.const 20
                              local.get 5
                              i32.load offset=16
                              local.get 6
                              i32.eq
                              select
                              i32.add
                              local.get 0
                              i32.store
                              local.get 0
                              i32.eqz
                              br_if 5 (;@8;)
                              br 4 (;@9;)
                            end
                            local.get 7
                            local.get 0
                            i32.store
                            local.get 0
                            br_if 3 (;@9;)
                            i32.const 0
                            i32.const 0
                            i32.load offset=1050500
                            i32.const -2
                            local.get 6
                            i32.load offset=28
                            i32.rotl
                            i32.and
                            i32.store offset=1050500
                            br 4 (;@8;)
                          end
                          local.get 0
                          i32.load offset=4
                          i32.const -8
                          i32.and
                          local.get 3
                          i32.sub
                          local.tee 7
                          local.get 2
                          local.get 7
                          local.get 2
                          i32.lt_u
                          local.tee 7
                          select
                          local.set 2
                          local.get 0
                          local.get 6
                          local.get 7
                          select
                          local.set 6
                          local.get 0
                          local.set 7
                          br 0 (;@11;)
                        end
                      end
                      block  ;; label = @10
                        block  ;; label = @11
                          local.get 0
                          local.get 2
                          i32.shl
                          i32.const 2
                          local.get 2
                          i32.shl
                          local.tee 0
                          i32.const 0
                          local.get 0
                          i32.sub
                          i32.or
                          i32.and
                          i32.ctz
                          local.tee 9
                          i32.const 3
                          i32.shl
                          local.tee 2
                          i32.const 1050232
                          i32.add
                          local.tee 7
                          local.get 2
                          i32.const 1050240
                          i32.add
                          i32.load
                          local.tee 0
                          i32.load offset=8
                          local.tee 8
                          i32.eq
                          br_if 0 (;@11;)
                          local.get 8
                          local.get 7
                          i32.store offset=12
                          local.get 7
                          local.get 8
                          i32.store offset=8
                          br 1 (;@10;)
                        end
                        i32.const 0
                        local.get 6
                        i32.const -2
                        local.get 9
                        i32.rotl
                        i32.and
                        i32.store offset=1050496
                      end
                      local.get 0
                      local.get 3
                      i32.const 3
                      i32.or
                      i32.store offset=4
                      local.get 0
                      local.get 3
                      i32.add
                      local.tee 8
                      local.get 2
                      local.get 3
                      i32.sub
                      local.tee 7
                      i32.const 1
                      i32.or
                      i32.store offset=4
                      local.get 0
                      local.get 2
                      i32.add
                      local.get 7
                      i32.store
                      block  ;; label = @10
                        i32.const 0
                        i32.load offset=1050504
                        local.tee 6
                        i32.eqz
                        br_if 0 (;@10;)
                        local.get 6
                        i32.const -8
                        i32.and
                        i32.const 1050232
                        i32.add
                        local.set 2
                        i32.const 0
                        i32.load offset=1050512
                        local.set 3
                        block  ;; label = @11
                          block  ;; label = @12
                            i32.const 0
                            i32.load offset=1050496
                            local.tee 9
                            i32.const 1
                            local.get 6
                            i32.const 3
                            i32.shr_u
                            i32.shl
                            local.tee 6
                            i32.and
                            br_if 0 (;@12;)
                            i32.const 0
                            local.get 9
                            local.get 6
                            i32.or
                            i32.store offset=1050496
                            local.get 2
                            local.set 6
                            br 1 (;@11;)
                          end
                          local.get 2
                          i32.load offset=8
                          local.set 6
                        end
                        local.get 2
                        local.get 3
                        i32.store offset=8
                        local.get 6
                        local.get 3
                        i32.store offset=12
                        local.get 3
                        local.get 2
                        i32.store offset=12
                        local.get 3
                        local.get 6
                        i32.store offset=8
                      end
                      local.get 0
                      i32.const 8
                      i32.add
                      local.set 0
                      i32.const 0
                      local.get 8
                      i32.store offset=1050512
                      i32.const 0
                      local.get 7
                      i32.store offset=1050504
                      br 8 (;@1;)
                    end
                    local.get 0
                    local.get 5
                    i32.store offset=24
                    block  ;; label = @9
                      local.get 6
                      i32.load offset=16
                      local.tee 7
                      i32.eqz
                      br_if 0 (;@9;)
                      local.get 0
                      local.get 7
                      i32.store offset=16
                      local.get 7
                      local.get 0
                      i32.store offset=24
                    end
                    local.get 6
                    i32.load offset=20
                    local.tee 7
                    i32.eqz
                    br_if 0 (;@8;)
                    local.get 0
                    local.get 7
                    i32.store offset=20
                    local.get 7
                    local.get 0
                    i32.store offset=24
                  end
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        local.get 2
                        i32.const 16
                        i32.lt_u
                        br_if 0 (;@10;)
                        local.get 6
                        local.get 3
                        i32.const 3
                        i32.or
                        i32.store offset=4
                        local.get 6
                        local.get 3
                        i32.add
                        local.tee 3
                        local.get 2
                        i32.const 1
                        i32.or
                        i32.store offset=4
                        local.get 3
                        local.get 2
                        i32.add
                        local.get 2
                        i32.store
                        i32.const 0
                        i32.load offset=1050504
                        local.tee 8
                        i32.eqz
                        br_if 1 (;@9;)
                        local.get 8
                        i32.const -8
                        i32.and
                        i32.const 1050232
                        i32.add
                        local.set 7
                        i32.const 0
                        i32.load offset=1050512
                        local.set 0
                        block  ;; label = @11
                          block  ;; label = @12
                            i32.const 0
                            i32.load offset=1050496
                            local.tee 9
                            i32.const 1
                            local.get 8
                            i32.const 3
                            i32.shr_u
                            i32.shl
                            local.tee 8
                            i32.and
                            br_if 0 (;@12;)
                            i32.const 0
                            local.get 9
                            local.get 8
                            i32.or
                            i32.store offset=1050496
                            local.get 7
                            local.set 8
                            br 1 (;@11;)
                          end
                          local.get 7
                          i32.load offset=8
                          local.set 8
                        end
                        local.get 7
                        local.get 0
                        i32.store offset=8
                        local.get 8
                        local.get 0
                        i32.store offset=12
                        local.get 0
                        local.get 7
                        i32.store offset=12
                        local.get 0
                        local.get 8
                        i32.store offset=8
                        br 1 (;@9;)
                      end
                      local.get 6
                      local.get 2
                      local.get 3
                      i32.add
                      local.tee 0
                      i32.const 3
                      i32.or
                      i32.store offset=4
                      local.get 6
                      local.get 0
                      i32.add
                      local.tee 0
                      local.get 0
                      i32.load offset=4
                      i32.const 1
                      i32.or
                      i32.store offset=4
                      br 1 (;@8;)
                    end
                    i32.const 0
                    local.get 3
                    i32.store offset=1050512
                    i32.const 0
                    local.get 2
                    i32.store offset=1050504
                  end
                  local.get 6
                  i32.const 8
                  i32.add
                  local.set 0
                  br 6 (;@1;)
                end
                block  ;; label = @7
                  local.get 0
                  local.get 7
                  i32.or
                  br_if 0 (;@7;)
                  i32.const 0
                  local.set 7
                  i32.const 2
                  local.get 5
                  i32.shl
                  local.tee 0
                  i32.const 0
                  local.get 0
                  i32.sub
                  i32.or
                  local.get 4
                  i32.and
                  local.tee 0
                  i32.eqz
                  br_if 3 (;@4;)
                  local.get 0
                  i32.ctz
                  i32.const 2
                  i32.shl
                  i32.const 1050088
                  i32.add
                  i32.load
                  local.set 0
                end
                local.get 0
                i32.eqz
                br_if 1 (;@5;)
              end
              loop  ;; label = @6
                local.get 0
                local.get 7
                local.get 0
                i32.load offset=4
                i32.const -8
                i32.and
                local.tee 6
                local.get 3
                i32.sub
                local.tee 9
                local.get 2
                i32.lt_u
                local.tee 5
                select
                local.set 4
                local.get 6
                local.get 3
                i32.lt_u
                local.set 8
                local.get 9
                local.get 2
                local.get 5
                select
                local.set 9
                block  ;; label = @7
                  local.get 0
                  i32.load offset=16
                  local.tee 6
                  br_if 0 (;@7;)
                  local.get 0
                  i32.load offset=20
                  local.set 6
                end
                local.get 7
                local.get 4
                local.get 8
                select
                local.set 7
                local.get 2
                local.get 9
                local.get 8
                select
                local.set 2
                local.get 6
                local.set 0
                local.get 6
                br_if 0 (;@6;)
              end
            end
            local.get 7
            i32.eqz
            br_if 0 (;@4;)
            block  ;; label = @5
              i32.const 0
              i32.load offset=1050504
              local.tee 0
              local.get 3
              i32.lt_u
              br_if 0 (;@5;)
              local.get 2
              local.get 0
              local.get 3
              i32.sub
              i32.ge_u
              br_if 1 (;@4;)
            end
            local.get 7
            i32.load offset=24
            local.set 5
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 7
                  i32.load offset=12
                  local.tee 0
                  local.get 7
                  i32.ne
                  br_if 0 (;@7;)
                  local.get 7
                  i32.const 20
                  i32.const 16
                  local.get 7
                  i32.load offset=20
                  local.tee 0
                  select
                  i32.add
                  i32.load
                  local.tee 6
                  br_if 1 (;@6;)
                  i32.const 0
                  local.set 0
                  br 2 (;@5;)
                end
                local.get 7
                i32.load offset=8
                local.tee 6
                local.get 0
                i32.store offset=12
                local.get 0
                local.get 6
                i32.store offset=8
                br 1 (;@5;)
              end
              local.get 7
              i32.const 20
              i32.add
              local.get 7
              i32.const 16
              i32.add
              local.get 0
              select
              local.set 8
              loop  ;; label = @6
                local.get 8
                local.set 9
                local.get 6
                local.tee 0
                i32.const 20
                i32.add
                local.get 0
                i32.const 16
                i32.add
                local.get 0
                i32.load offset=20
                local.tee 6
                select
                local.set 8
                local.get 0
                i32.const 20
                i32.const 16
                local.get 6
                select
                i32.add
                i32.load
                local.tee 6
                br_if 0 (;@6;)
              end
              local.get 9
              i32.const 0
              i32.store
            end
            local.get 5
            i32.eqz
            br_if 2 (;@2;)
            block  ;; label = @5
              local.get 7
              i32.load offset=28
              i32.const 2
              i32.shl
              i32.const 1050088
              i32.add
              local.tee 6
              i32.load
              local.get 7
              i32.eq
              br_if 0 (;@5;)
              local.get 5
              i32.const 16
              i32.const 20
              local.get 5
              i32.load offset=16
              local.get 7
              i32.eq
              select
              i32.add
              local.get 0
              i32.store
              local.get 0
              i32.eqz
              br_if 3 (;@2;)
              br 2 (;@3;)
            end
            local.get 6
            local.get 0
            i32.store
            local.get 0
            br_if 1 (;@3;)
            i32.const 0
            i32.const 0
            i32.load offset=1050500
            i32.const -2
            local.get 7
            i32.load offset=28
            i32.rotl
            i32.and
            i32.store offset=1050500
            br 2 (;@2;)
          end
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      i32.const 0
                      i32.load offset=1050504
                      local.tee 0
                      local.get 3
                      i32.ge_u
                      br_if 0 (;@9;)
                      block  ;; label = @10
                        i32.const 0
                        i32.load offset=1050508
                        local.tee 0
                        local.get 3
                        i32.gt_u
                        br_if 0 (;@10;)
                        local.get 1
                        i32.const 4
                        i32.add
                        i32.const 1050540
                        local.get 3
                        i32.const 65583
                        i32.add
                        i32.const -65536
                        i32.and
                        call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$5alloc17hf38218fce26a9c00E
                        block  ;; label = @11
                          local.get 1
                          i32.load offset=4
                          local.tee 6
                          br_if 0 (;@11;)
                          i32.const 0
                          local.set 0
                          br 10 (;@1;)
                        end
                        local.get 1
                        i32.load offset=12
                        local.set 5
                        i32.const 0
                        i32.const 0
                        i32.load offset=1050520
                        local.get 1
                        i32.load offset=8
                        local.tee 9
                        i32.add
                        local.tee 0
                        i32.store offset=1050520
                        i32.const 0
                        i32.const 0
                        i32.load offset=1050524
                        local.tee 2
                        local.get 0
                        local.get 2
                        local.get 0
                        i32.gt_u
                        select
                        i32.store offset=1050524
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              i32.const 0
                              i32.load offset=1050516
                              local.tee 2
                              i32.eqz
                              br_if 0 (;@13;)
                              i32.const 1050216
                              local.set 0
                              loop  ;; label = @14
                                local.get 6
                                local.get 0
                                i32.load
                                local.tee 7
                                local.get 0
                                i32.load offset=4
                                local.tee 8
                                i32.add
                                i32.eq
                                br_if 2 (;@12;)
                                local.get 0
                                i32.load offset=8
                                local.tee 0
                                br_if 0 (;@14;)
                                br 3 (;@11;)
                              end
                            end
                            block  ;; label = @13
                              block  ;; label = @14
                                i32.const 0
                                i32.load offset=1050532
                                local.tee 0
                                i32.eqz
                                br_if 0 (;@14;)
                                local.get 6
                                local.get 0
                                i32.ge_u
                                br_if 1 (;@13;)
                              end
                              i32.const 0
                              local.get 6
                              i32.store offset=1050532
                            end
                            i32.const 0
                            i32.const 4095
                            i32.store offset=1050536
                            i32.const 0
                            local.get 5
                            i32.store offset=1050228
                            i32.const 0
                            local.get 9
                            i32.store offset=1050220
                            i32.const 0
                            local.get 6
                            i32.store offset=1050216
                            i32.const 0
                            i32.const 1050232
                            i32.store offset=1050244
                            i32.const 0
                            i32.const 1050240
                            i32.store offset=1050252
                            i32.const 0
                            i32.const 1050232
                            i32.store offset=1050240
                            i32.const 0
                            i32.const 1050248
                            i32.store offset=1050260
                            i32.const 0
                            i32.const 1050240
                            i32.store offset=1050248
                            i32.const 0
                            i32.const 1050256
                            i32.store offset=1050268
                            i32.const 0
                            i32.const 1050248
                            i32.store offset=1050256
                            i32.const 0
                            i32.const 1050264
                            i32.store offset=1050276
                            i32.const 0
                            i32.const 1050256
                            i32.store offset=1050264
                            i32.const 0
                            i32.const 1050272
                            i32.store offset=1050284
                            i32.const 0
                            i32.const 1050264
                            i32.store offset=1050272
                            i32.const 0
                            i32.const 1050280
                            i32.store offset=1050292
                            i32.const 0
                            i32.const 1050272
                            i32.store offset=1050280
                            i32.const 0
                            i32.const 1050288
                            i32.store offset=1050300
                            i32.const 0
                            i32.const 1050280
                            i32.store offset=1050288
                            i32.const 0
                            i32.const 1050296
                            i32.store offset=1050308
                            i32.const 0
                            i32.const 1050288
                            i32.store offset=1050296
                            i32.const 0
                            i32.const 1050296
                            i32.store offset=1050304
                            i32.const 0
                            i32.const 1050304
                            i32.store offset=1050316
                            i32.const 0
                            i32.const 1050304
                            i32.store offset=1050312
                            i32.const 0
                            i32.const 1050312
                            i32.store offset=1050324
                            i32.const 0
                            i32.const 1050312
                            i32.store offset=1050320
                            i32.const 0
                            i32.const 1050320
                            i32.store offset=1050332
                            i32.const 0
                            i32.const 1050320
                            i32.store offset=1050328
                            i32.const 0
                            i32.const 1050328
                            i32.store offset=1050340
                            i32.const 0
                            i32.const 1050328
                            i32.store offset=1050336
                            i32.const 0
                            i32.const 1050336
                            i32.store offset=1050348
                            i32.const 0
                            i32.const 1050336
                            i32.store offset=1050344
                            i32.const 0
                            i32.const 1050344
                            i32.store offset=1050356
                            i32.const 0
                            i32.const 1050344
                            i32.store offset=1050352
                            i32.const 0
                            i32.const 1050352
                            i32.store offset=1050364
                            i32.const 0
                            i32.const 1050352
                            i32.store offset=1050360
                            i32.const 0
                            i32.const 1050360
                            i32.store offset=1050372
                            i32.const 0
                            i32.const 1050368
                            i32.store offset=1050380
                            i32.const 0
                            i32.const 1050360
                            i32.store offset=1050368
                            i32.const 0
                            i32.const 1050376
                            i32.store offset=1050388
                            i32.const 0
                            i32.const 1050368
                            i32.store offset=1050376
                            i32.const 0
                            i32.const 1050384
                            i32.store offset=1050396
                            i32.const 0
                            i32.const 1050376
                            i32.store offset=1050384
                            i32.const 0
                            i32.const 1050392
                            i32.store offset=1050404
                            i32.const 0
                            i32.const 1050384
                            i32.store offset=1050392
                            i32.const 0
                            i32.const 1050400
                            i32.store offset=1050412
                            i32.const 0
                            i32.const 1050392
                            i32.store offset=1050400
                            i32.const 0
                            i32.const 1050408
                            i32.store offset=1050420
                            i32.const 0
                            i32.const 1050400
                            i32.store offset=1050408
                            i32.const 0
                            i32.const 1050416
                            i32.store offset=1050428
                            i32.const 0
                            i32.const 1050408
                            i32.store offset=1050416
                            i32.const 0
                            i32.const 1050424
                            i32.store offset=1050436
                            i32.const 0
                            i32.const 1050416
                            i32.store offset=1050424
                            i32.const 0
                            i32.const 1050432
                            i32.store offset=1050444
                            i32.const 0
                            i32.const 1050424
                            i32.store offset=1050432
                            i32.const 0
                            i32.const 1050440
                            i32.store offset=1050452
                            i32.const 0
                            i32.const 1050432
                            i32.store offset=1050440
                            i32.const 0
                            i32.const 1050448
                            i32.store offset=1050460
                            i32.const 0
                            i32.const 1050440
                            i32.store offset=1050448
                            i32.const 0
                            i32.const 1050456
                            i32.store offset=1050468
                            i32.const 0
                            i32.const 1050448
                            i32.store offset=1050456
                            i32.const 0
                            i32.const 1050464
                            i32.store offset=1050476
                            i32.const 0
                            i32.const 1050456
                            i32.store offset=1050464
                            i32.const 0
                            i32.const 1050472
                            i32.store offset=1050484
                            i32.const 0
                            i32.const 1050464
                            i32.store offset=1050472
                            i32.const 0
                            i32.const 1050480
                            i32.store offset=1050492
                            i32.const 0
                            i32.const 1050472
                            i32.store offset=1050480
                            i32.const 0
                            local.get 6
                            i32.const 15
                            i32.add
                            i32.const -8
                            i32.and
                            local.tee 0
                            i32.const -8
                            i32.add
                            local.tee 2
                            i32.store offset=1050516
                            i32.const 0
                            i32.const 1050480
                            i32.store offset=1050488
                            i32.const 0
                            local.get 6
                            local.get 0
                            i32.sub
                            local.get 9
                            i32.const -40
                            i32.add
                            local.tee 0
                            i32.add
                            i32.const 8
                            i32.add
                            local.tee 7
                            i32.store offset=1050508
                            local.get 2
                            local.get 7
                            i32.const 1
                            i32.or
                            i32.store offset=4
                            local.get 6
                            local.get 0
                            i32.add
                            i32.const 40
                            i32.store offset=4
                            i32.const 0
                            i32.const 2097152
                            i32.store offset=1050528
                            br 8 (;@4;)
                          end
                          local.get 2
                          local.get 6
                          i32.ge_u
                          br_if 0 (;@11;)
                          local.get 7
                          local.get 2
                          i32.gt_u
                          br_if 0 (;@11;)
                          local.get 0
                          i32.load offset=12
                          local.tee 7
                          i32.const 1
                          i32.and
                          br_if 0 (;@11;)
                          local.get 7
                          i32.const 1
                          i32.shr_u
                          local.get 5
                          i32.eq
                          br_if 3 (;@8;)
                        end
                        i32.const 0
                        i32.const 0
                        i32.load offset=1050532
                        local.tee 0
                        local.get 6
                        local.get 6
                        local.get 0
                        i32.gt_u
                        select
                        i32.store offset=1050532
                        local.get 6
                        local.get 9
                        i32.add
                        local.set 7
                        i32.const 1050216
                        local.set 0
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              loop  ;; label = @14
                                local.get 0
                                i32.load
                                local.tee 8
                                local.get 7
                                i32.eq
                                br_if 1 (;@13;)
                                local.get 0
                                i32.load offset=8
                                local.tee 0
                                br_if 0 (;@14;)
                                br 2 (;@12;)
                              end
                            end
                            local.get 0
                            i32.load offset=12
                            local.tee 7
                            i32.const 1
                            i32.and
                            br_if 0 (;@12;)
                            local.get 7
                            i32.const 1
                            i32.shr_u
                            local.get 5
                            i32.eq
                            br_if 1 (;@11;)
                          end
                          i32.const 1050216
                          local.set 0
                          block  ;; label = @12
                            loop  ;; label = @13
                              block  ;; label = @14
                                local.get 0
                                i32.load
                                local.tee 7
                                local.get 2
                                i32.gt_u
                                br_if 0 (;@14;)
                                local.get 2
                                local.get 7
                                local.get 0
                                i32.load offset=4
                                i32.add
                                local.tee 7
                                i32.lt_u
                                br_if 2 (;@12;)
                              end
                              local.get 0
                              i32.load offset=8
                              local.set 0
                              br 0 (;@13;)
                            end
                          end
                          i32.const 0
                          local.get 6
                          i32.const 15
                          i32.add
                          i32.const -8
                          i32.and
                          local.tee 0
                          i32.const -8
                          i32.add
                          local.tee 8
                          i32.store offset=1050516
                          i32.const 0
                          local.get 6
                          local.get 0
                          i32.sub
                          local.get 9
                          i32.const -40
                          i32.add
                          local.tee 0
                          i32.add
                          i32.const 8
                          i32.add
                          local.tee 4
                          i32.store offset=1050508
                          local.get 8
                          local.get 4
                          i32.const 1
                          i32.or
                          i32.store offset=4
                          local.get 6
                          local.get 0
                          i32.add
                          i32.const 40
                          i32.store offset=4
                          i32.const 0
                          i32.const 2097152
                          i32.store offset=1050528
                          local.get 2
                          local.get 7
                          i32.const -32
                          i32.add
                          i32.const -8
                          i32.and
                          i32.const -8
                          i32.add
                          local.tee 0
                          local.get 0
                          local.get 2
                          i32.const 16
                          i32.add
                          i32.lt_u
                          select
                          local.tee 8
                          i32.const 27
                          i32.store offset=4
                          i32.const 0
                          i64.load offset=1050216 align=4
                          local.set 10
                          local.get 8
                          i32.const 16
                          i32.add
                          i32.const 0
                          i64.load offset=1050224 align=4
                          i64.store align=4
                          local.get 8
                          local.get 10
                          i64.store offset=8 align=4
                          i32.const 0
                          local.get 5
                          i32.store offset=1050228
                          i32.const 0
                          local.get 9
                          i32.store offset=1050220
                          i32.const 0
                          local.get 6
                          i32.store offset=1050216
                          i32.const 0
                          local.get 8
                          i32.const 8
                          i32.add
                          i32.store offset=1050224
                          local.get 8
                          i32.const 28
                          i32.add
                          local.set 0
                          loop  ;; label = @12
                            local.get 0
                            i32.const 7
                            i32.store
                            local.get 0
                            i32.const 4
                            i32.add
                            local.tee 0
                            local.get 7
                            i32.lt_u
                            br_if 0 (;@12;)
                          end
                          local.get 8
                          local.get 2
                          i32.eq
                          br_if 7 (;@4;)
                          local.get 8
                          local.get 8
                          i32.load offset=4
                          i32.const -2
                          i32.and
                          i32.store offset=4
                          local.get 2
                          local.get 8
                          local.get 2
                          i32.sub
                          local.tee 0
                          i32.const 1
                          i32.or
                          i32.store offset=4
                          local.get 8
                          local.get 0
                          i32.store
                          block  ;; label = @12
                            local.get 0
                            i32.const 256
                            i32.lt_u
                            br_if 0 (;@12;)
                            local.get 2
                            local.get 0
                            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17ha51abd6cd7031e06E
                            br 8 (;@4;)
                          end
                          local.get 0
                          i32.const 248
                          i32.and
                          i32.const 1050232
                          i32.add
                          local.set 7
                          block  ;; label = @12
                            block  ;; label = @13
                              i32.const 0
                              i32.load offset=1050496
                              local.tee 6
                              i32.const 1
                              local.get 0
                              i32.const 3
                              i32.shr_u
                              i32.shl
                              local.tee 0
                              i32.and
                              br_if 0 (;@13;)
                              i32.const 0
                              local.get 6
                              local.get 0
                              i32.or
                              i32.store offset=1050496
                              local.get 7
                              local.set 0
                              br 1 (;@12;)
                            end
                            local.get 7
                            i32.load offset=8
                            local.set 0
                          end
                          local.get 7
                          local.get 2
                          i32.store offset=8
                          local.get 0
                          local.get 2
                          i32.store offset=12
                          local.get 2
                          local.get 7
                          i32.store offset=12
                          local.get 2
                          local.get 0
                          i32.store offset=8
                          br 7 (;@4;)
                        end
                        local.get 0
                        local.get 6
                        i32.store
                        local.get 0
                        local.get 0
                        i32.load offset=4
                        local.get 9
                        i32.add
                        i32.store offset=4
                        local.get 6
                        i32.const 15
                        i32.add
                        i32.const -8
                        i32.and
                        i32.const -8
                        i32.add
                        local.tee 7
                        local.get 3
                        i32.const 3
                        i32.or
                        i32.store offset=4
                        local.get 8
                        i32.const 15
                        i32.add
                        i32.const -8
                        i32.and
                        i32.const -8
                        i32.add
                        local.tee 2
                        local.get 7
                        local.get 3
                        i32.add
                        local.tee 0
                        i32.sub
                        local.set 3
                        local.get 2
                        i32.const 0
                        i32.load offset=1050516
                        i32.eq
                        br_if 3 (;@7;)
                        local.get 2
                        i32.const 0
                        i32.load offset=1050512
                        i32.eq
                        br_if 4 (;@6;)
                        block  ;; label = @11
                          local.get 2
                          i32.load offset=4
                          local.tee 6
                          i32.const 3
                          i32.and
                          i32.const 1
                          i32.ne
                          br_if 0 (;@11;)
                          local.get 2
                          local.get 6
                          i32.const -8
                          i32.and
                          local.tee 6
                          call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$12unlink_chunk17h0d0f475ea8907bb5E
                          local.get 6
                          local.get 3
                          i32.add
                          local.set 3
                          local.get 2
                          local.get 6
                          i32.add
                          local.tee 2
                          i32.load offset=4
                          local.set 6
                        end
                        local.get 2
                        local.get 6
                        i32.const -2
                        i32.and
                        i32.store offset=4
                        local.get 0
                        local.get 3
                        i32.const 1
                        i32.or
                        i32.store offset=4
                        local.get 0
                        local.get 3
                        i32.add
                        local.get 3
                        i32.store
                        block  ;; label = @11
                          local.get 3
                          i32.const 256
                          i32.lt_u
                          br_if 0 (;@11;)
                          local.get 0
                          local.get 3
                          call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17ha51abd6cd7031e06E
                          br 6 (;@5;)
                        end
                        local.get 3
                        i32.const 248
                        i32.and
                        i32.const 1050232
                        i32.add
                        local.set 2
                        block  ;; label = @11
                          block  ;; label = @12
                            i32.const 0
                            i32.load offset=1050496
                            local.tee 6
                            i32.const 1
                            local.get 3
                            i32.const 3
                            i32.shr_u
                            i32.shl
                            local.tee 3
                            i32.and
                            br_if 0 (;@12;)
                            i32.const 0
                            local.get 6
                            local.get 3
                            i32.or
                            i32.store offset=1050496
                            local.get 2
                            local.set 3
                            br 1 (;@11;)
                          end
                          local.get 2
                          i32.load offset=8
                          local.set 3
                        end
                        local.get 2
                        local.get 0
                        i32.store offset=8
                        local.get 3
                        local.get 0
                        i32.store offset=12
                        local.get 0
                        local.get 2
                        i32.store offset=12
                        local.get 0
                        local.get 3
                        i32.store offset=8
                        br 5 (;@5;)
                      end
                      i32.const 0
                      local.get 0
                      local.get 3
                      i32.sub
                      local.tee 2
                      i32.store offset=1050508
                      i32.const 0
                      i32.const 0
                      i32.load offset=1050516
                      local.tee 0
                      local.get 3
                      i32.add
                      local.tee 7
                      i32.store offset=1050516
                      local.get 7
                      local.get 2
                      i32.const 1
                      i32.or
                      i32.store offset=4
                      local.get 0
                      local.get 3
                      i32.const 3
                      i32.or
                      i32.store offset=4
                      local.get 0
                      i32.const 8
                      i32.add
                      local.set 0
                      br 8 (;@1;)
                    end
                    i32.const 0
                    i32.load offset=1050512
                    local.set 2
                    block  ;; label = @9
                      block  ;; label = @10
                        local.get 0
                        local.get 3
                        i32.sub
                        local.tee 7
                        i32.const 15
                        i32.gt_u
                        br_if 0 (;@10;)
                        i32.const 0
                        i32.const 0
                        i32.store offset=1050512
                        i32.const 0
                        i32.const 0
                        i32.store offset=1050504
                        local.get 2
                        local.get 0
                        i32.const 3
                        i32.or
                        i32.store offset=4
                        local.get 2
                        local.get 0
                        i32.add
                        local.tee 0
                        local.get 0
                        i32.load offset=4
                        i32.const 1
                        i32.or
                        i32.store offset=4
                        br 1 (;@9;)
                      end
                      i32.const 0
                      local.get 7
                      i32.store offset=1050504
                      i32.const 0
                      local.get 2
                      local.get 3
                      i32.add
                      local.tee 6
                      i32.store offset=1050512
                      local.get 6
                      local.get 7
                      i32.const 1
                      i32.or
                      i32.store offset=4
                      local.get 2
                      local.get 0
                      i32.add
                      local.get 7
                      i32.store
                      local.get 2
                      local.get 3
                      i32.const 3
                      i32.or
                      i32.store offset=4
                    end
                    local.get 2
                    i32.const 8
                    i32.add
                    local.set 0
                    br 7 (;@1;)
                  end
                  local.get 0
                  local.get 8
                  local.get 9
                  i32.add
                  i32.store offset=4
                  i32.const 0
                  i32.const 0
                  i32.load offset=1050516
                  local.tee 0
                  i32.const 15
                  i32.add
                  i32.const -8
                  i32.and
                  local.tee 2
                  i32.const -8
                  i32.add
                  local.tee 7
                  i32.store offset=1050516
                  i32.const 0
                  local.get 0
                  local.get 2
                  i32.sub
                  i32.const 0
                  i32.load offset=1050508
                  local.get 9
                  i32.add
                  local.tee 2
                  i32.add
                  i32.const 8
                  i32.add
                  local.tee 6
                  i32.store offset=1050508
                  local.get 7
                  local.get 6
                  i32.const 1
                  i32.or
                  i32.store offset=4
                  local.get 0
                  local.get 2
                  i32.add
                  i32.const 40
                  i32.store offset=4
                  i32.const 0
                  i32.const 2097152
                  i32.store offset=1050528
                  br 3 (;@4;)
                end
                i32.const 0
                local.get 0
                i32.store offset=1050516
                i32.const 0
                i32.const 0
                i32.load offset=1050508
                local.get 3
                i32.add
                local.tee 3
                i32.store offset=1050508
                local.get 0
                local.get 3
                i32.const 1
                i32.or
                i32.store offset=4
                br 1 (;@5;)
              end
              i32.const 0
              local.get 0
              i32.store offset=1050512
              i32.const 0
              i32.const 0
              i32.load offset=1050504
              local.get 3
              i32.add
              local.tee 3
              i32.store offset=1050504
              local.get 0
              local.get 3
              i32.const 1
              i32.or
              i32.store offset=4
              local.get 0
              local.get 3
              i32.add
              local.get 3
              i32.store
            end
            local.get 7
            i32.const 8
            i32.add
            local.set 0
            br 3 (;@1;)
          end
          i32.const 0
          local.set 0
          i32.const 0
          i32.load offset=1050508
          local.tee 2
          local.get 3
          i32.le_u
          br_if 2 (;@1;)
          i32.const 0
          local.get 2
          local.get 3
          i32.sub
          local.tee 2
          i32.store offset=1050508
          i32.const 0
          i32.const 0
          i32.load offset=1050516
          local.tee 0
          local.get 3
          i32.add
          local.tee 7
          i32.store offset=1050516
          local.get 7
          local.get 2
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 0
          local.get 3
          i32.const 3
          i32.or
          i32.store offset=4
          local.get 0
          i32.const 8
          i32.add
          local.set 0
          br 2 (;@1;)
        end
        local.get 0
        local.get 5
        i32.store offset=24
        block  ;; label = @3
          local.get 7
          i32.load offset=16
          local.tee 6
          i32.eqz
          br_if 0 (;@3;)
          local.get 0
          local.get 6
          i32.store offset=16
          local.get 6
          local.get 0
          i32.store offset=24
        end
        local.get 7
        i32.load offset=20
        local.tee 6
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        local.get 6
        i32.store offset=20
        local.get 6
        local.get 0
        i32.store offset=24
      end
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          i32.const 16
          i32.lt_u
          br_if 0 (;@3;)
          local.get 7
          local.get 3
          i32.const 3
          i32.or
          i32.store offset=4
          local.get 7
          local.get 3
          i32.add
          local.tee 0
          local.get 2
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 0
          local.get 2
          i32.add
          local.get 2
          i32.store
          block  ;; label = @4
            local.get 2
            i32.const 256
            i32.lt_u
            br_if 0 (;@4;)
            local.get 0
            local.get 2
            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17ha51abd6cd7031e06E
            br 2 (;@2;)
          end
          local.get 2
          i32.const 248
          i32.and
          i32.const 1050232
          i32.add
          local.set 3
          block  ;; label = @4
            block  ;; label = @5
              i32.const 0
              i32.load offset=1050496
              local.tee 6
              i32.const 1
              local.get 2
              i32.const 3
              i32.shr_u
              i32.shl
              local.tee 2
              i32.and
              br_if 0 (;@5;)
              i32.const 0
              local.get 6
              local.get 2
              i32.or
              i32.store offset=1050496
              local.get 3
              local.set 2
              br 1 (;@4;)
            end
            local.get 3
            i32.load offset=8
            local.set 2
          end
          local.get 3
          local.get 0
          i32.store offset=8
          local.get 2
          local.get 0
          i32.store offset=12
          local.get 0
          local.get 3
          i32.store offset=12
          local.get 0
          local.get 2
          i32.store offset=8
          br 1 (;@2;)
        end
        local.get 7
        local.get 2
        local.get 3
        i32.add
        local.tee 0
        i32.const 3
        i32.or
        i32.store offset=4
        local.get 7
        local.get 0
        i32.add
        local.tee 0
        local.get 0
        i32.load offset=4
        i32.const 1
        i32.or
        i32.store offset=4
      end
      local.get 7
      i32.const 8
      i32.add
      local.set 0
    end
    local.get 1
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$8memalign17h1d4b2c605e5367c5E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32)
    i32.const 0
    local.set 2
    block  ;; label = @1
      i32.const -65587
      local.get 0
      i32.const 16
      local.get 0
      i32.const 16
      i32.gt_u
      select
      local.tee 0
      i32.sub
      local.get 1
      i32.le_u
      br_if 0 (;@1;)
      local.get 0
      i32.const 16
      local.get 1
      i32.const 11
      i32.add
      i32.const -8
      i32.and
      local.get 1
      i32.const 11
      i32.lt_u
      select
      local.tee 3
      i32.add
      i32.const 12
      i32.add
      call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17hd2421ed15302c503E
      local.tee 1
      i32.eqz
      br_if 0 (;@1;)
      local.get 1
      i32.const -8
      i32.add
      local.set 2
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          i32.const -1
          i32.add
          local.tee 4
          local.get 1
          i32.and
          br_if 0 (;@3;)
          local.get 2
          local.set 0
          br 1 (;@2;)
        end
        local.get 1
        i32.const -4
        i32.add
        local.tee 5
        i32.load
        local.tee 6
        i32.const -8
        i32.and
        local.get 4
        local.get 1
        i32.add
        i32.const 0
        local.get 0
        i32.sub
        i32.and
        i32.const -8
        i32.add
        local.tee 1
        i32.const 0
        local.get 0
        local.get 1
        local.get 2
        i32.sub
        i32.const 16
        i32.gt_u
        select
        i32.add
        local.tee 0
        local.get 2
        i32.sub
        local.tee 1
        i32.sub
        local.set 4
        block  ;; label = @3
          local.get 6
          i32.const 3
          i32.and
          i32.eqz
          br_if 0 (;@3;)
          local.get 0
          local.get 4
          local.get 0
          i32.load offset=4
          i32.const 1
          i32.and
          i32.or
          i32.const 2
          i32.or
          i32.store offset=4
          local.get 0
          local.get 4
          i32.add
          local.tee 4
          local.get 4
          i32.load offset=4
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 5
          local.get 1
          local.get 5
          i32.load
          i32.const 1
          i32.and
          i32.or
          i32.const 2
          i32.or
          i32.store
          local.get 2
          local.get 1
          i32.add
          local.tee 4
          local.get 4
          i32.load offset=4
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 2
          local.get 1
          call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17ha03e82fa7bdf8a33E
          br 1 (;@2;)
        end
        local.get 2
        i32.load
        local.set 2
        local.get 0
        local.get 4
        i32.store offset=4
        local.get 0
        local.get 2
        local.get 1
        i32.add
        i32.store
      end
      block  ;; label = @2
        local.get 0
        i32.load offset=4
        local.tee 1
        i32.const 3
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        i32.const -8
        i32.and
        local.tee 2
        local.get 3
        i32.const 16
        i32.add
        i32.le_u
        br_if 0 (;@2;)
        local.get 0
        local.get 3
        local.get 1
        i32.const 1
        i32.and
        i32.or
        i32.const 2
        i32.or
        i32.store offset=4
        local.get 0
        local.get 3
        i32.add
        local.tee 1
        local.get 2
        local.get 3
        i32.sub
        local.tee 3
        i32.const 3
        i32.or
        i32.store offset=4
        local.get 0
        local.get 2
        i32.add
        local.tee 2
        local.get 2
        i32.load offset=4
        i32.const 1
        i32.or
        i32.store offset=4
        local.get 1
        local.get 3
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17ha03e82fa7bdf8a33E
      end
      local.get 0
      i32.const 8
      i32.add
      local.set 2
    end
    local.get 2)
  (func $_ZN3std3sys9backtrace26__rust_end_short_backtrace17h8eb99c908c86e40bE (type 8) (param i32)
    local.get 0
    call $_ZN3std9panicking19begin_panic_handler28_$u7b$$u7b$closure$u7d$$u7d$17h83b3d84f04c7372bE
    unreachable)
  (func $_ZN3std9panicking19begin_panic_handler28_$u7b$$u7b$closure$u7d$$u7d$17h83b3d84f04c7372bE (type 8) (param i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    local.get 0
    i32.load
    local.tee 2
    i32.load offset=12
    local.set 3
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 2
            i32.load offset=4
            br_table 0 (;@4;) 1 (;@3;) 2 (;@2;)
          end
          local.get 3
          br_if 1 (;@2;)
          i32.const 1
          local.set 2
          i32.const 0
          local.set 3
          br 2 (;@1;)
        end
        local.get 3
        br_if 0 (;@2;)
        local.get 2
        i32.load
        local.tee 2
        i32.load offset=4
        local.set 3
        local.get 2
        i32.load
        local.set 2
        br 1 (;@1;)
      end
      local.get 1
      i32.const -2147483648
      i32.store
      local.get 1
      local.get 0
      i32.store offset=12
      local.get 1
      i32.const 1049528
      local.get 0
      i32.load offset=4
      local.get 0
      i32.load offset=8
      local.tee 0
      i32.load8_u offset=8
      local.get 0
      i32.load8_u offset=9
      call $_ZN3std9panicking20rust_panic_with_hook17hb39abb160cd4038cE
      unreachable
    end
    local.get 1
    local.get 3
    i32.store offset=4
    local.get 1
    local.get 2
    i32.store
    local.get 1
    i32.const 1049500
    local.get 0
    i32.load offset=4
    local.get 0
    i32.load offset=8
    local.tee 0
    i32.load8_u offset=8
    local.get 0
    i32.load8_u offset=9
    call $_ZN3std9panicking20rust_panic_with_hook17hb39abb160cd4038cE
    unreachable)
  (func $_ZN3std5alloc24default_alloc_error_hook17h7c876c22af7f81cfE (type 0) (param i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      i32.const 0
      i32.load8_u offset=1050064
      i32.eqz
      br_if 0 (;@1;)
      local.get 2
      i32.const 2
      i32.store offset=12
      local.get 2
      i32.const 1049412
      i32.store offset=8
      local.get 2
      i64.const 1
      i64.store offset=20 align=4
      local.get 2
      local.get 1
      i32.store offset=44
      local.get 2
      i32.const 2
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.get 2
      i32.const 44
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=32
      local.get 2
      local.get 2
      i32.const 32
      i32.add
      i32.store offset=16
      local.get 2
      i32.const 8
      i32.add
      i32.const 1049452
      call $_ZN4core9panicking9panic_fmt17h6f4dae69dcc1a6d2E
      unreachable
    end
    local.get 2
    i32.const 48
    i32.add
    global.set $__stack_pointer)
  (func $__rdl_alloc (type 2) (param i32 i32) (result i32)
    block  ;; label = @1
      local.get 1
      i32.const 9
      i32.lt_u
      br_if 0 (;@1;)
      local.get 1
      local.get 0
      call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$8memalign17h1d4b2c605e5367c5E
      return
    end
    local.get 0
    call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17hd2421ed15302c503E)
  (func $__rdl_dealloc (type 4) (param i32 i32 i32)
    (local i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.const -4
        i32.add
        i32.load
        local.tee 3
        i32.const -8
        i32.and
        local.tee 4
        i32.const 4
        i32.const 8
        local.get 3
        i32.const 3
        i32.and
        local.tee 3
        select
        local.get 1
        i32.add
        i32.lt_u
        br_if 0 (;@2;)
        block  ;; label = @3
          local.get 3
          i32.eqz
          br_if 0 (;@3;)
          local.get 4
          local.get 1
          i32.const 39
          i32.add
          i32.gt_u
          br_if 2 (;@1;)
        end
        local.get 0
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$4free17hbb624227e39e47e9E
        return
      end
      i32.const 1049249
      i32.const 46
      i32.const 1049296
      call $_ZN4core9panicking5panic17hb7d13004db45f2e3E
      unreachable
    end
    i32.const 1049312
    i32.const 46
    i32.const 1049360
    call $_ZN4core9panicking5panic17hb7d13004db45f2e3E
    unreachable)
  (func $__rdl_realloc (type 5) (param i32 i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 0
              i32.const -4
              i32.add
              local.tee 4
              i32.load
              local.tee 5
              i32.const -8
              i32.and
              local.tee 6
              i32.const 4
              i32.const 8
              local.get 5
              i32.const 3
              i32.and
              local.tee 7
              select
              local.get 1
              i32.add
              i32.lt_u
              br_if 0 (;@5;)
              local.get 1
              i32.const 39
              i32.add
              local.set 8
              block  ;; label = @6
                local.get 7
                i32.eqz
                br_if 0 (;@6;)
                local.get 6
                local.get 8
                i32.gt_u
                br_if 2 (;@4;)
              end
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 2
                    i32.const 9
                    i32.lt_u
                    br_if 0 (;@8;)
                    local.get 2
                    local.get 3
                    call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$8memalign17h1d4b2c605e5367c5E
                    local.tee 2
                    br_if 1 (;@7;)
                    i32.const 0
                    return
                  end
                  i32.const 0
                  local.set 2
                  local.get 3
                  i32.const -65588
                  i32.gt_u
                  br_if 1 (;@6;)
                  i32.const 16
                  local.get 3
                  i32.const 11
                  i32.add
                  i32.const -8
                  i32.and
                  local.get 3
                  i32.const 11
                  i32.lt_u
                  select
                  local.set 1
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 7
                      br_if 0 (;@9;)
                      local.get 1
                      i32.const 256
                      i32.lt_u
                      br_if 1 (;@8;)
                      local.get 6
                      local.get 1
                      i32.const 4
                      i32.or
                      i32.lt_u
                      br_if 1 (;@8;)
                      local.get 6
                      local.get 1
                      i32.sub
                      i32.const 131073
                      i32.ge_u
                      br_if 1 (;@8;)
                      local.get 0
                      return
                    end
                    local.get 0
                    i32.const -8
                    i32.add
                    local.tee 8
                    local.get 6
                    i32.add
                    local.set 7
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              local.get 6
                              local.get 1
                              i32.ge_u
                              br_if 0 (;@13;)
                              local.get 7
                              i32.const 0
                              i32.load offset=1050516
                              i32.eq
                              br_if 4 (;@9;)
                              local.get 7
                              i32.const 0
                              i32.load offset=1050512
                              i32.eq
                              br_if 2 (;@11;)
                              local.get 7
                              i32.load offset=4
                              local.tee 5
                              i32.const 2
                              i32.and
                              br_if 5 (;@8;)
                              local.get 5
                              i32.const -8
                              i32.and
                              local.tee 9
                              local.get 6
                              i32.add
                              local.tee 5
                              local.get 1
                              i32.lt_u
                              br_if 5 (;@8;)
                              local.get 7
                              local.get 9
                              call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$12unlink_chunk17h0d0f475ea8907bb5E
                              local.get 5
                              local.get 1
                              i32.sub
                              local.tee 3
                              i32.const 16
                              i32.lt_u
                              br_if 1 (;@12;)
                              local.get 4
                              local.get 1
                              local.get 4
                              i32.load
                              i32.const 1
                              i32.and
                              i32.or
                              i32.const 2
                              i32.or
                              i32.store
                              local.get 8
                              local.get 1
                              i32.add
                              local.tee 1
                              local.get 3
                              i32.const 3
                              i32.or
                              i32.store offset=4
                              local.get 8
                              local.get 5
                              i32.add
                              local.tee 2
                              local.get 2
                              i32.load offset=4
                              i32.const 1
                              i32.or
                              i32.store offset=4
                              local.get 1
                              local.get 3
                              call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17ha03e82fa7bdf8a33E
                              local.get 0
                              return
                            end
                            local.get 6
                            local.get 1
                            i32.sub
                            local.tee 3
                            i32.const 15
                            i32.gt_u
                            br_if 2 (;@10;)
                            local.get 0
                            return
                          end
                          local.get 4
                          local.get 5
                          local.get 4
                          i32.load
                          i32.const 1
                          i32.and
                          i32.or
                          i32.const 2
                          i32.or
                          i32.store
                          local.get 8
                          local.get 5
                          i32.add
                          local.tee 1
                          local.get 1
                          i32.load offset=4
                          i32.const 1
                          i32.or
                          i32.store offset=4
                          local.get 0
                          return
                        end
                        i32.const 0
                        i32.load offset=1050504
                        local.get 6
                        i32.add
                        local.tee 7
                        local.get 1
                        i32.lt_u
                        br_if 2 (;@8;)
                        block  ;; label = @11
                          block  ;; label = @12
                            local.get 7
                            local.get 1
                            i32.sub
                            local.tee 3
                            i32.const 15
                            i32.gt_u
                            br_if 0 (;@12;)
                            local.get 4
                            local.get 5
                            i32.const 1
                            i32.and
                            local.get 7
                            i32.or
                            i32.const 2
                            i32.or
                            i32.store
                            local.get 8
                            local.get 7
                            i32.add
                            local.tee 1
                            local.get 1
                            i32.load offset=4
                            i32.const 1
                            i32.or
                            i32.store offset=4
                            i32.const 0
                            local.set 3
                            i32.const 0
                            local.set 1
                            br 1 (;@11;)
                          end
                          local.get 4
                          local.get 1
                          local.get 5
                          i32.const 1
                          i32.and
                          i32.or
                          i32.const 2
                          i32.or
                          i32.store
                          local.get 8
                          local.get 1
                          i32.add
                          local.tee 1
                          local.get 3
                          i32.const 1
                          i32.or
                          i32.store offset=4
                          local.get 8
                          local.get 7
                          i32.add
                          local.tee 2
                          local.get 3
                          i32.store
                          local.get 2
                          local.get 2
                          i32.load offset=4
                          i32.const -2
                          i32.and
                          i32.store offset=4
                        end
                        i32.const 0
                        local.get 1
                        i32.store offset=1050512
                        i32.const 0
                        local.get 3
                        i32.store offset=1050504
                        local.get 0
                        return
                      end
                      local.get 4
                      local.get 1
                      local.get 5
                      i32.const 1
                      i32.and
                      i32.or
                      i32.const 2
                      i32.or
                      i32.store
                      local.get 8
                      local.get 1
                      i32.add
                      local.tee 1
                      local.get 3
                      i32.const 3
                      i32.or
                      i32.store offset=4
                      local.get 7
                      local.get 7
                      i32.load offset=4
                      i32.const 1
                      i32.or
                      i32.store offset=4
                      local.get 1
                      local.get 3
                      call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17ha03e82fa7bdf8a33E
                      local.get 0
                      return
                    end
                    i32.const 0
                    i32.load offset=1050508
                    local.get 6
                    i32.add
                    local.tee 7
                    local.get 1
                    i32.gt_u
                    br_if 7 (;@1;)
                  end
                  local.get 3
                  call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17hd2421ed15302c503E
                  local.tee 1
                  i32.eqz
                  br_if 1 (;@6;)
                  local.get 1
                  local.get 0
                  i32.const -4
                  i32.const -8
                  local.get 4
                  i32.load
                  local.tee 2
                  i32.const 3
                  i32.and
                  select
                  local.get 2
                  i32.const -8
                  i32.and
                  i32.add
                  local.tee 2
                  local.get 3
                  local.get 2
                  local.get 3
                  i32.lt_u
                  select
                  call $memcpy
                  local.set 1
                  local.get 0
                  call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$4free17hbb624227e39e47e9E
                  local.get 1
                  return
                end
                local.get 2
                local.get 0
                local.get 1
                local.get 3
                local.get 1
                local.get 3
                i32.lt_u
                select
                call $memcpy
                drop
                local.get 4
                i32.load
                local.tee 3
                i32.const -8
                i32.and
                local.tee 7
                i32.const 4
                i32.const 8
                local.get 3
                i32.const 3
                i32.and
                local.tee 3
                select
                local.get 1
                i32.add
                i32.lt_u
                br_if 3 (;@3;)
                block  ;; label = @7
                  local.get 3
                  i32.eqz
                  br_if 0 (;@7;)
                  local.get 7
                  local.get 8
                  i32.gt_u
                  br_if 5 (;@2;)
                end
                local.get 0
                call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$4free17hbb624227e39e47e9E
              end
              local.get 2
              return
            end
            i32.const 1049249
            i32.const 46
            i32.const 1049296
            call $_ZN4core9panicking5panic17hb7d13004db45f2e3E
            unreachable
          end
          i32.const 1049312
          i32.const 46
          i32.const 1049360
          call $_ZN4core9panicking5panic17hb7d13004db45f2e3E
          unreachable
        end
        i32.const 1049249
        i32.const 46
        i32.const 1049296
        call $_ZN4core9panicking5panic17hb7d13004db45f2e3E
        unreachable
      end
      i32.const 1049312
      i32.const 46
      i32.const 1049360
      call $_ZN4core9panicking5panic17hb7d13004db45f2e3E
      unreachable
    end
    local.get 4
    local.get 1
    local.get 5
    i32.const 1
    i32.and
    i32.or
    i32.const 2
    i32.or
    i32.store
    local.get 8
    local.get 1
    i32.add
    local.tee 3
    local.get 7
    local.get 1
    i32.sub
    local.tee 1
    i32.const 1
    i32.or
    i32.store offset=4
    i32.const 0
    local.get 1
    i32.store offset=1050508
    i32.const 0
    local.get 3
    i32.store offset=1050516
    local.get 0)
  (func $__rdl_alloc_zeroed (type 2) (param i32 i32) (result i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.const 9
        i32.lt_u
        br_if 0 (;@2;)
        local.get 1
        local.get 0
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$8memalign17h1d4b2c605e5367c5E
        local.set 1
        br 1 (;@1;)
      end
      local.get 0
      call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17hd2421ed15302c503E
      local.set 1
    end
    block  ;; label = @1
      local.get 1
      i32.eqz
      br_if 0 (;@1;)
      local.get 1
      i32.const -4
      i32.add
      i32.load8_u
      i32.const 3
      i32.and
      i32.eqz
      br_if 0 (;@1;)
      local.get 1
      i32.const 0
      local.get 0
      call $memset
      drop
    end
    local.get 1)
  (func $_ZN3std9panicking11panic_count8increase17h06eada8cf2e7ed98E (type 3) (param i32) (result i32)
    (local i32 i32)
    i32.const 0
    local.set 1
    i32.const 0
    i32.const 0
    i32.load offset=1050084
    local.tee 2
    i32.const 1
    i32.add
    i32.store offset=1050084
    block  ;; label = @1
      local.get 2
      i32.const 0
      i32.lt_s
      br_if 0 (;@1;)
      i32.const 1
      local.set 1
      i32.const 0
      i32.load8_u offset=1050544
      br_if 0 (;@1;)
      i32.const 0
      local.get 0
      i32.store8 offset=1050544
      i32.const 0
      i32.const 0
      i32.load offset=1050540
      i32.const 1
      i32.add
      i32.store offset=1050540
      i32.const 2
      local.set 1
    end
    local.get 1)
  (func $rust_begin_unwind (type 8) (param i32)
    (local i32 i64)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    local.get 0
    i64.load align=4
    local.set 2
    local.get 1
    local.get 0
    i32.store offset=12
    local.get 1
    local.get 2
    i64.store offset=4 align=4
    local.get 1
    i32.const 4
    i32.add
    call $_ZN3std3sys9backtrace26__rust_end_short_backtrace17h8eb99c908c86e40bE
    unreachable)
  (func $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17h059ea5adc6a21895E (type 0) (param i32 i32)
    (local i32 i32 i32 i64)
    global.get $__stack_pointer
    i32.const 64
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      local.get 1
      i32.load
      i32.const -2147483648
      i32.ne
      br_if 0 (;@1;)
      local.get 1
      i32.load offset=12
      local.set 3
      local.get 2
      i32.const 28
      i32.add
      i32.const 8
      i32.add
      local.tee 4
      i32.const 0
      i32.store
      local.get 2
      i64.const 4294967296
      i64.store offset=28 align=4
      local.get 2
      i32.const 40
      i32.add
      i32.const 8
      i32.add
      local.get 3
      i32.load
      local.tee 3
      i32.const 8
      i32.add
      i64.load align=4
      i64.store
      local.get 2
      i32.const 40
      i32.add
      i32.const 16
      i32.add
      local.get 3
      i32.const 16
      i32.add
      i64.load align=4
      i64.store
      local.get 2
      local.get 3
      i64.load align=4
      i64.store offset=40
      local.get 2
      i32.const 28
      i32.add
      i32.const 1049184
      local.get 2
      i32.const 40
      i32.add
      call $_ZN4core3fmt5write17h2db157f4177a0bcdE
      drop
      local.get 2
      i32.const 16
      i32.add
      i32.const 8
      i32.add
      local.get 4
      i32.load
      local.tee 3
      i32.store
      local.get 2
      local.get 2
      i64.load offset=28 align=4
      local.tee 5
      i64.store offset=16
      local.get 1
      i32.const 8
      i32.add
      local.get 3
      i32.store
      local.get 1
      local.get 5
      i64.store align=4
    end
    local.get 1
    i64.load align=4
    local.set 5
    local.get 1
    i64.const 4294967296
    i64.store align=4
    local.get 2
    i32.const 8
    i32.add
    local.tee 3
    local.get 1
    i32.const 8
    i32.add
    local.tee 1
    i32.load
    i32.store
    local.get 1
    i32.const 0
    i32.store
    i32.const 0
    i32.load8_u offset=1050065
    drop
    local.get 2
    local.get 5
    i64.store
    block  ;; label = @1
      i32.const 12
      i32.const 4
      call $__rust_alloc
      local.tee 1
      br_if 0 (;@1;)
      i32.const 4
      i32.const 12
      call $_ZN5alloc5alloc18handle_alloc_error17haa33c1301de96704E
      unreachable
    end
    local.get 1
    local.get 2
    i64.load
    i64.store align=4
    local.get 1
    i32.const 8
    i32.add
    local.get 3
    i32.load
    i32.store
    local.get 0
    i32.const 1049468
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store
    local.get 2
    i32.const 64
    i32.add
    global.set $__stack_pointer)
  (func $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17hb9087c3a32205b67E (type 0) (param i32 i32)
    (local i32 i32 i32 i64)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      local.get 1
      i32.load
      i32.const -2147483648
      i32.ne
      br_if 0 (;@1;)
      local.get 1
      i32.load offset=12
      local.set 3
      local.get 2
      i32.const 12
      i32.add
      i32.const 8
      i32.add
      local.tee 4
      i32.const 0
      i32.store
      local.get 2
      i64.const 4294967296
      i64.store offset=12 align=4
      local.get 2
      i32.const 24
      i32.add
      i32.const 8
      i32.add
      local.get 3
      i32.load
      local.tee 3
      i32.const 8
      i32.add
      i64.load align=4
      i64.store
      local.get 2
      i32.const 24
      i32.add
      i32.const 16
      i32.add
      local.get 3
      i32.const 16
      i32.add
      i64.load align=4
      i64.store
      local.get 2
      local.get 3
      i64.load align=4
      i64.store offset=24
      local.get 2
      i32.const 12
      i32.add
      i32.const 1049184
      local.get 2
      i32.const 24
      i32.add
      call $_ZN4core3fmt5write17h2db157f4177a0bcdE
      drop
      local.get 2
      i32.const 8
      i32.add
      local.get 4
      i32.load
      local.tee 3
      i32.store
      local.get 2
      local.get 2
      i64.load offset=12 align=4
      local.tee 5
      i64.store
      local.get 1
      i32.const 8
      i32.add
      local.get 3
      i32.store
      local.get 1
      local.get 5
      i64.store align=4
    end
    local.get 0
    i32.const 1049468
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store
    local.get 2
    i32.const 48
    i32.add
    global.set $__stack_pointer)
  (func $_ZN95_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..fmt..Display$GT$3fmt17h2929032b84366b94E (type 2) (param i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load
        i32.const -2147483648
        i32.eq
        br_if 0 (;@2;)
        local.get 1
        local.get 0
        i32.load offset=4
        local.get 0
        i32.load offset=8
        call $_ZN4core3fmt9Formatter9write_str17h4abba99f2e253f35E
        local.set 0
        br 1 (;@1;)
      end
      local.get 2
      i32.const 8
      i32.add
      i32.const 8
      i32.add
      local.get 0
      i32.load offset=12
      i32.load
      local.tee 0
      i32.const 8
      i32.add
      i64.load align=4
      i64.store
      local.get 2
      i32.const 8
      i32.add
      i32.const 16
      i32.add
      local.get 0
      i32.const 16
      i32.add
      i64.load align=4
      i64.store
      local.get 2
      local.get 0
      i64.load align=4
      i64.store offset=8
      local.get 1
      i32.load offset=28
      local.get 1
      i32.load offset=32
      local.get 2
      i32.const 8
      i32.add
      call $_ZN4core3fmt5write17h2db157f4177a0bcdE
      local.set 0
    end
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17he7b48c12b382998cE (type 0) (param i32 i32)
    (local i32 i32)
    i32.const 0
    i32.load8_u offset=1050065
    drop
    local.get 1
    i32.load offset=4
    local.set 2
    local.get 1
    i32.load
    local.set 3
    block  ;; label = @1
      i32.const 8
      i32.const 4
      call $__rust_alloc
      local.tee 1
      br_if 0 (;@1;)
      i32.const 4
      i32.const 8
      call $_ZN5alloc5alloc18handle_alloc_error17haa33c1301de96704E
      unreachable
    end
    local.get 1
    local.get 2
    i32.store offset=4
    local.get 1
    local.get 3
    i32.store
    local.get 0
    i32.const 1049484
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store)
  (func $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17h14568fb11df09eaeE (type 0) (param i32 i32)
    local.get 0
    i32.const 1049484
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store)
  (func $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$6as_str17h942de68efd2647a4E (type 0) (param i32 i32)
    local.get 0
    local.get 1
    i64.load align=4
    i64.store)
  (func $_ZN92_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..fmt..Display$GT$3fmt17h12a3052156fbd475E (type 2) (param i32 i32) (result i32)
    local.get 1
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    call $_ZN4core3fmt9Formatter9write_str17h4abba99f2e253f35E)
  (func $_ZN3std9panicking20rust_panic_with_hook17hb39abb160cd4038cE (type 7) (param i32 i32 i32 i32 i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        i32.const 1
        call $_ZN3std9panicking11panic_count8increase17h06eada8cf2e7ed98E
        i32.const 255
        i32.and
        local.tee 6
        i32.const 2
        i32.eq
        br_if 0 (;@2;)
        local.get 6
        i32.const 1
        i32.and
        i32.eqz
        br_if 1 (;@1;)
        local.get 5
        i32.const 8
        i32.add
        local.get 0
        local.get 1
        i32.load offset=24
        call_indirect (type 0)
        unreachable
      end
      i32.const 0
      i32.load offset=1050072
      local.tee 6
      i32.const -1
      i32.le_s
      br_if 0 (;@1;)
      i32.const 0
      local.get 6
      i32.const 1
      i32.add
      i32.store offset=1050072
      block  ;; label = @2
        i32.const 0
        i32.load offset=1050076
        i32.eqz
        br_if 0 (;@2;)
        local.get 5
        local.get 0
        local.get 1
        i32.load offset=20
        call_indirect (type 0)
        local.get 5
        local.get 4
        i32.store8 offset=29
        local.get 5
        local.get 3
        i32.store8 offset=28
        local.get 5
        local.get 2
        i32.store offset=24
        local.get 5
        local.get 5
        i64.load
        i64.store offset=16 align=4
        i32.const 0
        i32.load offset=1050076
        local.get 5
        i32.const 16
        i32.add
        i32.const 0
        i32.load offset=1050080
        i32.load offset=20
        call_indirect (type 0)
        i32.const 0
        i32.load offset=1050072
        i32.const -1
        i32.add
        local.set 6
      end
      i32.const 0
      local.get 6
      i32.store offset=1050072
      i32.const 0
      i32.const 0
      i32.store8 offset=1050544
      local.get 3
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      call $rust_panic
    end
    unreachable)
  (func $rust_panic (type 0) (param i32 i32)
    local.get 0
    local.get 1
    call $__rust_start_panic
    drop
    unreachable)
  (func $__rg_oom (type 0) (param i32 i32)
    (local i32)
    local.get 1
    local.get 0
    i32.const 0
    i32.load offset=1050068
    local.tee 2
    i32.const 3
    local.get 2
    select
    call_indirect (type 0)
    unreachable)
  (func $__rust_start_panic (type 2) (param i32 i32) (result i32)
    unreachable)
  (func $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$5alloc17hf38218fce26a9c00E (type 4) (param i32 i32 i32)
    (local i32)
    local.get 2
    i32.const 16
    i32.shr_u
    memory.grow
    local.set 3
    local.get 0
    i32.const 0
    i32.store offset=8
    local.get 0
    i32.const 0
    local.get 2
    i32.const -65536
    i32.and
    local.get 3
    i32.const -1
    i32.eq
    local.tee 2
    select
    i32.store offset=4
    local.get 0
    i32.const 0
    local.get 3
    i32.const 16
    i32.shl
    local.get 2
    select
    i32.store)
  (func $_ZN5alloc7raw_vec17capacity_overflow17hbc71c29d4abc75a0E (type 8) (param i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    local.get 1
    i32.const 0
    i32.store offset=24
    local.get 1
    i32.const 1
    i32.store offset=12
    local.get 1
    i32.const 1049576
    i32.store offset=8
    local.get 1
    i64.const 4
    i64.store offset=16 align=4
    local.get 1
    i32.const 8
    i32.add
    local.get 0
    call $_ZN4core9panicking9panic_fmt17h6f4dae69dcc1a6d2E
    unreachable)
  (func $_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$8grow_one17h57212a4e3c838e92E (type 0) (param i32 i32)
    (local i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      local.get 0
      i32.load
      local.tee 3
      i32.const -1
      i32.ne
      br_if 0 (;@1;)
      i32.const 0
      i32.const 0
      local.get 1
      call $_ZN5alloc7raw_vec12handle_error17hcd6c5f33527353caE
      unreachable
    end
    block  ;; label = @1
      local.get 3
      i32.const 1
      i32.shl
      local.tee 4
      local.get 3
      i32.const 1
      i32.add
      local.tee 5
      local.get 4
      local.get 5
      i32.gt_u
      select
      local.tee 4
      i32.const 8
      local.get 4
      i32.const 8
      i32.gt_u
      select
      local.tee 4
      i32.const 0
      i32.ge_s
      br_if 0 (;@1;)
      i32.const 0
      i32.const 0
      local.get 1
      call $_ZN5alloc7raw_vec12handle_error17hcd6c5f33527353caE
      unreachable
    end
    i32.const 0
    local.set 5
    block  ;; label = @1
      local.get 3
      i32.eqz
      br_if 0 (;@1;)
      local.get 2
      local.get 3
      i32.store offset=28
      local.get 2
      local.get 0
      i32.load offset=4
      i32.store offset=20
      i32.const 1
      local.set 5
    end
    local.get 2
    local.get 5
    i32.store offset=24
    local.get 2
    i32.const 8
    i32.add
    i32.const 1
    local.get 4
    local.get 2
    i32.const 20
    i32.add
    call $_ZN5alloc7raw_vec11finish_grow17hd640c6805a3fe5d3E
    block  ;; label = @1
      local.get 2
      i32.load offset=8
      i32.const 1
      i32.ne
      br_if 0 (;@1;)
      local.get 2
      i32.load offset=12
      local.get 2
      i32.load offset=16
      local.get 1
      call $_ZN5alloc7raw_vec12handle_error17hcd6c5f33527353caE
      unreachable
    end
    local.get 2
    i32.load offset=12
    local.set 3
    local.get 0
    local.get 4
    i32.store
    local.get 0
    local.get 3
    i32.store offset=4
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN5alloc7raw_vec12handle_error17hcd6c5f33527353caE (type 4) (param i32 i32 i32)
    block  ;; label = @1
      local.get 0
      br_if 0 (;@1;)
      local.get 2
      call $_ZN5alloc7raw_vec17capacity_overflow17hbc71c29d4abc75a0E
      unreachable
    end
    local.get 0
    local.get 1
    call $_ZN5alloc5alloc18handle_alloc_error17haa33c1301de96704E
    unreachable)
  (func $_ZN5alloc7raw_vec11finish_grow17hd640c6805a3fe5d3E (type 9) (param i32 i32 i32 i32)
    (local i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 2
        i32.const 0
        i32.lt_s
        br_if 0 (;@2;)
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 3
              i32.load offset=4
              i32.eqz
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 3
                i32.load offset=8
                local.tee 4
                br_if 0 (;@6;)
                block  ;; label = @7
                  local.get 2
                  br_if 0 (;@7;)
                  local.get 1
                  local.set 3
                  br 4 (;@3;)
                end
                i32.const 0
                i32.load8_u offset=1050065
                drop
                br 2 (;@4;)
              end
              local.get 3
              i32.load
              local.get 4
              local.get 1
              local.get 2
              call $__rust_realloc
              local.set 3
              br 2 (;@3;)
            end
            block  ;; label = @5
              local.get 2
              br_if 0 (;@5;)
              local.get 1
              local.set 3
              br 2 (;@3;)
            end
            i32.const 0
            i32.load8_u offset=1050065
            drop
          end
          local.get 2
          local.get 1
          call $__rust_alloc
          local.set 3
        end
        block  ;; label = @3
          local.get 3
          i32.eqz
          br_if 0 (;@3;)
          local.get 0
          local.get 2
          i32.store offset=8
          local.get 0
          local.get 3
          i32.store offset=4
          local.get 0
          i32.const 0
          i32.store
          return
        end
        local.get 0
        local.get 2
        i32.store offset=8
        local.get 0
        local.get 1
        i32.store offset=4
        br 1 (;@1;)
      end
      local.get 0
      i32.const 0
      i32.store offset=4
    end
    local.get 0
    i32.const 1
    i32.store)
  (func $_ZN5alloc5alloc18handle_alloc_error17haa33c1301de96704E (type 0) (param i32 i32)
    local.get 1
    local.get 0
    call $__rust_alloc_error_handler
    unreachable)
  (func $_ZN4core5slice5index26slice_start_index_len_fail17h6ba96fe804246016E (type 4) (param i32 i32 i32)
    local.get 0
    local.get 1
    local.get 2
    call $_ZN4core5slice5index26slice_start_index_len_fail8do_panic7runtime17h8f5f6eb23a09cf83E
    unreachable)
  (func $_ZN4core5slice5index24slice_end_index_len_fail17hddeff0f8fd5a93e3E (type 4) (param i32 i32 i32)
    local.get 0
    local.get 1
    local.get 2
    call $_ZN4core5slice5index24slice_end_index_len_fail8do_panic7runtime17h7780901f520234faE
    unreachable)
  (func $_ZN4core3fmt9Formatter3pad17hc11ca54d5ab5b124E (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      local.get 0
      i32.load
      local.tee 3
      local.get 0
      i32.load offset=8
      local.tee 4
      i32.or
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 4
        i32.const 1
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        local.get 2
        i32.add
        local.set 5
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            i32.load offset=12
            local.tee 6
            br_if 0 (;@4;)
            i32.const 0
            local.set 7
            local.get 1
            local.set 8
            br 1 (;@3;)
          end
          i32.const 0
          local.set 7
          local.get 1
          local.set 8
          loop  ;; label = @4
            local.get 8
            local.tee 4
            local.get 5
            i32.eq
            br_if 2 (;@2;)
            block  ;; label = @5
              block  ;; label = @6
                local.get 4
                i32.load8_s
                local.tee 8
                i32.const -1
                i32.le_s
                br_if 0 (;@6;)
                local.get 4
                i32.const 1
                i32.add
                local.set 8
                br 1 (;@5;)
              end
              block  ;; label = @6
                local.get 8
                i32.const -32
                i32.ge_u
                br_if 0 (;@6;)
                local.get 4
                i32.const 2
                i32.add
                local.set 8
                br 1 (;@5;)
              end
              block  ;; label = @6
                local.get 8
                i32.const -16
                i32.ge_u
                br_if 0 (;@6;)
                local.get 4
                i32.const 3
                i32.add
                local.set 8
                br 1 (;@5;)
              end
              local.get 4
              i32.const 4
              i32.add
              local.set 8
            end
            local.get 8
            local.get 4
            i32.sub
            local.get 7
            i32.add
            local.set 7
            local.get 6
            i32.const -1
            i32.add
            local.tee 6
            br_if 0 (;@4;)
          end
        end
        local.get 8
        local.get 5
        i32.eq
        br_if 0 (;@2;)
        block  ;; label = @3
          local.get 8
          i32.load8_s
          local.tee 4
          i32.const -1
          i32.gt_s
          br_if 0 (;@3;)
          local.get 4
          i32.const -32
          i32.lt_u
          drop
        end
        block  ;; label = @3
          block  ;; label = @4
            local.get 7
            i32.eqz
            br_if 0 (;@4;)
            block  ;; label = @5
              local.get 7
              local.get 2
              i32.lt_u
              br_if 0 (;@5;)
              local.get 7
              local.get 2
              i32.eq
              br_if 1 (;@4;)
              i32.const 0
              local.set 4
              br 2 (;@3;)
            end
            local.get 1
            local.get 7
            i32.add
            i32.load8_s
            i32.const -64
            i32.ge_s
            br_if 0 (;@4;)
            i32.const 0
            local.set 4
            br 1 (;@3;)
          end
          local.get 1
          local.set 4
        end
        local.get 7
        local.get 2
        local.get 4
        select
        local.set 2
        local.get 4
        local.get 1
        local.get 4
        select
        local.set 1
      end
      block  ;; label = @2
        local.get 3
        br_if 0 (;@2;)
        local.get 0
        i32.load offset=28
        local.get 1
        local.get 2
        local.get 0
        i32.load offset=32
        i32.load offset=12
        call_indirect (type 1)
        return
      end
      local.get 0
      i32.load offset=4
      local.set 3
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          i32.const 16
          i32.lt_u
          br_if 0 (;@3;)
          local.get 1
          local.get 2
          call $_ZN4core3str5count14do_count_chars17h99e5bacf8097c0c8E
          local.set 4
          br 1 (;@2;)
        end
        block  ;; label = @3
          local.get 2
          br_if 0 (;@3;)
          i32.const 0
          local.set 4
          br 1 (;@2;)
        end
        local.get 2
        i32.const 3
        i32.and
        local.set 6
        block  ;; label = @3
          block  ;; label = @4
            local.get 2
            i32.const 4
            i32.ge_u
            br_if 0 (;@4;)
            i32.const 0
            local.set 4
            i32.const 0
            local.set 7
            br 1 (;@3;)
          end
          local.get 2
          i32.const 12
          i32.and
          local.set 5
          i32.const 0
          local.set 4
          i32.const 0
          local.set 7
          loop  ;; label = @4
            local.get 4
            local.get 1
            local.get 7
            i32.add
            local.tee 8
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.get 8
            i32.const 1
            i32.add
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.get 8
            i32.const 2
            i32.add
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.get 8
            i32.const 3
            i32.add
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.set 4
            local.get 5
            local.get 7
            i32.const 4
            i32.add
            local.tee 7
            i32.ne
            br_if 0 (;@4;)
          end
        end
        local.get 6
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        local.get 7
        i32.add
        local.set 8
        loop  ;; label = @3
          local.get 4
          local.get 8
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.set 4
          local.get 8
          i32.const 1
          i32.add
          local.set 8
          local.get 6
          i32.const -1
          i32.add
          local.tee 6
          br_if 0 (;@3;)
        end
      end
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          local.get 4
          i32.le_u
          br_if 0 (;@3;)
          local.get 3
          local.get 4
          i32.sub
          local.set 6
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                i32.const 0
                local.get 0
                i32.load8_u offset=24
                local.tee 4
                local.get 4
                i32.const 3
                i32.eq
                select
                local.tee 4
                br_table 2 (;@4;) 0 (;@6;) 1 (;@5;) 2 (;@4;)
              end
              local.get 6
              local.set 4
              i32.const 0
              local.set 6
              br 1 (;@4;)
            end
            local.get 6
            i32.const 1
            i32.shr_u
            local.set 4
            local.get 6
            i32.const 1
            i32.add
            i32.const 1
            i32.shr_u
            local.set 6
          end
          local.get 4
          i32.const 1
          i32.add
          local.set 4
          local.get 0
          i32.load offset=16
          local.set 7
          local.get 0
          i32.load offset=32
          local.set 8
          local.get 0
          i32.load offset=28
          local.set 0
          loop  ;; label = @4
            local.get 4
            i32.const -1
            i32.add
            local.tee 4
            i32.eqz
            br_if 2 (;@2;)
            local.get 0
            local.get 7
            local.get 8
            i32.load offset=16
            call_indirect (type 2)
            i32.eqz
            br_if 0 (;@4;)
          end
          i32.const 1
          return
        end
        local.get 0
        i32.load offset=28
        local.get 1
        local.get 2
        local.get 0
        i32.load offset=32
        i32.load offset=12
        call_indirect (type 1)
        return
      end
      block  ;; label = @2
        local.get 0
        local.get 1
        local.get 2
        local.get 8
        i32.load offset=12
        call_indirect (type 1)
        i32.eqz
        br_if 0 (;@2;)
        i32.const 1
        return
      end
      i32.const 0
      local.set 4
      loop  ;; label = @2
        block  ;; label = @3
          local.get 6
          local.get 4
          i32.ne
          br_if 0 (;@3;)
          local.get 6
          local.get 6
          i32.lt_u
          return
        end
        local.get 4
        i32.const 1
        i32.add
        local.set 4
        local.get 0
        local.get 7
        local.get 8
        i32.load offset=16
        call_indirect (type 2)
        i32.eqz
        br_if 0 (;@2;)
      end
      local.get 4
      i32.const -1
      i32.add
      local.get 6
      i32.lt_u
      return
    end
    local.get 0
    i32.load offset=28
    local.get 1
    local.get 2
    local.get 0
    i32.load offset=32
    i32.load offset=12
    call_indirect (type 1))
  (func $_ZN4core9panicking5panic17hb7d13004db45f2e3E (type 4) (param i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    i32.const 0
    i32.store offset=16
    local.get 3
    i32.const 1
    i32.store offset=4
    local.get 3
    i64.const 4
    i64.store offset=8 align=4
    local.get 3
    local.get 1
    i32.store offset=28
    local.get 3
    local.get 0
    i32.store offset=24
    local.get 3
    local.get 3
    i32.const 24
    i32.add
    i32.store
    local.get 3
    local.get 2
    call $_ZN4core9panicking9panic_fmt17h6f4dae69dcc1a6d2E
    unreachable)
  (func $_ZN4core9panicking9panic_fmt17h6f4dae69dcc1a6d2E (type 0) (param i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    i32.const 1
    i32.store16 offset=12
    local.get 2
    local.get 1
    i32.store offset=8
    local.get 2
    local.get 0
    i32.store offset=4
    local.get 2
    i32.const 4
    i32.add
    call $rust_begin_unwind
    unreachable)
  (func $_ZN4core3fmt5write17h2db157f4177a0bcdE (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    local.get 1
    i32.store offset=44
    local.get 3
    local.get 0
    i32.store offset=40
    local.get 3
    i32.const 3
    i32.store8 offset=36
    local.get 3
    i64.const 32
    i64.store offset=28 align=4
    i32.const 0
    local.set 4
    local.get 3
    i32.const 0
    i32.store offset=20
    local.get 3
    i32.const 0
    i32.store offset=12
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 2
              i32.load offset=16
              local.tee 5
              br_if 0 (;@5;)
              local.get 2
              i32.load offset=12
              local.tee 0
              i32.eqz
              br_if 1 (;@4;)
              local.get 2
              i32.load offset=8
              local.tee 1
              local.get 0
              i32.const 3
              i32.shl
              i32.add
              local.set 6
              local.get 0
              i32.const -1
              i32.add
              i32.const 536870911
              i32.and
              i32.const 1
              i32.add
              local.set 4
              local.get 2
              i32.load
              local.set 0
              loop  ;; label = @6
                block  ;; label = @7
                  local.get 0
                  i32.const 4
                  i32.add
                  i32.load
                  local.tee 7
                  i32.eqz
                  br_if 0 (;@7;)
                  local.get 3
                  i32.load offset=40
                  local.get 0
                  i32.load
                  local.get 7
                  local.get 3
                  i32.load offset=44
                  i32.load offset=12
                  call_indirect (type 1)
                  br_if 4 (;@3;)
                end
                local.get 1
                i32.load
                local.get 3
                i32.const 12
                i32.add
                local.get 1
                i32.const 4
                i32.add
                i32.load
                call_indirect (type 2)
                br_if 3 (;@3;)
                local.get 0
                i32.const 8
                i32.add
                local.set 0
                local.get 1
                i32.const 8
                i32.add
                local.tee 1
                local.get 6
                i32.ne
                br_if 0 (;@6;)
                br 2 (;@4;)
              end
            end
            local.get 2
            i32.load offset=20
            local.tee 1
            i32.eqz
            br_if 0 (;@4;)
            local.get 1
            i32.const 5
            i32.shl
            local.set 8
            local.get 1
            i32.const -1
            i32.add
            i32.const 134217727
            i32.and
            i32.const 1
            i32.add
            local.set 4
            local.get 2
            i32.load offset=8
            local.set 9
            local.get 2
            i32.load
            local.set 0
            i32.const 0
            local.set 7
            loop  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.const 4
                i32.add
                i32.load
                local.tee 1
                i32.eqz
                br_if 0 (;@6;)
                local.get 3
                i32.load offset=40
                local.get 0
                i32.load
                local.get 1
                local.get 3
                i32.load offset=44
                i32.load offset=12
                call_indirect (type 1)
                br_if 3 (;@3;)
              end
              local.get 3
              local.get 5
              local.get 7
              i32.add
              local.tee 1
              i32.const 16
              i32.add
              i32.load
              i32.store offset=28
              local.get 3
              local.get 1
              i32.const 28
              i32.add
              i32.load8_u
              i32.store8 offset=36
              local.get 3
              local.get 1
              i32.const 24
              i32.add
              i32.load
              i32.store offset=32
              local.get 1
              i32.const 12
              i32.add
              i32.load
              local.set 6
              i32.const 0
              local.set 10
              i32.const 0
              local.set 11
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 1
                    i32.const 8
                    i32.add
                    i32.load
                    br_table 1 (;@7;) 0 (;@8;) 2 (;@6;) 1 (;@7;)
                  end
                  local.get 6
                  i32.const 3
                  i32.shl
                  local.set 12
                  i32.const 0
                  local.set 11
                  local.get 9
                  local.get 12
                  i32.add
                  local.tee 12
                  i32.load
                  br_if 1 (;@6;)
                  local.get 12
                  i32.load offset=4
                  local.set 6
                end
                i32.const 1
                local.set 11
              end
              local.get 3
              local.get 6
              i32.store offset=16
              local.get 3
              local.get 11
              i32.store offset=12
              local.get 1
              i32.const 4
              i32.add
              i32.load
              local.set 6
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 1
                    i32.load
                    br_table 1 (;@7;) 0 (;@8;) 2 (;@6;) 1 (;@7;)
                  end
                  local.get 6
                  i32.const 3
                  i32.shl
                  local.set 11
                  local.get 9
                  local.get 11
                  i32.add
                  local.tee 11
                  i32.load
                  br_if 1 (;@6;)
                  local.get 11
                  i32.load offset=4
                  local.set 6
                end
                i32.const 1
                local.set 10
              end
              local.get 3
              local.get 6
              i32.store offset=24
              local.get 3
              local.get 10
              i32.store offset=20
              local.get 9
              local.get 1
              i32.const 20
              i32.add
              i32.load
              i32.const 3
              i32.shl
              i32.add
              local.tee 1
              i32.load
              local.get 3
              i32.const 12
              i32.add
              local.get 1
              i32.const 4
              i32.add
              i32.load
              call_indirect (type 2)
              br_if 2 (;@3;)
              local.get 0
              i32.const 8
              i32.add
              local.set 0
              local.get 8
              local.get 7
              i32.const 32
              i32.add
              local.tee 7
              i32.ne
              br_if 0 (;@5;)
            end
          end
          local.get 4
          local.get 2
          i32.load offset=4
          i32.ge_u
          br_if 1 (;@2;)
          local.get 3
          i32.load offset=40
          local.get 2
          i32.load
          local.get 4
          i32.const 3
          i32.shl
          i32.add
          local.tee 1
          i32.load
          local.get 1
          i32.load offset=4
          local.get 3
          i32.load offset=44
          i32.load offset=12
          call_indirect (type 1)
          i32.eqz
          br_if 1 (;@2;)
        end
        i32.const 1
        local.set 1
        br 1 (;@1;)
      end
      i32.const 0
      local.set 1
    end
    local.get 3
    i32.const 48
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $_ZN4core3fmt3num3imp21_$LT$impl$u20$u32$GT$4_fmt17hccdc97766a169818E (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    i32.const 10
    local.set 4
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.const 10000
        i32.ge_u
        br_if 0 (;@2;)
        local.get 0
        local.set 5
        br 1 (;@1;)
      end
      i32.const 10
      local.set 4
      loop  ;; label = @2
        local.get 3
        i32.const 6
        i32.add
        local.get 4
        i32.add
        local.tee 6
        i32.const -4
        i32.add
        local.get 0
        local.get 0
        i32.const 10000
        i32.div_u
        local.tee 5
        i32.const 10000
        i32.mul
        i32.sub
        local.tee 7
        i32.const 65535
        i32.and
        i32.const 100
        i32.div_u
        local.tee 8
        i32.const 1
        i32.shl
        i32.const 1049604
        i32.add
        i32.load16_u align=1
        i32.store16 align=1
        local.get 6
        i32.const -2
        i32.add
        local.get 7
        local.get 8
        i32.const 100
        i32.mul
        i32.sub
        i32.const 65535
        i32.and
        i32.const 1
        i32.shl
        i32.const 1049604
        i32.add
        i32.load16_u align=1
        i32.store16 align=1
        local.get 4
        i32.const -4
        i32.add
        local.set 4
        local.get 0
        i32.const 99999999
        i32.gt_u
        local.set 6
        local.get 5
        local.set 0
        local.get 6
        br_if 0 (;@2;)
      end
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 5
        i32.const 99
        i32.gt_u
        br_if 0 (;@2;)
        local.get 5
        local.set 0
        br 1 (;@1;)
      end
      local.get 3
      i32.const 6
      i32.add
      local.get 4
      i32.const -2
      i32.add
      local.tee 4
      i32.add
      local.get 5
      local.get 5
      i32.const 65535
      i32.and
      i32.const 100
      i32.div_u
      local.tee 0
      i32.const 100
      i32.mul
      i32.sub
      i32.const 65535
      i32.and
      i32.const 1
      i32.shl
      i32.const 1049604
      i32.add
      i32.load16_u align=1
      i32.store16 align=1
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.const 10
        i32.lt_u
        br_if 0 (;@2;)
        local.get 3
        i32.const 6
        i32.add
        local.get 4
        i32.const -2
        i32.add
        local.tee 4
        i32.add
        local.get 0
        i32.const 1
        i32.shl
        i32.const 1049604
        i32.add
        i32.load16_u align=1
        i32.store16 align=1
        br 1 (;@1;)
      end
      local.get 3
      i32.const 6
      i32.add
      local.get 4
      i32.const -1
      i32.add
      local.tee 4
      i32.add
      local.get 0
      i32.const 48
      i32.or
      i32.store8
    end
    local.get 2
    local.get 1
    i32.const 1
    i32.const 0
    local.get 3
    i32.const 6
    i32.add
    local.get 4
    i32.add
    i32.const 10
    local.get 4
    i32.sub
    call $_ZN4core3fmt9Formatter12pad_integral17hcd2413804a182f1fE
    local.set 0
    local.get 3
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN4core3fmt9Formatter12pad_integral17hcd2413804a182f1fE (type 10) (param i32 i32 i32 i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        br_if 0 (;@2;)
        local.get 5
        i32.const 1
        i32.add
        local.set 6
        local.get 0
        i32.load offset=20
        local.set 7
        i32.const 45
        local.set 8
        br 1 (;@1;)
      end
      i32.const 43
      i32.const 1114112
      local.get 0
      i32.load offset=20
      local.tee 7
      i32.const 1
      i32.and
      local.tee 1
      select
      local.set 8
      local.get 1
      local.get 5
      i32.add
      local.set 6
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 7
        i32.const 4
        i32.and
        br_if 0 (;@2;)
        i32.const 0
        local.set 2
        br 1 (;@1;)
      end
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          i32.const 16
          i32.lt_u
          br_if 0 (;@3;)
          local.get 2
          local.get 3
          call $_ZN4core3str5count14do_count_chars17h99e5bacf8097c0c8E
          local.set 1
          br 1 (;@2;)
        end
        block  ;; label = @3
          local.get 3
          br_if 0 (;@3;)
          i32.const 0
          local.set 1
          br 1 (;@2;)
        end
        local.get 3
        i32.const 3
        i32.and
        local.set 9
        block  ;; label = @3
          block  ;; label = @4
            local.get 3
            i32.const 4
            i32.ge_u
            br_if 0 (;@4;)
            i32.const 0
            local.set 1
            i32.const 0
            local.set 10
            br 1 (;@3;)
          end
          local.get 3
          i32.const 12
          i32.and
          local.set 11
          i32.const 0
          local.set 1
          i32.const 0
          local.set 10
          loop  ;; label = @4
            local.get 1
            local.get 2
            local.get 10
            i32.add
            local.tee 12
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.get 12
            i32.const 1
            i32.add
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.get 12
            i32.const 2
            i32.add
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.get 12
            i32.const 3
            i32.add
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.set 1
            local.get 11
            local.get 10
            i32.const 4
            i32.add
            local.tee 10
            i32.ne
            br_if 0 (;@4;)
          end
        end
        local.get 9
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        local.get 10
        i32.add
        local.set 12
        loop  ;; label = @3
          local.get 1
          local.get 12
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.set 1
          local.get 12
          i32.const 1
          i32.add
          local.set 12
          local.get 9
          i32.const -1
          i32.add
          local.tee 9
          br_if 0 (;@3;)
        end
      end
      local.get 1
      local.get 6
      i32.add
      local.set 6
    end
    block  ;; label = @1
      local.get 0
      i32.load
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 0
        i32.load offset=28
        local.tee 1
        local.get 0
        i32.load offset=32
        local.tee 12
        local.get 8
        local.get 2
        local.get 3
        call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h2d8dc401c4f74e4cE
        i32.eqz
        br_if 0 (;@2;)
        i32.const 1
        return
      end
      local.get 1
      local.get 4
      local.get 5
      local.get 12
      i32.load offset=12
      call_indirect (type 1)
      return
    end
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            i32.load offset=4
            local.tee 1
            local.get 6
            i32.gt_u
            br_if 0 (;@4;)
            local.get 0
            i32.load offset=28
            local.tee 1
            local.get 0
            i32.load offset=32
            local.tee 12
            local.get 8
            local.get 2
            local.get 3
            call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h2d8dc401c4f74e4cE
            i32.eqz
            br_if 1 (;@3;)
            i32.const 1
            return
          end
          local.get 7
          i32.const 8
          i32.and
          i32.eqz
          br_if 1 (;@2;)
          local.get 0
          i32.load offset=16
          local.set 9
          local.get 0
          i32.const 48
          i32.store offset=16
          local.get 0
          i32.load8_u offset=24
          local.set 7
          i32.const 1
          local.set 11
          local.get 0
          i32.const 1
          i32.store8 offset=24
          local.get 0
          i32.load offset=28
          local.tee 12
          local.get 0
          i32.load offset=32
          local.tee 10
          local.get 8
          local.get 2
          local.get 3
          call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h2d8dc401c4f74e4cE
          br_if 2 (;@1;)
          local.get 1
          local.get 6
          i32.sub
          i32.const 1
          i32.add
          local.set 1
          block  ;; label = @4
            loop  ;; label = @5
              local.get 1
              i32.const -1
              i32.add
              local.tee 1
              i32.eqz
              br_if 1 (;@4;)
              local.get 12
              i32.const 48
              local.get 10
              i32.load offset=16
              call_indirect (type 2)
              i32.eqz
              br_if 0 (;@5;)
            end
            i32.const 1
            return
          end
          block  ;; label = @4
            local.get 12
            local.get 4
            local.get 5
            local.get 10
            i32.load offset=12
            call_indirect (type 1)
            i32.eqz
            br_if 0 (;@4;)
            i32.const 1
            return
          end
          local.get 0
          local.get 7
          i32.store8 offset=24
          local.get 0
          local.get 9
          i32.store offset=16
          i32.const 0
          return
        end
        local.get 1
        local.get 4
        local.get 5
        local.get 12
        i32.load offset=12
        call_indirect (type 1)
        local.set 11
        br 1 (;@1;)
      end
      local.get 1
      local.get 6
      i32.sub
      local.set 6
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            i32.const 1
            local.get 0
            i32.load8_u offset=24
            local.tee 1
            local.get 1
            i32.const 3
            i32.eq
            select
            local.tee 1
            br_table 2 (;@2;) 0 (;@4;) 1 (;@3;) 2 (;@2;)
          end
          local.get 6
          local.set 1
          i32.const 0
          local.set 6
          br 1 (;@2;)
        end
        local.get 6
        i32.const 1
        i32.shr_u
        local.set 1
        local.get 6
        i32.const 1
        i32.add
        i32.const 1
        i32.shr_u
        local.set 6
      end
      local.get 1
      i32.const 1
      i32.add
      local.set 1
      local.get 0
      i32.load offset=16
      local.set 9
      local.get 0
      i32.load offset=32
      local.set 12
      local.get 0
      i32.load offset=28
      local.set 10
      block  ;; label = @2
        loop  ;; label = @3
          local.get 1
          i32.const -1
          i32.add
          local.tee 1
          i32.eqz
          br_if 1 (;@2;)
          local.get 10
          local.get 9
          local.get 12
          i32.load offset=16
          call_indirect (type 2)
          i32.eqz
          br_if 0 (;@3;)
        end
        i32.const 1
        return
      end
      i32.const 1
      local.set 11
      local.get 10
      local.get 12
      local.get 8
      local.get 2
      local.get 3
      call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h2d8dc401c4f74e4cE
      br_if 0 (;@1;)
      local.get 10
      local.get 4
      local.get 5
      local.get 12
      i32.load offset=12
      call_indirect (type 1)
      br_if 0 (;@1;)
      i32.const 0
      local.set 1
      loop  ;; label = @2
        block  ;; label = @3
          local.get 6
          local.get 1
          i32.ne
          br_if 0 (;@3;)
          local.get 6
          local.get 6
          i32.lt_u
          return
        end
        local.get 1
        i32.const 1
        i32.add
        local.set 1
        local.get 10
        local.get 9
        local.get 12
        i32.load offset=16
        call_indirect (type 2)
        i32.eqz
        br_if 0 (;@2;)
      end
      local.get 1
      i32.const -1
      i32.add
      local.get 6
      i32.lt_u
      return
    end
    local.get 11)
  (func $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h63293e3d55e16e04E (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.load
    i32.const 1
    local.get 1
    call $_ZN4core3fmt3num3imp21_$LT$impl$u20$u32$GT$4_fmt17hccdc97766a169818E)
  (func $_ZN4core6result13unwrap_failed17he8f1ea0683e142ebE (type 7) (param i32 i32 i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 64
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    local.get 5
    local.get 1
    i32.store offset=12
    local.get 5
    local.get 0
    i32.store offset=8
    local.get 5
    local.get 3
    i32.store offset=20
    local.get 5
    local.get 2
    i32.store offset=16
    local.get 5
    i32.const 2
    i32.store offset=28
    local.get 5
    i32.const 1049588
    i32.store offset=24
    local.get 5
    i64.const 2
    i64.store offset=36 align=4
    local.get 5
    i32.const 19
    i64.extend_i32_u
    i64.const 32
    i64.shl
    local.get 5
    i32.const 16
    i32.add
    i64.extend_i32_u
    i64.or
    i64.store offset=56
    local.get 5
    i32.const 20
    i64.extend_i32_u
    i64.const 32
    i64.shl
    local.get 5
    i32.const 8
    i32.add
    i64.extend_i32_u
    i64.or
    i64.store offset=48
    local.get 5
    local.get 5
    i32.const 48
    i32.add
    i32.store offset=32
    local.get 5
    i32.const 24
    i32.add
    local.get 4
    call $_ZN4core9panicking9panic_fmt17h6f4dae69dcc1a6d2E
    unreachable)
  (func $_ZN4core5slice5index22slice_index_order_fail17h45c0711bdbeba6b0E (type 4) (param i32 i32 i32)
    local.get 0
    local.get 1
    local.get 2
    call $_ZN4core5slice5index22slice_index_order_fail8do_panic7runtime17h88e230a95f697701E
    unreachable)
  (func $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h59afe8cd927f3e5aE (type 2) (param i32 i32) (result i32)
    local.get 1
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    call $_ZN4core3fmt9Formatter3pad17hc11ca54d5ab5b124E)
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h9262c679b64284cbE (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 1
    local.get 0
    i32.load offset=4
    i32.load offset=12
    call_indirect (type 2))
  (func $_ZN4core3str5count14do_count_chars17h99e5bacf8097c0c8E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        local.get 0
        i32.const 3
        i32.add
        i32.const -4
        i32.and
        local.tee 2
        local.get 0
        i32.sub
        local.tee 3
        i32.lt_u
        br_if 0 (;@2;)
        local.get 1
        local.get 3
        i32.sub
        local.tee 4
        i32.const 4
        i32.lt_u
        br_if 0 (;@2;)
        local.get 4
        i32.const 3
        i32.and
        local.set 5
        i32.const 0
        local.set 6
        i32.const 0
        local.set 1
        block  ;; label = @3
          local.get 2
          local.get 0
          i32.eq
          local.tee 7
          br_if 0 (;@3;)
          i32.const 0
          local.set 1
          block  ;; label = @4
            block  ;; label = @5
              local.get 0
              local.get 2
              i32.sub
              local.tee 8
              i32.const -4
              i32.le_u
              br_if 0 (;@5;)
              i32.const 0
              local.set 9
              br 1 (;@4;)
            end
            i32.const 0
            local.set 9
            loop  ;; label = @5
              local.get 1
              local.get 0
              local.get 9
              i32.add
              local.tee 2
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 2
              i32.const 1
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 2
              i32.const 2
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.get 2
              i32.const 3
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              i32.add
              local.set 1
              local.get 9
              i32.const 4
              i32.add
              local.tee 9
              br_if 0 (;@5;)
            end
          end
          local.get 7
          br_if 0 (;@3;)
          local.get 0
          local.get 9
          i32.add
          local.set 2
          loop  ;; label = @4
            local.get 1
            local.get 2
            i32.load8_s
            i32.const -65
            i32.gt_s
            i32.add
            local.set 1
            local.get 2
            i32.const 1
            i32.add
            local.set 2
            local.get 8
            i32.const 1
            i32.add
            local.tee 8
            br_if 0 (;@4;)
          end
        end
        local.get 0
        local.get 3
        i32.add
        local.set 0
        block  ;; label = @3
          local.get 5
          i32.eqz
          br_if 0 (;@3;)
          local.get 0
          local.get 4
          i32.const -4
          i32.and
          i32.add
          local.tee 2
          i32.load8_s
          i32.const -65
          i32.gt_s
          local.set 6
          local.get 5
          i32.const 1
          i32.eq
          br_if 0 (;@3;)
          local.get 6
          local.get 2
          i32.load8_s offset=1
          i32.const -65
          i32.gt_s
          i32.add
          local.set 6
          local.get 5
          i32.const 2
          i32.eq
          br_if 0 (;@3;)
          local.get 6
          local.get 2
          i32.load8_s offset=2
          i32.const -65
          i32.gt_s
          i32.add
          local.set 6
        end
        local.get 4
        i32.const 2
        i32.shr_u
        local.set 8
        local.get 6
        local.get 1
        i32.add
        local.set 3
        loop  ;; label = @3
          local.get 0
          local.set 4
          local.get 8
          i32.eqz
          br_if 2 (;@1;)
          local.get 8
          i32.const 192
          local.get 8
          i32.const 192
          i32.lt_u
          select
          local.tee 6
          i32.const 3
          i32.and
          local.set 7
          local.get 6
          i32.const 2
          i32.shl
          local.set 5
          i32.const 0
          local.set 2
          block  ;; label = @4
            local.get 8
            i32.const 4
            i32.lt_u
            br_if 0 (;@4;)
            local.get 4
            local.get 5
            i32.const 1008
            i32.and
            i32.add
            local.set 9
            i32.const 0
            local.set 2
            local.get 4
            local.set 1
            loop  ;; label = @5
              local.get 1
              i32.load offset=12
              local.tee 0
              i32.const -1
              i32.xor
              i32.const 7
              i32.shr_u
              local.get 0
              i32.const 6
              i32.shr_u
              i32.or
              i32.const 16843009
              i32.and
              local.get 1
              i32.load offset=8
              local.tee 0
              i32.const -1
              i32.xor
              i32.const 7
              i32.shr_u
              local.get 0
              i32.const 6
              i32.shr_u
              i32.or
              i32.const 16843009
              i32.and
              local.get 1
              i32.load offset=4
              local.tee 0
              i32.const -1
              i32.xor
              i32.const 7
              i32.shr_u
              local.get 0
              i32.const 6
              i32.shr_u
              i32.or
              i32.const 16843009
              i32.and
              local.get 1
              i32.load
              local.tee 0
              i32.const -1
              i32.xor
              i32.const 7
              i32.shr_u
              local.get 0
              i32.const 6
              i32.shr_u
              i32.or
              i32.const 16843009
              i32.and
              local.get 2
              i32.add
              i32.add
              i32.add
              i32.add
              local.set 2
              local.get 1
              i32.const 16
              i32.add
              local.tee 1
              local.get 9
              i32.ne
              br_if 0 (;@5;)
            end
          end
          local.get 8
          local.get 6
          i32.sub
          local.set 8
          local.get 4
          local.get 5
          i32.add
          local.set 0
          local.get 2
          i32.const 8
          i32.shr_u
          i32.const 16711935
          i32.and
          local.get 2
          i32.const 16711935
          i32.and
          i32.add
          i32.const 65537
          i32.mul
          i32.const 16
          i32.shr_u
          local.get 3
          i32.add
          local.set 3
          local.get 7
          i32.eqz
          br_if 0 (;@3;)
        end
        local.get 4
        local.get 6
        i32.const 252
        i32.and
        i32.const 2
        i32.shl
        i32.add
        local.tee 2
        i32.load
        local.tee 1
        i32.const -1
        i32.xor
        i32.const 7
        i32.shr_u
        local.get 1
        i32.const 6
        i32.shr_u
        i32.or
        i32.const 16843009
        i32.and
        local.set 1
        block  ;; label = @3
          local.get 7
          i32.const 1
          i32.eq
          br_if 0 (;@3;)
          local.get 2
          i32.load offset=4
          local.tee 0
          i32.const -1
          i32.xor
          i32.const 7
          i32.shr_u
          local.get 0
          i32.const 6
          i32.shr_u
          i32.or
          i32.const 16843009
          i32.and
          local.get 1
          i32.add
          local.set 1
          local.get 7
          i32.const 2
          i32.eq
          br_if 0 (;@3;)
          local.get 2
          i32.load offset=8
          local.tee 2
          i32.const -1
          i32.xor
          i32.const 7
          i32.shr_u
          local.get 2
          i32.const 6
          i32.shr_u
          i32.or
          i32.const 16843009
          i32.and
          local.get 1
          i32.add
          local.set 1
        end
        local.get 1
        i32.const 8
        i32.shr_u
        i32.const 459007
        i32.and
        local.get 1
        i32.const 16711935
        i32.and
        i32.add
        i32.const 65537
        i32.mul
        i32.const 16
        i32.shr_u
        local.get 3
        i32.add
        return
      end
      block  ;; label = @2
        local.get 1
        br_if 0 (;@2;)
        i32.const 0
        return
      end
      local.get 1
      i32.const 3
      i32.and
      local.set 9
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          i32.const 4
          i32.ge_u
          br_if 0 (;@3;)
          i32.const 0
          local.set 3
          i32.const 0
          local.set 2
          br 1 (;@2;)
        end
        local.get 1
        i32.const -4
        i32.and
        local.set 8
        i32.const 0
        local.set 3
        i32.const 0
        local.set 2
        loop  ;; label = @3
          local.get 3
          local.get 0
          local.get 2
          i32.add
          local.tee 1
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.get 1
          i32.const 1
          i32.add
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.get 1
          i32.const 2
          i32.add
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.get 1
          i32.const 3
          i32.add
          i32.load8_s
          i32.const -65
          i32.gt_s
          i32.add
          local.set 3
          local.get 8
          local.get 2
          i32.const 4
          i32.add
          local.tee 2
          i32.ne
          br_if 0 (;@3;)
        end
      end
      local.get 9
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      local.get 2
      i32.add
      local.set 1
      loop  ;; label = @2
        local.get 3
        local.get 1
        i32.load8_s
        i32.const -65
        i32.gt_s
        i32.add
        local.set 3
        local.get 1
        i32.const 1
        i32.add
        local.set 1
        local.get 9
        i32.const -1
        i32.add
        local.tee 9
        br_if 0 (;@2;)
      end
    end
    local.get 3)
  (func $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h2d8dc401c4f74e4cE (type 11) (param i32 i32 i32 i32 i32) (result i32)
    block  ;; label = @1
      local.get 2
      i32.const 1114112
      i32.eq
      br_if 0 (;@1;)
      local.get 0
      local.get 2
      local.get 1
      i32.load offset=16
      call_indirect (type 2)
      i32.eqz
      br_if 0 (;@1;)
      i32.const 1
      return
    end
    block  ;; label = @1
      local.get 3
      br_if 0 (;@1;)
      i32.const 0
      return
    end
    local.get 0
    local.get 3
    local.get 4
    local.get 1
    i32.load offset=12
    call_indirect (type 1))
  (func $_ZN4core3fmt9Formatter9write_str17h4abba99f2e253f35E (type 1) (param i32 i32 i32) (result i32)
    local.get 0
    i32.load offset=28
    local.get 1
    local.get 2
    local.get 0
    i32.load offset=32
    i32.load offset=12
    call_indirect (type 1))
  (func $_ZN4core5slice5index26slice_start_index_len_fail8do_panic7runtime17h8f5f6eb23a09cf83E (type 4) (param i32 i32 i32)
    (local i32 i64)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    local.get 1
    i32.store offset=4
    local.get 3
    local.get 0
    i32.store
    local.get 3
    i32.const 2
    i32.store offset=12
    local.get 3
    i32.const 1049856
    i32.store offset=8
    local.get 3
    i64.const 2
    i64.store offset=20 align=4
    local.get 3
    i32.const 2
    i64.extend_i32_u
    i64.const 32
    i64.shl
    local.tee 4
    local.get 3
    i32.const 4
    i32.add
    i64.extend_i32_u
    i64.or
    i64.store offset=40
    local.get 3
    local.get 4
    local.get 3
    i64.extend_i32_u
    i64.or
    i64.store offset=32
    local.get 3
    local.get 3
    i32.const 32
    i32.add
    i32.store offset=16
    local.get 3
    i32.const 8
    i32.add
    local.get 2
    call $_ZN4core9panicking9panic_fmt17h6f4dae69dcc1a6d2E
    unreachable)
  (func $_ZN4core5slice5index24slice_end_index_len_fail8do_panic7runtime17h7780901f520234faE (type 4) (param i32 i32 i32)
    (local i32 i64)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    local.get 1
    i32.store offset=4
    local.get 3
    local.get 0
    i32.store
    local.get 3
    i32.const 2
    i32.store offset=12
    local.get 3
    i32.const 1049888
    i32.store offset=8
    local.get 3
    i64.const 2
    i64.store offset=20 align=4
    local.get 3
    i32.const 2
    i64.extend_i32_u
    i64.const 32
    i64.shl
    local.tee 4
    local.get 3
    i32.const 4
    i32.add
    i64.extend_i32_u
    i64.or
    i64.store offset=40
    local.get 3
    local.get 4
    local.get 3
    i64.extend_i32_u
    i64.or
    i64.store offset=32
    local.get 3
    local.get 3
    i32.const 32
    i32.add
    i32.store offset=16
    local.get 3
    i32.const 8
    i32.add
    local.get 2
    call $_ZN4core9panicking9panic_fmt17h6f4dae69dcc1a6d2E
    unreachable)
  (func $_ZN4core5slice5index22slice_index_order_fail8do_panic7runtime17h88e230a95f697701E (type 4) (param i32 i32 i32)
    (local i32 i64)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    local.get 1
    i32.store offset=4
    local.get 3
    local.get 0
    i32.store
    local.get 3
    i32.const 2
    i32.store offset=12
    local.get 3
    i32.const 1049940
    i32.store offset=8
    local.get 3
    i64.const 2
    i64.store offset=20 align=4
    local.get 3
    i32.const 2
    i64.extend_i32_u
    i64.const 32
    i64.shl
    local.tee 4
    local.get 3
    i32.const 4
    i32.add
    i64.extend_i32_u
    i64.or
    i64.store offset=40
    local.get 3
    local.get 4
    local.get 3
    i64.extend_i32_u
    i64.or
    i64.store offset=32
    local.get 3
    local.get 3
    i32.const 32
    i32.add
    i32.store offset=16
    local.get 3
    i32.const 8
    i32.add
    local.get 2
    call $_ZN4core9panicking9panic_fmt17h6f4dae69dcc1a6d2E
    unreachable)
  (func $_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$15copy_from_slice17len_mismatch_fail17h0920f35544df82f7E (type 4) (param i32 i32 i32)
    local.get 1
    local.get 0
    local.get 2
    call $_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$15copy_from_slice17len_mismatch_fail8do_panic7runtime17h87418eea28dfe12eE
    unreachable)
  (func $_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$15copy_from_slice17len_mismatch_fail8do_panic7runtime17h87418eea28dfe12eE (type 4) (param i32 i32 i32)
    (local i32 i64)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    local.get 1
    i32.store offset=4
    local.get 3
    local.get 0
    i32.store
    local.get 3
    i32.const 3
    i32.store offset=12
    local.get 3
    i32.const 1050040
    i32.store offset=8
    local.get 3
    i64.const 2
    i64.store offset=20 align=4
    local.get 3
    i32.const 2
    i64.extend_i32_u
    i64.const 32
    i64.shl
    local.tee 4
    local.get 3
    i32.const 4
    i32.add
    i64.extend_i32_u
    i64.or
    i64.store offset=40
    local.get 3
    local.get 4
    local.get 3
    i64.extend_i32_u
    i64.or
    i64.store offset=32
    local.get 3
    local.get 3
    i32.const 32
    i32.add
    i32.store offset=16
    local.get 3
    i32.const 8
    i32.add
    local.get 2
    call $_ZN4core9panicking9panic_fmt17h6f4dae69dcc1a6d2E
    unreachable)
  (func $memset (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 2
        i32.const 16
        i32.ge_u
        br_if 0 (;@2;)
        local.get 0
        local.set 3
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 0
        i32.const 0
        local.get 0
        i32.sub
        i32.const 3
        i32.and
        local.tee 4
        i32.add
        local.tee 5
        local.get 0
        i32.le_u
        br_if 0 (;@2;)
        local.get 4
        i32.const -1
        i32.add
        local.set 6
        local.get 0
        local.set 3
        block  ;; label = @3
          local.get 4
          i32.eqz
          br_if 0 (;@3;)
          local.get 4
          local.set 7
          local.get 0
          local.set 3
          loop  ;; label = @4
            local.get 3
            local.get 1
            i32.store8
            local.get 3
            i32.const 1
            i32.add
            local.set 3
            local.get 7
            i32.const -1
            i32.add
            local.tee 7
            br_if 0 (;@4;)
          end
        end
        local.get 6
        i32.const 7
        i32.lt_u
        br_if 0 (;@2;)
        loop  ;; label = @3
          local.get 3
          local.get 1
          i32.store8
          local.get 3
          i32.const 7
          i32.add
          local.get 1
          i32.store8
          local.get 3
          i32.const 6
          i32.add
          local.get 1
          i32.store8
          local.get 3
          i32.const 5
          i32.add
          local.get 1
          i32.store8
          local.get 3
          i32.const 4
          i32.add
          local.get 1
          i32.store8
          local.get 3
          i32.const 3
          i32.add
          local.get 1
          i32.store8
          local.get 3
          i32.const 2
          i32.add
          local.get 1
          i32.store8
          local.get 3
          i32.const 1
          i32.add
          local.get 1
          i32.store8
          local.get 3
          i32.const 8
          i32.add
          local.tee 3
          local.get 5
          i32.ne
          br_if 0 (;@3;)
        end
      end
      block  ;; label = @2
        local.get 5
        local.get 5
        local.get 2
        local.get 4
        i32.sub
        local.tee 2
        i32.const -4
        i32.and
        i32.add
        local.tee 3
        i32.ge_u
        br_if 0 (;@2;)
        local.get 1
        i32.const 255
        i32.and
        i32.const 16843009
        i32.mul
        local.set 7
        loop  ;; label = @3
          local.get 5
          local.get 7
          i32.store
          local.get 5
          i32.const 4
          i32.add
          local.tee 5
          local.get 3
          i32.lt_u
          br_if 0 (;@3;)
        end
      end
      local.get 2
      i32.const 3
      i32.and
      local.set 2
    end
    block  ;; label = @1
      local.get 3
      local.get 3
      local.get 2
      i32.add
      local.tee 7
      i32.ge_u
      br_if 0 (;@1;)
      local.get 2
      i32.const -1
      i32.add
      local.set 4
      block  ;; label = @2
        local.get 2
        i32.const 7
        i32.and
        local.tee 5
        i32.eqz
        br_if 0 (;@2;)
        loop  ;; label = @3
          local.get 3
          local.get 1
          i32.store8
          local.get 3
          i32.const 1
          i32.add
          local.set 3
          local.get 5
          i32.const -1
          i32.add
          local.tee 5
          br_if 0 (;@3;)
        end
      end
      local.get 4
      i32.const 7
      i32.lt_u
      br_if 0 (;@1;)
      loop  ;; label = @2
        local.get 3
        local.get 1
        i32.store8
        local.get 3
        i32.const 7
        i32.add
        local.get 1
        i32.store8
        local.get 3
        i32.const 6
        i32.add
        local.get 1
        i32.store8
        local.get 3
        i32.const 5
        i32.add
        local.get 1
        i32.store8
        local.get 3
        i32.const 4
        i32.add
        local.get 1
        i32.store8
        local.get 3
        i32.const 3
        i32.add
        local.get 1
        i32.store8
        local.get 3
        i32.const 2
        i32.add
        local.get 1
        i32.store8
        local.get 3
        i32.const 1
        i32.add
        local.get 1
        i32.store8
        local.get 3
        i32.const 8
        i32.add
        local.tee 3
        local.get 7
        i32.ne
        br_if 0 (;@2;)
      end
    end
    local.get 0)
  (func $memcpy (type 1) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 2
        i32.const 16
        i32.ge_u
        br_if 0 (;@2;)
        local.get 0
        local.set 3
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 0
        i32.const 0
        local.get 0
        i32.sub
        i32.const 3
        i32.and
        local.tee 4
        i32.add
        local.tee 5
        local.get 0
        i32.le_u
        br_if 0 (;@2;)
        local.get 4
        i32.const -1
        i32.add
        local.set 6
        local.get 0
        local.set 3
        local.get 1
        local.set 7
        block  ;; label = @3
          local.get 4
          i32.eqz
          br_if 0 (;@3;)
          local.get 4
          local.set 8
          local.get 0
          local.set 3
          local.get 1
          local.set 7
          loop  ;; label = @4
            local.get 3
            local.get 7
            i32.load8_u
            i32.store8
            local.get 7
            i32.const 1
            i32.add
            local.set 7
            local.get 3
            i32.const 1
            i32.add
            local.set 3
            local.get 8
            i32.const -1
            i32.add
            local.tee 8
            br_if 0 (;@4;)
          end
        end
        local.get 6
        i32.const 7
        i32.lt_u
        br_if 0 (;@2;)
        loop  ;; label = @3
          local.get 3
          local.get 7
          i32.load8_u
          i32.store8
          local.get 3
          i32.const 1
          i32.add
          local.get 7
          i32.const 1
          i32.add
          i32.load8_u
          i32.store8
          local.get 3
          i32.const 2
          i32.add
          local.get 7
          i32.const 2
          i32.add
          i32.load8_u
          i32.store8
          local.get 3
          i32.const 3
          i32.add
          local.get 7
          i32.const 3
          i32.add
          i32.load8_u
          i32.store8
          local.get 3
          i32.const 4
          i32.add
          local.get 7
          i32.const 4
          i32.add
          i32.load8_u
          i32.store8
          local.get 3
          i32.const 5
          i32.add
          local.get 7
          i32.const 5
          i32.add
          i32.load8_u
          i32.store8
          local.get 3
          i32.const 6
          i32.add
          local.get 7
          i32.const 6
          i32.add
          i32.load8_u
          i32.store8
          local.get 3
          i32.const 7
          i32.add
          local.get 7
          i32.const 7
          i32.add
          i32.load8_u
          i32.store8
          local.get 7
          i32.const 8
          i32.add
          local.set 7
          local.get 3
          i32.const 8
          i32.add
          local.tee 3
          local.get 5
          i32.ne
          br_if 0 (;@3;)
        end
      end
      local.get 5
      local.get 2
      local.get 4
      i32.sub
      local.tee 8
      i32.const -4
      i32.and
      local.tee 6
      i32.add
      local.set 3
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          local.get 4
          i32.add
          local.tee 7
          i32.const 3
          i32.and
          br_if 0 (;@3;)
          local.get 5
          local.get 3
          i32.ge_u
          br_if 1 (;@2;)
          local.get 7
          local.set 1
          loop  ;; label = @4
            local.get 5
            local.get 1
            i32.load
            i32.store
            local.get 1
            i32.const 4
            i32.add
            local.set 1
            local.get 5
            i32.const 4
            i32.add
            local.tee 5
            local.get 3
            i32.lt_u
            br_if 0 (;@4;)
            br 2 (;@2;)
          end
        end
        local.get 5
        local.get 3
        i32.ge_u
        br_if 0 (;@2;)
        local.get 7
        i32.const 3
        i32.shl
        local.tee 2
        i32.const 24
        i32.and
        local.set 4
        local.get 7
        i32.const -4
        i32.and
        local.tee 9
        i32.const 4
        i32.add
        local.set 1
        i32.const 0
        local.get 2
        i32.sub
        i32.const 24
        i32.and
        local.set 10
        local.get 9
        i32.load
        local.set 2
        loop  ;; label = @3
          local.get 5
          local.get 2
          local.get 4
          i32.shr_u
          local.get 1
          i32.load
          local.tee 2
          local.get 10
          i32.shl
          i32.or
          i32.store
          local.get 1
          i32.const 4
          i32.add
          local.set 1
          local.get 5
          i32.const 4
          i32.add
          local.tee 5
          local.get 3
          i32.lt_u
          br_if 0 (;@3;)
        end
      end
      local.get 8
      i32.const 3
      i32.and
      local.set 2
      local.get 7
      local.get 6
      i32.add
      local.set 1
    end
    block  ;; label = @1
      local.get 3
      local.get 3
      local.get 2
      i32.add
      local.tee 5
      i32.ge_u
      br_if 0 (;@1;)
      local.get 2
      i32.const -1
      i32.add
      local.set 8
      block  ;; label = @2
        local.get 2
        i32.const 7
        i32.and
        local.tee 7
        i32.eqz
        br_if 0 (;@2;)
        loop  ;; label = @3
          local.get 3
          local.get 1
          i32.load8_u
          i32.store8
          local.get 1
          i32.const 1
          i32.add
          local.set 1
          local.get 3
          i32.const 1
          i32.add
          local.set 3
          local.get 7
          i32.const -1
          i32.add
          local.tee 7
          br_if 0 (;@3;)
        end
      end
      local.get 8
      i32.const 7
      i32.lt_u
      br_if 0 (;@1;)
      loop  ;; label = @2
        local.get 3
        local.get 1
        i32.load8_u
        i32.store8
        local.get 3
        i32.const 1
        i32.add
        local.get 1
        i32.const 1
        i32.add
        i32.load8_u
        i32.store8
        local.get 3
        i32.const 2
        i32.add
        local.get 1
        i32.const 2
        i32.add
        i32.load8_u
        i32.store8
        local.get 3
        i32.const 3
        i32.add
        local.get 1
        i32.const 3
        i32.add
        i32.load8_u
        i32.store8
        local.get 3
        i32.const 4
        i32.add
        local.get 1
        i32.const 4
        i32.add
        i32.load8_u
        i32.store8
        local.get 3
        i32.const 5
        i32.add
        local.get 1
        i32.const 5
        i32.add
        i32.load8_u
        i32.store8
        local.get 3
        i32.const 6
        i32.add
        local.get 1
        i32.const 6
        i32.add
        i32.load8_u
        i32.store8
        local.get 3
        i32.const 7
        i32.add
        local.get 1
        i32.const 7
        i32.add
        i32.load8_u
        i32.store8
        local.get 1
        i32.const 8
        i32.add
        local.set 1
        local.get 3
        i32.const 8
        i32.add
        local.tee 3
        local.get 5
        i32.ne
        br_if 0 (;@2;)
      end
    end
    local.get 0)
  (table (;0;) 21 21 funcref)
  (memory (;0;) 17)
  (global $__stack_pointer (mut i32) (i32.const 1048576))
  (global (;1;) i32 (i32.const 1050545))
  (global (;2;) i32 (i32.const 1050560))
  (export "memory" (memory 0))
  (export "alloc" (func $alloc))
  (export "alloc_zeroed" (func $alloc_zeroed))
  (export "blake2b" (func $blake2b))
  (export "dealloc" (func $dealloc))
  (export "__data_end" (global 1))
  (export "__heap_base" (global 2))
  (elem (;0;) (i32.const 1) func $_ZN69_$LT$core..alloc..layout..LayoutError$u20$as$u20$core..fmt..Debug$GT$3fmt17h10f1d925090e4d42E $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h63293e3d55e16e04E $_ZN3std5alloc24default_alloc_error_hook17h7c876c22af7f81cfE $_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h754849e789348a4dE $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$9write_str17h7abd7ca86aa58925E $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$10write_char17hb8fbefe4b2d7bfd9E $_ZN4core3fmt5Write9write_fmt17h6206e68e5ed68901E $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17he16a8fb985669180E $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17he4d2fe6d646ce06fE $_ZN92_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..fmt..Display$GT$3fmt17h12a3052156fbd475E $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17he7b48c12b382998cE $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17h14568fb11df09eaeE $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$6as_str17h942de68efd2647a4E $_ZN4core3ptr77drop_in_place$LT$std..panicking..begin_panic_handler..FormatStringPayload$GT$17hb1289cf6f1496592E $_ZN95_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..fmt..Display$GT$3fmt17h2929032b84366b94E $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17h059ea5adc6a21895E $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17hb9087c3a32205b67E $_ZN4core5panic12PanicPayload6as_str17had35548f12cb95a5E $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h9262c679b64284cbE $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h59afe8cd927f3e5aE)
  (data $.rodata (i32.const 1048576) "LayoutError\00\00\00\00\00\00\00\00\00\01\00\00\00\01\00\00\00called `Result::unwrap()` on an `Err` valuesrc/lib.rs\00\00\00G\00\10\00\0a\00\00\00\03\00\00\008\00\00\00G\00\10\00\0a\00\00\00\09\00\00\008\00\00\00G\00\10\00\0a\00\00\00\1d\00\00\008\00\00\00/home/ubuntu/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/blake2ya-1.0.2/src/blake2b.rsassertion failed: 1 <= n && n <= 64\00\00\84\00\10\00_\00\00\00\e7\00\00\00\09\00\00\00\84\00\10\00_\00\00\00'\01\00\00\0f\00\00\00\84\00\10\00_\00\00\00'\01\00\00\18\00\00\00\84\00\10\00_\00\00\00'\01\00\00-\00\00\00\84\00\10\00_\00\00\00!\01\00\00)\00\00\00\84\00\10\00_\00\00\00\1a\01\00\00\13\00\00\00\84\00\10\00_\00\00\00\14\01\00\00\13\00\00\00\84\00\10\00_\00\00\002\01\00\00\1e\00\00\00\84\00\10\00_\00\00\002\01\00\00\0b\00\00\00\84\00\10\00_\00\00\00-\01\00\00\0f\00\00\00/rustc/4d91de4e48198da2e33413efdcd9cd2cc0c46688/library/alloc/src/string.rs\00\a8\01\10\00K\00\00\00\8d\05\00\00\1b\00\00\00/rustc/4d91de4e48198da2e33413efdcd9cd2cc0c46688/library/alloc/src/raw_vec.rs\04\02\10\00L\00\00\00(\02\00\00\11\00\00\00\04\00\00\00\0c\00\00\00\04\00\00\00\05\00\00\00\06\00\00\00\07\00\00\00/rust/deps/dlmalloc-0.2.7/src/dlmalloc.rsassertion failed: psize >= size + min_overhead\00x\02\10\00)\00\00\00\a8\04\00\00\09\00\00\00assertion failed: psize <= size + max_overhead\00\00x\02\10\00)\00\00\00\ae\04\00\00\0d\00\00\00memory allocation of  bytes failed\00\00 \03\10\00\15\00\00\005\03\10\00\0d\00\00\00library/std/src/alloc.rsT\03\10\00\18\00\00\00c\01\00\00\09\00\00\00\04\00\00\00\0c\00\00\00\04\00\00\00\08\00\00\00\00\00\00\00\08\00\00\00\04\00\00\00\09\00\00\00\00\00\00\00\08\00\00\00\04\00\00\00\0a\00\00\00\0b\00\00\00\0c\00\00\00\0d\00\00\00\0e\00\00\00\10\00\00\00\04\00\00\00\0f\00\00\00\10\00\00\00\11\00\00\00\12\00\00\00capacity overflow\00\00\00\d4\03\10\00\11\00\00\00): \00\01\00\00\00\00\00\00\00\f1\03\10\00\02\00\00\0000010203040506070809101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899range start index  out of range for slice of length \cc\04\10\00\12\00\00\00\de\04\10\00\22\00\00\00range end index \10\05\10\00\10\00\00\00\de\04\10\00\22\00\00\00slice index starts at  but ends at \000\05\10\00\16\00\00\00F\05\10\00\0d\00\00\00copy_from_slice: source slice length () does not match destination slice length (\00\00\00d\05\10\00&\00\00\00\8a\05\10\00+\00\00\00\f0\03\10\00\01\00\00\00"))
