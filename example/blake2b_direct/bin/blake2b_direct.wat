(module $blake2b_direct.wasm
  (type (;0;) (func (param i32 i32)))
  (type (;1;) (func (param i32 i32) (result i32)))
  (type (;2;) (func (param i32 i32 i32) (result i32)))
  (type (;3;) (func (param i32) (result i32)))
  (type (;4;) (func (param i32 i32 i32)))
  (type (;5;) (func (param i32 i32 i32 i32) (result i32)))
  (type (;6;) (func (param i32 i32 i64 i64 i64 i64)))
  (type (;7;) (func (param i32 i32 i32 i32 i32)))
  (type (;8;) (func (param i32)))
  (type (;9;) (func (param i32 i32 i32 i32)))
  (type (;10;) (func (param i32 i32 i32 i32 i32 i32) (result i32)))
  (type (;11;) (func (param i32 i32 i32 i32 i32) (result i32)))
  (func $_ZN69_$LT$core..alloc..layout..LayoutError$u20$as$u20$core..fmt..Debug$GT$3fmt17hf22f41cb8f5fdff3E (type 1) (param i32 i32) (result i32)
    local.get 1
    i32.const 1048576
    i32.const 11
    call $_ZN4core3fmt9Formatter9write_str17h5f591b7d46bcc7dbE)
  (func $alloc (type 3) (param i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    block  ;; label = @1
      local.get 0
      i32.const -1
      i32.gt_s
      br_if 0 (;@1;)
      i32.const 1048604
      i32.const 43
      local.get 1
      i32.const 15
      i32.add
      i32.const 1048588
      i32.const 1048660
      call $_ZN4core6result13unwrap_failed17h4e312bd8e5eb4431E
      unreachable
    end
    i32.const 0
    i32.load8_u offset=1049977
    drop
    local.get 0
    i32.const 1
    call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
    local.set 0
    local.get 1
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $alloc_zeroed (type 3) (param i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    block  ;; label = @1
      local.get 0
      i32.const -1
      i32.gt_s
      br_if 0 (;@1;)
      i32.const 1048604
      i32.const 43
      local.get 1
      i32.const 15
      i32.add
      i32.const 1048588
      i32.const 1048676
      call $_ZN4core6result13unwrap_failed17h4e312bd8e5eb4431E
      unreachable
    end
    i32.const 0
    i32.load8_u offset=1049977
    drop
    local.get 0
    i32.const 1
    call $_RNvCs691rhTbG0Ee_7___rustc19___rust_alloc_zeroed
    local.set 0
    local.get 1
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $blake2b (type 1) (param i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 688
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    i32.const 624
    i32.add
    i32.const 60
    i32.add
    i32.const 0
    i32.store align=2
    local.get 2
    i32.const 624
    i32.add
    i32.const 52
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 624
    i32.add
    i32.const 44
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 624
    i32.add
    i32.const 36
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 624
    i32.add
    i32.const 28
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 624
    i32.add
    i32.const 20
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 624
    i32.add
    i32.const 12
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 8
    i32.add
    i32.const 12
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 8
    i32.add
    i32.const 20
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 8
    i32.add
    i32.const 28
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 8
    i32.add
    i32.const 36
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 8
    i32.add
    i32.const 44
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 8
    i32.add
    i32.const 52
    i32.add
    i64.const 0
    i64.store align=2
    local.get 2
    i32.const 8
    i32.add
    i32.const 60
    i32.add
    i32.const 0
    i32.store align=2
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
    i64.const 0
    i64.store offset=628 align=2
    local.get 2
    i32.const 0
    i32.store offset=72 align=2
    local.get 2
    i32.const 16842752
    i32.store offset=8 align=2
    local.get 2
    i32.const 8
    i32.add
    i32.const 64
    call $_ZN8blake2ya7blake2b7Param2b6digest17h72a2d9ccd477238dE
    block  ;; label = @1
      i32.const 128
      i32.eqz
      br_if 0 (;@1;)
      local.get 2
      i32.const 496
      i32.add
      local.get 2
      i32.const 8
      i32.add
      i32.const 128
      memory.copy
    end
    local.get 2
    i32.const 136
    i32.add
    local.get 2
    i32.const 496
    i32.add
    call $_ZN8blake2ya7blake2b7blake2b17h855b19c6cd048e5bE
    local.get 2
    i32.const 136
    i32.add
    local.get 0
    local.get 1
    call $_ZN8blake2ya7blake2b7Blake2b6update17h6af962144cc2c580E
    local.get 2
    i32.const 0
    i32.store offset=624 align=2
    local.get 2
    i32.const 136
    i32.add
    local.get 2
    i32.const 624
    i32.add
    i32.const 64
    call $_ZN8blake2ya7blake2b7Blake2b6digest17h7e289db40c319d9fE
    i32.const 0
    i32.load8_u offset=1049977
    drop
    i32.const 64
    i32.const 1
    call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
    local.tee 1
    i32.const 56
    i32.add
    local.get 2
    i32.const 624
    i32.add
    i32.const 56
    i32.add
    i64.load align=2
    i64.store align=1
    local.get 1
    i32.const 48
    i32.add
    local.get 2
    i32.const 624
    i32.add
    i32.const 48
    i32.add
    i64.load align=2
    i64.store align=1
    local.get 1
    i32.const 40
    i32.add
    local.get 2
    i32.const 624
    i32.add
    i32.const 40
    i32.add
    i64.load align=2
    i64.store align=1
    local.get 1
    i32.const 32
    i32.add
    local.get 2
    i32.const 624
    i32.add
    i32.const 32
    i32.add
    i64.load align=2
    i64.store align=1
    local.get 1
    i32.const 24
    i32.add
    local.get 2
    i32.const 624
    i32.add
    i32.const 24
    i32.add
    i64.load align=2
    i64.store align=1
    local.get 1
    i32.const 16
    i32.add
    local.get 2
    i32.const 624
    i32.add
    i32.const 16
    i32.add
    i64.load align=2
    i64.store align=1
    local.get 1
    i32.const 8
    i32.add
    local.get 2
    i32.const 624
    i32.add
    i32.const 8
    i32.add
    i64.load align=2
    i64.store align=1
    local.get 1
    local.get 2
    i64.load offset=624 align=2
    i64.store align=1
    local.get 2
    i32.const 688
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
      i32.const -1
      i32.gt_s
      br_if 0 (;@1;)
      i32.const 1048604
      i32.const 43
      local.get 2
      i32.const 15
      i32.add
      i32.const 1048588
      i32.const 1048692
      call $_ZN4core6result13unwrap_failed17h4e312bd8e5eb4431E
      unreachable
    end
    local.get 0
    local.get 1
    i32.const 1
    call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer)
  (func $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc (type 1) (param i32 i32) (result i32)
    (local i32)
    local.get 0
    local.get 1
    call $_RNvCs691rhTbG0Ee_7___rustc11___rdl_alloc
    local.set 2
    local.get 2
    return)
  (func $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc (type 4) (param i32 i32 i32)
    local.get 0
    local.get 1
    local.get 2
    call $_RNvCs691rhTbG0Ee_7___rustc13___rdl_dealloc
    return)
  (func $_RNvCs691rhTbG0Ee_7___rustc14___rust_realloc (type 5) (param i32 i32 i32 i32) (result i32)
    (local i32)
    local.get 0
    local.get 1
    local.get 2
    local.get 3
    call $_RNvCs691rhTbG0Ee_7___rustc13___rdl_realloc
    local.set 4
    local.get 4
    return)
  (func $_RNvCs691rhTbG0Ee_7___rustc19___rust_alloc_zeroed (type 1) (param i32 i32) (result i32)
    (local i32)
    local.get 0
    local.get 1
    call $_RNvCs691rhTbG0Ee_7___rustc18___rdl_alloc_zeroed
    local.set 2
    local.get 2
    return)
  (func $_RNvCs691rhTbG0Ee_7___rustc26___rust_alloc_error_handler (type 0) (param i32 i32)
    local.get 0
    local.get 1
    call $_RNvCs691rhTbG0Ee_7___rustc8___rg_oom
    return)
  (func $_ZN8blake2ya7blake2b6reduce17h592ec0095d14d42bE (type 6) (param i32 i32 i64 i64 i64 i64)
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
    local.get 2
    local.get 10
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
    local.get 3
    local.get 18
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
    local.get 5
    local.get 27
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
    local.get 4
    local.get 34
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
    local.get 21
    local.get 30
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
    local.get 29
    local.get 23
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
    local.get 22
    local.get 36
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
    local.get 5
    local.get 20
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
  (func $_ZN8blake2ya7blake2b7Param2b6digest17h72a2d9ccd477238dE (type 0) (param i32 i32)
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
      call $_ZN4core9panicking5panic17hcb4f0bfb9f36a348E
      unreachable
    end
    local.get 0
    local.get 1
    i32.store8)
  (func $_ZN8blake2ya7blake2b7Blake2b6update17h6af962144cc2c580E (type 4) (param i32 i32 i32)
    (local i32 i32 i32 i32 i64 i64 i32 i32 i32)
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
                  local.get 2
                  i32.const 128
                  local.get 0
                  i32.load offset=352
                  local.tee 4
                  i32.sub
                  local.tee 5
                  i32.le_u
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
                block  ;; label = @7
                  local.get 2
                  i32.eqz
                  br_if 0 (;@7;)
                  local.get 0
                  local.get 4
                  i32.add
                  local.get 1
                  local.get 2
                  memory.copy
                end
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
                block  ;; label = @7
                  local.get 5
                  i32.eqz
                  br_if 0 (;@7;)
                  local.get 0
                  local.get 4
                  i32.add
                  local.get 1
                  local.get 5
                  memory.copy
                end
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
                block  ;; label = @7
                  i32.const 128
                  i32.eqz
                  br_if 0 (;@7;)
                  local.get 3
                  local.get 0
                  i32.const 128
                  memory.copy
                end
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
                call $_ZN8blake2ya7blake2b6reduce17h592ec0095d14d42bE
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
              call $_ZN4core5slice5index26slice_start_index_len_fail17h026a9215e79c1fdbE
              unreachable
            end
            local.get 4
            local.get 5
            i32.const 1048936
            call $_ZN4core5slice5index22slice_index_order_fail17h87f34a99f306396eE
            unreachable
          end
          local.get 5
          i32.const 128
          i32.const 1048936
          call $_ZN4core5slice5index24slice_end_index_len_fail17hadfbc7e1a15974a1E
          unreachable
        end
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 6
                i32.const -1
                i32.add
                local.tee 9
                i32.const 128
                i32.lt_u
                br_if 0 (;@6;)
                local.get 0
                i32.const 256
                i32.add
                local.set 10
                local.get 9
                i32.const 7
                i32.shr_u
                local.set 5
                local.get 6
                local.get 9
                i32.const -128
                i32.and
                i32.sub
                local.set 6
                loop  ;; label = @7
                  local.get 4
                  i32.const -129
                  i32.gt_u
                  br_if 2 (;@5;)
                  local.get 4
                  i32.const 128
                  i32.add
                  local.tee 9
                  local.get 2
                  i32.gt_u
                  br_if 3 (;@4;)
                  local.get 1
                  local.get 4
                  i32.add
                  local.set 4
                  block  ;; label = @8
                    i32.const 128
                    i32.eqz
                    local.tee 11
                    br_if 0 (;@8;)
                    local.get 0
                    local.get 4
                    i32.const 128
                    memory.copy
                  end
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
                  block  ;; label = @8
                    local.get 11
                    br_if 0 (;@8;)
                    local.get 3
                    local.get 4
                    i32.const 128
                    memory.copy
                  end
                  local.get 10
                  local.get 3
                  local.get 8
                  local.get 7
                  local.get 0
                  i64.load offset=336
                  local.get 0
                  i64.load offset=344
                  call $_ZN8blake2ya7blake2b6reduce17h592ec0095d14d42bE
                  local.get 9
                  local.set 4
                  local.get 5
                  i32.const -1
                  i32.add
                  local.tee 5
                  br_if 0 (;@7;)
                end
                block  ;; label = @7
                  local.get 6
                  i32.const 129
                  i32.ge_u
                  br_if 0 (;@7;)
                  local.get 9
                  local.set 4
                  br 4 (;@3;)
                end
                local.get 6
                i32.const 128
                i32.const 1048856
                call $_ZN4core5slice5index24slice_end_index_len_fail17hadfbc7e1a15974a1E
                unreachable
              end
              local.get 4
              local.get 2
              i32.le_u
              br_if 2 (;@3;)
              local.get 4
              local.get 2
              i32.const 1048888
              call $_ZN4core5slice5index26slice_start_index_len_fail17h026a9215e79c1fdbE
              unreachable
            end
            local.get 4
            local.get 4
            i32.const 128
            i32.add
            i32.const 1048904
            call $_ZN4core5slice5index22slice_index_order_fail17h87f34a99f306396eE
            unreachable
          end
          local.get 4
          i32.const 128
          i32.add
          local.get 2
          i32.const 1048904
          call $_ZN4core5slice5index24slice_end_index_len_fail17hadfbc7e1a15974a1E
          unreachable
        end
        local.get 6
        local.get 2
        local.get 4
        i32.sub
        local.tee 5
        i32.ne
        br_if 1 (;@1;)
        local.get 6
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        local.get 1
        local.get 4
        i32.add
        local.get 6
        memory.copy
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
    call $_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$15copy_from_slice17len_mismatch_fail17hfc67e42bedcb4f60E
    unreachable)
  (func $_ZN8blake2ya7blake2b7Blake2b6digest17h7e289db40c319d9fE (type 4) (param i32 i32 i32)
    (local i32 i32 i64 i32 i64)
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
            block  ;; label = @5
              i32.const 128
              local.get 4
              i32.sub
              local.tee 6
              i32.eqz
              br_if 0 (;@5;)
              local.get 0
              local.get 4
              i32.add
              i32.const 0
              local.get 6
              memory.fill
            end
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
          local.tee 7
          local.get 5
          i64.add
          local.tee 5
          i64.store offset=320
          local.get 0
          local.get 0
          i64.load offset=328
          local.get 5
          local.get 7
          i64.lt_u
          i64.extend_i32_u
          i64.add
          local.tee 7
          i64.store offset=328
          block  ;; label = @4
            i32.const 128
            i32.eqz
            br_if 0 (;@4;)
            local.get 3
            local.get 0
            i32.const 128
            memory.copy
          end
          local.get 0
          i32.const 256
          i32.add
          local.get 3
          local.get 5
          local.get 7
          i64.const -1
          local.get 0
          i64.load offset=344
          call $_ZN8blake2ya7blake2b6reduce17h592ec0095d14d42bE
          local.get 3
          i32.const 56
          i32.add
          local.get 0
          i32.const 312
          i32.add
          i64.load align=1
          i64.store
          local.get 3
          i32.const 48
          i32.add
          local.get 0
          i32.const 304
          i32.add
          i64.load align=1
          i64.store
          local.get 3
          i32.const 40
          i32.add
          local.get 0
          i32.const 296
          i32.add
          i64.load align=1
          i64.store
          local.get 3
          i32.const 32
          i32.add
          local.get 0
          i32.const 288
          i32.add
          i64.load align=1
          i64.store
          local.get 3
          i32.const 24
          i32.add
          local.get 0
          i32.const 280
          i32.add
          i64.load align=1
          i64.store
          local.get 3
          i32.const 16
          i32.add
          local.get 0
          i32.const 272
          i32.add
          i64.load align=1
          i64.store
          local.get 3
          i32.const 8
          i32.add
          local.get 0
          i32.const 264
          i32.add
          i64.load align=1
          i64.store
          local.get 3
          local.get 0
          i64.load offset=256 align=1
          i64.store
          local.get 0
          i32.load8_u offset=128
          local.tee 0
          i32.const 65
          i32.ge_u
          br_if 1 (;@2;)
          local.get 2
          local.get 0
          i32.ne
          br_if 2 (;@1;)
          block  ;; label = @4
            local.get 2
            i32.eqz
            br_if 0 (;@4;)
            local.get 1
            local.get 3
            local.get 2
            memory.copy
          end
          local.get 3
          i32.const 128
          i32.add
          global.set $__stack_pointer
          return
        end
        local.get 4
        i32.const 128
        i32.const 1048984
        call $_ZN4core5slice5index26slice_start_index_len_fail17h026a9215e79c1fdbE
        unreachable
      end
      local.get 0
      i32.const 64
      i32.const 1048952
      call $_ZN4core5slice5index24slice_end_index_len_fail17hadfbc7e1a15974a1E
      unreachable
    end
    local.get 2
    local.get 0
    i32.const 1048968
    call $_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$15copy_from_slice17len_mismatch_fail17hfc67e42bedcb4f60E
    unreachable)
  (func $_ZN8blake2ya7blake2b7blake2b17h855b19c6cd048e5bE (type 0) (param i32 i32)
    (local i32 i32 i64)
    global.get $__stack_pointer
    i32.const 496
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      i32.const 128
      i32.eqz
      local.tee 3
      br_if 0 (;@1;)
      local.get 2
      i32.const 8
      i32.add
      i32.const 0
      i32.const 128
      memory.fill
    end
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
    block  ;; label = @1
      local.get 3
      br_if 0 (;@1;)
      local.get 2
      i32.const 8
      i32.add
      i32.const 128
      i32.add
      local.get 1
      i32.const 128
      memory.copy
    end
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
    local.tee 4
    i64.const 7640891576956012808
    i64.xor
    i64.store offset=264
    block  ;; label = @1
      local.get 4
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
      call $_ZN8blake2ya7blake2b7Blake2b6update17h6af962144cc2c580E
    end
    block  ;; label = @1
      i32.const 360
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      local.get 2
      i32.const 8
      i32.add
      i32.const 360
      memory.copy
    end
    local.get 2
    i32.const 496
    i32.add
    global.set $__stack_pointer)
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h7304e3c4160876daE (type 0) (param i32 i32)
    local.get 0
    i64.const 7199936582794304877
    i64.store offset=8
    local.get 0
    i64.const -5076933981314334344
    i64.store)
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17hffe704d8309d203aE (type 0) (param i32 i32)
    local.get 0
    i64.const 7305752822554981023
    i64.store offset=8
    local.get 0
    i64.const 3513012367455052835
    i64.store)
  (func $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17h9d7cabd5071c5a51E (type 7) (param i32 i32 i32 i32 i32)
    (local i32 i32 i32 i64 i32)
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
          local.get 2
          local.get 0
          i32.load
          local.tee 1
          i32.const 1
          i32.shl
          local.tee 7
          local.get 2
          local.get 7
          i32.gt_u
          select
          local.tee 2
          i32.const 8
          i32.const 4
          local.get 4
          i32.const 1
          i32.eq
          select
          local.tee 7
          local.get 2
          local.get 7
          i32.gt_u
          select
          local.tee 7
          i64.extend_i32_u
          i64.mul
          local.tee 8
          i64.const 32
          i64.shr_u
          i32.wrap_i64
          i32.eqz
          br_if 0 (;@3;)
          br 1 (;@2;)
        end
        local.get 8
        i32.wrap_i64
        local.tee 9
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
        local.get 9
        local.get 5
        i32.const 20
        i32.add
        call $_ZN5alloc7raw_vec11finish_grow17h31fcfb118e0508a4E
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
      i32.const 1049080
      call $_ZN5alloc7raw_vec12handle_error17h57ad9ee517c44fc6E
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
  (func $_ZN4core3fmt5Write9write_fmt17hc808c42956869ae8E (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.const 1049096
    local.get 1
    call $_ZN4core3fmt5write17h68542eb4423e8992E)
  (func $_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h37d546d4b358ccb9E (type 8) (param i32)
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
      call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
    end)
  (func $_ZN4core3ptr74drop_in_place$LT$core..option..Option$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$17h5e7c564ca6a856faE (type 0) (param i32 i32)
    block  ;; label = @1
      local.get 0
      i32.const -2147483648
      i32.or
      i32.const -2147483648
      i32.eq
      br_if 0 (;@1;)
      local.get 1
      local.get 0
      i32.const 1
      call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
    end)
  (func $_ZN4core3ptr77drop_in_place$LT$std..panicking..begin_panic_handler..FormatStringPayload$GT$17h328305dd0d118fb6E (type 8) (param i32)
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
      call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
    end)
  (func $_ZN4core5panic12PanicPayload6as_str17h3575ee572e511855E (type 0) (param i32 i32)
    local.get 0
    i32.const 0
    i32.store)
  (func $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$10write_char17h61f319b0423b9825E (type 1) (param i32 i32) (result i32)
    (local i32 i32 i32)
    local.get 0
    i32.load offset=8
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.const 128
        i32.ge_u
        br_if 0 (;@2;)
        i32.const 1
        local.set 3
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 1
        i32.const 2048
        i32.ge_u
        br_if 0 (;@2;)
        i32.const 2
        local.set 3
        br 1 (;@1;)
      end
      i32.const 3
      i32.const 4
      local.get 1
      i32.const 65536
      i32.lt_u
      select
      local.set 3
    end
    local.get 2
    local.set 4
    block  ;; label = @1
      local.get 3
      local.get 0
      i32.load
      local.get 2
      i32.sub
      i32.le_u
      br_if 0 (;@1;)
      local.get 0
      local.get 2
      local.get 3
      i32.const 1
      i32.const 1
      call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17h9d7cabd5071c5a51E
      local.get 0
      i32.load offset=8
      local.set 4
    end
    local.get 0
    i32.load offset=4
    local.get 4
    i32.add
    local.set 4
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          i32.const 128
          i32.lt_u
          br_if 0 (;@3;)
          local.get 1
          i32.const 2048
          i32.lt_u
          br_if 1 (;@2;)
          block  ;; label = @4
            local.get 1
            i32.const 65536
            i32.lt_u
            br_if 0 (;@4;)
            local.get 4
            local.get 1
            i32.const 63
            i32.and
            i32.const 128
            i32.or
            i32.store8 offset=3
            local.get 4
            local.get 1
            i32.const 18
            i32.shr_u
            i32.const 240
            i32.or
            i32.store8
            local.get 4
            local.get 1
            i32.const 6
            i32.shr_u
            i32.const 63
            i32.and
            i32.const 128
            i32.or
            i32.store8 offset=2
            local.get 4
            local.get 1
            i32.const 12
            i32.shr_u
            i32.const 63
            i32.and
            i32.const 128
            i32.or
            i32.store8 offset=1
            br 3 (;@1;)
          end
          local.get 4
          local.get 1
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.store8 offset=2
          local.get 4
          local.get 1
          i32.const 12
          i32.shr_u
          i32.const 224
          i32.or
          i32.store8
          local.get 4
          local.get 1
          i32.const 6
          i32.shr_u
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.store8 offset=1
          br 2 (;@1;)
        end
        local.get 4
        local.get 1
        i32.store8
        br 1 (;@1;)
      end
      local.get 4
      local.get 1
      i32.const 63
      i32.and
      i32.const 128
      i32.or
      i32.store8 offset=1
      local.get 4
      local.get 1
      i32.const 6
      i32.shr_u
      i32.const 192
      i32.or
      i32.store8
    end
    local.get 0
    local.get 3
    local.get 2
    i32.add
    i32.store offset=8
    i32.const 0)
  (func $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$9write_str17h7850057311a0cef1E (type 2) (param i32 i32 i32) (result i32)
    (local i32)
    block  ;; label = @1
      local.get 2
      local.get 0
      i32.load
      local.get 0
      i32.load offset=8
      local.tee 3
      i32.sub
      i32.le_u
      br_if 0 (;@1;)
      local.get 0
      local.get 3
      local.get 2
      i32.const 1
      i32.const 1
      call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17h9d7cabd5071c5a51E
      local.get 0
      i32.load offset=8
      local.set 3
    end
    block  ;; label = @1
      local.get 2
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      i32.load offset=4
      local.get 3
      i32.add
      local.get 1
      local.get 2
      memory.copy
    end
    local.get 0
    local.get 3
    local.get 2
    i32.add
    i32.store offset=8
    i32.const 0)
  (func $_ZN5alloc7raw_vec11finish_grow17h31fcfb118e0508a4E (type 9) (param i32 i32 i32 i32)
    (local i32)
    block  ;; label = @1
      local.get 2
      i32.const 0
      i32.lt_s
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 3
            i32.load offset=4
            i32.eqz
            br_if 0 (;@4;)
            block  ;; label = @5
              local.get 3
              i32.load offset=8
              local.tee 4
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 2
                br_if 0 (;@6;)
                local.get 1
                local.set 3
                br 4 (;@2;)
              end
              i32.const 0
              i32.load8_u offset=1049977
              drop
              br 2 (;@3;)
            end
            local.get 3
            i32.load
            local.get 4
            local.get 1
            local.get 2
            call $_RNvCs691rhTbG0Ee_7___rustc14___rust_realloc
            local.set 3
            br 2 (;@2;)
          end
          block  ;; label = @4
            local.get 2
            br_if 0 (;@4;)
            local.get 1
            local.set 3
            br 2 (;@2;)
          end
          i32.const 0
          i32.load8_u offset=1049977
          drop
        end
        local.get 2
        local.get 1
        call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
        local.set 3
      end
      block  ;; label = @2
        local.get 3
        br_if 0 (;@2;)
        local.get 0
        local.get 2
        i32.store offset=8
        local.get 0
        local.get 1
        i32.store offset=4
        local.get 0
        i32.const 1
        i32.store
        return
      end
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
    i32.const 0
    i32.store offset=4
    local.get 0
    i32.const 1
    i32.store)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$12unlink_chunk17h724f0d9c050c94c6E (type 0) (param i32 i32)
    (local i32 i32 i32 i32)
    local.get 0
    i32.load offset=12
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            i32.const 256
            i32.lt_u
            br_if 0 (;@4;)
            local.get 0
            i32.load offset=24
            local.set 3
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 2
                  local.get 0
                  i32.ne
                  br_if 0 (;@7;)
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
                  br_if 1 (;@6;)
                  i32.const 0
                  local.set 2
                  br 2 (;@5;)
                end
                local.get 0
                i32.load offset=8
                local.tee 1
                local.get 2
                i32.store offset=12
                local.get 2
                local.get 1
                i32.store offset=8
                br 1 (;@5;)
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
              loop  ;; label = @6
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
                br_if 0 (;@6;)
              end
              local.get 5
              i32.const 0
              i32.store
            end
            local.get 3
            i32.eqz
            br_if 2 (;@2;)
            block  ;; label = @5
              block  ;; label = @6
                local.get 0
                local.get 0
                i32.load offset=28
                i32.const 2
                i32.shl
                i32.const 1050000
                i32.add
                local.tee 1
                i32.load
                i32.eq
                br_if 0 (;@6;)
                local.get 3
                i32.load offset=16
                local.get 0
                i32.eq
                br_if 1 (;@5;)
                local.get 3
                local.get 2
                i32.store offset=20
                local.get 2
                br_if 3 (;@3;)
                br 4 (;@2;)
              end
              local.get 1
              local.get 2
              i32.store
              local.get 2
              i32.eqz
              br_if 4 (;@1;)
              br 2 (;@3;)
            end
            local.get 3
            local.get 2
            i32.store offset=16
            local.get 2
            br_if 1 (;@3;)
            br 2 (;@2;)
          end
          block  ;; label = @4
            local.get 2
            local.get 0
            i32.load offset=8
            local.tee 4
            i32.eq
            br_if 0 (;@4;)
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
          i32.load offset=1050408
          i32.const -2
          local.get 1
          i32.const 3
          i32.shr_u
          i32.rotl
          i32.and
          i32.store offset=1050408
          return
        end
        local.get 2
        local.get 3
        i32.store offset=24
        block  ;; label = @3
          local.get 0
          i32.load offset=16
          local.tee 1
          i32.eqz
          br_if 0 (;@3;)
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
        br_if 0 (;@2;)
        local.get 2
        local.get 1
        i32.store offset=20
        local.get 1
        local.get 2
        i32.store offset=24
        return
      end
      return
    end
    i32.const 0
    i32.const 0
    i32.load offset=1050412
    i32.const -2
    local.get 0
    i32.load offset=28
    i32.rotl
    i32.and
    i32.store offset=1050412)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17hcac66ba809c22ef9E (type 0) (param i32 i32)
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
          i32.load offset=1050424
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
          i32.store offset=1050416
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
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$12unlink_chunk17h724f0d9c050c94c6E
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
              i32.load offset=1050428
              i32.eq
              br_if 2 (;@3;)
              local.get 2
              i32.const 0
              i32.load offset=1050424
              i32.eq
              br_if 3 (;@2;)
              local.get 2
              local.get 3
              i32.const -8
              i32.and
              local.tee 3
              call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$12unlink_chunk17h724f0d9c050c94c6E
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
              i32.load offset=1050424
              i32.ne
              br_if 1 (;@4;)
              i32.const 0
              local.get 1
              i32.store offset=1050416
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
            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17h36f158d3d0e17661E
            return
          end
          local.get 1
          i32.const 248
          i32.and
          i32.const 1050144
          i32.add
          local.set 2
          block  ;; label = @4
            block  ;; label = @5
              i32.const 0
              i32.load offset=1050408
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
              i32.store offset=1050408
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
        i32.store offset=1050428
        i32.const 0
        i32.const 0
        i32.load offset=1050420
        local.get 1
        i32.add
        local.tee 1
        i32.store offset=1050420
        local.get 0
        local.get 1
        i32.const 1
        i32.or
        i32.store offset=4
        local.get 0
        i32.const 0
        i32.load offset=1050424
        i32.ne
        br_if 1 (;@1;)
        i32.const 0
        i32.const 0
        i32.store offset=1050416
        i32.const 0
        i32.const 0
        i32.store offset=1050424
        return
      end
      i32.const 0
      local.get 0
      i32.store offset=1050424
      i32.const 0
      i32.const 0
      i32.load offset=1050416
      local.get 1
      i32.add
      local.tee 1
      i32.store offset=1050416
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
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17h36f158d3d0e17661E (type 0) (param i32 i32)
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
    i32.const 1050000
    i32.add
    local.set 3
    block  ;; label = @1
      i32.const 0
      i32.load offset=1050412
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
      i32.load offset=1050412
      local.get 4
      i32.or
      i32.store offset=1050412
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
          local.tee 5
          i32.load offset=16
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
    i32.const 16
    i32.add
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
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$4free17hd05ac7097937f97bE (type 8) (param i32)
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
          i32.load offset=1050424
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
          i32.store offset=1050416
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
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$12unlink_chunk17h724f0d9c050c94c6E
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
                  i32.load offset=1050428
                  i32.eq
                  br_if 2 (;@5;)
                  local.get 3
                  i32.const 0
                  i32.load offset=1050424
                  i32.eq
                  br_if 3 (;@4;)
                  local.get 3
                  local.get 2
                  i32.const -8
                  i32.and
                  local.tee 2
                  call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$12unlink_chunk17h724f0d9c050c94c6E
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
                  i32.load offset=1050424
                  i32.ne
                  br_if 1 (;@6;)
                  i32.const 0
                  local.get 0
                  i32.store offset=1050416
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
              call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17h36f158d3d0e17661E
              i32.const 0
              local.set 1
              i32.const 0
              i32.const 0
              i32.load offset=1050448
              i32.const -1
              i32.add
              local.tee 0
              i32.store offset=1050448
              local.get 0
              br_if 4 (;@1;)
              block  ;; label = @6
                i32.const 0
                i32.load offset=1050136
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
              i32.store offset=1050448
              return
            end
            i32.const 0
            local.get 1
            i32.store offset=1050428
            i32.const 0
            i32.const 0
            i32.load offset=1050420
            local.get 0
            i32.add
            local.tee 0
            i32.store offset=1050420
            local.get 1
            local.get 0
            i32.const 1
            i32.or
            i32.store offset=4
            block  ;; label = @5
              local.get 1
              i32.const 0
              i32.load offset=1050424
              i32.ne
              br_if 0 (;@5;)
              i32.const 0
              i32.const 0
              i32.store offset=1050416
              i32.const 0
              i32.const 0
              i32.store offset=1050424
            end
            local.get 0
            i32.const 0
            i32.load offset=1050440
            local.tee 4
            i32.le_u
            br_if 3 (;@1;)
            i32.const 0
            i32.load offset=1050428
            local.tee 0
            i32.eqz
            br_if 3 (;@1;)
            i32.const 0
            local.set 2
            i32.const 0
            i32.load offset=1050420
            local.tee 5
            i32.const 41
            i32.lt_u
            br_if 2 (;@2;)
            i32.const 1050128
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
          i32.store offset=1050424
          i32.const 0
          i32.const 0
          i32.load offset=1050416
          local.get 0
          i32.add
          local.tee 0
          i32.store offset=1050416
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
        i32.const 1050144
        i32.add
        local.set 3
        block  ;; label = @3
          block  ;; label = @4
            i32.const 0
            i32.load offset=1050408
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
            i32.store offset=1050408
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
        i32.load offset=1050136
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
      i32.store offset=1050448
      local.get 5
      local.get 4
      i32.le_u
      br_if 0 (;@1;)
      i32.const 0
      i32.const -1
      i32.store offset=1050440
    end)
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17h90ff8eedc9c6744dE (type 3) (param i32) (result i32)
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
                      i32.const -65588
                      i32.le_u
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
                    i32.load offset=1050412
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
                      i32.const 1050000
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
                      i32.load offset=16
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
                    i32.load offset=1050408
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
                        i32.const 1050144
                        i32.add
                        local.tee 0
                        local.get 3
                        i32.const 1050152
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
                      i32.store offset=1050408
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
                  i32.load offset=1050416
                  i32.le_u
                  br_if 3 (;@4;)
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        local.get 0
                        br_if 0 (;@10;)
                        i32.const 0
                        i32.load offset=1050412
                        local.tee 0
                        i32.eqz
                        br_if 6 (;@4;)
                        local.get 0
                        i32.ctz
                        i32.const 2
                        i32.shl
                        i32.const 1050000
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
                              block  ;; label = @14
                                local.get 6
                                local.get 6
                                i32.load offset=28
                                i32.const 2
                                i32.shl
                                i32.const 1050000
                                i32.add
                                local.tee 7
                                i32.load
                                i32.eq
                                br_if 0 (;@14;)
                                block  ;; label = @15
                                  local.get 5
                                  i32.load offset=16
                                  local.get 6
                                  i32.eq
                                  br_if 0 (;@15;)
                                  local.get 5
                                  local.get 0
                                  i32.store offset=20
                                  local.get 0
                                  br_if 2 (;@13;)
                                  br 7 (;@8;)
                                end
                                local.get 5
                                local.get 0
                                i32.store offset=16
                                local.get 0
                                br_if 1 (;@13;)
                                br 6 (;@8;)
                              end
                              local.get 7
                              local.get 0
                              i32.store
                              local.get 0
                              i32.eqz
                              br_if 4 (;@9;)
                            end
                            local.get 0
                            local.get 5
                            i32.store offset=24
                            block  ;; label = @13
                              local.get 6
                              i32.load offset=16
                              local.tee 7
                              i32.eqz
                              br_if 0 (;@13;)
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
                            br_if 4 (;@8;)
                            local.get 0
                            local.get 7
                            i32.store offset=20
                            local.get 7
                            local.get 0
                            i32.store offset=24
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
                          i32.const 1050144
                          i32.add
                          local.tee 7
                          local.get 2
                          i32.const 1050152
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
                        i32.store offset=1050408
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
                        i32.load offset=1050416
                        local.tee 6
                        i32.eqz
                        br_if 0 (;@10;)
                        local.get 6
                        i32.const -8
                        i32.and
                        i32.const 1050144
                        i32.add
                        local.set 2
                        i32.const 0
                        i32.load offset=1050424
                        local.set 3
                        block  ;; label = @11
                          block  ;; label = @12
                            i32.const 0
                            i32.load offset=1050408
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
                            i32.store offset=1050408
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
                      i32.store offset=1050424
                      i32.const 0
                      local.get 7
                      i32.store offset=1050416
                      br 8 (;@1;)
                    end
                    i32.const 0
                    i32.const 0
                    i32.load offset=1050412
                    i32.const -2
                    local.get 6
                    i32.load offset=28
                    i32.rotl
                    i32.and
                    i32.store offset=1050412
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
                        i32.load offset=1050416
                        local.tee 8
                        i32.eqz
                        br_if 1 (;@9;)
                        local.get 8
                        i32.const -8
                        i32.and
                        i32.const 1050144
                        i32.add
                        local.set 7
                        i32.const 0
                        i32.load offset=1050424
                        local.set 0
                        block  ;; label = @11
                          block  ;; label = @12
                            i32.const 0
                            i32.load offset=1050408
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
                            i32.store offset=1050408
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
                    i32.store offset=1050424
                    i32.const 0
                    local.get 2
                    i32.store offset=1050416
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
                  i32.const 1050000
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
              i32.load offset=1050416
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
              block  ;; label = @6
                local.get 7
                local.get 7
                i32.load offset=28
                i32.const 2
                i32.shl
                i32.const 1050000
                i32.add
                local.tee 6
                i32.load
                i32.eq
                br_if 0 (;@6;)
                block  ;; label = @7
                  local.get 5
                  i32.load offset=16
                  local.get 7
                  i32.eq
                  br_if 0 (;@7;)
                  local.get 5
                  local.get 0
                  i32.store offset=20
                  local.get 0
                  br_if 2 (;@5;)
                  br 5 (;@2;)
                end
                local.get 5
                local.get 0
                i32.store offset=16
                local.get 0
                br_if 1 (;@5;)
                br 4 (;@2;)
              end
              local.get 6
              local.get 0
              i32.store
              local.get 0
              i32.eqz
              br_if 2 (;@3;)
            end
            local.get 0
            local.get 5
            i32.store offset=24
            block  ;; label = @5
              local.get 7
              i32.load offset=16
              local.tee 6
              i32.eqz
              br_if 0 (;@5;)
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
            br_if 2 (;@2;)
            local.get 0
            local.get 6
            i32.store offset=20
            local.get 6
            local.get 0
            i32.store offset=24
            br 2 (;@2;)
          end
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      i32.const 0
                      i32.load offset=1050416
                      local.tee 0
                      local.get 3
                      i32.ge_u
                      br_if 0 (;@9;)
                      block  ;; label = @10
                        i32.const 0
                        i32.load offset=1050420
                        local.tee 0
                        local.get 3
                        i32.gt_u
                        br_if 0 (;@10;)
                        local.get 1
                        i32.const 4
                        i32.add
                        i32.const 1050452
                        local.get 3
                        i32.const 65583
                        i32.add
                        i32.const -65536
                        i32.and
                        call $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$5alloc17hd536f0311f53ebe2E
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
                        i32.load offset=1050432
                        local.get 1
                        i32.load offset=8
                        local.tee 9
                        i32.add
                        local.tee 0
                        i32.store offset=1050432
                        i32.const 0
                        local.get 0
                        i32.const 0
                        i32.load offset=1050436
                        local.tee 2
                        local.get 0
                        local.get 2
                        i32.gt_u
                        select
                        i32.store offset=1050436
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              i32.const 0
                              i32.load offset=1050428
                              local.tee 2
                              i32.eqz
                              br_if 0 (;@13;)
                              i32.const 1050128
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
                                i32.load offset=1050444
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
                              i32.store offset=1050444
                            end
                            i32.const 0
                            i32.const 4095
                            i32.store offset=1050448
                            i32.const 0
                            local.get 5
                            i32.store offset=1050140
                            i32.const 0
                            local.get 9
                            i32.store offset=1050132
                            i32.const 0
                            local.get 6
                            i32.store offset=1050128
                            i32.const 0
                            i32.const 1050144
                            i32.store offset=1050156
                            i32.const 0
                            i32.const 1050152
                            i32.store offset=1050164
                            i32.const 0
                            i32.const 1050144
                            i32.store offset=1050152
                            i32.const 0
                            i32.const 1050160
                            i32.store offset=1050172
                            i32.const 0
                            i32.const 1050152
                            i32.store offset=1050160
                            i32.const 0
                            i32.const 1050168
                            i32.store offset=1050180
                            i32.const 0
                            i32.const 1050160
                            i32.store offset=1050168
                            i32.const 0
                            i32.const 1050176
                            i32.store offset=1050188
                            i32.const 0
                            i32.const 1050168
                            i32.store offset=1050176
                            i32.const 0
                            i32.const 1050184
                            i32.store offset=1050196
                            i32.const 0
                            i32.const 1050176
                            i32.store offset=1050184
                            i32.const 0
                            i32.const 1050192
                            i32.store offset=1050204
                            i32.const 0
                            i32.const 1050184
                            i32.store offset=1050192
                            i32.const 0
                            i32.const 1050200
                            i32.store offset=1050212
                            i32.const 0
                            i32.const 1050192
                            i32.store offset=1050200
                            i32.const 0
                            i32.const 1050208
                            i32.store offset=1050220
                            i32.const 0
                            i32.const 1050200
                            i32.store offset=1050208
                            i32.const 0
                            i32.const 1050208
                            i32.store offset=1050216
                            i32.const 0
                            i32.const 1050216
                            i32.store offset=1050228
                            i32.const 0
                            i32.const 1050216
                            i32.store offset=1050224
                            i32.const 0
                            i32.const 1050224
                            i32.store offset=1050236
                            i32.const 0
                            i32.const 1050224
                            i32.store offset=1050232
                            i32.const 0
                            i32.const 1050232
                            i32.store offset=1050244
                            i32.const 0
                            i32.const 1050232
                            i32.store offset=1050240
                            i32.const 0
                            i32.const 1050240
                            i32.store offset=1050252
                            i32.const 0
                            i32.const 1050240
                            i32.store offset=1050248
                            i32.const 0
                            i32.const 1050248
                            i32.store offset=1050260
                            i32.const 0
                            i32.const 1050248
                            i32.store offset=1050256
                            i32.const 0
                            i32.const 1050256
                            i32.store offset=1050268
                            i32.const 0
                            i32.const 1050256
                            i32.store offset=1050264
                            i32.const 0
                            i32.const 1050264
                            i32.store offset=1050276
                            i32.const 0
                            i32.const 1050264
                            i32.store offset=1050272
                            i32.const 0
                            i32.const 1050272
                            i32.store offset=1050284
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
                            i32.const 1050304
                            i32.store offset=1050316
                            i32.const 0
                            i32.const 1050296
                            i32.store offset=1050304
                            i32.const 0
                            i32.const 1050312
                            i32.store offset=1050324
                            i32.const 0
                            i32.const 1050304
                            i32.store offset=1050312
                            i32.const 0
                            i32.const 1050320
                            i32.store offset=1050332
                            i32.const 0
                            i32.const 1050312
                            i32.store offset=1050320
                            i32.const 0
                            i32.const 1050328
                            i32.store offset=1050340
                            i32.const 0
                            i32.const 1050320
                            i32.store offset=1050328
                            i32.const 0
                            i32.const 1050336
                            i32.store offset=1050348
                            i32.const 0
                            i32.const 1050328
                            i32.store offset=1050336
                            i32.const 0
                            i32.const 1050344
                            i32.store offset=1050356
                            i32.const 0
                            i32.const 1050336
                            i32.store offset=1050344
                            i32.const 0
                            i32.const 1050352
                            i32.store offset=1050364
                            i32.const 0
                            i32.const 1050344
                            i32.store offset=1050352
                            i32.const 0
                            i32.const 1050360
                            i32.store offset=1050372
                            i32.const 0
                            i32.const 1050352
                            i32.store offset=1050360
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
                            local.get 6
                            i32.const 15
                            i32.add
                            i32.const -8
                            i32.and
                            local.tee 0
                            i32.const -8
                            i32.add
                            local.tee 2
                            i32.store offset=1050428
                            i32.const 0
                            i32.const 1050392
                            i32.store offset=1050400
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
                            i32.store offset=1050420
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
                            i32.store offset=1050440
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
                        i32.load offset=1050444
                        local.tee 0
                        local.get 6
                        local.get 0
                        local.get 6
                        i32.lt_u
                        select
                        i32.store offset=1050444
                        local.get 6
                        local.get 9
                        i32.add
                        local.set 7
                        i32.const 1050128
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
                          i32.const 1050128
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
                          i32.store offset=1050428
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
                          i32.store offset=1050420
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
                          i32.store offset=1050440
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
                          i64.load offset=1050128 align=4
                          local.set 10
                          local.get 8
                          i32.const 16
                          i32.add
                          i32.const 0
                          i64.load offset=1050136 align=4
                          i64.store align=4
                          local.get 8
                          local.get 10
                          i64.store offset=8 align=4
                          i32.const 0
                          local.get 5
                          i32.store offset=1050140
                          i32.const 0
                          local.get 9
                          i32.store offset=1050132
                          i32.const 0
                          local.get 6
                          i32.store offset=1050128
                          i32.const 0
                          local.get 8
                          i32.const 8
                          i32.add
                          i32.store offset=1050136
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
                            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17h36f158d3d0e17661E
                            br 8 (;@4;)
                          end
                          local.get 0
                          i32.const 248
                          i32.and
                          i32.const 1050144
                          i32.add
                          local.set 7
                          block  ;; label = @12
                            block  ;; label = @13
                              i32.const 0
                              i32.load offset=1050408
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
                              i32.store offset=1050408
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
                        i32.load offset=1050428
                        i32.eq
                        br_if 3 (;@7;)
                        local.get 2
                        i32.const 0
                        i32.load offset=1050424
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
                          call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$12unlink_chunk17h724f0d9c050c94c6E
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
                          call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17h36f158d3d0e17661E
                          br 6 (;@5;)
                        end
                        local.get 3
                        i32.const 248
                        i32.and
                        i32.const 1050144
                        i32.add
                        local.set 2
                        block  ;; label = @11
                          block  ;; label = @12
                            i32.const 0
                            i32.load offset=1050408
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
                            i32.store offset=1050408
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
                      i32.store offset=1050420
                      i32.const 0
                      i32.const 0
                      i32.load offset=1050428
                      local.tee 0
                      local.get 3
                      i32.add
                      local.tee 7
                      i32.store offset=1050428
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
                    i32.load offset=1050424
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
                        i32.store offset=1050424
                        i32.const 0
                        i32.const 0
                        i32.store offset=1050416
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
                      i32.store offset=1050416
                      i32.const 0
                      local.get 2
                      local.get 3
                      i32.add
                      local.tee 6
                      i32.store offset=1050424
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
                  i32.load offset=1050428
                  local.tee 0
                  i32.const 15
                  i32.add
                  i32.const -8
                  i32.and
                  local.tee 2
                  i32.const -8
                  i32.add
                  local.tee 7
                  i32.store offset=1050428
                  i32.const 0
                  local.get 0
                  local.get 2
                  i32.sub
                  i32.const 0
                  i32.load offset=1050420
                  local.get 9
                  i32.add
                  local.tee 2
                  i32.add
                  i32.const 8
                  i32.add
                  local.tee 6
                  i32.store offset=1050420
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
                  i32.store offset=1050440
                  br 3 (;@4;)
                end
                i32.const 0
                local.get 0
                i32.store offset=1050428
                i32.const 0
                i32.const 0
                i32.load offset=1050420
                local.get 3
                i32.add
                local.tee 3
                i32.store offset=1050420
                local.get 0
                local.get 3
                i32.const 1
                i32.or
                i32.store offset=4
                br 1 (;@5;)
              end
              i32.const 0
              local.get 0
              i32.store offset=1050424
              i32.const 0
              i32.const 0
              i32.load offset=1050416
              local.get 3
              i32.add
              local.tee 3
              i32.store offset=1050416
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
          i32.load offset=1050420
          local.tee 2
          local.get 3
          i32.le_u
          br_if 2 (;@1;)
          i32.const 0
          local.get 2
          local.get 3
          i32.sub
          local.tee 2
          i32.store offset=1050420
          i32.const 0
          i32.const 0
          i32.load offset=1050428
          local.tee 0
          local.get 3
          i32.add
          local.tee 7
          i32.store offset=1050428
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
        i32.const 0
        i32.const 0
        i32.load offset=1050412
        i32.const -2
        local.get 7
        i32.load offset=28
        i32.rotl
        i32.and
        i32.store offset=1050412
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
            call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$18insert_large_chunk17h36f158d3d0e17661E
            br 2 (;@2;)
          end
          local.get 2
          i32.const 248
          i32.and
          i32.const 1050144
          i32.add
          local.set 3
          block  ;; label = @4
            block  ;; label = @5
              i32.const 0
              i32.load offset=1050408
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
              i32.store offset=1050408
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
  (func $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$8memalign17h0e39a8832380600bE (type 1) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32)
    i32.const 0
    local.set 2
    block  ;; label = @1
      local.get 1
      i32.const -65587
      local.get 0
      i32.const 16
      local.get 0
      i32.const 16
      i32.gt_u
      select
      local.tee 0
      i32.sub
      i32.ge_u
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
      call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17h90ff8eedc9c6744dE
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
          call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17hcac66ba809c22ef9E
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
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17hcac66ba809c22ef9E
      end
      local.get 0
      i32.const 8
      i32.add
      local.set 2
    end
    local.get 2)
  (func $_ZN3std3sys9backtrace26__rust_end_short_backtrace17h16ab72765b32282dE (type 8) (param i32)
    local.get 0
    call $_ZN3std9panicking19begin_panic_handler28_$u7b$$u7b$closure$u7d$$u7d$17h23ff416a921468b4E
    unreachable)
  (func $_ZN3std9panicking19begin_panic_handler28_$u7b$$u7b$closure$u7d$$u7d$17h23ff416a921468b4E (type 8) (param i32)
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
      i32.const 1049440
      local.get 0
      i32.load offset=4
      local.get 0
      i32.load offset=8
      local.tee 0
      i32.load8_u offset=8
      local.get 0
      i32.load8_u offset=9
      call $_ZN3std9panicking20rust_panic_with_hook17hc276d0501ad5b954E
      unreachable
    end
    local.get 1
    local.get 3
    i32.store offset=4
    local.get 1
    local.get 2
    i32.store
    local.get 1
    i32.const 1049412
    local.get 0
    i32.load offset=4
    local.get 0
    i32.load offset=8
    local.tee 0
    i32.load8_u offset=8
    local.get 0
    i32.load8_u offset=9
    call $_ZN3std9panicking20rust_panic_with_hook17hc276d0501ad5b954E
    unreachable)
  (func $_ZN3std5alloc24default_alloc_error_hook17hbd8de71f1732263eE (type 0) (param i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      i32.const 0
      i32.load8_u offset=1049976
      br_if 0 (;@1;)
      local.get 2
      i32.const 48
      i32.add
      global.set $__stack_pointer
      return
    end
    local.get 2
    i32.const 2
    i32.store offset=12
    local.get 2
    i32.const 1049324
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
    i32.const 1049364
    call $_ZN4core9panicking9panic_fmt17h41cfed79b2ddbf13E
    unreachable)
  (func $_RNvCs691rhTbG0Ee_7___rustc11___rdl_alloc (type 1) (param i32 i32) (result i32)
    block  ;; label = @1
      local.get 1
      i32.const 9
      i32.lt_u
      br_if 0 (;@1;)
      local.get 1
      local.get 0
      call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$8memalign17h0e39a8832380600bE
      return
    end
    local.get 0
    call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17h90ff8eedc9c6744dE)
  (func $_RNvCs691rhTbG0Ee_7___rustc13___rdl_dealloc (type 4) (param i32 i32 i32)
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
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$4free17hd05ac7097937f97bE
        return
      end
      i32.const 1049161
      i32.const 46
      i32.const 1049208
      call $_ZN4core9panicking5panic17hcb4f0bfb9f36a348E
      unreachable
    end
    i32.const 1049224
    i32.const 46
    i32.const 1049272
    call $_ZN4core9panicking5panic17hcb4f0bfb9f36a348E
    unreachable)
  (func $_RNvCs691rhTbG0Ee_7___rustc13___rdl_realloc (type 5) (param i32 i32 i32 i32) (result i32)
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
                    call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$8memalign17h0e39a8832380600bE
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
                              i32.load offset=1050428
                              i32.eq
                              br_if 4 (;@9;)
                              local.get 7
                              i32.const 0
                              i32.load offset=1050424
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
                              call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$12unlink_chunk17h724f0d9c050c94c6E
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
                              call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17hcac66ba809c22ef9E
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
                        i32.load offset=1050416
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
                        i32.store offset=1050424
                        i32.const 0
                        local.get 3
                        i32.store offset=1050416
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
                      call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$13dispose_chunk17hcac66ba809c22ef9E
                      local.get 0
                      return
                    end
                    i32.const 0
                    i32.load offset=1050420
                    local.get 6
                    i32.add
                    local.tee 7
                    local.get 1
                    i32.gt_u
                    br_if 7 (;@1;)
                  end
                  local.get 3
                  call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17h90ff8eedc9c6744dE
                  local.tee 1
                  i32.eqz
                  br_if 1 (;@6;)
                  block  ;; label = @8
                    local.get 3
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
                    i32.lt_u
                    select
                    local.tee 3
                    i32.eqz
                    br_if 0 (;@8;)
                    local.get 1
                    local.get 0
                    local.get 3
                    memory.copy
                  end
                  local.get 0
                  call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$4free17hd05ac7097937f97bE
                  local.get 1
                  return
                end
                block  ;; label = @7
                  local.get 3
                  local.get 1
                  local.get 3
                  local.get 1
                  i32.lt_u
                  select
                  local.tee 3
                  i32.eqz
                  br_if 0 (;@7;)
                  local.get 2
                  local.get 0
                  local.get 3
                  memory.copy
                end
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
                call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$4free17hd05ac7097937f97bE
              end
              local.get 2
              return
            end
            i32.const 1049161
            i32.const 46
            i32.const 1049208
            call $_ZN4core9panicking5panic17hcb4f0bfb9f36a348E
            unreachable
          end
          i32.const 1049224
          i32.const 46
          i32.const 1049272
          call $_ZN4core9panicking5panic17hcb4f0bfb9f36a348E
          unreachable
        end
        i32.const 1049161
        i32.const 46
        i32.const 1049208
        call $_ZN4core9panicking5panic17hcb4f0bfb9f36a348E
        unreachable
      end
      i32.const 1049224
      i32.const 46
      i32.const 1049272
      call $_ZN4core9panicking5panic17hcb4f0bfb9f36a348E
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
    i32.store offset=1050420
    i32.const 0
    local.get 3
    i32.store offset=1050428
    local.get 0)
  (func $_RNvCs691rhTbG0Ee_7___rustc18___rdl_alloc_zeroed (type 1) (param i32 i32) (result i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.const 9
        i32.lt_u
        br_if 0 (;@2;)
        local.get 1
        local.get 0
        call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$8memalign17h0e39a8832380600bE
        local.set 1
        br 1 (;@1;)
      end
      local.get 0
      call $_ZN8dlmalloc8dlmalloc17Dlmalloc$LT$A$GT$6malloc17h90ff8eedc9c6744dE
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
      local.get 0
      i32.eqz
      br_if 0 (;@1;)
      local.get 1
      i32.const 0
      local.get 0
      memory.fill
    end
    local.get 1)
  (func $_ZN3std9panicking11panic_count8increase17h3de8e2b47e9166f9E (type 3) (param i32) (result i32)
    (local i32 i32)
    i32.const 0
    local.set 1
    i32.const 0
    i32.const 0
    i32.load offset=1049996
    local.tee 2
    i32.const 1
    i32.add
    i32.store offset=1049996
    block  ;; label = @1
      local.get 2
      i32.const 0
      i32.lt_s
      br_if 0 (;@1;)
      i32.const 1
      local.set 1
      i32.const 0
      i32.load8_u offset=1050456
      br_if 0 (;@1;)
      i32.const 0
      local.get 0
      i32.store8 offset=1050456
      i32.const 0
      i32.const 0
      i32.load offset=1050452
      i32.const 1
      i32.add
      i32.store offset=1050452
      i32.const 2
      local.set 1
    end
    local.get 1)
  (func $_RNvCs691rhTbG0Ee_7___rustc17rust_begin_unwind (type 8) (param i32)
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
    call $_ZN3std3sys9backtrace26__rust_end_short_backtrace17h16ab72765b32282dE
    unreachable)
  (func $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17ha7c451ef50e5f856E (type 0) (param i32 i32)
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
      i32.const 1049096
      local.get 2
      i32.const 40
      i32.add
      call $_ZN4core3fmt5write17h68542eb4423e8992E
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
    i32.load8_u offset=1049977
    drop
    local.get 2
    local.get 5
    i64.store
    block  ;; label = @1
      i32.const 12
      i32.const 4
      call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
      local.tee 1
      br_if 0 (;@1;)
      i32.const 4
      i32.const 12
      call $_ZN5alloc5alloc18handle_alloc_error17h538ce9133f14f3ccE
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
    i32.const 1049380
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store
    local.get 2
    i32.const 64
    i32.add
    global.set $__stack_pointer)
  (func $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17he84c4c3017ddad6dE (type 0) (param i32 i32)
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
      i32.const 1049096
      local.get 2
      i32.const 24
      i32.add
      call $_ZN4core3fmt5write17h68542eb4423e8992E
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
    i32.const 1049380
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store
    local.get 2
    i32.const 48
    i32.add
    global.set $__stack_pointer)
  (func $_ZN95_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..fmt..Display$GT$3fmt17h22bfd80d379a9576E (type 1) (param i32 i32) (result i32)
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
        call $_ZN4core3fmt9Formatter9write_str17h5f591b7d46bcc7dbE
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
      i32.load
      local.get 1
      i32.load offset=4
      local.get 2
      i32.const 8
      i32.add
      call $_ZN4core3fmt5write17h68542eb4423e8992E
      local.set 0
    end
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17h89f7fb848e07ab49E (type 0) (param i32 i32)
    (local i32 i32)
    i32.const 0
    i32.load8_u offset=1049977
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
      call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
      local.tee 1
      br_if 0 (;@1;)
      i32.const 4
      i32.const 8
      call $_ZN5alloc5alloc18handle_alloc_error17h538ce9133f14f3ccE
      unreachable
    end
    local.get 1
    local.get 2
    i32.store offset=4
    local.get 1
    local.get 3
    i32.store
    local.get 0
    i32.const 1049396
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store)
  (func $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17hf8e628056151d29dE (type 0) (param i32 i32)
    local.get 0
    i32.const 1049396
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store)
  (func $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$6as_str17h4b3ad1b286f4163aE (type 0) (param i32 i32)
    local.get 0
    local.get 1
    i64.load align=4
    i64.store)
  (func $_ZN92_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..fmt..Display$GT$3fmt17h1300d7785d2cb8e7E (type 1) (param i32 i32) (result i32)
    local.get 1
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    call $_ZN4core3fmt9Formatter9write_str17h5f591b7d46bcc7dbE)
  (func $_ZN3std9panicking20rust_panic_with_hook17hc276d0501ad5b954E (type 7) (param i32 i32 i32 i32 i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    block  ;; label = @1
      i32.const 1
      call $_ZN3std9panicking11panic_count8increase17h3de8e2b47e9166f9E
      i32.const 255
      i32.and
      local.tee 6
      i32.const 2
      i32.eq
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 6
        i32.const 1
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        local.get 5
        i32.const 8
        i32.add
        local.get 0
        local.get 1
        i32.load offset=24
        call_indirect (type 0)
      end
      i32.const -2147483648
      local.get 5
      call $_ZN4core3ptr74drop_in_place$LT$core..option..Option$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$17h5e7c564ca6a856faE
      unreachable
    end
    block  ;; label = @1
      block  ;; label = @2
        i32.const 0
        i32.load offset=1049984
        local.tee 6
        i32.const -1
        i32.le_s
        br_if 0 (;@2;)
        i32.const 0
        local.get 6
        i32.const 1
        i32.add
        i32.store offset=1049984
        block  ;; label = @3
          block  ;; label = @4
            i32.const 0
            i32.load offset=1049988
            i32.eqz
            br_if 0 (;@4;)
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
            i32.load offset=1049988
            local.get 5
            i32.const 16
            i32.add
            i32.const 0
            i32.load offset=1049992
            i32.load offset=20
            call_indirect (type 0)
            br 1 (;@3;)
          end
          i32.const -2147483648
          local.get 5
          call $_ZN4core3ptr74drop_in_place$LT$core..option..Option$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$17h5e7c564ca6a856faE
        end
        i32.const 0
        i32.const 0
        i32.load offset=1049984
        i32.const -1
        i32.add
        i32.store offset=1049984
        i32.const 0
        i32.const 0
        i32.store8 offset=1050456
        local.get 3
        i32.eqz
        br_if 1 (;@1;)
        local.get 0
        local.get 1
        call $_RNvCs691rhTbG0Ee_7___rustc10rust_panic
      end
      unreachable
    end
    i32.const -2147483648
    local.get 5
    call $_ZN4core3ptr74drop_in_place$LT$core..option..Option$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$17h5e7c564ca6a856faE
    unreachable)
  (func $_RNvCs691rhTbG0Ee_7___rustc10rust_panic (type 0) (param i32 i32)
    local.get 0
    local.get 1
    call $_RNvCs691rhTbG0Ee_7___rustc18___rust_start_panic
    drop
    i32.const -2147483648
    local.get 1
    call $_ZN4core3ptr74drop_in_place$LT$core..option..Option$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$17h5e7c564ca6a856faE
    unreachable)
  (func $_RNvCs691rhTbG0Ee_7___rustc8___rg_oom (type 0) (param i32 i32)
    (local i32)
    local.get 1
    local.get 0
    i32.const 0
    i32.load offset=1049980
    local.tee 2
    i32.const 3
    local.get 2
    select
    call_indirect (type 0)
    unreachable)
  (func $_RNvCs691rhTbG0Ee_7___rustc18___rust_start_panic (type 1) (param i32 i32) (result i32)
    unreachable)
  (func $_ZN61_$LT$dlmalloc..sys..System$u20$as$u20$dlmalloc..Allocator$GT$5alloc17hd536f0311f53ebe2E (type 4) (param i32 i32 i32)
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
  (func $_ZN5alloc7raw_vec17capacity_overflow17hfc61731a92216a2cE (type 8) (param i32)
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
    i32.const 1049488
    i32.store offset=8
    local.get 1
    i64.const 4
    i64.store offset=16 align=4
    local.get 1
    i32.const 8
    i32.add
    local.get 0
    call $_ZN4core9panicking9panic_fmt17h41cfed79b2ddbf13E
    unreachable)
  (func $_ZN5alloc7raw_vec12handle_error17h57ad9ee517c44fc6E (type 4) (param i32 i32 i32)
    block  ;; label = @1
      local.get 0
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      call $_ZN5alloc5alloc18handle_alloc_error17h538ce9133f14f3ccE
      unreachable
    end
    local.get 2
    call $_ZN5alloc7raw_vec17capacity_overflow17hfc61731a92216a2cE
    unreachable)
  (func $_ZN5alloc5alloc18handle_alloc_error17h538ce9133f14f3ccE (type 0) (param i32 i32)
    local.get 1
    local.get 0
    call $_RNvCs691rhTbG0Ee_7___rustc26___rust_alloc_error_handler
    unreachable)
  (func $_ZN4core5slice5index26slice_start_index_len_fail17h026a9215e79c1fdbE (type 4) (param i32 i32 i32)
    local.get 0
    local.get 1
    local.get 2
    call $_ZN4core5slice5index26slice_start_index_len_fail8do_panic7runtime17he2583cd0648d1116E
    unreachable)
  (func $_ZN4core5slice5index24slice_end_index_len_fail17hadfbc7e1a15974a1E (type 4) (param i32 i32 i32)
    local.get 0
    local.get 1
    local.get 2
    call $_ZN4core5slice5index24slice_end_index_len_fail8do_panic7runtime17h911bca498e89ce56E
    unreachable)
  (func $_ZN4core3fmt9Formatter3pad17h5a5f539bbb272398E (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load offset=8
        local.tee 3
        i32.const 402653184
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 3
                  i32.const 268435456
                  i32.and
                  i32.eqz
                  br_if 0 (;@7;)
                  local.get 0
                  i32.load16_u offset=14
                  local.tee 4
                  br_if 1 (;@6;)
                  i32.const 0
                  local.set 2
                  br 2 (;@5;)
                end
                block  ;; label = @7
                  local.get 2
                  i32.const 16
                  i32.lt_u
                  br_if 0 (;@7;)
                  local.get 1
                  local.get 2
                  call $_ZN4core3str5count14do_count_chars17hfba32584e02717a7E
                  local.set 5
                  br 4 (;@3;)
                end
                block  ;; label = @7
                  local.get 2
                  br_if 0 (;@7;)
                  i32.const 0
                  local.set 2
                  i32.const 0
                  local.set 5
                  br 4 (;@3;)
                end
                local.get 2
                i32.const 3
                i32.and
                local.set 6
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 2
                    i32.const 4
                    i32.ge_u
                    br_if 0 (;@8;)
                    i32.const 0
                    local.set 5
                    i32.const 0
                    local.set 7
                    br 1 (;@7;)
                  end
                  local.get 2
                  i32.const 12
                  i32.and
                  local.set 4
                  i32.const 0
                  local.set 5
                  i32.const 0
                  local.set 7
                  loop  ;; label = @8
                    local.get 5
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
                    local.set 5
                    local.get 4
                    local.get 7
                    i32.const 4
                    i32.add
                    local.tee 7
                    i32.ne
                    br_if 0 (;@8;)
                  end
                end
                local.get 6
                i32.eqz
                br_if 3 (;@3;)
                local.get 1
                local.get 7
                i32.add
                local.set 8
                loop  ;; label = @7
                  local.get 5
                  local.get 8
                  i32.load8_s
                  i32.const -65
                  i32.gt_s
                  i32.add
                  local.set 5
                  local.get 8
                  i32.const 1
                  i32.add
                  local.set 8
                  local.get 6
                  i32.const -1
                  i32.add
                  local.tee 6
                  br_if 0 (;@7;)
                  br 4 (;@3;)
                end
              end
              local.get 1
              local.get 2
              i32.add
              local.set 6
              i32.const 0
              local.set 2
              local.get 4
              local.set 7
              local.get 1
              local.set 8
              loop  ;; label = @6
                local.get 8
                local.tee 5
                local.get 6
                i32.eq
                br_if 2 (;@4;)
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 5
                    i32.load8_s
                    local.tee 8
                    i32.const -1
                    i32.le_s
                    br_if 0 (;@8;)
                    local.get 5
                    i32.const 1
                    i32.add
                    local.set 8
                    br 1 (;@7;)
                  end
                  block  ;; label = @8
                    local.get 8
                    i32.const -32
                    i32.ge_u
                    br_if 0 (;@8;)
                    local.get 5
                    i32.const 2
                    i32.add
                    local.set 8
                    br 1 (;@7;)
                  end
                  block  ;; label = @8
                    local.get 8
                    i32.const -16
                    i32.ge_u
                    br_if 0 (;@8;)
                    local.get 5
                    i32.const 3
                    i32.add
                    local.set 8
                    br 1 (;@7;)
                  end
                  local.get 5
                  i32.const 4
                  i32.add
                  local.set 8
                end
                local.get 8
                local.get 5
                i32.sub
                local.get 2
                i32.add
                local.set 2
                local.get 7
                i32.const -1
                i32.add
                local.tee 7
                br_if 0 (;@6;)
              end
            end
            i32.const 0
            local.set 7
          end
          local.get 4
          local.get 7
          i32.sub
          local.set 5
        end
        local.get 5
        local.get 0
        i32.load16_u offset=12
        local.tee 8
        i32.ge_u
        br_if 0 (;@2;)
        local.get 8
        local.get 5
        i32.sub
        local.set 9
        i32.const 0
        local.set 5
        i32.const 0
        local.set 4
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 3
              i32.const 29
              i32.shr_u
              i32.const 3
              i32.and
              br_table 2 (;@3;) 0 (;@5;) 1 (;@4;) 2 (;@3;) 2 (;@3;)
            end
            local.get 9
            local.set 4
            br 1 (;@3;)
          end
          local.get 9
          i32.const 65534
          i32.and
          i32.const 1
          i32.shr_u
          local.set 4
        end
        local.get 3
        i32.const 2097151
        i32.and
        local.set 6
        local.get 0
        i32.load offset=4
        local.set 7
        local.get 0
        i32.load
        local.set 0
        block  ;; label = @3
          loop  ;; label = @4
            local.get 5
            i32.const 65535
            i32.and
            local.get 4
            i32.const 65535
            i32.and
            i32.ge_u
            br_if 1 (;@3;)
            i32.const 1
            local.set 8
            local.get 5
            i32.const 1
            i32.add
            local.set 5
            local.get 0
            local.get 6
            local.get 7
            i32.load offset=16
            call_indirect (type 1)
            br_if 3 (;@1;)
            br 0 (;@4;)
          end
        end
        i32.const 1
        local.set 8
        local.get 0
        local.get 1
        local.get 2
        local.get 7
        i32.load offset=12
        call_indirect (type 2)
        br_if 1 (;@1;)
        i32.const 0
        local.set 5
        local.get 9
        local.get 4
        i32.sub
        i32.const 65535
        i32.and
        local.set 2
        loop  ;; label = @3
          local.get 5
          i32.const 65535
          i32.and
          local.tee 4
          local.get 2
          i32.lt_u
          local.set 8
          local.get 4
          local.get 2
          i32.ge_u
          br_if 2 (;@1;)
          local.get 5
          i32.const 1
          i32.add
          local.set 5
          local.get 0
          local.get 6
          local.get 7
          i32.load offset=16
          call_indirect (type 1)
          br_if 2 (;@1;)
          br 0 (;@3;)
        end
      end
      local.get 0
      i32.load
      local.get 1
      local.get 2
      local.get 0
      i32.load offset=4
      i32.load offset=12
      call_indirect (type 2)
      local.set 8
    end
    local.get 8)
  (func $_ZN4core9panicking5panic17hcb4f0bfb9f36a348E (type 4) (param i32 i32 i32)
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
    call $_ZN4core9panicking9panic_fmt17h41cfed79b2ddbf13E
    unreachable)
  (func $_ZN4core9panicking9panic_fmt17h41cfed79b2ddbf13E (type 0) (param i32 i32)
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
    call $_RNvCs691rhTbG0Ee_7___rustc17rust_begin_unwind
    unreachable)
  (func $_ZN4core3fmt5write17h68542eb4423e8992E (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
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
    i64.const 3758096416
    i64.store offset=8 align=4
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 2
              i32.load offset=16
              local.tee 4
              i32.eqz
              br_if 0 (;@5;)
              local.get 2
              i32.load offset=20
              local.tee 1
              br_if 1 (;@4;)
              br 2 (;@3;)
            end
            local.get 2
            i32.load offset=12
            local.tee 0
            i32.eqz
            br_if 1 (;@3;)
            local.get 2
            i32.load offset=8
            local.tee 1
            local.get 0
            i32.const 3
            i32.shl
            i32.add
            local.set 5
            local.get 0
            i32.const -1
            i32.add
            i32.const 536870911
            i32.and
            i32.const 1
            i32.add
            local.set 6
            local.get 2
            i32.load
            local.set 0
            loop  ;; label = @5
              block  ;; label = @6
                local.get 0
                i32.const 4
                i32.add
                i32.load
                local.tee 7
                i32.eqz
                br_if 0 (;@6;)
                local.get 3
                i32.load
                local.get 0
                i32.load
                local.get 7
                local.get 3
                i32.load offset=4
                i32.load offset=12
                call_indirect (type 2)
                i32.eqz
                br_if 0 (;@6;)
                i32.const 1
                local.set 1
                br 5 (;@1;)
              end
              block  ;; label = @6
                local.get 1
                i32.load
                local.get 3
                local.get 1
                i32.const 4
                i32.add
                i32.load
                call_indirect (type 1)
                i32.eqz
                br_if 0 (;@6;)
                i32.const 1
                local.set 1
                br 5 (;@1;)
              end
              local.get 0
              i32.const 8
              i32.add
              local.set 0
              local.get 1
              i32.const 8
              i32.add
              local.tee 1
              local.get 5
              i32.eq
              br_if 3 (;@2;)
              br 0 (;@5;)
            end
          end
          local.get 1
          i32.const 24
          i32.mul
          local.set 8
          local.get 1
          i32.const -1
          i32.add
          i32.const 536870911
          i32.and
          i32.const 1
          i32.add
          local.set 6
          local.get 2
          i32.load offset=8
          local.set 9
          local.get 2
          i32.load
          local.set 0
          i32.const 0
          local.set 7
          loop  ;; label = @4
            block  ;; label = @5
              local.get 0
              i32.const 4
              i32.add
              i32.load
              local.tee 1
              i32.eqz
              br_if 0 (;@5;)
              local.get 3
              i32.load
              local.get 0
              i32.load
              local.get 1
              local.get 3
              i32.load offset=4
              i32.load offset=12
              call_indirect (type 2)
              i32.eqz
              br_if 0 (;@5;)
              i32.const 1
              local.set 1
              br 4 (;@1;)
            end
            i32.const 0
            local.set 5
            i32.const 0
            local.set 10
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 4
                  local.get 7
                  i32.add
                  local.tee 1
                  i32.const 8
                  i32.add
                  i32.load16_u
                  br_table 0 (;@7;) 1 (;@6;) 2 (;@5;) 0 (;@7;)
                end
                local.get 1
                i32.const 10
                i32.add
                i32.load16_u
                local.set 10
                br 1 (;@5;)
              end
              local.get 9
              local.get 1
              i32.const 12
              i32.add
              i32.load
              i32.const 3
              i32.shl
              i32.add
              i32.load16_u offset=4
              local.set 10
            end
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 1
                  i32.load16_u
                  br_table 0 (;@7;) 1 (;@6;) 2 (;@5;) 0 (;@7;)
                end
                local.get 1
                i32.const 2
                i32.add
                i32.load16_u
                local.set 5
                br 1 (;@5;)
              end
              local.get 9
              local.get 1
              i32.const 4
              i32.add
              i32.load
              i32.const 3
              i32.shl
              i32.add
              i32.load16_u offset=4
              local.set 5
            end
            local.get 3
            local.get 5
            i32.store16 offset=14
            local.get 3
            local.get 10
            i32.store16 offset=12
            local.get 3
            local.get 1
            i32.const 20
            i32.add
            i32.load
            i32.store offset=8
            block  ;; label = @5
              local.get 9
              local.get 1
              i32.const 16
              i32.add
              i32.load
              i32.const 3
              i32.shl
              i32.add
              local.tee 1
              i32.load
              local.get 3
              local.get 1
              i32.load offset=4
              call_indirect (type 1)
              i32.eqz
              br_if 0 (;@5;)
              i32.const 1
              local.set 1
              br 4 (;@1;)
            end
            local.get 0
            i32.const 8
            i32.add
            local.set 0
            local.get 8
            local.get 7
            i32.const 24
            i32.add
            local.tee 7
            i32.eq
            br_if 2 (;@2;)
            br 0 (;@4;)
          end
        end
        i32.const 0
        local.set 6
      end
      block  ;; label = @2
        local.get 6
        local.get 2
        i32.load offset=4
        i32.ge_u
        br_if 0 (;@2;)
        local.get 3
        i32.load
        local.get 2
        i32.load
        local.get 6
        i32.const 3
        i32.shl
        i32.add
        local.tee 1
        i32.load
        local.get 1
        i32.load offset=4
        local.get 3
        i32.load offset=4
        i32.load offset=12
        call_indirect (type 2)
        i32.eqz
        br_if 0 (;@2;)
        i32.const 1
        local.set 1
        br 1 (;@1;)
      end
      i32.const 0
      local.set 1
    end
    local.get 3
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $_ZN4core3fmt3num3imp21_$LT$impl$u20$u32$GT$4_fmt17habc228f2dba507bcE (type 2) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    i32.const 10
    local.set 4
    local.get 0
    local.set 5
    block  ;; label = @1
      local.get 0
      i32.const 1000
      i32.lt_u
      br_if 0 (;@1;)
      i32.const 10
      local.set 4
      local.get 0
      local.set 6
      loop  ;; label = @2
        local.get 3
        i32.const 6
        i32.add
        local.get 4
        i32.add
        local.tee 7
        i32.const -3
        i32.add
        local.get 6
        local.get 6
        i32.const 10000
        i32.div_u
        local.tee 5
        i32.const 10000
        i32.mul
        i32.sub
        local.tee 8
        i32.const 65535
        i32.and
        i32.const 100
        i32.div_u
        local.tee 9
        i32.const 1
        i32.shl
        local.tee 10
        i32.const 1049517
        i32.add
        i32.load8_u
        i32.store8
        local.get 7
        i32.const -4
        i32.add
        local.get 10
        i32.const 1049516
        i32.add
        i32.load8_u
        i32.store8
        local.get 7
        i32.const -1
        i32.add
        local.get 8
        local.get 9
        i32.const 100
        i32.mul
        i32.sub
        i32.const 65535
        i32.and
        i32.const 1
        i32.shl
        local.tee 8
        i32.const 1049517
        i32.add
        i32.load8_u
        i32.store8
        local.get 7
        i32.const -2
        i32.add
        local.get 8
        i32.const 1049516
        i32.add
        i32.load8_u
        i32.store8
        local.get 4
        i32.const -4
        i32.add
        local.set 4
        local.get 6
        i32.const 9999999
        i32.gt_u
        local.set 7
        local.get 5
        local.set 6
        local.get 7
        br_if 0 (;@2;)
      end
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 5
        i32.const 9
        i32.gt_u
        br_if 0 (;@2;)
        local.get 5
        local.set 6
        br 1 (;@1;)
      end
      local.get 3
      i32.const 6
      i32.add
      local.get 4
      i32.add
      i32.const -1
      i32.add
      local.get 5
      local.get 5
      i32.const 65535
      i32.and
      i32.const 100
      i32.div_u
      local.tee 6
      i32.const 100
      i32.mul
      i32.sub
      i32.const 65535
      i32.and
      i32.const 1
      i32.shl
      local.tee 7
      i32.const 1049517
      i32.add
      i32.load8_u
      i32.store8
      local.get 3
      i32.const 6
      i32.add
      local.get 4
      i32.const -2
      i32.add
      local.tee 4
      i32.add
      local.get 7
      i32.const 1049516
      i32.add
      i32.load8_u
      i32.store8
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.eqz
        br_if 0 (;@2;)
        local.get 6
        i32.eqz
        br_if 1 (;@1;)
      end
      local.get 3
      i32.const 6
      i32.add
      local.get 4
      i32.const -1
      i32.add
      local.tee 4
      i32.add
      local.get 6
      i32.const 1
      i32.shl
      i32.const 30
      i32.and
      i32.const 1049517
      i32.add
      i32.load8_u
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
    call $_ZN4core3fmt9Formatter12pad_integral17hafdfc3db6446f97dE
    local.set 6
    local.get 3
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 6)
  (func $_ZN4core3fmt9Formatter12pad_integral17hafdfc3db6446f97dE (type 10) (param i32 i32 i32 i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i64)
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        br_if 0 (;@2;)
        local.get 5
        i32.const 1
        i32.add
        local.set 6
        local.get 0
        i32.load offset=8
        local.set 7
        i32.const 45
        local.set 8
        br 1 (;@1;)
      end
      i32.const 43
      i32.const 1114112
      local.get 0
      i32.load offset=8
      local.tee 7
      i32.const 2097152
      i32.and
      local.tee 1
      select
      local.set 8
      local.get 1
      i32.const 21
      i32.shr_u
      local.get 5
      i32.add
      local.set 6
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 7
        i32.const 8388608
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
          call $_ZN4core3str5count14do_count_chars17hfba32584e02717a7E
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
      block  ;; label = @2
        local.get 6
        local.get 0
        i32.load16_u offset=12
        local.tee 11
        i32.ge_u
        br_if 0 (;@2;)
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 7
              i32.const 16777216
              i32.and
              br_if 0 (;@5;)
              local.get 11
              local.get 6
              i32.sub
              local.set 13
              i32.const 0
              local.set 1
              i32.const 0
              local.set 11
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 7
                    i32.const 29
                    i32.shr_u
                    i32.const 3
                    i32.and
                    br_table 2 (;@6;) 0 (;@8;) 1 (;@7;) 0 (;@8;) 2 (;@6;)
                  end
                  local.get 13
                  local.set 11
                  br 1 (;@6;)
                end
                local.get 13
                i32.const 65534
                i32.and
                i32.const 1
                i32.shr_u
                local.set 11
              end
              local.get 7
              i32.const 2097151
              i32.and
              local.set 6
              local.get 0
              i32.load offset=4
              local.set 9
              local.get 0
              i32.load
              local.set 10
              loop  ;; label = @6
                local.get 1
                i32.const 65535
                i32.and
                local.get 11
                i32.const 65535
                i32.and
                i32.ge_u
                br_if 2 (;@4;)
                i32.const 1
                local.set 12
                local.get 1
                i32.const 1
                i32.add
                local.set 1
                local.get 10
                local.get 6
                local.get 9
                i32.load offset=16
                call_indirect (type 1)
                i32.eqz
                br_if 0 (;@6;)
                br 5 (;@1;)
              end
            end
            local.get 0
            local.get 0
            i64.load offset=8 align=4
            local.tee 14
            i32.wrap_i64
            i32.const -1612709888
            i32.and
            i32.const 536870960
            i32.or
            i32.store offset=8
            i32.const 1
            local.set 12
            local.get 0
            i32.load
            local.tee 10
            local.get 0
            i32.load offset=4
            local.tee 9
            local.get 8
            local.get 2
            local.get 3
            call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h9b7f224add674e2aE
            br_if 3 (;@1;)
            i32.const 0
            local.set 1
            local.get 11
            local.get 6
            i32.sub
            i32.const 65535
            i32.and
            local.set 2
            loop  ;; label = @5
              local.get 1
              i32.const 65535
              i32.and
              local.get 2
              i32.ge_u
              br_if 2 (;@3;)
              i32.const 1
              local.set 12
              local.get 1
              i32.const 1
              i32.add
              local.set 1
              local.get 10
              i32.const 48
              local.get 9
              i32.load offset=16
              call_indirect (type 1)
              i32.eqz
              br_if 0 (;@5;)
              br 4 (;@1;)
            end
          end
          i32.const 1
          local.set 12
          local.get 10
          local.get 9
          local.get 8
          local.get 2
          local.get 3
          call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h9b7f224add674e2aE
          br_if 2 (;@1;)
          local.get 10
          local.get 4
          local.get 5
          local.get 9
          i32.load offset=12
          call_indirect (type 2)
          br_if 2 (;@1;)
          i32.const 0
          local.set 1
          local.get 13
          local.get 11
          i32.sub
          i32.const 65535
          i32.and
          local.set 0
          loop  ;; label = @4
            local.get 1
            i32.const 65535
            i32.and
            local.tee 2
            local.get 0
            i32.lt_u
            local.set 12
            local.get 2
            local.get 0
            i32.ge_u
            br_if 3 (;@1;)
            local.get 1
            i32.const 1
            i32.add
            local.set 1
            local.get 10
            local.get 6
            local.get 9
            i32.load offset=16
            call_indirect (type 1)
            i32.eqz
            br_if 0 (;@4;)
            br 3 (;@1;)
          end
        end
        i32.const 1
        local.set 12
        local.get 10
        local.get 4
        local.get 5
        local.get 9
        i32.load offset=12
        call_indirect (type 2)
        br_if 1 (;@1;)
        local.get 0
        local.get 14
        i64.store offset=8 align=4
        i32.const 0
        return
      end
      i32.const 1
      local.set 12
      local.get 0
      i32.load
      local.tee 1
      local.get 0
      i32.load offset=4
      local.tee 10
      local.get 8
      local.get 2
      local.get 3
      call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h9b7f224add674e2aE
      br_if 0 (;@1;)
      local.get 1
      local.get 4
      local.get 5
      local.get 10
      i32.load offset=12
      call_indirect (type 2)
      local.set 12
    end
    local.get 12)
  (func $_ZN4core3str5count14do_count_chars17hfba32584e02717a7E (type 1) (param i32 i32) (result i32)
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
              i32.const 12
              i32.add
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
              local.get 1
              i32.const 8
              i32.add
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
              local.get 1
              i32.const 4
              i32.add
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
  (func $_ZN4core6result13unwrap_failed17h4e312bd8e5eb4431E (type 7) (param i32 i32 i32 i32 i32)
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
    i32.const 1049500
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
    call $_ZN4core9panicking9panic_fmt17h41cfed79b2ddbf13E
    unreachable)
  (func $_ZN4core5slice5index22slice_index_order_fail17h87f34a99f306396eE (type 4) (param i32 i32 i32)
    local.get 0
    local.get 1
    local.get 2
    call $_ZN4core5slice5index22slice_index_order_fail8do_panic7runtime17h7ba96d6775765185E
    unreachable)
  (func $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h10d43ed3b5ffe62fE (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.load
    i32.const 1
    local.get 1
    call $_ZN4core3fmt3num3imp21_$LT$impl$u20$u32$GT$4_fmt17habc228f2dba507bcE)
  (func $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h44818328333068deE (type 1) (param i32 i32) (result i32)
    local.get 1
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    call $_ZN4core3fmt9Formatter3pad17h5a5f539bbb272398E)
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hb7cc4525d713b4b9E (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 1
    local.get 0
    i32.load offset=4
    i32.load offset=12
    call_indirect (type 1))
  (func $_ZN4core3fmt9Formatter12pad_integral12write_prefix17h9b7f224add674e2aE (type 11) (param i32 i32 i32 i32 i32) (result i32)
    block  ;; label = @1
      local.get 2
      i32.const 1114112
      i32.eq
      br_if 0 (;@1;)
      local.get 0
      local.get 2
      local.get 1
      i32.load offset=16
      call_indirect (type 1)
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
    call_indirect (type 2))
  (func $_ZN4core3fmt9Formatter9write_str17h5f591b7d46bcc7dbE (type 2) (param i32 i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 1
    local.get 2
    local.get 0
    i32.load offset=4
    i32.load offset=12
    call_indirect (type 2))
  (func $_ZN4core5slice5index26slice_start_index_len_fail8do_panic7runtime17he2583cd0648d1116E (type 4) (param i32 i32 i32)
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
    i32.const 1049768
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
    call $_ZN4core9panicking9panic_fmt17h41cfed79b2ddbf13E
    unreachable)
  (func $_ZN4core5slice5index24slice_end_index_len_fail8do_panic7runtime17h911bca498e89ce56E (type 4) (param i32 i32 i32)
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
    i32.const 1049800
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
    call $_ZN4core9panicking9panic_fmt17h41cfed79b2ddbf13E
    unreachable)
  (func $_ZN4core5slice5index22slice_index_order_fail8do_panic7runtime17h7ba96d6775765185E (type 4) (param i32 i32 i32)
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
    i32.const 1049852
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
    call $_ZN4core9panicking9panic_fmt17h41cfed79b2ddbf13E
    unreachable)
  (func $_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$15copy_from_slice17len_mismatch_fail17hfc67e42bedcb4f60E (type 4) (param i32 i32 i32)
    local.get 1
    local.get 0
    local.get 2
    call $_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$15copy_from_slice17len_mismatch_fail8do_panic7runtime17h33872926555474c8E
    unreachable)
  (func $_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$15copy_from_slice17len_mismatch_fail8do_panic7runtime17h33872926555474c8E (type 4) (param i32 i32 i32)
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
    i32.const 1049952
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
    call $_ZN4core9panicking9panic_fmt17h41cfed79b2ddbf13E
    unreachable)
  (table (;0;) 21 21 funcref)
  (memory (;0;) 17)
  (global $__stack_pointer (mut i32) (i32.const 1048576))
  (global (;1;) i32 (i32.const 1050457))
  (global (;2;) i32 (i32.const 1050464))
  (export "memory" (memory 0))
  (export "alloc" (func $alloc))
  (export "alloc_zeroed" (func $alloc_zeroed))
  (export "blake2b" (func $blake2b))
  (export "dealloc" (func $dealloc))
  (export "__data_end" (global 1))
  (export "__heap_base" (global 2))
  (elem (;0;) (i32.const 1) func $_ZN69_$LT$core..alloc..layout..LayoutError$u20$as$u20$core..fmt..Debug$GT$3fmt17hf22f41cb8f5fdff3E $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h10d43ed3b5ffe62fE $_ZN3std5alloc24default_alloc_error_hook17hbd8de71f1732263eE $_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h37d546d4b358ccb9E $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$9write_str17h7850057311a0cef1E $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$10write_char17h61f319b0423b9825E $_ZN4core3fmt5Write9write_fmt17hc808c42956869ae8E $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17hffe704d8309d203aE $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h7304e3c4160876daE $_ZN92_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..fmt..Display$GT$3fmt17h1300d7785d2cb8e7E $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17h89f7fb848e07ab49E $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17hf8e628056151d29dE $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$6as_str17h4b3ad1b286f4163aE $_ZN4core3ptr77drop_in_place$LT$std..panicking..begin_panic_handler..FormatStringPayload$GT$17h328305dd0d118fb6E $_ZN95_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..fmt..Display$GT$3fmt17h22bfd80d379a9576E $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17ha7c451ef50e5f856E $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17he84c4c3017ddad6dE $_ZN4core5panic12PanicPayload6as_str17h3575ee572e511855E $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hb7cc4525d713b4b9E $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h44818328333068deE)
  (data $.rodata (i32.const 1048576) "LayoutError\00\00\00\00\00\00\00\00\00\01\00\00\00\01\00\00\00called `Result::unwrap()` on an `Err` valuesrc/lib.rs\00\00\00G\00\10\00\0a\00\00\00\03\00\00\008\00\00\00G\00\10\00\0a\00\00\00\09\00\00\008\00\00\00G\00\10\00\0a\00\00\00\1d\00\00\008\00\00\00/home/ubuntu/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/blake2ya-1.0.2/src/blake2b.rsassertion failed: 1 <= n && n <= 64\00\00\84\00\10\00_\00\00\00\e7\00\00\00\09\00\00\00\84\00\10\00_\00\00\00'\01\00\00\0f\00\00\00\84\00\10\00_\00\00\00'\01\00\00\18\00\00\00\84\00\10\00_\00\00\00'\01\00\00-\00\00\00\84\00\10\00_\00\00\00!\01\00\00)\00\00\00\84\00\10\00_\00\00\00\1a\01\00\00\13\00\00\00\84\00\10\00_\00\00\00\14\01\00\00\13\00\00\00\84\00\10\00_\00\00\002\01\00\00\1e\00\00\00\84\00\10\00_\00\00\002\01\00\00\0b\00\00\00\84\00\10\00_\00\00\00-\01\00\00\0f\00\00\00/rustc/6b00bc3880198600130e1cf62b8f8a93494488cc/library/alloc/src/raw_vec/mod.rs\a8\01\10\00P\00\00\00.\02\00\00\11\00\00\00\04\00\00\00\0c\00\00\00\04\00\00\00\05\00\00\00\06\00\00\00\07\00\00\00/rust/deps/dlmalloc-0.2.8/src/dlmalloc.rsassertion failed: psize >= size + min_overhead\00 \02\10\00)\00\00\00\ac\04\00\00\09\00\00\00assertion failed: psize <= size + max_overhead\00\00 \02\10\00)\00\00\00\b2\04\00\00\0d\00\00\00memory allocation of  bytes failed\00\00\c8\02\10\00\15\00\00\00\dd\02\10\00\0d\00\00\00library/std/src/alloc.rs\fc\02\10\00\18\00\00\00d\01\00\00\09\00\00\00\04\00\00\00\0c\00\00\00\04\00\00\00\08\00\00\00\00\00\00\00\08\00\00\00\04\00\00\00\09\00\00\00\00\00\00\00\08\00\00\00\04\00\00\00\0a\00\00\00\0b\00\00\00\0c\00\00\00\0d\00\00\00\0e\00\00\00\10\00\00\00\04\00\00\00\0f\00\00\00\10\00\00\00\11\00\00\00\12\00\00\00capacity overflow\00\00\00|\03\10\00\11\00\00\00): \00\01\00\00\00\00\00\00\00\99\03\10\00\02\00\00\0000010203040506070809101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899range start index  out of range for slice of length t\04\10\00\12\00\00\00\86\04\10\00\22\00\00\00range end index \b8\04\10\00\10\00\00\00\86\04\10\00\22\00\00\00slice index starts at  but ends at \00\d8\04\10\00\16\00\00\00\ee\04\10\00\0d\00\00\00copy_from_slice: source slice length () does not match destination slice length (\00\00\00\0c\05\10\00&\00\00\002\05\10\00+\00\00\00\98\03\10\00\01\00\00\00"))
