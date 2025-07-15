(module $wasi_httpbin-ed7e3352f651a03b.wasm
  (type (;0;) (func))
  (type (;1;) (func (param i32)))
  (type (;2;) (func (param i32 i32) (result i32)))
  (type (;3;) (func (param i32) (result i32)))
  (type (;4;) (func (param i32 i32 i32)))
  (type (;5;) (func (param i32 i32 i32) (result i32)))
  (type (;6;) (func (param i32 i32)))
  (type (;7;) (func (param i32 i32 i32 i32)))
  (type (;8;) (func (param i32 i32 i32 i32 i32 i32) (result i32)))
  (type (;9;) (func (param i32 i32 i32 i32 i32) (result i32)))
  (type (;10;) (func (param i32 i32 i32 i32) (result i32)))
  (type (;11;) (func (result i32)))
  (type (;12;) (func (param i32 i32 i32 i32 i32)))
  (type (;13;) (func (param i32 i32 i32 i32 i32 i32 i32)))
  (type (;14;) (func (param i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32) (result i32)))
  (type (;15;) (func (param i32 i32 i32 i32 i32 i32 i32) (result i32)))
  (import "wasi_snapshot_preview1" "sock_recv" (func $_ZN4wasi13lib_generated22wasi_snapshot_preview19sock_recv17h632db59114fe67aaE (type 8)))
  (import "wasi_snapshot_preview1" "sock_send" (func $_ZN4wasi13lib_generated22wasi_snapshot_preview19sock_send17h97e07b0399bea6bbE (type 9)))
  (import "wasi_snapshot_preview1" "sock_shutdown" (func $_ZN4wasi13lib_generated22wasi_snapshot_preview113sock_shutdown17h2519275d4ee615f8E (type 2)))
  (import "wasi_snapshot_preview1" "fd_write" (func $_ZN4wasi13lib_generated22wasi_snapshot_preview18fd_write17h33aeb12ec25abb21E (type 10)))
  (import "wasi_snapshot_preview1" "environ_get" (func $__imported_wasi_snapshot_preview1_environ_get (type 2)))
  (import "wasi_snapshot_preview1" "environ_sizes_get" (func $__imported_wasi_snapshot_preview1_environ_sizes_get (type 2)))
  (import "wasi_snapshot_preview1" "proc_exit" (func $__imported_wasi_snapshot_preview1_proc_exit (type 1)))
  (func $__wasm_call_ctors (type 0))
  (func $_start (type 0)
    (local i32)
    block  ;; label = @1
      block  ;; label = @2
        global.get $GOT.data.internal.__memory_base
        i32.const 1062184
        i32.add
        i32.load
        br_if 0 (;@2;)
        global.get $GOT.data.internal.__memory_base
        i32.const 1062184
        i32.add
        i32.const 1
        i32.store
        call $__wasm_call_ctors
        call $__main_void
        local.set 0
        call $__wasm_call_dtors
        local.get 0
        br_if 1 (;@1;)
        return
      end
      unreachable
    end
    local.get 0
    call $__wasi_proc_exit
    unreachable)
  (func $_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h141e62f8c62f75caE (type 3) (param i32) (result i32)
    local.get 0
    i32.load
    call $_ZN3std3sys9backtrace28__rust_begin_short_backtrace17hbe0ca226de9ef4c8E
    i32.const 0)
  (func $_ZN3std3sys9backtrace28__rust_begin_short_backtrace17hbe0ca226de9ef4c8E (type 1) (param i32)
    local.get 0
    call_indirect (type 0))
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hdcd39cf569c7529eE (type 2) (param i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load
        local.tee 0
        i32.load8_u
        i32.const 1
        i32.ne
        br_if 0 (;@2;)
        local.get 2
        local.get 0
        i32.const 1
        i32.add
        i32.store offset=12
        local.get 1
        i32.const 1048684
        i32.const 4
        local.get 2
        i32.const 12
        i32.add
        i32.const 1048668
        call $_ZN4core3fmt9Formatter25debug_tuple_field1_finish17h820928a379ff3ec2E
        local.set 0
        br 1 (;@1;)
      end
      local.get 1
      i32.const 1048661
      i32.const 4
      call $_ZN4core3fmt9Formatter9write_str17hdf9d14a3fcabff76E
      local.set 0
    end
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17he465ca2c6b841884E (type 2) (param i32 i32) (result i32)
    (local i32)
    local.get 0
    i32.load
    local.set 0
    block  ;; label = @1
      local.get 1
      i32.load offset=8
      local.tee 2
      i32.const 33554432
      i32.and
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 2
        i32.const 67108864
        i32.and
        br_if 0 (;@2;)
        local.get 0
        local.get 1
        call $_ZN4core3fmt3num3imp51_$LT$impl$u20$core..fmt..Display$u20$for$u20$u8$GT$3fmt17h3aee1a4af9b1cd21E
        return
      end
      local.get 0
      local.get 1
      call $_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i8$GT$3fmt17h41ed9124bb676b3fE
      return
    end
    local.get 0
    local.get 1
    call $_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i8$GT$3fmt17he7063fd2fe3493f9E)
  (func $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hcc5b6de86c24e41dE (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    local.get 1
    call $_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17hf7f012776df7e14cE)
  (func $_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hf3306bbd8b6bdd55E (type 2) (param i32 i32) (result i32)
    (local i32)
    block  ;; label = @1
      local.get 1
      i32.load offset=8
      local.tee 2
      i32.const 33554432
      i32.and
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 2
        i32.const 67108864
        i32.and
        br_if 0 (;@2;)
        local.get 0
        local.get 1
        call $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h5cd5bf496cf18c08E
        return
      end
      local.get 0
      local.get 1
      call $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17h2e5d1c92a54fe8a1E
      return
    end
    local.get 0
    local.get 1
    call $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i32$GT$3fmt17h33f159b23376b92cE)
  (func $_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h1f05bfa0720339aaE (type 3) (param i32) (result i32)
    local.get 0
    i32.load
    call $_ZN3std3sys9backtrace28__rust_begin_short_backtrace17hbe0ca226de9ef4c8E
    i32.const 0)
  (func $_ZN64_$LT$core..str..error..Utf8Error$u20$as$u20$core..fmt..Debug$GT$3fmt17he058c9f858a9d8f5E (type 2) (param i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    local.get 0
    i32.const 4
    i32.add
    i32.store offset=12
    local.get 1
    i32.const 1048632
    i32.const 9
    i32.const 1048641
    i32.const 11
    local.get 0
    i32.const 1048600
    i32.const 1048652
    i32.const 9
    local.get 2
    i32.const 12
    i32.add
    i32.const 1048616
    call $_ZN4core3fmt9Formatter26debug_struct_field2_finish17h05c90c1de6f82831E
    local.set 0
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN12wasi_httpbin4main17he7c86e12b30448a2E (type 0)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 1104
    i32.sub
    local.tee 0
    global.set $__stack_pointer
    block  ;; label = @1
      i32.const 965
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      i32.const 16
      i32.add
      i32.const 59
      i32.add
      i32.const 0
      i32.const 965
      memory.fill
    end
    local.get 0
    i32.const 71
    i32.add
    i32.const 0
    i32.load offset=1048743 align=1
    i32.store align=1
    local.get 0
    i32.const 64
    i32.add
    i32.const 0
    i64.load offset=1048736 align=1
    i64.store
    local.get 0
    i32.const 56
    i32.add
    i32.const 0
    i64.load offset=1048728 align=1
    i64.store
    local.get 0
    i32.const 48
    i32.add
    i32.const 0
    i64.load offset=1048720 align=1
    i64.store
    local.get 0
    i32.const 40
    i32.add
    i32.const 0
    i64.load offset=1048712 align=1
    i64.store
    local.get 0
    i32.const 32
    i32.add
    i32.const 0
    i64.load offset=1048704 align=1
    i64.store
    local.get 0
    i32.const 24
    i32.add
    i32.const 0
    i64.load offset=1048696 align=1
    i64.store
    local.get 0
    i32.const 0
    i64.load offset=1048688 align=1
    i64.store offset=16
    local.get 0
    i32.const 59
    i32.store offset=1048
    local.get 0
    local.get 0
    i32.const 16
    i32.add
    i32.store offset=1044
    local.get 0
    i32.const 1072
    i32.add
    i32.const 3
    local.get 0
    i32.const 1044
    i32.add
    i32.const 1
    i32.const 0
    call $_ZN4wasi13lib_generated9sock_send17h00e19c18ec7751d3E
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 0
              i32.load16_u offset=1072
              i32.const 1
              i32.eq
              br_if 0 (;@5;)
              local.get 0
              local.get 0
              i32.load offset=1076
              local.tee 1
              i32.store offset=1052
              local.get 0
              i32.const 59
              i32.store offset=1096
              local.get 1
              i32.const 59
              i32.ne
              br_if 1 (;@4;)
              local.get 0
              i32.const 1024
              i32.store offset=1060
              local.get 0
              local.get 0
              i32.const 16
              i32.add
              i32.store offset=1056
              local.get 0
              i32.const 1072
              i32.add
              i32.const 3
              local.get 0
              i32.const 1056
              i32.add
              i32.const 1
              i32.const 2
              call $_ZN4wasi13lib_generated9sock_recv17h3594d8e56fd3f8f3E
              local.get 0
              i32.load16_u offset=1072
              br_if 2 (;@3;)
              local.get 0
              i32.load offset=1076
              local.tee 1
              i32.const 1025
              i32.ge_u
              br_if 3 (;@2;)
              local.get 0
              i32.const 1072
              i32.add
              local.get 0
              i32.const 16
              i32.add
              local.get 1
              call $_ZN4core3str21_$LT$impl$u20$str$GT$9from_utf817h384f8df377c8756eE
              local.get 0
              i32.load offset=1072
              i32.const 1
              i32.eq
              br_if 4 (;@1;)
              local.get 0
              local.get 0
              i64.load offset=1076 align=4
              i64.store offset=1064 align=4
              local.get 0
              i32.const 2
              i32.store offset=1076
              local.get 0
              i32.const 1048780
              i32.store offset=1072
              local.get 0
              i64.const 1
              i64.store offset=1084 align=4
              local.get 0
              i32.const 1
              i64.extend_i32_u
              i64.const 32
              i64.shl
              local.get 0
              i32.const 1064
              i32.add
              i64.extend_i32_u
              i64.or
              i64.store offset=1096
              local.get 0
              local.get 0
              i32.const 1096
              i32.add
              i32.store offset=1080
              local.get 0
              i32.const 1072
              i32.add
              call $_ZN3std2io5stdio6_print17h113dc87389378e4fE
              local.get 0
              i32.const 8
              i32.add
              i32.const 3
              i32.const 3
              call $_ZN4wasi13lib_generated13sock_shutdown17ha1f004a183b4ae33E
              local.get 0
              i32.const 1104
              i32.add
              global.set $__stack_pointer
              return
            end
            local.get 0
            local.get 0
            i32.load16_u offset=1074
            i32.store16 offset=1096
            i32.const 1048812
            i32.const 43
            local.get 0
            i32.const 1096
            i32.add
            i32.const 1048872
            i32.const 1048920
            call $_ZN4core6result13unwrap_failed17h398ddd55d54bb216E
            unreachable
          end
          local.get 0
          i32.const 0
          i32.store offset=1072
          i32.const 0
          local.get 0
          i32.const 1052
          i32.add
          local.get 0
          i32.const 1096
          i32.add
          local.get 0
          i32.const 1072
          i32.add
          i32.const 1048904
          call $_ZN4core9panicking13assert_failed17h40a15157b46eef88E
          unreachable
        end
        local.get 0
        local.get 0
        i32.load16_u offset=1074
        i32.store16 offset=1096
        i32.const 1048812
        i32.const 43
        local.get 0
        i32.const 1096
        i32.add
        i32.const 1048872
        i32.const 1048888
        call $_ZN4core6result13unwrap_failed17h398ddd55d54bb216E
        unreachable
      end
      local.get 1
      i32.const 1024
      i32.const 1048760
      call $_ZN4core5slice5index24slice_end_index_len_fail17hc7943372990115c8E
      unreachable
    end
    local.get 0
    local.get 0
    i64.load offset=1076 align=4
    i64.store offset=1096
    i32.const 1048812
    i32.const 43
    local.get 0
    i32.const 1096
    i32.add
    i32.const 1048796
    i32.const 1048856
    call $_ZN4core6result13unwrap_failed17h398ddd55d54bb216E
    unreachable)
  (func $__main_void (type 11) (result i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 0
    global.set $__stack_pointer
    local.get 0
    i32.const 2
    i32.store offset=12
    local.get 0
    i32.const 12
    i32.add
    i32.const 1048576
    i32.const 0
    i32.const 0
    i32.const 0
    call $_ZN3std2rt19lang_start_internal17h130be55fe5a08399E
    local.set 1
    local.get 0
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc (type 2) (param i32 i32) (result i32)
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
  (func $_RNvCs691rhTbG0Ee_7___rustc14___rust_realloc (type 10) (param i32 i32 i32 i32) (result i32)
    (local i32)
    local.get 0
    local.get 1
    local.get 2
    local.get 3
    call $_RNvCs691rhTbG0Ee_7___rustc13___rdl_realloc
    local.set 4
    local.get 4
    return)
  (func $_RNvCs691rhTbG0Ee_7___rustc26___rust_alloc_error_handler (type 6) (param i32 i32)
    local.get 0
    local.get 1
    call $_RNvCs691rhTbG0Ee_7___rustc8___rg_oom
    return)
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h9e1d70983b4e2748E (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    local.get 1
    call $_ZN40_$LT$str$u20$as$u20$core..fmt..Debug$GT$3fmt17he4df7632dab5ca2aE)
  (func $_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u16$GT$3fmt17hdd5627b38d8a7d3bE (type 2) (param i32 i32) (result i32)
    (local i32)
    block  ;; label = @1
      local.get 1
      i32.load offset=8
      local.tee 2
      i32.const 33554432
      i32.and
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 2
        i32.const 67108864
        i32.and
        br_if 0 (;@2;)
        local.get 0
        local.get 1
        call $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u16$GT$3fmt17h0a70fcf6ae4f6af2E
        return
      end
      local.get 0
      local.get 1
      call $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i16$GT$3fmt17h9bd2fb75ef2ef589E
      return
    end
    local.get 0
    local.get 1
    call $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i16$GT$3fmt17hd4aea400ca6ba288E)
  (func $_ZN4wasi13lib_generated5Errno4name17h34c97615fb2b8ce6E (type 6) (param i32 i32)
    local.get 0
    local.get 1
    i32.load16_s
    i32.const 2
    i32.shl
    local.tee 1
    i32.const 1051220
    i32.add
    i32.load
    i32.store offset=4
    local.get 0
    local.get 1
    i32.const 1051528
    i32.add
    i32.load
    i32.store)
  (func $_ZN4wasi13lib_generated5Errno7message17h8c3391208162de4dE (type 6) (param i32 i32)
    local.get 0
    local.get 1
    i32.load16_s
    i32.const 2
    i32.shl
    local.tee 1
    i32.const 1051836
    i32.add
    i32.load
    i32.store offset=4
    local.get 0
    local.get 1
    i32.const 1052144
    i32.add
    i32.load
    i32.store)
  (func $_ZN63_$LT$wasi..lib_generated..Errno$u20$as$u20$core..fmt..Debug$GT$3fmt17hee0aaf6495e0ee2eE (type 2) (param i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    i32.const 24
    i32.add
    local.get 1
    i32.const 1051197
    i32.const 5
    call $_ZN4core3fmt9Formatter12debug_struct17h8b04cc0c27469750E
    local.get 2
    i32.const 24
    i32.add
    i32.const 1048936
    i32.const 4
    local.get 0
    i32.const 1051204
    call $_ZN4core3fmt8builders11DebugStruct5field17h13f66060f544090dE
    local.set 1
    local.get 2
    i32.const 16
    i32.add
    local.get 0
    call $_ZN4wasi13lib_generated5Errno4name17h34c97615fb2b8ce6E
    local.get 2
    local.get 2
    i64.load offset=16
    i64.store offset=32 align=4
    local.get 1
    i32.const 1048956
    i32.const 4
    local.get 2
    i32.const 32
    i32.add
    i32.const 1048940
    call $_ZN4core3fmt8builders11DebugStruct5field17h13f66060f544090dE
    local.set 1
    local.get 2
    i32.const 8
    i32.add
    local.get 0
    call $_ZN4wasi13lib_generated5Errno7message17h8c3391208162de4dE
    local.get 2
    local.get 2
    i64.load offset=8
    i64.store offset=40 align=4
    local.get 1
    i32.const 1048960
    i32.const 7
    local.get 2
    i32.const 40
    i32.add
    i32.const 1048940
    call $_ZN4core3fmt8builders11DebugStruct5field17h13f66060f544090dE
    call $_ZN4core3fmt8builders11DebugStruct6finish17h9c0eaac50360f7e7E
    local.set 0
    local.get 2
    i32.const 48
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN4wasi13lib_generated9sock_recv17h3594d8e56fd3f8f3E (type 12) (param i32 i32 i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        local.get 2
        local.get 3
        local.get 4
        i32.const 65535
        i32.and
        local.get 5
        i32.const 8
        i32.add
        local.get 5
        i32.const 14
        i32.add
        call $_ZN4wasi13lib_generated22wasi_snapshot_preview19sock_recv17h632db59114fe67aaE
        local.tee 4
        br_if 0 (;@2;)
        local.get 0
        local.get 5
        i32.load16_u offset=14
        i32.store16 offset=8
        local.get 0
        local.get 5
        i32.load offset=8
        i32.store offset=4
        i32.const 0
        local.set 4
        br 1 (;@1;)
      end
      local.get 0
      local.get 4
      i32.store16 offset=2
      i32.const 1
      local.set 4
    end
    local.get 0
    local.get 4
    i32.store16
    local.get 5
    i32.const 16
    i32.add
    global.set $__stack_pointer)
  (func $_ZN4wasi13lib_generated9sock_send17h00e19c18ec7751d3E (type 12) (param i32 i32 i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        local.get 2
        local.get 3
        local.get 4
        i32.const 65535
        i32.and
        local.get 5
        i32.const 12
        i32.add
        call $_ZN4wasi13lib_generated22wasi_snapshot_preview19sock_send17h97e07b0399bea6bbE
        local.tee 4
        br_if 0 (;@2;)
        local.get 0
        local.get 5
        i32.load offset=12
        i32.store offset=4
        i32.const 0
        local.set 4
        br 1 (;@1;)
      end
      local.get 0
      local.get 4
      i32.store16 offset=2
      i32.const 1
      local.set 4
    end
    local.get 0
    local.get 4
    i32.store16
    local.get 5
    i32.const 16
    i32.add
    global.set $__stack_pointer)
  (func $_ZN4wasi13lib_generated13sock_shutdown17ha1f004a183b4ae33E (type 4) (param i32 i32 i32)
    local.get 0
    local.get 1
    local.get 2
    i32.const 255
    i32.and
    call $_ZN4wasi13lib_generated22wasi_snapshot_preview113sock_shutdown17h2519275d4ee615f8E
    local.tee 2
    i32.store16 offset=2
    local.get 0
    local.get 2
    i32.const 0
    i32.ne
    i32.store16)
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h4efe53c54189bac6E (type 6) (param i32 i32)
    local.get 0
    i64.const 7199936582794304877
    i64.store offset=8
    local.get 0
    i64.const -5076933981314334344
    i64.store)
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h91f73deee89ea2feE (type 6) (param i32 i32)
    local.get 0
    i64.const 3353964679774260343
    i64.store offset=8
    local.get 0
    i64.const -5190768330908619786
    i64.store)
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h3150aa17e091748dE (type 2) (param i32 i32) (result i32)
    (local i32)
    local.get 0
    i32.load
    local.set 0
    block  ;; label = @1
      local.get 1
      i32.load offset=8
      local.tee 2
      i32.const 33554432
      i32.and
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 2
        i32.const 67108864
        i32.and
        br_if 0 (;@2;)
        local.get 0
        local.get 1
        call $_ZN4core3fmt3num3imp51_$LT$impl$u20$core..fmt..Display$u20$for$u20$u8$GT$3fmt17h3aee1a4af9b1cd21E
        return
      end
      local.get 0
      local.get 1
      call $_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i8$GT$3fmt17h41ed9124bb676b3fE
      return
    end
    local.get 0
    local.get 1
    call $_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i8$GT$3fmt17he7063fd2fe3493f9E)
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hb66487f36964aa60E (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 1
    call $_ZN43_$LT$bool$u20$as$u20$core..fmt..Display$GT$3fmt17he3b1fcab12cb0898E)
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hf130eefae1d3725aE (type 2) (param i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load
        local.tee 0
        i32.load8_u
        i32.const 1
        i32.ne
        br_if 0 (;@2;)
        local.get 2
        local.get 0
        i32.const 1
        i32.add
        i32.store offset=12
        local.get 1
        i32.const 1052769
        i32.const 4
        local.get 2
        i32.const 12
        i32.add
        i32.const 1052484
        call $_ZN4core3fmt9Formatter25debug_tuple_field1_finish17h820928a379ff3ec2E
        local.set 0
        br 1 (;@1;)
      end
      local.get 1
      i32.const 1052765
      i32.const 4
      call $_ZN4core3fmt9Formatter9write_str17hdf9d14a3fcabff76E
      local.set 0
    end
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h98109e2d277772fbE (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i64)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 1
    i32.load offset=4
    local.set 3
    local.get 1
    i32.load
    local.set 4
    local.get 0
    i32.load
    local.set 1
    local.get 2
    i32.const 3
    i32.store offset=4
    local.get 2
    i32.const 1052776
    i32.store
    local.get 2
    i64.const 3
    i64.store offset=12 align=4
    local.get 2
    i32.const 12
    i64.extend_i32_u
    i64.const 32
    i64.shl
    local.get 1
    i64.extend_i32_u
    i64.or
    i64.store offset=24
    local.get 2
    i32.const 13
    i64.extend_i32_u
    i64.const 32
    i64.shl
    local.tee 5
    local.get 1
    i32.const 12
    i32.add
    i64.extend_i32_u
    i64.or
    i64.store offset=40
    local.get 2
    local.get 5
    local.get 1
    i32.const 8
    i32.add
    i64.extend_i32_u
    i64.or
    i64.store offset=32
    local.get 2
    local.get 2
    i32.const 24
    i32.add
    i32.store offset=8
    local.get 4
    local.get 3
    local.get 2
    call $_ZN4core3fmt5write17hb4e267bf92503392E
    local.set 1
    local.get 2
    i32.const 48
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hd0fd140cfc9a36efE (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    local.get 1
    call $_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17hf7f012776df7e14cE)
  (func $_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hf3306bbd8b6bdd55E.1 (type 2) (param i32 i32) (result i32)
    (local i32)
    block  ;; label = @1
      local.get 1
      i32.load offset=8
      local.tee 2
      i32.const 33554432
      i32.and
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 2
        i32.const 67108864
        i32.and
        br_if 0 (;@2;)
        local.get 0
        local.get 1
        call $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h5cd5bf496cf18c08E
        return
      end
      local.get 0
      local.get 1
      call $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17h2e5d1c92a54fe8a1E
      return
    end
    local.get 0
    local.get 1
    call $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i32$GT$3fmt17h33f159b23376b92cE)
  (func $_ZN4core3fmt5Write10write_char17h52852870b95da1a0E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    i32.const 0
    i32.store offset=4
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
            local.get 2
            local.get 1
            i32.const 63
            i32.and
            i32.const 128
            i32.or
            i32.store8 offset=7
            local.get 2
            local.get 1
            i32.const 18
            i32.shr_u
            i32.const 240
            i32.or
            i32.store8 offset=4
            local.get 2
            local.get 1
            i32.const 6
            i32.shr_u
            i32.const 63
            i32.and
            i32.const 128
            i32.or
            i32.store8 offset=6
            local.get 2
            local.get 1
            i32.const 12
            i32.shr_u
            i32.const 63
            i32.and
            i32.const 128
            i32.or
            i32.store8 offset=5
            i32.const 4
            local.set 1
            br 3 (;@1;)
          end
          local.get 2
          local.get 1
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.store8 offset=6
          local.get 2
          local.get 1
          i32.const 12
          i32.shr_u
          i32.const 224
          i32.or
          i32.store8 offset=4
          local.get 2
          local.get 1
          i32.const 6
          i32.shr_u
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.store8 offset=5
          i32.const 3
          local.set 1
          br 2 (;@1;)
        end
        local.get 2
        local.get 1
        i32.store8 offset=4
        i32.const 1
        local.set 1
        br 1 (;@1;)
      end
      local.get 2
      local.get 1
      i32.const 63
      i32.and
      i32.const 128
      i32.or
      i32.store8 offset=5
      local.get 2
      local.get 1
      i32.const 6
      i32.shr_u
      i32.const 192
      i32.or
      i32.store8 offset=4
      i32.const 2
      local.set 1
    end
    local.get 2
    i32.const 8
    i32.add
    local.get 0
    i32.load offset=8
    local.get 2
    i32.const 4
    i32.add
    local.get 1
    call $_ZN61_$LT$std..io..stdio..StdoutLock$u20$as$u20$std..io..Write$GT$9write_all17he8e1b902282633b2E
    block  ;; label = @1
      local.get 2
      i32.load8_u offset=8
      local.tee 1
      i32.const 4
      i32.eq
      br_if 0 (;@1;)
      local.get 0
      i32.load offset=4
      local.set 3
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          i32.load8_u
          local.tee 4
          i32.const 4
          i32.gt_u
          br_if 0 (;@3;)
          local.get 4
          i32.const 3
          i32.ne
          br_if 1 (;@2;)
        end
        local.get 3
        i32.load
        local.set 5
        block  ;; label = @3
          local.get 3
          i32.const 4
          i32.add
          i32.load
          local.tee 4
          i32.load
          local.tee 6
          i32.eqz
          br_if 0 (;@3;)
          local.get 5
          local.get 6
          call_indirect (type 1)
        end
        block  ;; label = @3
          local.get 4
          i32.load offset=4
          local.tee 6
          i32.eqz
          br_if 0 (;@3;)
          local.get 5
          local.get 6
          local.get 4
          i32.load offset=8
          call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        end
        local.get 3
        i32.const 12
        i32.const 4
        call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
      end
      local.get 0
      local.get 2
      i64.load offset=8
      i64.store align=4
    end
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 1
    i32.const 4
    i32.ne)
  (func $_ZN61_$LT$std..io..stdio..StdoutLock$u20$as$u20$std..io..Write$GT$9write_all17he8e1b902282633b2E (type 7) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i64 i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 4
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 1
                      i32.load
                      local.tee 1
                      i32.load offset=16
                      br_if 0 (;@9;)
                      local.get 1
                      i32.const -1
                      i32.store offset=16
                      local.get 4
                      i32.const 8
                      i32.add
                      i32.const 10
                      local.get 2
                      local.get 3
                      call $_ZN4core5slice6memchr7memrchr17h3f286f71ea91eee5E
                      block  ;; label = @10
                        block  ;; label = @11
                          local.get 4
                          i32.load offset=8
                          i32.const 1
                          i32.and
                          i32.eqz
                          br_if 0 (;@11;)
                          local.get 3
                          local.get 4
                          i32.load offset=12
                          i32.const 1
                          i32.add
                          local.tee 5
                          i32.ge_u
                          br_if 1 (;@10;)
                          local.get 4
                          i32.const 0
                          i32.store offset=32
                          local.get 4
                          i32.const 1
                          i32.store offset=20
                          local.get 4
                          i32.const 1053372
                          i32.store offset=16
                          local.get 4
                          i64.const 4
                          i64.store offset=24 align=4
                          local.get 4
                          i32.const 16
                          i32.add
                          i32.const 1053380
                          call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
                          unreachable
                        end
                        block  ;; label = @11
                          local.get 1
                          i32.load offset=28
                          local.tee 6
                          br_if 0 (;@11;)
                          i32.const 0
                          local.set 6
                          br 8 (;@3;)
                        end
                        local.get 1
                        i32.load offset=24
                        local.tee 7
                        local.get 6
                        i32.add
                        i32.const -1
                        i32.add
                        i32.load8_u
                        i32.const 10
                        i32.ne
                        br_if 7 (;@3;)
                        i32.const 0
                        local.set 8
                        loop  ;; label = @11
                          local.get 4
                          local.get 6
                          local.get 8
                          i32.sub
                          local.tee 9
                          i32.store offset=44
                          local.get 4
                          local.get 7
                          local.get 8
                          i32.add
                          local.tee 10
                          i32.store offset=40
                          local.get 4
                          i32.const 16
                          i32.add
                          i32.const 1
                          local.get 4
                          i32.const 40
                          i32.add
                          i32.const 1
                          call $_ZN4wasi13lib_generated8fd_write17h8e36e57726d845e0E
                          block  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                block  ;; label = @15
                                  block  ;; label = @16
                                    local.get 4
                                    i32.load16_u offset=16
                                    i32.const 1
                                    i32.ne
                                    br_if 0 (;@16;)
                                    local.get 9
                                    local.set 11
                                    local.get 4
                                    i32.load16_u offset=18
                                    local.tee 5
                                    i32.const 8
                                    i32.eq
                                    br_if 1 (;@15;)
                                    local.get 1
                                    i32.const 0
                                    i32.store8 offset=32
                                    local.get 5
                                    i32.const 27
                                    i32.eq
                                    br_if 4 (;@12;)
                                    local.get 5
                                    i64.extend_i32_u
                                    i64.const 32
                                    i64.shl
                                    local.set 12
                                    br 2 (;@14;)
                                  end
                                  local.get 4
                                  i32.load offset=20
                                  local.set 11
                                end
                                local.get 1
                                i32.const 0
                                i32.store8 offset=32
                                local.get 11
                                br_if 1 (;@13;)
                                i32.const 1053256
                                i64.extend_i32_u
                                i64.const 32
                                i64.shl
                                i64.const 2
                                i64.or
                                local.set 12
                              end
                              block  ;; label = @14
                                local.get 8
                                i32.eqz
                                br_if 0 (;@14;)
                                block  ;; label = @15
                                  local.get 9
                                  i32.eqz
                                  br_if 0 (;@15;)
                                  local.get 7
                                  local.get 10
                                  local.get 9
                                  memory.copy
                                end
                                local.get 1
                                local.get 9
                                i32.store offset=28
                              end
                              local.get 12
                              i64.const 255
                              i64.and
                              i64.const 4
                              i64.ne
                              br_if 5 (;@8;)
                              local.get 1
                              i32.load offset=28
                              local.set 6
                              br 10 (;@3;)
                            end
                            local.get 11
                            local.get 8
                            i32.add
                            local.set 8
                          end
                          local.get 8
                          local.get 6
                          i32.ge_u
                          br_if 7 (;@4;)
                          br 0 (;@11;)
                        end
                      end
                      block  ;; label = @10
                        local.get 1
                        i32.load offset=28
                        local.tee 8
                        br_if 0 (;@10;)
                        local.get 5
                        i32.eqz
                        br_if 5 (;@5;)
                        local.get 2
                        local.set 6
                        local.get 5
                        local.set 8
                        loop  ;; label = @11
                          local.get 4
                          local.get 8
                          i32.store offset=44
                          local.get 4
                          local.get 6
                          i32.store offset=40
                          local.get 4
                          i32.const 16
                          i32.add
                          i32.const 1
                          local.get 4
                          i32.const 40
                          i32.add
                          i32.const 1
                          call $_ZN4wasi13lib_generated8fd_write17h8e36e57726d845e0E
                          block  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                block  ;; label = @15
                                  local.get 4
                                  i32.load16_u offset=16
                                  i32.const 1
                                  i32.ne
                                  br_if 0 (;@15;)
                                  local.get 4
                                  i64.load16_u offset=18
                                  local.tee 12
                                  i64.const 27
                                  i64.eq
                                  br_if 3 (;@12;)
                                  local.get 12
                                  i64.const 32
                                  i64.shl
                                  local.set 12
                                  br 1 (;@14;)
                                end
                                local.get 4
                                i32.load offset=20
                                local.tee 11
                                br_if 1 (;@13;)
                                i32.const 0
                                i64.load offset=1053440
                                local.set 12
                              end
                              local.get 12
                              i64.const 255
                              i64.and
                              i64.const 4
                              i64.eq
                              br_if 8 (;@5;)
                              local.get 12
                              i64.const -4294967041
                              i64.and
                              i64.const 34359738368
                              i64.eq
                              br_if 8 (;@5;)
                              local.get 0
                              local.get 12
                              i64.store align=4
                              br 11 (;@2;)
                            end
                            local.get 8
                            local.get 11
                            i32.lt_u
                            br_if 5 (;@7;)
                            local.get 6
                            local.get 11
                            i32.add
                            local.set 6
                            local.get 8
                            local.get 11
                            i32.sub
                            local.set 8
                          end
                          local.get 8
                          br_if 0 (;@11;)
                          br 6 (;@5;)
                        end
                      end
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            local.get 5
                            local.get 1
                            i32.load offset=20
                            local.get 8
                            i32.sub
                            i32.lt_u
                            br_if 0 (;@12;)
                            local.get 4
                            i32.const 16
                            i32.add
                            local.get 1
                            i32.const 20
                            i32.add
                            local.get 2
                            local.get 5
                            call $_ZN3std2io8buffered9bufwriter18BufWriter$LT$W$GT$14write_all_cold17hbec3c57489ed568fE
                            local.get 4
                            i32.load8_u offset=16
                            i32.const 4
                            i32.eq
                            br_if 1 (;@11;)
                            local.get 0
                            local.get 4
                            i64.load offset=16
                            i64.store align=4
                            br 10 (;@2;)
                          end
                          block  ;; label = @12
                            local.get 5
                            i32.eqz
                            br_if 0 (;@12;)
                            local.get 1
                            i32.load offset=24
                            local.get 8
                            i32.add
                            local.get 2
                            local.get 5
                            memory.copy
                          end
                          local.get 1
                          local.get 8
                          local.get 5
                          i32.add
                          local.tee 11
                          i32.store offset=28
                          br 1 (;@10;)
                        end
                        local.get 1
                        i32.load offset=28
                        local.set 11
                      end
                      local.get 11
                      i32.eqz
                      br_if 4 (;@5;)
                      local.get 1
                      i32.load offset=24
                      local.set 7
                      i32.const 0
                      local.set 8
                      loop  ;; label = @10
                        local.get 4
                        local.get 11
                        local.get 8
                        i32.sub
                        local.tee 9
                        i32.store offset=44
                        local.get 4
                        local.get 7
                        local.get 8
                        i32.add
                        local.tee 10
                        i32.store offset=40
                        local.get 4
                        i32.const 16
                        i32.add
                        i32.const 1
                        local.get 4
                        i32.const 40
                        i32.add
                        i32.const 1
                        call $_ZN4wasi13lib_generated8fd_write17h8e36e57726d845e0E
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                block  ;; label = @15
                                  local.get 4
                                  i32.load16_u offset=16
                                  i32.const 1
                                  i32.ne
                                  br_if 0 (;@15;)
                                  local.get 9
                                  local.set 6
                                  local.get 4
                                  i32.load16_u offset=18
                                  local.tee 13
                                  i32.const 8
                                  i32.eq
                                  br_if 1 (;@14;)
                                  local.get 1
                                  i32.const 0
                                  i32.store8 offset=32
                                  local.get 13
                                  i32.const 27
                                  i32.eq
                                  br_if 4 (;@11;)
                                  local.get 13
                                  i64.extend_i32_u
                                  i64.const 32
                                  i64.shl
                                  local.set 12
                                  br 2 (;@13;)
                                end
                                local.get 4
                                i32.load offset=20
                                local.set 6
                              end
                              local.get 1
                              i32.const 0
                              i32.store8 offset=32
                              local.get 6
                              br_if 1 (;@12;)
                              i32.const 1053256
                              i64.extend_i32_u
                              i64.const 32
                              i64.shl
                              i64.const 2
                              i64.or
                              local.set 12
                            end
                            block  ;; label = @13
                              local.get 8
                              i32.eqz
                              br_if 0 (;@13;)
                              block  ;; label = @14
                                local.get 9
                                i32.eqz
                                br_if 0 (;@14;)
                                local.get 7
                                local.get 10
                                local.get 9
                                memory.copy
                              end
                              local.get 1
                              local.get 9
                              i32.store offset=28
                            end
                            local.get 12
                            i64.const 255
                            i64.and
                            i64.const 4
                            i64.eq
                            br_if 7 (;@5;)
                            local.get 0
                            local.get 12
                            i64.store align=4
                            br 10 (;@2;)
                          end
                          local.get 6
                          local.get 8
                          i32.add
                          local.set 8
                        end
                        local.get 8
                        local.get 11
                        i32.ge_u
                        br_if 4 (;@6;)
                        br 0 (;@10;)
                      end
                    end
                    i32.const 1054296
                    call $_ZN4core4cell22panic_already_borrowed17h95614011b014b567E
                    unreachable
                  end
                  local.get 0
                  local.get 12
                  i64.store align=4
                  br 5 (;@2;)
                end
                local.get 11
                local.get 8
                i32.const 1054688
                call $_ZN4core5slice5index26slice_start_index_len_fail17hcb91b9a11352b54bE
                unreachable
              end
              block  ;; label = @6
                local.get 8
                local.get 11
                i32.gt_u
                br_if 0 (;@6;)
                local.get 1
                i32.const 0
                i32.store offset=28
                br 1 (;@5;)
              end
              local.get 8
              local.get 11
              i32.const 1052592
              call $_ZN4core5slice5index24slice_end_index_len_fail17hc7943372990115c8E
              unreachable
            end
            local.get 2
            local.get 5
            i32.add
            local.set 11
            block  ;; label = @5
              local.get 3
              local.get 5
              i32.sub
              local.tee 8
              local.get 1
              i32.load offset=20
              local.get 1
              i32.load offset=28
              local.tee 6
              i32.sub
              i32.lt_u
              br_if 0 (;@5;)
              local.get 0
              local.get 1
              i32.const 20
              i32.add
              local.get 11
              local.get 8
              call $_ZN3std2io8buffered9bufwriter18BufWriter$LT$W$GT$14write_all_cold17hbec3c57489ed568fE
              br 3 (;@2;)
            end
            block  ;; label = @5
              local.get 8
              i32.eqz
              br_if 0 (;@5;)
              local.get 1
              i32.load offset=24
              local.get 6
              i32.add
              local.get 11
              local.get 8
              memory.copy
            end
            local.get 0
            i32.const 4
            i32.store8
            local.get 1
            local.get 6
            local.get 8
            i32.add
            i32.store offset=28
            br 2 (;@2;)
          end
          local.get 8
          local.get 6
          i32.gt_u
          br_if 2 (;@1;)
          i32.const 0
          local.set 6
          local.get 1
          i32.const 0
          i32.store offset=28
        end
        block  ;; label = @3
          local.get 3
          local.get 1
          i32.load offset=20
          local.get 6
          i32.sub
          i32.lt_u
          br_if 0 (;@3;)
          local.get 0
          local.get 1
          i32.const 20
          i32.add
          local.get 2
          local.get 3
          call $_ZN3std2io8buffered9bufwriter18BufWriter$LT$W$GT$14write_all_cold17hbec3c57489ed568fE
          br 1 (;@2;)
        end
        block  ;; label = @3
          local.get 3
          i32.eqz
          br_if 0 (;@3;)
          local.get 1
          i32.load offset=24
          local.get 6
          i32.add
          local.get 2
          local.get 3
          memory.copy
        end
        local.get 0
        i32.const 4
        i32.store8
        local.get 1
        local.get 6
        local.get 3
        i32.add
        i32.store offset=28
      end
      local.get 1
      local.get 1
      i32.load offset=16
      i32.const 1
      i32.add
      i32.store offset=16
      local.get 4
      i32.const 48
      i32.add
      global.set $__stack_pointer
      return
    end
    local.get 8
    local.get 6
    i32.const 1052592
    call $_ZN4core5slice5index24slice_end_index_len_fail17hc7943372990115c8E
    unreachable)
  (func $_ZN4core3fmt5Write10write_char17h8fdb4a4ad22d286fE (type 2) (param i32 i32) (result i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    i32.const 0
    i32.store offset=12
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
            br 3 (;@1;)
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
          br 2 (;@1;)
        end
        local.get 2
        local.get 1
        i32.store8 offset=12
        i32.const 1
        local.set 1
        br 1 (;@1;)
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
    block  ;; label = @1
      local.get 1
      local.get 0
      i32.load offset=8
      local.tee 0
      i32.load
      local.get 0
      i32.load offset=8
      local.tee 3
      i32.sub
      i32.le_u
      br_if 0 (;@1;)
      local.get 0
      local.get 3
      local.get 1
      i32.const 1
      i32.const 1
      call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hf4e8ee5cbddfee98E
      local.get 0
      i32.load offset=8
      local.set 3
    end
    block  ;; label = @1
      local.get 1
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      i32.load offset=4
      local.get 3
      i32.add
      local.get 2
      i32.const 12
      i32.add
      local.get 1
      memory.copy
    end
    local.get 0
    local.get 3
    local.get 1
    i32.add
    i32.store offset=8
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    i32.const 0)
  (func $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hf4e8ee5cbddfee98E (type 12) (param i32 i32 i32 i32 i32)
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
        call $_ZN5alloc7raw_vec11finish_grow17hdbe49ceb89f1e3aaE
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
      i32.const 1052688
      call $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E
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
  (func $_ZN4core3fmt5Write10write_char17ha2bc79364991ee1dE (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i64 i32 i32 i64)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    i32.const 0
    i32.store offset=12
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
            br 3 (;@1;)
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
          br 2 (;@1;)
        end
        local.get 2
        local.get 1
        i32.store8 offset=12
        i32.const 1
        local.set 1
        br 1 (;@1;)
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
    i32.const 0
    local.set 3
    block  ;; label = @1
      i32.const 0
      local.get 0
      i32.load offset=8
      local.tee 4
      i32.load offset=4
      local.tee 5
      local.get 4
      i64.load offset=8
      local.tee 6
      i64.const 4294967295
      local.get 6
      i64.const 4294967295
      i64.lt_u
      select
      i32.wrap_i64
      i32.sub
      local.tee 7
      local.get 7
      local.get 5
      i32.gt_u
      select
      local.tee 7
      local.get 1
      local.get 7
      local.get 1
      i32.lt_u
      select
      local.tee 8
      i32.eqz
      br_if 0 (;@1;)
      local.get 4
      i32.load
      local.get 6
      local.get 5
      i64.extend_i32_u
      local.tee 9
      local.get 6
      local.get 9
      i64.lt_u
      select
      i32.wrap_i64
      i32.add
      local.get 2
      i32.const 12
      i32.add
      local.get 8
      memory.copy
    end
    local.get 4
    local.get 6
    local.get 8
    i64.extend_i32_u
    i64.add
    i64.store offset=8
    block  ;; label = @1
      local.get 7
      local.get 1
      i32.ge_u
      br_if 0 (;@1;)
      i32.const 0
      local.set 3
      i32.const 0
      i64.load offset=1053440
      local.tee 6
      i64.const 255
      i64.and
      i64.const 4
      i64.eq
      br_if 0 (;@1;)
      local.get 0
      i32.load offset=4
      local.set 4
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          i32.load8_u
          local.tee 1
          i32.const 4
          i32.gt_u
          br_if 0 (;@3;)
          local.get 1
          i32.const 3
          i32.ne
          br_if 1 (;@2;)
        end
        local.get 4
        i32.load
        local.set 7
        block  ;; label = @3
          local.get 4
          i32.const 4
          i32.add
          i32.load
          local.tee 1
          i32.load
          local.tee 3
          i32.eqz
          br_if 0 (;@3;)
          local.get 7
          local.get 3
          call_indirect (type 1)
        end
        block  ;; label = @3
          local.get 1
          i32.load offset=4
          local.tee 3
          i32.eqz
          br_if 0 (;@3;)
          local.get 7
          local.get 3
          local.get 1
          i32.load offset=8
          call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        end
        local.get 4
        i32.const 12
        i32.const 4
        call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
      end
      local.get 0
      local.get 6
      i64.store align=4
      i32.const 1
      local.set 3
    end
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 3)
  (func $_ZN4core3fmt5Write10write_char17hd8cddfdb4fcc7641E (type 2) (param i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    i32.const 0
    i32.store offset=12
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
            br 3 (;@1;)
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
          br 2 (;@1;)
        end
        local.get 2
        local.get 1
        i32.store8 offset=12
        i32.const 1
        local.set 1
        br 1 (;@1;)
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
    local.get 0
    local.get 2
    i32.const 12
    i32.add
    local.get 1
    call $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17h4153cc3db7e9152aE
    local.set 1
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17h4153cc3db7e9152aE (type 5) (param i32 i32 i32) (result i32)
    (local i32 i32 i64 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    i32.const 0
    local.set 4
    block  ;; label = @1
      block  ;; label = @2
        local.get 2
        i32.eqz
        br_if 0 (;@2;)
        loop  ;; label = @3
          local.get 3
          local.get 2
          i32.store offset=4
          local.get 3
          local.get 1
          i32.store
          local.get 3
          i32.const 8
          i32.add
          i32.const 2
          local.get 3
          i32.const 1
          call $_ZN4wasi13lib_generated8fd_write17h8e36e57726d845e0E
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 3
                  i32.load16_u offset=8
                  i32.const 1
                  i32.ne
                  br_if 0 (;@7;)
                  local.get 3
                  i64.load16_u offset=10
                  local.tee 5
                  i64.const 27
                  i64.eq
                  br_if 3 (;@4;)
                  local.get 5
                  i64.const 32
                  i64.shl
                  local.set 5
                  br 1 (;@6;)
                end
                local.get 3
                i32.load offset=12
                local.tee 6
                br_if 1 (;@5;)
                i32.const 0
                i64.load offset=1053440
                local.set 5
              end
              local.get 5
              i64.const 255
              i64.and
              i64.const 4
              i64.eq
              br_if 3 (;@2;)
              local.get 0
              i32.load offset=4
              local.set 1
              block  ;; label = @6
                block  ;; label = @7
                  local.get 0
                  i32.load8_u
                  local.tee 2
                  i32.const 4
                  i32.gt_u
                  br_if 0 (;@7;)
                  local.get 2
                  i32.const 3
                  i32.ne
                  br_if 1 (;@6;)
                end
                local.get 1
                i32.load
                local.set 6
                block  ;; label = @7
                  local.get 1
                  i32.const 4
                  i32.add
                  i32.load
                  local.tee 2
                  i32.load
                  local.tee 4
                  i32.eqz
                  br_if 0 (;@7;)
                  local.get 6
                  local.get 4
                  call_indirect (type 1)
                end
                block  ;; label = @7
                  local.get 2
                  i32.load offset=4
                  local.tee 4
                  i32.eqz
                  br_if 0 (;@7;)
                  local.get 6
                  local.get 4
                  local.get 2
                  i32.load offset=8
                  call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
                end
                local.get 1
                i32.const 12
                i32.const 4
                call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
              end
              local.get 0
              local.get 5
              i64.store align=4
              i32.const 1
              local.set 4
              br 3 (;@2;)
            end
            local.get 2
            local.get 6
            i32.lt_u
            br_if 3 (;@1;)
            local.get 1
            local.get 6
            i32.add
            local.set 1
            local.get 2
            local.get 6
            i32.sub
            local.set 2
          end
          local.get 2
          br_if 0 (;@3;)
        end
      end
      local.get 3
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 4
      return
    end
    local.get 6
    local.get 2
    i32.const 1054688
    call $_ZN4core5slice5index26slice_start_index_len_fail17hcb91b9a11352b54bE
    unreachable)
  (func $_ZN4core3fmt5Write9write_fmt17h345d79298f1724e6E (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.const 1052800
    local.get 1
    call $_ZN4core3fmt5write17hb4e267bf92503392E)
  (func $_ZN4core3fmt5Write9write_fmt17h9c16d329b6a554acE (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.const 1052848
    local.get 1
    call $_ZN4core3fmt5write17hb4e267bf92503392E)
  (func $_ZN4core3fmt5Write9write_fmt17ha942ff10abf664dcE (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.const 1052872
    local.get 1
    call $_ZN4core3fmt5write17hb4e267bf92503392E)
  (func $_ZN4core3fmt5Write9write_fmt17ha99898242d13ca1cE (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.const 1052824
    local.get 1
    call $_ZN4core3fmt5write17hb4e267bf92503392E)
  (func $_ZN4core3fmt5Write9write_fmt17hd822b868a48f344bE (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.const 1052896
    local.get 1
    call $_ZN4core3fmt5write17hb4e267bf92503392E)
  (func $_ZN3std9panicking12default_hook17ha7cb01911cb0a911E (type 1) (param i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 80
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    i32.const 3
    local.set 2
    block  ;; label = @1
      local.get 0
      i32.load8_u offset=13
      br_if 0 (;@1;)
      i32.const 1
      local.set 2
      i32.const 0
      i32.load offset=1062288
      i32.const 1
      i32.gt_u
      br_if 0 (;@1;)
      call $_ZN3std5panic19get_backtrace_style17h7d01952034be105fE
      i32.const 255
      i32.and
      local.set 2
    end
    local.get 1
    local.get 2
    i32.store8 offset=15
    local.get 1
    local.get 0
    i32.load offset=8
    i32.store offset=16
    local.get 1
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    call $_ZN3std9panicking14payload_as_str17h7f1efc6f20392d51E
    local.get 1
    local.get 1
    i64.load
    i64.store offset=20 align=4
    local.get 1
    local.get 1
    i32.const 15
    i32.add
    i32.store offset=36
    local.get 1
    local.get 1
    i32.const 20
    i32.add
    i32.store offset=32
    local.get 1
    local.get 1
    i32.const 16
    i32.add
    i32.store offset=28
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              i32.const 0
              i32.load8_u offset=1062191
              br_if 0 (;@5;)
              local.get 1
              i64.const 0
              i64.store offset=40 align=4
              br 1 (;@4;)
            end
            i32.const 0
            i32.const 1
            i32.store8 offset=1062191
            local.get 1
            i32.const 0
            i32.store offset=40
            i32.const 0
            i32.load offset=1062296
            local.set 0
            i32.const 0
            i32.const 0
            i32.store offset=1062296
            local.get 1
            local.get 0
            i32.store offset=44
            local.get 0
            br_if 1 (;@3;)
          end
          local.get 1
          i32.const 40
          i32.add
          call $_ZN4core3ptr199drop_in_place$LT$core..result..Result$LT$core..option..Option$LT$alloc..sync..Arc$LT$std..sync..poison..mutex..Mutex$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$$GT$$C$std..thread..local..AccessError$GT$$GT$17h39961923d7009e78E
          local.get 1
          i32.const 28
          i32.add
          local.get 1
          i32.const 79
          i32.add
          i32.const 1055316
          call $_ZN3std9panicking12default_hook28_$u7b$$u7b$closure$u7d$$u7d$17h10e421fa9b730a1bE
          br 1 (;@2;)
        end
        local.get 0
        i32.load8_u offset=8
        local.set 2
        local.get 0
        i32.const 1
        i32.store8 offset=8
        local.get 1
        local.get 2
        i32.store8 offset=51
        local.get 2
        i32.const 1
        i32.eq
        br_if 1 (;@1;)
        local.get 1
        i32.const 28
        i32.add
        local.get 0
        i32.const 12
        i32.add
        i32.const 1055276
        call $_ZN3std9panicking12default_hook28_$u7b$$u7b$closure$u7d$$u7d$17h10e421fa9b730a1bE
        local.get 0
        i32.const 0
        i32.store8 offset=8
        i32.const 0
        i32.const 1
        i32.store8 offset=1062191
        i32.const 0
        i32.load offset=1062296
        local.set 2
        i32.const 0
        local.get 0
        i32.store offset=1062296
        local.get 1
        local.get 2
        i32.store offset=56
        local.get 1
        i32.const 1
        i32.store offset=52
        local.get 2
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        local.get 2
        i32.load
        local.tee 0
        i32.const -1
        i32.add
        i32.store
        local.get 0
        i32.const 1
        i32.ne
        br_if 0 (;@2;)
        local.get 1
        i32.const 56
        i32.add
        call $_ZN5alloc4sync16Arc$LT$T$C$A$GT$9drop_slow17h3073f53b2412ac4bE
      end
      local.get 1
      i32.const 80
      i32.add
      global.set $__stack_pointer
      return
    end
    local.get 1
    i64.const 0
    i64.store offset=64 align=4
    local.get 1
    i64.const 17179869185
    i64.store offset=56 align=4
    local.get 1
    i32.const 1054752
    i32.store offset=52
    i32.const 0
    local.get 1
    i32.const 51
    i32.add
    i32.const 1056220
    local.get 1
    i32.const 52
    i32.add
    i32.const 1054804
    call $_ZN4core9panicking13assert_failed17h837345b905b163c7E
    unreachable)
  (func $_ZN4core3ptr119drop_in_place$LT$std..io..default_write_fmt..Adapter$LT$std..io..cursor..Cursor$LT$$RF$mut$u20$$u5b$u8$u5d$$GT$$GT$$GT$17haa00b3b07a295c2eE (type 1) (param i32)
    (local i32 i32 i32)
    local.get 0
    i32.load offset=4
    local.set 1
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load8_u
        local.tee 0
        i32.const 4
        i32.gt_u
        br_if 0 (;@2;)
        local.get 0
        i32.const 3
        i32.ne
        br_if 1 (;@1;)
      end
      local.get 1
      i32.load
      local.set 2
      block  ;; label = @2
        local.get 1
        i32.const 4
        i32.add
        i32.load
        local.tee 0
        i32.load
        local.tee 3
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        local.get 3
        call_indirect (type 1)
      end
      block  ;; label = @2
        local.get 0
        i32.load offset=4
        local.tee 3
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        local.get 3
        local.get 0
        i32.load offset=8
        call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
      end
      local.get 1
      i32.const 12
      i32.const 4
      call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
    end)
  (func $_ZN4core3ptr199drop_in_place$LT$core..result..Result$LT$core..option..Option$LT$alloc..sync..Arc$LT$std..sync..poison..mutex..Mutex$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$$GT$$C$std..thread..local..AccessError$GT$$GT$17h39961923d7009e78E (type 1) (param i32)
    (local i32 i32)
    block  ;; label = @1
      local.get 0
      i32.load
      br_if 0 (;@1;)
      local.get 0
      i32.load offset=4
      local.tee 1
      i32.eqz
      br_if 0 (;@1;)
      local.get 1
      local.get 1
      i32.load
      local.tee 2
      i32.const -1
      i32.add
      i32.store
      local.get 2
      i32.const 1
      i32.ne
      br_if 0 (;@1;)
      local.get 0
      i32.const 4
      i32.add
      call $_ZN5alloc4sync16Arc$LT$T$C$A$GT$9drop_slow17h3073f53b2412ac4bE
    end)
  (func $_ZN5alloc4sync16Arc$LT$T$C$A$GT$9drop_slow17h3073f53b2412ac4bE (type 1) (param i32)
    (local i32)
    block  ;; label = @1
      local.get 0
      i32.load
      local.tee 0
      i32.const 12
      i32.add
      i32.load
      local.tee 1
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      i32.const 16
      i32.add
      i32.load
      local.get 1
      i32.const 1
      call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
    end
    block  ;; label = @1
      local.get 0
      i32.const -1
      i32.eq
      br_if 0 (;@1;)
      local.get 0
      local.get 0
      i32.load offset=4
      local.tee 1
      i32.const -1
      i32.add
      i32.store offset=4
      local.get 1
      i32.const 1
      i32.ne
      br_if 0 (;@1;)
      local.get 0
      i32.const 24
      i32.const 4
      call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
    end)
  (func $_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17he0b805fdcd295968E (type 1) (param i32)
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
  (func $_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17hd9b88af97f3c2071E (type 1) (param i32)
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
  (func $_ZN4core3ptr77drop_in_place$LT$std..panicking..begin_panic_handler..FormatStringPayload$GT$17ha0e54a94adfb7416E (type 1) (param i32)
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
  (func $_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h3da6fe1468662fefE (type 6) (param i32 i32)
    (local i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.const 255
        i32.and
        local.tee 0
        i32.const 4
        i32.gt_u
        br_if 0 (;@2;)
        local.get 0
        i32.const 3
        i32.ne
        br_if 1 (;@1;)
      end
      local.get 1
      i32.load
      local.set 2
      block  ;; label = @2
        local.get 1
        i32.const 4
        i32.add
        i32.load
        local.tee 0
        i32.load
        local.tee 3
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        local.get 3
        call_indirect (type 1)
      end
      block  ;; label = @2
        local.get 0
        i32.load offset=4
        local.tee 3
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        local.get 3
        local.get 0
        i32.load offset=8
        call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
      end
      local.get 1
      i32.const 12
      i32.const 4
      call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
    end)
  (func $_ZN4core5panic12PanicPayload6as_str17h72bb6430629ae496E (type 6) (param i32 i32)
    local.get 0
    i32.const 0
    i32.store)
  (func $_ZN4core9panicking13assert_failed17h837345b905b163c7E (type 12) (param i32 i32 i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    local.get 5
    local.get 2
    i32.store offset=12
    local.get 5
    local.get 1
    i32.store offset=8
    local.get 0
    local.get 5
    i32.const 8
    i32.add
    i32.const 1052500
    local.get 5
    i32.const 12
    i32.add
    i32.const 1052500
    local.get 3
    local.get 4
    call $_ZN4core9panicking19assert_failed_inner17ha727a1f35658cb19E
    unreachable)
  (func $_ZN52_$LT$$RF$mut$u20$T$u20$as$u20$core..fmt..Display$GT$3fmt17h0531e392a94f6dbeE (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 1
    local.get 0
    i32.load offset=4
    i32.load offset=12
    call_indirect (type 2))
  (func $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$10write_char17hc99d8b2b5ebe5dd6E (type 2) (param i32 i32) (result i32)
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
      call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hf4e8ee5cbddfee98E
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
  (func $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$9write_str17hb927a9f601e7c7bcE (type 5) (param i32 i32 i32) (result i32)
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
      call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hf4e8ee5cbddfee98E
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
  (func $_ZN5alloc7raw_vec11finish_grow17hdbe49ceb89f1e3aaE (type 7) (param i32 i32 i32 i32)
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
              i32.load8_u offset=1062189
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
          i32.load8_u offset=1062189
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
  (func $_ZN60_$LT$alloc..string..String$u20$as$u20$core..fmt..Display$GT$3fmt17h22c8aa5f6d5a984cE (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.load offset=4
    local.get 0
    i32.load offset=8
    local.get 1
    call $_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17hf7f012776df7e14cE)
  (func $_ZN64_$LT$core..str..error..Utf8Error$u20$as$u20$core..fmt..Debug$GT$3fmt17he058c9f858a9d8f5E.1 (type 2) (param i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    local.get 0
    i32.const 4
    i32.add
    i32.store offset=12
    local.get 1
    i32.const 1052736
    i32.const 9
    i32.const 1052745
    i32.const 11
    local.get 0
    i32.const 1052704
    i32.const 1052756
    i32.const 9
    local.get 2
    i32.const 12
    i32.add
    i32.const 1052720
    call $_ZN4core3fmt9Formatter26debug_struct_field2_finish17h05c90c1de6f82831E
    local.set 0
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN3std3sys4sync4once10no_threads4Once4call17h5c54e46b69727327E (type 1) (param i32)
    (local i32 i32 i64 i64 i64 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 48
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
                    block  ;; label = @9
                      block  ;; label = @10
                        i32.const 0
                        i32.load8_u offset=1062190
                        br_table 0 (;@10;) 2 (;@8;) 1 (;@9;) 9 (;@1;) 0 (;@10;)
                      end
                      i32.const 0
                      i32.const 2
                      i32.store8 offset=1062190
                      local.get 0
                      i32.load8_u
                      local.set 2
                      local.get 0
                      i32.const 0
                      i32.store8
                      block  ;; label = @10
                        local.get 2
                        i32.const 1
                        i32.ne
                        br_if 0 (;@10;)
                        local.get 1
                        i32.const 0
                        i32.store8 offset=39
                        block  ;; label = @11
                          i32.const 0
                          i32.load8_u offset=1062232
                          i32.const 3
                          i32.eq
                          br_if 0 (;@11;)
                          local.get 1
                          i32.const 39
                          i32.add
                          call $_ZN3std4sync9once_lock17OnceLock$LT$T$GT$10initialize17h1e4f1579a1ad7072E
                          local.get 1
                          i32.load8_u offset=39
                          i32.const 1
                          i32.and
                          br_if 9 (;@2;)
                        end
                        block  ;; label = @11
                          i32.const 0
                          i64.load offset=1062264
                          local.tee 3
                          i64.const 0
                          i64.ne
                          br_if 0 (;@11;)
                          i32.const 0
                          i64.load offset=1062272
                          local.set 4
                          loop  ;; label = @12
                            local.get 4
                            i64.const -1
                            i64.eq
                            br_if 5 (;@7;)
                            i32.const 0
                            local.get 4
                            i64.const 1
                            i64.add
                            local.tee 3
                            i32.const 0
                            i64.load offset=1062272
                            local.tee 5
                            local.get 5
                            local.get 4
                            i64.eq
                            local.tee 0
                            select
                            i64.store offset=1062272
                            local.get 5
                            local.set 4
                            local.get 0
                            i32.eqz
                            br_if 0 (;@12;)
                          end
                          i32.const 0
                          local.get 3
                          i64.store offset=1062264
                        end
                        block  ;; label = @11
                          block  ;; label = @12
                            local.get 3
                            i32.const 0
                            i64.load offset=1062192
                            i64.eq
                            br_if 0 (;@12;)
                            i32.const 0
                            i32.load8_u offset=1062204
                            local.set 2
                            i32.const 1
                            local.set 0
                            i32.const 0
                            i32.const 1
                            i32.store8 offset=1062204
                            local.get 2
                            br_if 10 (;@2;)
                            i32.const 0
                            local.get 3
                            i64.store offset=1062192
                            br 1 (;@11;)
                          end
                          i32.const 0
                          i32.load offset=1062200
                          local.tee 0
                          i32.const -1
                          i32.eq
                          br_if 9 (;@2;)
                          local.get 0
                          i32.const 1
                          i32.add
                          local.set 0
                        end
                        i32.const 0
                        local.get 0
                        i32.store offset=1062200
                        i32.const 0
                        i32.load offset=1062208
                        br_if 4 (;@6;)
                        i32.const 0
                        i32.const -1
                        i32.store offset=1062208
                        i32.const 0
                        i32.load8_u offset=1062224
                        br_if 7 (;@3;)
                        i32.const 0
                        local.set 0
                        i32.const 0
                        i32.load offset=1062220
                        local.tee 6
                        i32.eqz
                        br_if 7 (;@3;)
                        i32.const 0
                        i32.load offset=1062216
                        local.set 7
                        loop  ;; label = @11
                          local.get 1
                          local.get 6
                          local.get 0
                          i32.sub
                          local.tee 8
                          i32.store offset=44
                          local.get 1
                          local.get 7
                          local.get 0
                          i32.add
                          local.tee 9
                          i32.store offset=40
                          local.get 1
                          i32.const 12
                          i32.add
                          i32.const 1
                          local.get 1
                          i32.const 40
                          i32.add
                          i32.const 1
                          call $_ZN4wasi13lib_generated8fd_write17h8e36e57726d845e0E
                          block  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                block  ;; label = @15
                                  block  ;; label = @16
                                    local.get 1
                                    i32.load16_u offset=12
                                    i32.const 1
                                    i32.ne
                                    br_if 0 (;@16;)
                                    local.get 8
                                    local.set 2
                                    local.get 1
                                    i32.load16_u offset=14
                                    local.tee 10
                                    i32.const -8
                                    i32.add
                                    br_table 1 (;@15;) 2 (;@14;) 2 (;@14;) 2 (;@14;) 2 (;@14;) 2 (;@14;) 2 (;@14;) 2 (;@14;) 2 (;@14;) 2 (;@14;) 2 (;@14;) 2 (;@14;) 2 (;@14;) 2 (;@14;) 2 (;@14;) 2 (;@14;) 2 (;@14;) 2 (;@14;) 2 (;@14;) 4 (;@12;) 2 (;@14;)
                                  end
                                  local.get 1
                                  i32.load offset=16
                                  local.set 2
                                end
                                local.get 2
                                br_if 1 (;@13;)
                                i32.const 1053256
                                i64.extend_i32_u
                                i64.const 32
                                i64.shl
                                i64.const 2
                                i64.or
                                local.set 4
                                br 9 (;@5;)
                              end
                              local.get 10
                              i64.extend_i32_u
                              i64.const 32
                              i64.shl
                              local.set 4
                              br 8 (;@5;)
                            end
                            local.get 2
                            local.get 0
                            i32.add
                            local.set 0
                          end
                          local.get 0
                          local.get 6
                          i32.ge_u
                          br_if 7 (;@4;)
                          br 0 (;@11;)
                        end
                      end
                      i32.const 1054856
                      call $_ZN4core6option13unwrap_failed17habb842812e602dc6E
                      unreachable
                    end
                    local.get 1
                    i32.const 0
                    i32.store offset=28
                    local.get 1
                    i32.const 1
                    i32.store offset=16
                    local.get 1
                    i32.const 1056144
                    i32.store offset=12
                    local.get 1
                    i64.const 4
                    i64.store offset=20 align=4
                    local.get 1
                    i32.const 12
                    i32.add
                    i32.const 1053036
                    call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
                    unreachable
                  end
                  local.get 1
                  i32.const 0
                  i32.store offset=28
                  local.get 1
                  i32.const 1
                  i32.store offset=16
                  local.get 1
                  i32.const 1056080
                  i32.store offset=12
                  local.get 1
                  i64.const 4
                  i64.store offset=20 align=4
                  local.get 1
                  i32.const 12
                  i32.add
                  i32.const 1053036
                  call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
                  unreachable
                end
                call $_ZN3std6thread8ThreadId3new9exhausted17h79591ad025c79bdcE
                unreachable
              end
              i32.const 1054280
              call $_ZN4core4cell22panic_already_borrowed17h95614011b014b567E
              unreachable
            end
            local.get 4
            i32.wrap_i64
            local.set 2
            block  ;; label = @5
              local.get 0
              i32.eqz
              br_if 0 (;@5;)
              local.get 8
              i32.eqz
              br_if 0 (;@5;)
              local.get 7
              local.get 9
              local.get 8
              memory.copy
            end
            block  ;; label = @5
              local.get 2
              i32.const 255
              i32.and
              local.tee 0
              i32.const 4
              i32.gt_u
              br_if 0 (;@5;)
              local.get 0
              i32.const 3
              i32.ne
              br_if 2 (;@3;)
            end
            local.get 4
            i64.const 32
            i64.shr_u
            i32.wrap_i64
            local.tee 0
            i32.load
            local.set 6
            block  ;; label = @5
              local.get 0
              i32.const 4
              i32.add
              i32.load
              local.tee 2
              i32.load
              local.tee 8
              i32.eqz
              br_if 0 (;@5;)
              local.get 6
              local.get 8
              call_indirect (type 1)
            end
            block  ;; label = @5
              local.get 2
              i32.load offset=4
              local.tee 8
              i32.eqz
              br_if 0 (;@5;)
              local.get 6
              local.get 8
              local.get 2
              i32.load offset=8
              call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
            end
            local.get 0
            i32.const 12
            i32.const 4
            call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
            br 1 (;@3;)
          end
          local.get 0
          local.get 6
          i32.le_u
          br_if 0 (;@3;)
          local.get 0
          local.get 6
          i32.const 1052592
          call $_ZN4core5slice5index24slice_end_index_len_fail17hc7943372990115c8E
          unreachable
        end
        block  ;; label = @3
          i32.const 0
          i32.load offset=1062212
          local.tee 0
          i32.eqz
          br_if 0 (;@3;)
          i32.const 0
          i32.load offset=1062216
          local.get 0
          i32.const 1
          call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        end
        i32.const 0
        i64.const 4294967296
        i64.store offset=1062212 align=4
        i32.const 0
        i32.const 0
        i32.load offset=1062208
        i32.const 1
        i32.add
        i32.store offset=1062208
        i32.const 0
        i32.const 0
        i32.load offset=1062200
        i32.const -1
        i32.add
        local.tee 0
        i32.store offset=1062200
        i32.const 0
        i32.const 0
        i32.store8 offset=1062224
        i32.const 0
        i32.const 0
        i32.store offset=1062220
        local.get 0
        br_if 0 (;@2;)
        i32.const 0
        i64.const 0
        i64.store offset=1062192
        i32.const 0
        i32.const 0
        i32.store8 offset=1062204
      end
      i32.const 0
      i32.const 3
      i32.store8 offset=1062190
    end
    local.get 1
    i32.const 48
    i32.add
    global.set $__stack_pointer)
  (func $_ZN3std2rt19lang_start_internal17h130be55fe5a08399E (type 9) (param i32 i32 i32 i32 i32) (result i32)
    (local i32 i64 i64 i64 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        i32.const 0
        i64.load offset=1062264
        local.tee 6
        i64.const 0
        i64.ne
        br_if 0 (;@2;)
        i32.const 0
        i64.load offset=1062272
        local.set 7
        loop  ;; label = @3
          local.get 7
          i64.const -1
          i64.eq
          br_if 2 (;@1;)
          i32.const 0
          local.get 7
          i64.const 1
          i64.add
          local.tee 6
          i32.const 0
          i64.load offset=1062272
          local.tee 8
          local.get 8
          local.get 7
          i64.eq
          local.tee 9
          select
          i64.store offset=1062272
          local.get 8
          local.set 7
          local.get 9
          i32.eqz
          br_if 0 (;@3;)
        end
        i32.const 0
        local.get 6
        i64.store offset=1062264
      end
      i32.const 0
      local.get 6
      i64.store offset=1062280
      local.get 0
      local.get 1
      i32.load offset=20
      call_indirect (type 3)
      local.set 9
      block  ;; label = @2
        i32.const 0
        i32.load8_u offset=1062190
        i32.const 3
        i32.eq
        br_if 0 (;@2;)
        local.get 5
        i32.const 1
        i32.store8 offset=15
        local.get 5
        i32.const 15
        i32.add
        call $_ZN3std3sys4sync4once10no_threads4Once4call17h5c54e46b69727327E
      end
      local.get 5
      i32.const 16
      i32.add
      global.set $__stack_pointer
      local.get 9
      return
    end
    call $_ZN3std6thread8ThreadId3new9exhausted17h79591ad025c79bdcE
    unreachable)
  (func $_ZN3std6thread8ThreadId3new9exhausted17h79591ad025c79bdcE (type 0)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 0
    global.set $__stack_pointer
    local.get 0
    i32.const 0
    i32.store offset=24
    local.get 0
    i32.const 1
    i32.store offset=12
    local.get 0
    i32.const 1053136
    i32.store offset=8
    local.get 0
    i64.const 4
    i64.store offset=16 align=4
    local.get 0
    i32.const 8
    i32.add
    i32.const 1053144
    call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
    unreachable)
  (func $_ZN3std2io5Write9write_fmt17he070a5b119ee3d3cE (type 4) (param i32 i32 i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    i32.const 4
    i32.store8 offset=8
    local.get 3
    local.get 1
    i32.store offset=16
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          i32.const 8
          i32.add
          i32.const 1052872
          local.get 2
          call $_ZN4core3fmt5write17hb4e267bf92503392E
          i32.eqz
          br_if 0 (;@3;)
          local.get 3
          i32.load8_u offset=8
          i32.const 4
          i32.ne
          br_if 1 (;@2;)
          local.get 3
          i32.const 0
          i32.store offset=40
          local.get 3
          i32.const 1
          i32.store offset=28
          local.get 3
          i32.const 1054484
          i32.store offset=24
          local.get 3
          i64.const 4
          i64.store offset=32 align=4
          local.get 3
          i32.const 24
          i32.add
          i32.const 1054492
          call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
          unreachable
        end
        local.get 0
        i32.const 4
        i32.store8
        local.get 3
        i32.load offset=12
        local.set 2
        block  ;; label = @3
          local.get 3
          i32.load8_u offset=8
          local.tee 1
          i32.const 4
          i32.gt_u
          br_if 0 (;@3;)
          local.get 1
          i32.const 3
          i32.ne
          br_if 2 (;@1;)
        end
        local.get 2
        i32.load
        local.set 0
        block  ;; label = @3
          local.get 2
          i32.const 4
          i32.add
          i32.load
          local.tee 1
          i32.load
          local.tee 4
          i32.eqz
          br_if 0 (;@3;)
          local.get 0
          local.get 4
          call_indirect (type 1)
        end
        block  ;; label = @3
          local.get 1
          i32.load offset=4
          local.tee 4
          i32.eqz
          br_if 0 (;@3;)
          local.get 0
          local.get 4
          local.get 1
          i32.load offset=8
          call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        end
        local.get 2
        i32.const 12
        i32.const 4
        call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        br 1 (;@1;)
      end
      local.get 0
      local.get 3
      i64.load offset=8
      i64.store align=4
    end
    local.get 3
    i32.const 48
    i32.add
    global.set $__stack_pointer)
  (func $_ZN3std3sys3pal4wasi7helpers14abort_internal17he7a2be67736436b7E (type 0)
    call $abort
    unreachable)
  (func $_ZN3std3env11current_dir17h4dd17025e6a63360E (type 1) (param i32)
    (local i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    i32.const 0
    i32.load8_u offset=1062189
    drop
    i32.const 512
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        i32.const 512
        i32.const 1
        call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
        local.tee 3
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        local.get 3
        i32.store offset=8
        local.get 1
        i32.const 512
        i32.store offset=4
        block  ;; label = @3
          block  ;; label = @4
            local.get 3
            i32.const 512
            call $getcwd
            br_if 0 (;@4;)
            i32.const 512
            local.set 2
            loop  ;; label = @5
              block  ;; label = @6
                i32.const 0
                i32.load offset=1062800
                local.tee 4
                i32.const 68
                i32.eq
                br_if 0 (;@6;)
                local.get 0
                local.get 4
                i32.store offset=8
                local.get 0
                i64.const 2147483648
                i64.store align=4
                local.get 2
                i32.eqz
                br_if 3 (;@3;)
                local.get 3
                local.get 2
                i32.const 1
                call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
                br 3 (;@3;)
              end
              local.get 1
              local.get 2
              i32.store offset=12
              local.get 1
              i32.const 4
              i32.add
              local.get 2
              i32.const 1
              i32.const 1
              i32.const 1
              call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hf4e8ee5cbddfee98E
              local.get 1
              i32.load offset=8
              local.tee 3
              local.get 1
              i32.load offset=4
              local.tee 2
              call $getcwd
              i32.eqz
              br_if 0 (;@5;)
            end
          end
          local.get 1
          local.get 3
          call $strlen
          local.tee 4
          i32.store offset=12
          block  ;; label = @4
            local.get 2
            local.get 4
            i32.le_u
            br_if 0 (;@4;)
            block  ;; label = @5
              block  ;; label = @6
                local.get 4
                br_if 0 (;@6;)
                i32.const 1
                local.set 5
                local.get 3
                local.get 2
                i32.const 1
                call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
                br 1 (;@5;)
              end
              local.get 3
              local.get 2
              i32.const 1
              local.get 4
              call $_RNvCs691rhTbG0Ee_7___rustc14___rust_realloc
              local.tee 5
              i32.eqz
              br_if 4 (;@1;)
            end
            local.get 1
            local.get 4
            i32.store offset=4
            local.get 1
            local.get 5
            i32.store offset=8
          end
          local.get 0
          local.get 1
          i64.load offset=4 align=4
          i64.store align=4
          local.get 0
          i32.const 8
          i32.add
          local.get 1
          i32.const 4
          i32.add
          i32.const 8
          i32.add
          i32.load
          i32.store
        end
        local.get 1
        i32.const 16
        i32.add
        global.set $__stack_pointer
        return
      end
      i32.const 1
      i32.const 512
      i32.const 1056004
      call $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E
      unreachable
    end
    i32.const 1
    local.get 4
    i32.const 1056020
    call $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E
    unreachable)
  (func $_ZN3std3env7_var_os17h6273bebb9a87d50dE (type 4) (param i32 i32 i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 416
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          i32.const 383
          i32.gt_u
          br_if 0 (;@3;)
          block  ;; label = @4
            local.get 2
            i32.eqz
            br_if 0 (;@4;)
            local.get 3
            i32.const 20
            i32.add
            local.get 1
            local.get 2
            memory.copy
          end
          local.get 3
          i32.const 20
          i32.add
          local.get 2
          i32.add
          i32.const 0
          i32.store8
          local.get 3
          i32.const 404
          i32.add
          local.get 3
          i32.const 20
          i32.add
          local.get 2
          i32.const 1
          i32.add
          call $_ZN4core3ffi5c_str4CStr19from_bytes_with_nul17h21af397fb9054b6dE
          block  ;; label = @4
            local.get 3
            i32.load offset=404
            i32.const 1
            i32.ne
            br_if 0 (;@4;)
            local.get 3
            i32.const 0
            i64.load offset=1055040
            i64.store offset=12 align=4
            i32.const -2147483647
            local.set 2
            br 2 (;@2;)
          end
          block  ;; label = @4
            local.get 3
            i32.load offset=408
            call $getenv
            local.tee 1
            br_if 0 (;@4;)
            i32.const -2147483648
            local.set 2
            br 2 (;@2;)
          end
          i32.const 0
          local.set 4
          local.get 1
          call $strlen
          local.tee 2
          i32.const 0
          i32.lt_s
          br_if 2 (;@1;)
          block  ;; label = @4
            block  ;; label = @5
              local.get 2
              br_if 0 (;@5;)
              i32.const 1
              local.set 5
              br 1 (;@4;)
            end
            i32.const 0
            i32.load8_u offset=1062189
            drop
            i32.const 1
            local.set 4
            local.get 2
            i32.const 1
            call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
            local.tee 5
            i32.eqz
            br_if 3 (;@1;)
          end
          block  ;; label = @4
            local.get 2
            i32.eqz
            br_if 0 (;@4;)
            local.get 5
            local.get 1
            local.get 2
            memory.copy
          end
          local.get 3
          local.get 2
          i32.store offset=16
          local.get 3
          local.get 5
          i32.store offset=12
          br 1 (;@2;)
        end
        local.get 3
        i32.const 8
        i32.add
        local.get 1
        local.get 2
        call $_ZN3std3sys3pal6common14small_c_string24run_with_cstr_allocating17h67061e2070ad85d1E
        local.get 3
        i32.load offset=8
        local.set 2
      end
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          i32.const -2147483647
          i32.eq
          br_if 0 (;@3;)
          local.get 0
          local.get 3
          i64.load offset=12 align=4
          i64.store offset=4 align=4
          local.get 0
          local.get 2
          i32.store
          br 1 (;@2;)
        end
        block  ;; label = @3
          local.get 3
          i32.load8_u offset=12
          i32.const 3
          i32.ne
          br_if 0 (;@3;)
          local.get 3
          i32.load offset=16
          local.tee 2
          i32.load
          local.set 5
          block  ;; label = @4
            local.get 2
            i32.const 4
            i32.add
            i32.load
            local.tee 1
            i32.load
            local.tee 4
            i32.eqz
            br_if 0 (;@4;)
            local.get 5
            local.get 4
            call_indirect (type 1)
          end
          block  ;; label = @4
            local.get 1
            i32.load offset=4
            local.tee 4
            i32.eqz
            br_if 0 (;@4;)
            local.get 5
            local.get 4
            local.get 1
            i32.load offset=8
            call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
          end
          local.get 2
          i32.const 12
          i32.const 4
          call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        end
        local.get 0
        i32.const -2147483648
        i32.store
      end
      local.get 3
      i32.const 416
      i32.add
      global.set $__stack_pointer
      return
    end
    local.get 4
    local.get 2
    i32.const 1052996
    call $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E
    unreachable)
  (func $_ZN3std3sys3pal6common14small_c_string24run_with_cstr_allocating17h67061e2070ad85d1E (type 4) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    local.get 1
    local.get 2
    call $_ZN72_$LT$$RF$str$u20$as$u20$alloc..ffi..c_str..CString..new..SpecNewImpl$GT$13spec_new_impl17he8931c3ef0642905E
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          i32.load
          local.tee 2
          i32.const -2147483648
          i32.ne
          br_if 0 (;@3;)
          local.get 3
          i32.load offset=8
          local.set 1
          block  ;; label = @4
            block  ;; label = @5
              local.get 3
              i32.load offset=4
              local.tee 4
              call $getenv
              local.tee 5
              br_if 0 (;@5;)
              local.get 0
              i32.const -2147483648
              i32.store
              br 1 (;@4;)
            end
            i32.const 0
            local.set 6
            local.get 5
            call $strlen
            local.tee 2
            i32.const 0
            i32.lt_s
            br_if 3 (;@1;)
            block  ;; label = @5
              block  ;; label = @6
                local.get 2
                br_if 0 (;@6;)
                i32.const 1
                local.set 7
                br 1 (;@5;)
              end
              i32.const 0
              i32.load8_u offset=1062189
              drop
              i32.const 1
              local.set 6
              local.get 2
              i32.const 1
              call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
              local.tee 7
              i32.eqz
              br_if 4 (;@1;)
            end
            block  ;; label = @5
              local.get 2
              i32.eqz
              br_if 0 (;@5;)
              local.get 7
              local.get 5
              local.get 2
              memory.copy
            end
            local.get 0
            local.get 2
            i32.store offset=8
            local.get 0
            local.get 7
            i32.store offset=4
            local.get 0
            local.get 2
            i32.store
          end
          local.get 4
          i32.const 0
          i32.store8
          local.get 1
          i32.eqz
          br_if 1 (;@2;)
          local.get 4
          local.get 1
          i32.const 1
          call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
          br 1 (;@2;)
        end
        local.get 0
        i32.const -2147483647
        i32.store
        local.get 0
        i32.const 0
        i64.load offset=1055040
        i64.store offset=4 align=4
        local.get 2
        i32.eqz
        br_if 0 (;@2;)
        local.get 3
        i32.load offset=4
        local.get 2
        i32.const 1
        call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
      end
      local.get 3
      i32.const 16
      i32.add
      global.set $__stack_pointer
      return
    end
    local.get 6
    local.get 2
    i32.const 1052996
    call $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E
    unreachable)
  (func $_ZN3std2io8buffered9bufwriter18BufWriter$LT$W$GT$14write_all_cold17hbec3c57489ed568fE (type 7) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i64 i64)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 4
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 3
            local.get 1
            i32.load
            local.tee 5
            local.get 1
            i32.load offset=8
            local.tee 6
            i32.sub
            i32.le_u
            br_if 0 (;@4;)
            block  ;; label = @5
              local.get 6
              br_if 0 (;@5;)
              i32.const 0
              local.set 6
              br 1 (;@4;)
            end
            local.get 1
            i32.load offset=4
            local.set 7
            i32.const 0
            local.set 8
            loop  ;; label = @5
              local.get 4
              local.get 6
              local.get 8
              i32.sub
              local.tee 9
              i32.store offset=4
              local.get 4
              local.get 7
              local.get 8
              i32.add
              local.tee 10
              i32.store
              local.get 4
              i32.const 8
              i32.add
              i32.const 1
              local.get 4
              i32.const 1
              call $_ZN4wasi13lib_generated8fd_write17h8e36e57726d845e0E
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        local.get 4
                        i32.load16_u offset=8
                        i32.const 1
                        i32.ne
                        br_if 0 (;@10;)
                        local.get 9
                        local.set 11
                        local.get 4
                        i32.load16_u offset=10
                        local.tee 12
                        i32.const 8
                        i32.eq
                        br_if 1 (;@9;)
                        local.get 1
                        i32.const 0
                        i32.store8 offset=12
                        local.get 12
                        i32.const 27
                        i32.eq
                        br_if 4 (;@6;)
                        local.get 12
                        i64.extend_i32_u
                        i64.const 32
                        i64.shl
                        local.set 13
                        br 2 (;@8;)
                      end
                      local.get 4
                      i32.load offset=12
                      local.set 11
                    end
                    local.get 1
                    i32.const 0
                    i32.store8 offset=12
                    local.get 11
                    br_if 1 (;@7;)
                    i32.const 1053256
                    i64.extend_i32_u
                    i64.const 32
                    i64.shl
                    i64.const 2
                    i64.or
                    local.set 13
                  end
                  block  ;; label = @8
                    local.get 8
                    i32.eqz
                    br_if 0 (;@8;)
                    block  ;; label = @9
                      local.get 9
                      i32.eqz
                      br_if 0 (;@9;)
                      local.get 7
                      local.get 10
                      local.get 9
                      memory.copy
                    end
                    local.get 1
                    local.get 9
                    i32.store offset=8
                    local.get 9
                    local.set 6
                  end
                  local.get 13
                  i64.const 255
                  i64.and
                  i64.const 4
                  i64.eq
                  br_if 3 (;@4;)
                  local.get 0
                  local.get 13
                  i64.store align=4
                  br 4 (;@3;)
                end
                local.get 11
                local.get 8
                i32.add
                local.set 8
              end
              local.get 8
              local.get 6
              i32.lt_u
              br_if 0 (;@5;)
            end
            local.get 8
            local.get 6
            i32.gt_u
            br_if 2 (;@2;)
            i32.const 0
            local.set 6
            local.get 1
            i32.const 0
            i32.store offset=8
          end
          block  ;; label = @4
            local.get 3
            local.get 5
            i32.ge_u
            br_if 0 (;@4;)
            block  ;; label = @5
              local.get 3
              i32.eqz
              br_if 0 (;@5;)
              local.get 1
              i32.load offset=4
              local.get 6
              i32.add
              local.get 2
              local.get 3
              memory.copy
            end
            local.get 0
            i32.const 4
            i32.store8
            local.get 1
            local.get 6
            local.get 3
            i32.add
            i32.store offset=8
            br 1 (;@3;)
          end
          i64.const 0
          local.set 14
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 3
                  i32.eqz
                  br_if 0 (;@7;)
                  loop  ;; label = @8
                    local.get 4
                    local.get 3
                    i32.store offset=4
                    local.get 4
                    local.get 2
                    i32.store
                    local.get 4
                    i32.const 8
                    i32.add
                    i32.const 1
                    local.get 4
                    i32.const 1
                    call $_ZN4wasi13lib_generated8fd_write17h8e36e57726d845e0E
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            local.get 4
                            i32.load16_u offset=8
                            i32.const 1
                            i32.ne
                            br_if 0 (;@12;)
                            local.get 4
                            i64.load16_u offset=10
                            local.tee 13
                            i64.const 27
                            i64.eq
                            br_if 3 (;@9;)
                            local.get 13
                            i64.const 32
                            i64.shl
                            local.set 13
                            br 1 (;@11;)
                          end
                          local.get 4
                          i32.load offset=12
                          local.tee 8
                          br_if 1 (;@10;)
                          i32.const 0
                          i64.load offset=1053440
                          local.set 13
                        end
                        local.get 13
                        i64.const 32
                        i64.shr_u
                        local.set 14
                        local.get 13
                        i32.wrap_i64
                        i32.const 255
                        i32.and
                        local.tee 8
                        i32.const 4
                        i32.eq
                        br_if 4 (;@6;)
                        local.get 8
                        br_if 5 (;@5;)
                        local.get 14
                        i64.const 8
                        i64.ne
                        br_if 5 (;@5;)
                        i64.const 4
                        local.set 14
                        i64.const 0
                        local.set 13
                        br 6 (;@4;)
                      end
                      local.get 3
                      local.get 8
                      i32.lt_u
                      br_if 8 (;@1;)
                      local.get 2
                      local.get 8
                      i32.add
                      local.set 2
                      local.get 3
                      local.get 8
                      i32.sub
                      local.set 3
                    end
                    local.get 3
                    br_if 0 (;@8;)
                  end
                end
                i64.const 0
                local.set 13
              end
              local.get 13
              i64.const 4294967040
              i64.and
              local.get 14
              i64.const 32
              i64.shl
              i64.or
              local.set 13
              i64.const 4
              local.set 14
              br 1 (;@4;)
            end
            local.get 13
            i64.const 255
            i64.and
            local.set 14
            local.get 13
            i64.const -256
            i64.and
            local.set 13
          end
          local.get 1
          i32.const 0
          i32.store8 offset=12
          local.get 0
          local.get 14
          local.get 13
          i64.or
          i64.store align=4
        end
        local.get 4
        i32.const 16
        i32.add
        global.set $__stack_pointer
        return
      end
      local.get 8
      local.get 6
      i32.const 1052592
      call $_ZN4core5slice5index24slice_end_index_len_fail17hc7943372990115c8E
      unreachable
    end
    local.get 8
    local.get 3
    i32.const 1054688
    call $_ZN4core5slice5index26slice_start_index_len_fail17hcb91b9a11352b54bE
    unreachable)
  (func $_ZN3std3sys3pal4wasi2os12error_string17h5dc9a2a2e621b569E (type 6) (param i32 i32)
    (local i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 1056
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      i32.const 1024
      i32.eqz
      br_if 0 (;@1;)
      local.get 2
      i32.const 0
      i32.const 1024
      memory.fill
    end
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          local.get 2
          i32.const 1024
          call $strerror_r
          i32.const 0
          i32.lt_s
          br_if 0 (;@3;)
          local.get 2
          i32.const 1024
          i32.add
          local.get 2
          local.get 2
          call $strlen
          call $_ZN4core3str8converts9from_utf817hb5c7d3e2ee61e867E
          local.get 2
          i32.load offset=1024
          br_if 1 (;@2;)
          i32.const 0
          local.set 3
          local.get 2
          i32.load offset=1032
          local.tee 1
          i32.const 0
          i32.lt_s
          br_if 2 (;@1;)
          local.get 2
          i32.load offset=1028
          local.set 4
          block  ;; label = @4
            block  ;; label = @5
              local.get 1
              br_if 0 (;@5;)
              i32.const 1
              local.set 5
              br 1 (;@4;)
            end
            i32.const 0
            i32.load8_u offset=1062189
            drop
            i32.const 1
            local.set 3
            local.get 1
            i32.const 1
            call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
            local.tee 5
            i32.eqz
            br_if 3 (;@1;)
          end
          block  ;; label = @4
            local.get 1
            i32.eqz
            br_if 0 (;@4;)
            local.get 5
            local.get 4
            local.get 1
            memory.copy
          end
          local.get 0
          local.get 1
          i32.store offset=8
          local.get 0
          local.get 5
          i32.store offset=4
          local.get 0
          local.get 1
          i32.store
          local.get 2
          i32.const 1056
          i32.add
          global.set $__stack_pointer
          return
        end
        local.get 2
        i32.const 0
        i32.store offset=1040
        local.get 2
        i32.const 1
        i32.store offset=1028
        local.get 2
        i32.const 1055980
        i32.store offset=1024
        local.get 2
        i64.const 4
        i64.store offset=1032 align=4
        local.get 2
        i32.const 1024
        i32.add
        i32.const 1055988
        call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
        unreachable
      end
      local.get 2
      local.get 2
      i64.load offset=1028 align=4
      i64.store offset=1048
      i32.const 1053178
      i32.const 43
      local.get 2
      i32.const 1048
      i32.add
      i32.const 1055892
      i32.const 1055944
      call $_ZN4core6result13unwrap_failed17h398ddd55d54bb216E
      unreachable
    end
    local.get 3
    local.get 1
    i32.const 1052996
    call $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E
    unreachable)
  (func $_ZN60_$LT$std..io..error..Error$u20$as$u20$core..fmt..Display$GT$3fmt17h2ced7ae1889d6455E (type 2) (param i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 64
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 0
              i32.load8_u
              br_table 0 (;@5;) 1 (;@4;) 2 (;@3;) 3 (;@2;) 0 (;@5;)
            end
            local.get 2
            local.get 0
            i32.load offset=4
            local.tee 0
            i32.store offset=4
            local.get 2
            i32.const 8
            i32.add
            local.get 0
            call $_ZN3std3sys3pal4wasi2os12error_string17h5dc9a2a2e621b569E
            local.get 2
            i32.const 3
            i32.store offset=44
            local.get 2
            i32.const 1054212
            i32.store offset=40
            local.get 2
            i64.const 2
            i64.store offset=52 align=4
            local.get 2
            i32.const 14
            i64.extend_i32_u
            i64.const 32
            i64.shl
            local.get 2
            i32.const 4
            i32.add
            i64.extend_i32_u
            i64.or
            i64.store offset=32
            local.get 2
            i32.const 15
            i64.extend_i32_u
            i64.const 32
            i64.shl
            local.get 2
            i32.const 8
            i32.add
            i64.extend_i32_u
            i64.or
            i64.store offset=24
            local.get 2
            local.get 2
            i32.const 24
            i32.add
            i32.store offset=48
            local.get 1
            i32.load
            local.get 1
            i32.load offset=4
            local.get 2
            i32.const 40
            i32.add
            call $_ZN4core3fmt5write17hb4e267bf92503392E
            local.set 0
            local.get 2
            i32.load offset=8
            local.tee 1
            i32.eqz
            br_if 3 (;@1;)
            local.get 2
            i32.load offset=12
            local.get 1
            i32.const 1
            call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
            br 3 (;@1;)
          end
          local.get 0
          i32.load8_u offset=1
          local.set 0
          local.get 2
          i32.const 1
          i32.store offset=44
          local.get 2
          i32.const 1053308
          i32.store offset=40
          local.get 2
          i64.const 1
          i64.store offset=52 align=4
          local.get 2
          i32.const 12
          i64.extend_i32_u
          i64.const 32
          i64.shl
          local.get 2
          i32.const 24
          i32.add
          i64.extend_i32_u
          i64.or
          i64.store offset=8
          local.get 2
          local.get 0
          i32.const 2
          i32.shl
          local.tee 0
          i32.const 1056224
          i32.add
          i32.load
          i32.store offset=28
          local.get 2
          local.get 0
          i32.const 1056392
          i32.add
          i32.load
          i32.store offset=24
          local.get 2
          local.get 2
          i32.const 8
          i32.add
          i32.store offset=48
          local.get 1
          i32.load
          local.get 1
          i32.load offset=4
          local.get 2
          i32.const 40
          i32.add
          call $_ZN4core3fmt5write17hb4e267bf92503392E
          local.set 0
          br 2 (;@1;)
        end
        local.get 0
        i32.load offset=4
        local.tee 0
        i32.load
        local.get 0
        i32.load offset=4
        local.get 1
        call $_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17hf7f012776df7e14cE
        local.set 0
        br 1 (;@1;)
      end
      local.get 0
      i32.load offset=4
      local.tee 0
      i32.load
      local.get 1
      local.get 0
      i32.load offset=4
      i32.load offset=16
      call_indirect (type 2)
      local.set 0
    end
    local.get 2
    i32.const 64
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$5write17hb9727852f7c84a6aE (type 7) (param i32 i32 i32 i32)
    (local i32)
    block  ;; label = @1
      local.get 3
      local.get 1
      i32.load
      local.get 1
      i32.load offset=8
      local.tee 4
      i32.sub
      i32.le_u
      br_if 0 (;@1;)
      local.get 1
      local.get 4
      local.get 3
      i32.const 1
      i32.const 1
      call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hf4e8ee5cbddfee98E
      local.get 1
      i32.load offset=8
      local.set 4
    end
    block  ;; label = @1
      local.get 3
      i32.eqz
      br_if 0 (;@1;)
      local.get 1
      i32.load offset=4
      local.get 4
      i32.add
      local.get 2
      local.get 3
      memory.copy
    end
    local.get 0
    local.get 3
    i32.store offset=4
    local.get 1
    local.get 4
    local.get 3
    i32.add
    i32.store offset=8
    local.get 0
    i32.const 4
    i32.store8)
  (func $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$14write_vectored17h0846ae4dacdce16fE (type 7) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 3
        br_if 0 (;@2;)
        i32.const 0
        local.set 4
        br 1 (;@1;)
      end
      local.get 3
      i32.const 3
      i32.and
      local.set 5
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          i32.const 4
          i32.ge_u
          br_if 0 (;@3;)
          i32.const 0
          local.set 4
          i32.const 0
          local.set 6
          br 1 (;@2;)
        end
        local.get 2
        i32.const 28
        i32.add
        local.set 7
        local.get 3
        i32.const -4
        i32.and
        local.set 8
        i32.const 0
        local.set 4
        i32.const 0
        local.set 6
        loop  ;; label = @3
          local.get 7
          i32.load
          local.get 7
          i32.const -8
          i32.add
          i32.load
          local.get 7
          i32.const -16
          i32.add
          i32.load
          local.get 7
          i32.const -24
          i32.add
          i32.load
          local.get 4
          i32.add
          i32.add
          i32.add
          i32.add
          local.set 4
          local.get 7
          i32.const 32
          i32.add
          local.set 7
          local.get 8
          local.get 6
          i32.const 4
          i32.add
          local.tee 6
          i32.ne
          br_if 0 (;@3;)
        end
      end
      block  ;; label = @2
        local.get 5
        i32.eqz
        br_if 0 (;@2;)
        local.get 6
        i32.const 3
        i32.shl
        local.get 2
        i32.add
        i32.const 4
        i32.add
        local.set 7
        loop  ;; label = @3
          local.get 7
          i32.load
          local.get 4
          i32.add
          local.set 4
          local.get 7
          i32.const 8
          i32.add
          local.set 7
          local.get 5
          i32.const -1
          i32.add
          local.tee 5
          br_if 0 (;@3;)
        end
      end
      local.get 3
      i32.const 3
      i32.shl
      local.set 7
      block  ;; label = @2
        local.get 4
        local.get 1
        i32.load
        local.get 1
        i32.load offset=8
        local.tee 5
        i32.sub
        i32.le_u
        br_if 0 (;@2;)
        local.get 1
        local.get 5
        local.get 4
        i32.const 1
        i32.const 1
        call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hf4e8ee5cbddfee98E
      end
      local.get 2
      local.get 7
      i32.add
      local.set 8
      local.get 1
      i32.load offset=8
      local.set 7
      loop  ;; label = @2
        local.get 2
        i32.load
        local.set 6
        block  ;; label = @3
          local.get 2
          i32.const 4
          i32.add
          i32.load
          local.tee 5
          local.get 1
          i32.load
          local.get 7
          i32.sub
          i32.le_u
          br_if 0 (;@3;)
          local.get 1
          local.get 7
          local.get 5
          i32.const 1
          i32.const 1
          call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hf4e8ee5cbddfee98E
          local.get 1
          i32.load offset=8
          local.set 7
        end
        block  ;; label = @3
          local.get 5
          i32.eqz
          br_if 0 (;@3;)
          local.get 1
          i32.load offset=4
          local.get 7
          i32.add
          local.get 6
          local.get 5
          memory.copy
        end
        local.get 1
        local.get 7
        local.get 5
        i32.add
        local.tee 7
        i32.store offset=8
        local.get 2
        i32.const 8
        i32.add
        local.tee 2
        local.get 8
        i32.ne
        br_if 0 (;@2;)
      end
    end
    local.get 0
    i32.const 4
    i32.store8
    local.get 0
    local.get 4
    i32.store offset=4)
  (func $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$17is_write_vectored17h85ccc55a9e1850d4E (type 3) (param i32) (result i32)
    i32.const 1)
  (func $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$9write_all17h6bed96dfd3f6d961E (type 7) (param i32 i32 i32 i32)
    (local i32)
    block  ;; label = @1
      local.get 3
      local.get 1
      i32.load
      local.get 1
      i32.load offset=8
      local.tee 4
      i32.sub
      i32.le_u
      br_if 0 (;@1;)
      local.get 1
      local.get 4
      local.get 3
      i32.const 1
      i32.const 1
      call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hf4e8ee5cbddfee98E
      local.get 1
      i32.load offset=8
      local.set 4
    end
    block  ;; label = @1
      local.get 3
      i32.eqz
      br_if 0 (;@1;)
      local.get 1
      i32.load offset=4
      local.get 4
      i32.add
      local.get 2
      local.get 3
      memory.copy
    end
    local.get 0
    i32.const 4
    i32.store8
    local.get 1
    local.get 4
    local.get 3
    i32.add
    i32.store offset=8)
  (func $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$18write_all_vectored17ha48943a12795c360E (type 7) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32)
    block  ;; label = @1
      local.get 3
      i32.eqz
      br_if 0 (;@1;)
      local.get 3
      i32.const 3
      i32.and
      local.set 4
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          i32.const 4
          i32.ge_u
          br_if 0 (;@3;)
          i32.const 0
          local.set 5
          i32.const 0
          local.set 6
          br 1 (;@2;)
        end
        local.get 2
        i32.const 28
        i32.add
        local.set 7
        local.get 3
        i32.const -4
        i32.and
        local.set 8
        i32.const 0
        local.set 5
        i32.const 0
        local.set 6
        loop  ;; label = @3
          local.get 7
          i32.load
          local.get 7
          i32.const -8
          i32.add
          i32.load
          local.get 7
          i32.const -16
          i32.add
          i32.load
          local.get 7
          i32.const -24
          i32.add
          i32.load
          local.get 5
          i32.add
          i32.add
          i32.add
          i32.add
          local.set 5
          local.get 7
          i32.const 32
          i32.add
          local.set 7
          local.get 8
          local.get 6
          i32.const 4
          i32.add
          local.tee 6
          i32.ne
          br_if 0 (;@3;)
        end
      end
      block  ;; label = @2
        local.get 4
        i32.eqz
        br_if 0 (;@2;)
        local.get 6
        i32.const 3
        i32.shl
        local.get 2
        i32.add
        i32.const 4
        i32.add
        local.set 7
        loop  ;; label = @3
          local.get 7
          i32.load
          local.get 5
          i32.add
          local.set 5
          local.get 7
          i32.const 8
          i32.add
          local.set 7
          local.get 4
          i32.const -1
          i32.add
          local.tee 4
          br_if 0 (;@3;)
        end
      end
      local.get 3
      i32.const 3
      i32.shl
      local.set 4
      block  ;; label = @2
        local.get 5
        local.get 1
        i32.load
        local.get 1
        i32.load offset=8
        local.tee 7
        i32.sub
        i32.le_u
        br_if 0 (;@2;)
        local.get 1
        local.get 7
        local.get 5
        i32.const 1
        i32.const 1
        call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hf4e8ee5cbddfee98E
        local.get 1
        i32.load offset=8
        local.set 7
      end
      local.get 2
      local.get 4
      i32.add
      local.set 6
      loop  ;; label = @2
        local.get 2
        i32.load
        local.set 4
        block  ;; label = @3
          local.get 2
          i32.const 4
          i32.add
          i32.load
          local.tee 5
          local.get 1
          i32.load
          local.get 7
          i32.sub
          i32.le_u
          br_if 0 (;@3;)
          local.get 1
          local.get 7
          local.get 5
          i32.const 1
          i32.const 1
          call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hf4e8ee5cbddfee98E
          local.get 1
          i32.load offset=8
          local.set 7
        end
        block  ;; label = @3
          local.get 5
          i32.eqz
          br_if 0 (;@3;)
          local.get 1
          i32.load offset=4
          local.get 7
          i32.add
          local.get 4
          local.get 5
          memory.copy
        end
        local.get 1
        local.get 7
        local.get 5
        i32.add
        local.tee 7
        i32.store offset=8
        local.get 2
        i32.const 8
        i32.add
        local.tee 2
        local.get 6
        i32.ne
        br_if 0 (;@2;)
      end
    end
    local.get 0
    i32.const 4
    i32.store8)
  (func $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$5flush17h1f2dc7de04349823E (type 6) (param i32 i32)
    local.get 0
    i32.const 4
    i32.store8)
  (func $_ZN3std2io5Write18write_all_vectored17h0a60c130116d5293E (type 7) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32 i64 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 4
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 3
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        i32.const 4
        i32.add
        local.set 5
        local.get 3
        i32.const 3
        i32.shl
        local.set 6
        local.get 3
        i32.const -1
        i32.add
        i32.const 536870911
        i32.and
        i32.const 1
        i32.add
        local.set 7
        i32.const 0
        local.set 8
        block  ;; label = @3
          loop  ;; label = @4
            local.get 5
            i32.load
            br_if 1 (;@3;)
            local.get 5
            i32.const 8
            i32.add
            local.set 5
            local.get 8
            i32.const 1
            i32.add
            local.set 8
            local.get 6
            i32.const -8
            i32.add
            local.tee 6
            br_if 0 (;@4;)
          end
          local.get 7
          local.set 8
        end
        block  ;; label = @3
          local.get 3
          local.get 8
          i32.lt_u
          br_if 0 (;@3;)
          local.get 3
          local.get 8
          i32.eq
          br_if 1 (;@2;)
          local.get 3
          local.get 8
          i32.sub
          local.set 7
          local.get 2
          local.get 8
          i32.const 3
          i32.shl
          i32.add
          local.set 9
          block  ;; label = @4
            loop  ;; label = @5
              local.get 4
              i32.const 8
              i32.add
              i32.const 2
              local.get 9
              local.get 7
              call $_ZN4wasi13lib_generated8fd_write17h8e36e57726d845e0E
              block  ;; label = @6
                local.get 4
                i32.load16_u offset=8
                i32.eqz
                br_if 0 (;@6;)
                local.get 4
                i64.load16_u offset=10
                local.tee 10
                i64.const 27
                i64.eq
                br_if 1 (;@5;)
                local.get 0
                local.get 10
                i64.const 32
                i64.shl
                i64.store align=4
                br 5 (;@1;)
              end
              block  ;; label = @6
                local.get 4
                i32.load offset=12
                local.tee 5
                br_if 0 (;@6;)
                local.get 0
                i32.const 0
                i64.load offset=1053440
                i64.store align=4
                br 5 (;@1;)
              end
              local.get 9
              i32.const 4
              i32.add
              local.set 8
              local.get 7
              i32.const 3
              i32.shl
              local.set 3
              local.get 7
              i32.const -1
              i32.add
              i32.const 536870911
              i32.and
              i32.const 1
              i32.add
              local.set 11
              i32.const 0
              local.set 6
              block  ;; label = @6
                loop  ;; label = @7
                  local.get 5
                  local.get 8
                  i32.load
                  local.tee 2
                  i32.lt_u
                  br_if 1 (;@6;)
                  local.get 8
                  i32.const 8
                  i32.add
                  local.set 8
                  local.get 6
                  i32.const 1
                  i32.add
                  local.set 6
                  local.get 5
                  local.get 2
                  i32.sub
                  local.set 5
                  local.get 3
                  i32.const -8
                  i32.add
                  local.tee 3
                  br_if 0 (;@7;)
                end
                local.get 11
                local.set 6
              end
              block  ;; label = @6
                local.get 7
                local.get 6
                i32.lt_u
                br_if 0 (;@6;)
                block  ;; label = @7
                  local.get 7
                  local.get 6
                  i32.ne
                  br_if 0 (;@7;)
                  local.get 5
                  i32.eqz
                  br_if 5 (;@2;)
                  local.get 4
                  i32.const 0
                  i32.store offset=24
                  local.get 4
                  i32.const 1
                  i32.store offset=12
                  local.get 4
                  i32.const 1054564
                  i32.store offset=8
                  local.get 4
                  i64.const 4
                  i64.store offset=16 align=4
                  local.get 4
                  i32.const 8
                  i32.add
                  i32.const 1054572
                  call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
                  unreachable
                end
                local.get 9
                local.get 6
                i32.const 3
                i32.shl
                i32.add
                local.tee 9
                i32.load offset=4
                local.tee 8
                local.get 5
                i32.lt_u
                br_if 2 (;@4;)
                local.get 7
                local.get 6
                i32.sub
                local.set 7
                local.get 9
                local.get 8
                local.get 5
                i32.sub
                i32.store offset=4
                local.get 9
                local.get 9
                i32.load
                local.get 5
                i32.add
                i32.store
                br 1 (;@5;)
              end
            end
            local.get 6
            local.get 7
            i32.const 1054508
            call $_ZN4core5slice5index26slice_start_index_len_fail17hcb91b9a11352b54bE
            unreachable
          end
          local.get 4
          i32.const 0
          i32.store offset=24
          local.get 4
          i32.const 1
          i32.store offset=12
          local.get 4
          i32.const 1054624
          i32.store offset=8
          local.get 4
          i64.const 4
          i64.store offset=16 align=4
          local.get 4
          i32.const 8
          i32.add
          i32.const 1054672
          call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
          unreachable
        end
        local.get 8
        local.get 3
        i32.const 1054508
        call $_ZN4core5slice5index26slice_start_index_len_fail17hcb91b9a11352b54bE
        unreachable
      end
      local.get 0
      i32.const 4
      i32.store8
    end
    local.get 4
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN3std4sync9once_lock17OnceLock$LT$T$GT$10initialize17h815954f386348f6fE (type 0)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 0
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            i32.const 0
            i32.load8_u offset=1062232
            br_table 0 (;@4;) 0 (;@4;) 3 (;@1;) 1 (;@3;) 0 (;@4;)
          end
          i32.const 0
          i32.const 2
          i32.store8 offset=1062232
          i32.const 0
          i32.load8_u offset=1062189
          drop
          i32.const 1024
          i32.const 1
          call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
          local.tee 1
          i32.eqz
          br_if 1 (;@2;)
          i32.const 0
          i32.const 3
          i32.store8 offset=1062232
          i32.const 0
          local.get 1
          i32.store offset=1062216
          i32.const 0
          i64.const 4398046511104
          i64.store offset=1062208
          i32.const 0
          i64.const 0
          i64.store offset=1062192
          i32.const 0
          i32.const 0
          i32.store8 offset=1062224
          i32.const 0
          i32.const 0
          i32.store offset=1062220
          i32.const 0
          i32.const 0
          i32.store8 offset=1062204
          i32.const 0
          i32.const 0
          i32.store offset=1062200
        end
        local.get 0
        i32.const 32
        i32.add
        global.set $__stack_pointer
        return
      end
      i32.const 1
      i32.const 1024
      i32.const 1054236
      call $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E
      unreachable
    end
    local.get 0
    i32.const 0
    i32.store offset=24
    local.get 0
    i32.const 1
    i32.store offset=12
    local.get 0
    i32.const 1056144
    i32.store offset=8
    local.get 0
    i64.const 4
    i64.store offset=16 align=4
    local.get 0
    i32.const 8
    i32.add
    i32.const 1054872
    call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
    unreachable)
  (func $_ZN3std2io5stdio6Stderr4lock17hec8a0bceb40939a8E (type 3) (param i32) (result i32)
    (local i32 i32 i64 i64 i64)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    local.get 0
    i32.load
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        i32.const 0
        i64.load offset=1062264
        local.tee 3
        i64.const 0
        i64.ne
        br_if 0 (;@2;)
        i32.const 0
        i64.load offset=1062272
        local.set 4
        loop  ;; label = @3
          local.get 4
          i64.const -1
          i64.eq
          br_if 2 (;@1;)
          i32.const 0
          local.get 4
          i64.const 1
          i64.add
          local.tee 3
          i32.const 0
          i64.load offset=1062272
          local.tee 5
          local.get 5
          local.get 4
          i64.eq
          local.tee 0
          select
          i64.store offset=1062272
          local.get 5
          local.set 4
          local.get 0
          i32.eqz
          br_if 0 (;@3;)
        end
        i32.const 0
        local.get 3
        i64.store offset=1062264
      end
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 3
            local.get 2
            i64.load
            i64.eq
            br_if 0 (;@4;)
            local.get 2
            i32.load8_u offset=12
            local.set 0
            local.get 2
            i32.const 1
            i32.store8 offset=12
            local.get 1
            local.get 0
            i32.store8 offset=7
            local.get 0
            i32.eqz
            br_if 1 (;@3;)
            local.get 1
            i64.const 0
            i64.store offset=20 align=4
            local.get 1
            i64.const 17179869185
            i64.store offset=12 align=4
            local.get 1
            i32.const 1054752
            i32.store offset=8
            i32.const 0
            local.get 1
            i32.const 7
            i32.add
            i32.const 1056220
            local.get 1
            i32.const 8
            i32.add
            i32.const 1054804
            call $_ZN4core9panicking13assert_failed17h837345b905b163c7E
            unreachable
          end
          block  ;; label = @4
            local.get 2
            i32.load offset=8
            local.tee 0
            i32.const -1
            i32.eq
            br_if 0 (;@4;)
            local.get 2
            local.get 0
            i32.const 1
            i32.add
            i32.store offset=8
            br 2 (;@2;)
          end
          i32.const 1054888
          i32.const 38
          i32.const 1054964
          call $_ZN4core6option13expect_failed17hbb79b61f61810248E
          unreachable
        end
        local.get 2
        i32.const 1
        i32.store offset=8
        local.get 2
        local.get 3
        i64.store
      end
      local.get 1
      i32.const 32
      i32.add
      global.set $__stack_pointer
      local.get 2
      return
    end
    call $_ZN3std6thread8ThreadId3new9exhausted17h79591ad025c79bdcE
    unreachable)
  (func $_ZN61_$LT$$RF$std..io..stdio..Stdout$u20$as$u20$std..io..Write$GT$9write_fmt17h5601bb8d8f2c55b4E (type 4) (param i32 i32 i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    local.get 1
    i32.load
    call $_ZN3std2io5stdio6Stderr4lock17hec8a0bceb40939a8E
    i32.store offset=4
    local.get 3
    i32.const 4
    i32.store8 offset=8
    local.get 3
    local.get 3
    i32.const 4
    i32.add
    i32.store offset=16
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          i32.const 8
          i32.add
          i32.const 1052800
          local.get 2
          call $_ZN4core3fmt5write17hb4e267bf92503392E
          i32.eqz
          br_if 0 (;@3;)
          local.get 3
          i32.load8_u offset=8
          i32.const 4
          i32.ne
          br_if 1 (;@2;)
          local.get 3
          i32.const 0
          i32.store offset=40
          local.get 3
          i32.const 1
          i32.store offset=28
          local.get 3
          i32.const 1054484
          i32.store offset=24
          local.get 3
          i64.const 4
          i64.store offset=32 align=4
          local.get 3
          i32.const 24
          i32.add
          i32.const 1054492
          call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
          unreachable
        end
        local.get 0
        i32.const 4
        i32.store8
        local.get 3
        i32.load offset=12
        local.set 2
        block  ;; label = @3
          local.get 3
          i32.load8_u offset=8
          local.tee 1
          i32.const 4
          i32.gt_u
          br_if 0 (;@3;)
          local.get 1
          i32.const 3
          i32.ne
          br_if 2 (;@1;)
        end
        local.get 2
        i32.load
        local.set 0
        block  ;; label = @3
          local.get 2
          i32.const 4
          i32.add
          i32.load
          local.tee 1
          i32.load
          local.tee 4
          i32.eqz
          br_if 0 (;@3;)
          local.get 0
          local.get 4
          call_indirect (type 1)
        end
        block  ;; label = @3
          local.get 1
          i32.load offset=4
          local.tee 4
          i32.eqz
          br_if 0 (;@3;)
          local.get 0
          local.get 4
          local.get 1
          i32.load offset=8
          call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        end
        local.get 2
        i32.const 12
        i32.const 4
        call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        br 1 (;@1;)
      end
      local.get 0
      local.get 3
      i64.load offset=8
      i64.store align=4
    end
    local.get 3
    i32.load offset=4
    local.tee 1
    local.get 1
    i32.load offset=8
    i32.const -1
    i32.add
    local.tee 2
    i32.store offset=8
    block  ;; label = @1
      local.get 2
      br_if 0 (;@1;)
      local.get 1
      i32.const 0
      i32.store8 offset=12
      local.get 1
      i64.const 0
      i64.store
    end
    local.get 3
    i32.const 48
    i32.add
    global.set $__stack_pointer)
  (func $_ZN3std2io5stdio31print_to_buffer_if_capture_used17h2fee8f57ff6b00a0E (type 3) (param i32) (result i32)
    (local i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    i32.const 0
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        i32.const 0
        i32.load8_u offset=1062191
        i32.eqz
        br_if 0 (;@2;)
        i32.const 0
        local.set 2
        i32.const 0
        i32.load offset=1062296
        local.set 3
        i32.const 0
        i32.const 0
        i32.store offset=1062296
        local.get 3
        i32.eqz
        br_if 0 (;@2;)
        local.get 3
        i32.load8_u offset=8
        local.set 2
        local.get 3
        i32.const 1
        i32.store8 offset=8
        local.get 1
        local.get 2
        i32.store8 offset=7
        local.get 2
        i32.const 1
        i32.eq
        br_if 1 (;@1;)
        local.get 1
        i32.const 8
        i32.add
        local.get 3
        i32.const 12
        i32.add
        local.get 0
        call $_ZN3std2io5Write9write_fmt17h35f31b561ea91fb1E
        local.get 1
        i32.load offset=12
        local.set 0
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            i32.load8_u offset=8
            local.tee 2
            i32.const 4
            i32.gt_u
            br_if 0 (;@4;)
            local.get 2
            i32.const 3
            i32.ne
            br_if 1 (;@3;)
          end
          local.get 0
          i32.load
          local.set 4
          block  ;; label = @4
            local.get 0
            i32.const 4
            i32.add
            i32.load
            local.tee 2
            i32.load
            local.tee 5
            i32.eqz
            br_if 0 (;@4;)
            local.get 4
            local.get 5
            call_indirect (type 1)
          end
          block  ;; label = @4
            local.get 2
            i32.load offset=4
            local.tee 5
            i32.eqz
            br_if 0 (;@4;)
            local.get 4
            local.get 5
            local.get 2
            i32.load offset=8
            call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
          end
          local.get 0
          i32.const 12
          i32.const 4
          call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        end
        local.get 3
        i32.const 0
        i32.store8 offset=8
        i32.const 0
        i32.load offset=1062296
        local.set 2
        i32.const 0
        local.get 3
        i32.store offset=1062296
        local.get 1
        local.get 2
        i32.store offset=8
        block  ;; label = @3
          local.get 2
          i32.eqz
          br_if 0 (;@3;)
          local.get 2
          local.get 2
          i32.load
          local.tee 3
          i32.const -1
          i32.add
          i32.store
          local.get 3
          i32.const 1
          i32.ne
          br_if 0 (;@3;)
          local.get 1
          i32.const 8
          i32.add
          call $_ZN5alloc4sync16Arc$LT$T$C$A$GT$9drop_slow17h3073f53b2412ac4bE
        end
        i32.const 1
        local.set 2
      end
      local.get 1
      i32.const 32
      i32.add
      global.set $__stack_pointer
      local.get 2
      return
    end
    local.get 1
    i64.const 0
    i64.store offset=20 align=4
    local.get 1
    i64.const 17179869185
    i64.store offset=12 align=4
    local.get 1
    i32.const 1054752
    i32.store offset=8
    i32.const 0
    local.get 1
    i32.const 7
    i32.add
    i32.const 1056220
    local.get 1
    i32.const 8
    i32.add
    i32.const 1054804
    call $_ZN4core9panicking13assert_failed17h837345b905b163c7E
    unreachable)
  (func $_ZN3std2io5Write9write_fmt17h35f31b561ea91fb1E (type 4) (param i32 i32 i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    i32.const 4
    i32.store8 offset=8
    local.get 3
    local.get 1
    i32.store offset=16
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          i32.const 8
          i32.add
          i32.const 1052848
          local.get 2
          call $_ZN4core3fmt5write17hb4e267bf92503392E
          i32.eqz
          br_if 0 (;@3;)
          local.get 3
          i32.load8_u offset=8
          i32.const 4
          i32.ne
          br_if 1 (;@2;)
          local.get 3
          i32.const 0
          i32.store offset=40
          local.get 3
          i32.const 1
          i32.store offset=28
          local.get 3
          i32.const 1054484
          i32.store offset=24
          local.get 3
          i64.const 4
          i64.store offset=32 align=4
          local.get 3
          i32.const 24
          i32.add
          i32.const 1054492
          call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
          unreachable
        end
        local.get 0
        i32.const 4
        i32.store8
        local.get 3
        i32.load offset=12
        local.set 2
        block  ;; label = @3
          local.get 3
          i32.load8_u offset=8
          local.tee 1
          i32.const 4
          i32.gt_u
          br_if 0 (;@3;)
          local.get 1
          i32.const 3
          i32.ne
          br_if 2 (;@1;)
        end
        local.get 2
        i32.load
        local.set 0
        block  ;; label = @3
          local.get 2
          i32.const 4
          i32.add
          i32.load
          local.tee 1
          i32.load
          local.tee 4
          i32.eqz
          br_if 0 (;@3;)
          local.get 0
          local.get 4
          call_indirect (type 1)
        end
        block  ;; label = @3
          local.get 1
          i32.load offset=4
          local.tee 4
          i32.eqz
          br_if 0 (;@3;)
          local.get 0
          local.get 4
          local.get 1
          i32.load offset=8
          call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        end
        local.get 2
        i32.const 12
        i32.const 4
        call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        br 1 (;@1;)
      end
      local.get 0
      local.get 3
      i64.load offset=8
      i64.store align=4
    end
    local.get 3
    i32.const 48
    i32.add
    global.set $__stack_pointer)
  (func $_ZN3std2io5stdio6_print17h113dc87389378e4fE (type 1) (param i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 80
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    local.get 1
    i32.const 6
    i32.store offset=12
    local.get 1
    i32.const 1054364
    i32.store offset=8
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        call $_ZN3std2io5stdio31print_to_buffer_if_capture_used17h2fee8f57ff6b00a0E
        br_if 0 (;@2;)
        block  ;; label = @3
          i32.const 0
          i32.load8_u offset=1062232
          i32.const 3
          i32.eq
          br_if 0 (;@3;)
          call $_ZN3std4sync9once_lock17OnceLock$LT$T$GT$10initialize17h815954f386348f6fE
        end
        local.get 1
        i32.const 1062192
        i32.store offset=28
        local.get 1
        local.get 1
        i32.const 28
        i32.add
        i32.store offset=40
        local.get 1
        i32.const 16
        i32.add
        local.get 1
        i32.const 40
        i32.add
        local.get 0
        call $_ZN61_$LT$$RF$std..io..stdio..Stdout$u20$as$u20$std..io..Write$GT$9write_fmt17h5601bb8d8f2c55b4E
        local.get 1
        i32.load8_u offset=16
        i32.const 4
        i32.ne
        br_if 1 (;@1;)
      end
      local.get 1
      i32.const 80
      i32.add
      global.set $__stack_pointer
      return
    end
    local.get 1
    local.get 1
    i64.load offset=16
    i64.store offset=32
    local.get 1
    i32.const 2
    i32.store offset=44
    local.get 1
    i32.const 1054332
    i32.store offset=40
    local.get 1
    i64.const 2
    i64.store offset=52 align=4
    local.get 1
    i32.const 16
    i64.extend_i32_u
    i64.const 32
    i64.shl
    local.get 1
    i32.const 32
    i32.add
    i64.extend_i32_u
    i64.or
    i64.store offset=72
    local.get 1
    i32.const 12
    i64.extend_i32_u
    i64.const 32
    i64.shl
    local.get 1
    i32.const 8
    i32.add
    i64.extend_i32_u
    i64.or
    i64.store offset=64
    local.get 1
    local.get 1
    i32.const 64
    i32.add
    i32.store offset=48
    local.get 1
    i32.const 40
    i32.add
    i32.const 1054348
    call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
    unreachable)
  (func $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17h6c912057206b6ef0E (type 5) (param i32 i32 i32) (result i32)
    (local i32)
    block  ;; label = @1
      local.get 2
      local.get 0
      i32.load offset=8
      local.tee 0
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
      call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hf4e8ee5cbddfee98E
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
  (func $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17hef3d614a18d92fc0E (type 5) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i64 i32 i32 i64)
    i32.const 0
    local.set 3
    block  ;; label = @1
      i32.const 0
      local.get 0
      i32.load offset=8
      local.tee 4
      i32.load offset=4
      local.tee 5
      local.get 4
      i64.load offset=8
      local.tee 6
      i64.const 4294967295
      local.get 6
      i64.const 4294967295
      i64.lt_u
      select
      i32.wrap_i64
      i32.sub
      local.tee 7
      local.get 7
      local.get 5
      i32.gt_u
      select
      local.tee 7
      local.get 2
      local.get 7
      local.get 2
      i32.lt_u
      select
      local.tee 8
      i32.eqz
      br_if 0 (;@1;)
      local.get 4
      i32.load
      local.get 6
      local.get 5
      i64.extend_i32_u
      local.tee 9
      local.get 6
      local.get 9
      i64.lt_u
      select
      i32.wrap_i64
      i32.add
      local.get 1
      local.get 8
      memory.copy
    end
    local.get 4
    local.get 6
    local.get 8
    i64.extend_i32_u
    i64.add
    i64.store offset=8
    block  ;; label = @1
      local.get 7
      local.get 2
      i32.ge_u
      br_if 0 (;@1;)
      i32.const 0
      local.set 3
      i32.const 0
      i64.load offset=1053440
      local.tee 6
      i64.const 255
      i64.and
      i64.const 4
      i64.eq
      br_if 0 (;@1;)
      local.get 0
      i32.load offset=4
      local.set 4
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          i32.load8_u
          local.tee 2
          i32.const 4
          i32.gt_u
          br_if 0 (;@3;)
          local.get 2
          i32.const 3
          i32.ne
          br_if 1 (;@2;)
        end
        local.get 4
        i32.load
        local.set 7
        block  ;; label = @3
          local.get 4
          i32.const 4
          i32.add
          i32.load
          local.tee 2
          i32.load
          local.tee 3
          i32.eqz
          br_if 0 (;@3;)
          local.get 7
          local.get 3
          call_indirect (type 1)
        end
        block  ;; label = @3
          local.get 2
          i32.load offset=4
          local.tee 3
          i32.eqz
          br_if 0 (;@3;)
          local.get 7
          local.get 3
          local.get 2
          i32.load offset=8
          call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        end
        local.get 4
        i32.const 12
        i32.const 4
        call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
      end
      local.get 0
      local.get 6
      i64.store align=4
      i32.const 1
      local.set 3
    end
    local.get 3)
  (func $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17hffca5ab1aa2ac1e7E (type 5) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    i32.const 8
    i32.add
    local.get 0
    i32.load offset=8
    local.get 1
    local.get 2
    call $_ZN61_$LT$std..io..stdio..StdoutLock$u20$as$u20$std..io..Write$GT$9write_all17he8e1b902282633b2E
    block  ;; label = @1
      local.get 3
      i32.load8_u offset=8
      local.tee 2
      i32.const 4
      i32.eq
      br_if 0 (;@1;)
      local.get 0
      i32.load offset=4
      local.set 4
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          i32.load8_u
          local.tee 1
          i32.const 4
          i32.gt_u
          br_if 0 (;@3;)
          local.get 1
          i32.const 3
          i32.ne
          br_if 1 (;@2;)
        end
        local.get 4
        i32.load
        local.set 5
        block  ;; label = @3
          local.get 4
          i32.const 4
          i32.add
          i32.load
          local.tee 1
          i32.load
          local.tee 6
          i32.eqz
          br_if 0 (;@3;)
          local.get 5
          local.get 6
          call_indirect (type 1)
        end
        block  ;; label = @3
          local.get 1
          i32.load offset=4
          local.tee 6
          i32.eqz
          br_if 0 (;@3;)
          local.get 5
          local.get 6
          local.get 1
          i32.load offset=8
          call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        end
        local.get 4
        i32.const 12
        i32.const 4
        call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
      end
      local.get 0
      local.get 3
      i64.load offset=8
      i64.store align=4
    end
    local.get 3
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 2
    i32.const 4
    i32.ne)
  (func $_ZN3std2io5Write9write_all17h55293c4c3ff1edf7E (type 7) (param i32 i32 i32 i32)
    (local i32 i64 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 4
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          i32.eqz
          br_if 0 (;@3;)
          loop  ;; label = @4
            local.get 4
            local.get 3
            i32.store offset=4
            local.get 4
            local.get 2
            i32.store
            local.get 4
            i32.const 8
            i32.add
            i32.const 2
            local.get 4
            i32.const 1
            call $_ZN4wasi13lib_generated8fd_write17h8e36e57726d845e0E
            block  ;; label = @5
              block  ;; label = @6
                local.get 4
                i32.load16_u offset=8
                i32.eqz
                br_if 0 (;@6;)
                local.get 4
                i64.load16_u offset=10
                local.tee 5
                i64.const 27
                i64.eq
                br_if 1 (;@5;)
                local.get 0
                local.get 5
                i64.const 32
                i64.shl
                i64.store align=4
                br 4 (;@2;)
              end
              block  ;; label = @6
                local.get 4
                i32.load offset=12
                local.tee 6
                br_if 0 (;@6;)
                local.get 0
                i32.const 0
                i64.load offset=1053440
                i64.store align=4
                br 4 (;@2;)
              end
              local.get 3
              local.get 6
              i32.lt_u
              br_if 4 (;@1;)
              local.get 2
              local.get 6
              i32.add
              local.set 2
              local.get 3
              local.get 6
              i32.sub
              local.set 3
            end
            local.get 3
            br_if 0 (;@4;)
          end
        end
        local.get 0
        i32.const 4
        i32.store8
      end
      local.get 4
      i32.const 16
      i32.add
      global.set $__stack_pointer
      return
    end
    local.get 6
    local.get 3
    i32.const 1054688
    call $_ZN4core5slice5index26slice_start_index_len_fail17hcb91b9a11352b54bE
    unreachable)
  (func $_ZN3std2io5Write9write_fmt17h8b2dfcfe3f286d05E (type 4) (param i32 i32 i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    i32.const 4
    i32.store8 offset=8
    local.get 3
    local.get 1
    i32.store offset=16
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          i32.const 8
          i32.add
          i32.const 1052824
          local.get 2
          call $_ZN4core3fmt5write17hb4e267bf92503392E
          i32.eqz
          br_if 0 (;@3;)
          local.get 3
          i32.load8_u offset=8
          i32.const 4
          i32.ne
          br_if 1 (;@2;)
          local.get 3
          i32.const 0
          i32.store offset=40
          local.get 3
          i32.const 1
          i32.store offset=28
          local.get 3
          i32.const 1054484
          i32.store offset=24
          local.get 3
          i64.const 4
          i64.store offset=32 align=4
          local.get 3
          i32.const 24
          i32.add
          i32.const 1054492
          call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
          unreachable
        end
        local.get 0
        i32.const 4
        i32.store8
        local.get 3
        i32.load offset=12
        local.set 2
        block  ;; label = @3
          local.get 3
          i32.load8_u offset=8
          local.tee 1
          i32.const 4
          i32.gt_u
          br_if 0 (;@3;)
          local.get 1
          i32.const 3
          i32.ne
          br_if 2 (;@1;)
        end
        local.get 2
        i32.load
        local.set 0
        block  ;; label = @3
          local.get 2
          i32.const 4
          i32.add
          i32.load
          local.tee 1
          i32.load
          local.tee 4
          i32.eqz
          br_if 0 (;@3;)
          local.get 0
          local.get 4
          call_indirect (type 1)
        end
        block  ;; label = @3
          local.get 1
          i32.load offset=4
          local.tee 4
          i32.eqz
          br_if 0 (;@3;)
          local.get 0
          local.get 4
          local.get 1
          i32.load offset=8
          call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        end
        local.get 2
        i32.const 12
        i32.const 4
        call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        br 1 (;@1;)
      end
      local.get 0
      local.get 3
      i64.load offset=8
      i64.store align=4
    end
    local.get 3
    i32.const 48
    i32.add
    global.set $__stack_pointer)
  (func $_ZN3std5panic19get_backtrace_style17h7d01952034be105fE (type 11) (result i32)
    (local i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 0
    global.set $__stack_pointer
    i32.const 3
    local.set 1
    block  ;; label = @1
      i32.const 0
      i32.load8_u offset=1062240
      i32.const -1
      i32.add
      local.tee 2
      i32.const 255
      i32.and
      i32.const 3
      i32.lt_u
      br_if 0 (;@1;)
      local.get 0
      i32.const 4
      i32.add
      i32.const 1053164
      i32.const 14
      call $_ZN3std3env7_var_os17h6273bebb9a87d50dE
      i32.const 2
      local.set 2
      block  ;; label = @2
        local.get 0
        i32.load offset=4
        local.tee 3
        i32.const -2147483648
        i32.eq
        br_if 0 (;@2;)
        local.get 0
        i32.load offset=8
        local.set 4
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 0
                  i32.load offset=12
                  i32.const -1
                  i32.add
                  br_table 1 (;@6;) 2 (;@5;) 2 (;@5;) 0 (;@7;) 2 (;@5;)
                end
                local.get 4
                i32.load align=1
                i32.const 1819047270
                i32.ne
                br_if 1 (;@5;)
                i32.const 1
                local.set 2
                i32.const 2
                local.set 1
                local.get 3
                br_if 3 (;@3;)
                br 4 (;@2;)
              end
              local.get 4
              i32.load8_u
              i32.const 48
              i32.eq
              br_if 1 (;@4;)
            end
            i32.const 0
            local.set 2
            i32.const 1
            local.set 1
            local.get 3
            i32.eqz
            br_if 2 (;@2;)
            br 1 (;@3;)
          end
          i32.const 2
          local.set 2
          i32.const 3
          local.set 1
          local.get 3
          i32.eqz
          br_if 1 (;@2;)
        end
        local.get 4
        local.get 3
        i32.const 1
        call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
      end
      i32.const 0
      i32.const 0
      i32.load8_u offset=1062240
      local.tee 3
      local.get 1
      local.get 3
      select
      i32.store8 offset=1062240
      local.get 3
      i32.eqz
      br_if 0 (;@1;)
      i32.const 3
      local.set 2
      local.get 3
      i32.const 4
      i32.ge_u
      br_if 0 (;@1;)
      i32.const 33619971
      local.get 3
      i32.const 3
      i32.shl
      i32.const 248
      i32.and
      i32.shr_u
      local.set 2
    end
    local.get 0
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 2)
  (func $_ZN3std7process5abort17hb229e5783e2ded8dE (type 0)
    call $_ZN3std3sys3pal4wasi7helpers14abort_internal17he7a2be67736436b7E
    unreachable)
  (func $_ZN3std4sync9once_lock17OnceLock$LT$T$GT$10initialize17h1e4f1579a1ad7072E (type 1) (param i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          i32.const 0
          i32.load8_u offset=1062232
          br_table 1 (;@2;) 1 (;@2;) 0 (;@3;) 2 (;@1;) 1 (;@2;)
        end
        local.get 1
        i32.const 0
        i32.store offset=24
        local.get 1
        i32.const 1
        i32.store offset=12
        local.get 1
        i32.const 1056144
        i32.store offset=8
        local.get 1
        i64.const 4
        i64.store offset=16 align=4
        local.get 1
        i32.const 8
        i32.add
        i32.const 1054872
        call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
        unreachable
      end
      i32.const 0
      i32.const 3
      i32.store8 offset=1062232
      i32.const 0
      i64.const 1
      i64.store offset=1062216
      i32.const 0
      i64.const 0
      i64.store offset=1062208
      i32.const 0
      i64.const 0
      i64.store offset=1062192
      local.get 0
      i32.const 1
      i32.store8
      i32.const 0
      i32.const 0
      i32.store8 offset=1062224
      i32.const 0
      i32.const 0
      i32.store8 offset=1062204
      i32.const 0
      i32.const 0
      i32.store offset=1062200
    end
    local.get 1
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN3std3sys9backtrace4lock17h8474d9d758c64cbdE (type 11) (result i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 0
    global.set $__stack_pointer
    i32.const 0
    i32.load8_u offset=1062241
    local.set 1
    i32.const 0
    i32.const 1
    i32.store8 offset=1062241
    local.get 0
    local.get 1
    i32.store8 offset=7
    block  ;; label = @1
      local.get 1
      i32.const 1
      i32.ne
      br_if 0 (;@1;)
      local.get 0
      i64.const 0
      i64.store offset=20 align=4
      local.get 0
      i64.const 17179869185
      i64.store offset=12 align=4
      local.get 0
      i32.const 1054752
      i32.store offset=8
      i32.const 0
      local.get 0
      i32.const 7
      i32.add
      i32.const 1056220
      local.get 0
      i32.const 8
      i32.add
      i32.const 1054804
      call $_ZN4core9panicking13assert_failed17h837345b905b163c7E
      unreachable
    end
    local.get 0
    i32.const 32
    i32.add
    global.set $__stack_pointer
    i32.const 1062241)
  (func $_ZN3std3sys9backtrace13BacktraceLock5print17h61f80b5fff84970cE (type 7) (param i32 i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 4
    global.set $__stack_pointer
    local.get 4
    i32.const 1
    i32.store offset=12
    local.get 4
    i32.const 1053308
    i32.store offset=8
    local.get 4
    i64.const 1
    i64.store offset=20 align=4
    local.get 4
    local.get 3
    i32.store8 offset=47
    local.get 4
    i32.const 17
    i64.extend_i32_u
    i64.const 32
    i64.shl
    local.get 4
    i32.const 47
    i32.add
    i64.extend_i32_u
    i64.or
    i64.store offset=32
    local.get 4
    local.get 4
    i32.const 32
    i32.add
    i32.store offset=16
    local.get 0
    local.get 1
    local.get 4
    i32.const 8
    i32.add
    local.get 2
    call_indirect (type 4)
    local.get 4
    i32.const 48
    i32.add
    global.set $__stack_pointer)
  (func $_ZN98_$LT$std..sys..backtrace..BacktraceLock..print..DisplayBacktrace$u20$as$u20$core..fmt..Display$GT$3fmt17h2855f445b96d4beeE (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i64 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 1
    i32.load offset=4
    local.set 3
    local.get 1
    i32.load
    local.set 4
    local.get 0
    i32.load8_u
    local.set 0
    local.get 2
    i32.const 4
    i32.add
    call $_ZN3std3env11current_dir17h4dd17025e6a63360E
    local.get 2
    i64.load offset=8 align=4
    local.set 5
    block  ;; label = @1
      local.get 2
      i32.load offset=4
      local.tee 1
      i32.const -2147483648
      i32.ne
      br_if 0 (;@1;)
      local.get 5
      i64.const 255
      i64.and
      i64.const 3
      i64.ne
      br_if 0 (;@1;)
      local.get 5
      i64.const 32
      i64.shr_u
      i32.wrap_i64
      local.tee 6
      i32.load
      local.set 7
      block  ;; label = @2
        local.get 6
        i32.const 4
        i32.add
        i32.load
        local.tee 8
        i32.load
        local.tee 9
        i32.eqz
        br_if 0 (;@2;)
        local.get 7
        local.get 9
        call_indirect (type 1)
      end
      block  ;; label = @2
        local.get 8
        i32.load offset=4
        local.tee 9
        i32.eqz
        br_if 0 (;@2;)
        local.get 7
        local.get 9
        local.get 8
        i32.load offset=8
        call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
      end
      local.get 6
      i32.const 12
      i32.const 4
      call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
    end
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 4
          i32.const 1055048
          i32.const 17
          local.get 3
          i32.load offset=12
          local.tee 3
          call_indirect (type 5)
          br_if 0 (;@3;)
          block  ;; label = @4
            local.get 0
            i32.const 1
            i32.and
            br_if 0 (;@4;)
            local.get 4
            i32.const 1055065
            i32.const 88
            local.get 3
            call_indirect (type 5)
            br_if 1 (;@3;)
          end
          i32.const 0
          local.set 4
          local.get 1
          i32.const -2147483648
          i32.or
          i32.const -2147483648
          i32.eq
          br_if 2 (;@1;)
          br 1 (;@2;)
        end
        i32.const 1
        local.set 4
        local.get 1
        i32.const -2147483648
        i32.or
        i32.const -2147483648
        i32.eq
        br_if 1 (;@1;)
      end
      local.get 5
      i32.wrap_i64
      local.get 1
      i32.const 1
      call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
    end
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 4)
  (func $_ZN3std3sys9backtrace26__rust_end_short_backtrace17heed88f70267ff169E (type 1) (param i32)
    local.get 0
    call $_ZN3std9panicking19begin_panic_handler28_$u7b$$u7b$closure$u7d$$u7d$17h03e6674a89ab6ac2E
    unreachable)
  (func $_ZN3std9panicking19begin_panic_handler28_$u7b$$u7b$closure$u7d$$u7d$17h03e6674a89ab6ac2E (type 1) (param i32)
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
      i32.const 1055588
      local.get 0
      i32.load offset=4
      local.get 0
      i32.load offset=8
      local.tee 0
      i32.load8_u offset=8
      local.get 0
      i32.load8_u offset=9
      call $_ZN3std9panicking20rust_panic_with_hook17hd6db915a7ab98bd5E
      unreachable
    end
    local.get 1
    local.get 3
    i32.store offset=4
    local.get 1
    local.get 2
    i32.store
    local.get 1
    i32.const 1055560
    local.get 0
    i32.load offset=4
    local.get 0
    i32.load offset=8
    local.tee 0
    i32.load8_u offset=8
    local.get 0
    i32.load8_u offset=9
    call $_ZN3std9panicking20rust_panic_with_hook17hd6db915a7ab98bd5E
    unreachable)
  (func $_ZN3std5alloc24default_alloc_error_hook17hfe3584b28bc072faE (type 6) (param i32 i32)
    (local i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      i32.const 0
      i32.load8_u offset=1062188
      br_if 0 (;@1;)
      local.get 2
      i32.const 2
      i32.store offset=12
      local.get 2
      i32.const 1055188
      i32.store offset=8
      local.get 2
      i64.const 1
      i64.store offset=20 align=4
      local.get 2
      i32.const 13
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.get 2
      i32.const 40
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=32
      local.get 2
      local.get 1
      i32.store offset=40
      local.get 2
      local.get 2
      i32.const 32
      i32.add
      i32.store offset=16
      local.get 2
      local.get 2
      i32.const 47
      i32.add
      local.get 2
      i32.const 8
      i32.add
      call $_ZN3std2io5Write9write_fmt17he070a5b119ee3d3cE
      local.get 2
      i32.load offset=4
      local.set 3
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          i32.load8_u
          local.tee 1
          i32.const 4
          i32.gt_u
          br_if 0 (;@3;)
          local.get 1
          i32.const 3
          i32.ne
          br_if 1 (;@2;)
        end
        local.get 3
        i32.load
        local.set 4
        block  ;; label = @3
          local.get 3
          i32.const 4
          i32.add
          i32.load
          local.tee 1
          i32.load
          local.tee 5
          i32.eqz
          br_if 0 (;@3;)
          local.get 4
          local.get 5
          call_indirect (type 1)
        end
        block  ;; label = @3
          local.get 1
          i32.load offset=4
          local.tee 5
          i32.eqz
          br_if 0 (;@3;)
          local.get 4
          local.get 5
          local.get 1
          i32.load offset=8
          call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        end
        local.get 3
        i32.const 12
        i32.const 4
        call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
      end
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
    i32.const 1055220
    i32.store offset=8
    local.get 2
    i64.const 1
    i64.store offset=20 align=4
    local.get 2
    local.get 1
    i32.store
    local.get 2
    i32.const 13
    i64.extend_i32_u
    i64.const 32
    i64.shl
    local.get 2
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
    i32.const 1055260
    call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
    unreachable)
  (func $_RNvCs691rhTbG0Ee_7___rustc11___rdl_alloc (type 2) (param i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          i32.const 8
          i32.gt_u
          br_if 0 (;@3;)
          local.get 1
          local.get 0
          i32.le_u
          br_if 1 (;@2;)
        end
        local.get 2
        i32.const 0
        i32.store offset=12
        local.get 2
        i32.const 12
        i32.add
        local.get 1
        i32.const 4
        local.get 1
        i32.const 4
        i32.gt_u
        select
        local.get 0
        call $posix_memalign
        local.set 1
        i32.const 0
        local.get 2
        i32.load offset=12
        local.get 1
        select
        local.set 1
        br 1 (;@1;)
      end
      local.get 0
      call $malloc
      local.set 1
    end
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $_RNvCs691rhTbG0Ee_7___rustc13___rdl_dealloc (type 4) (param i32 i32 i32)
    local.get 0
    call $free)
  (func $_RNvCs691rhTbG0Ee_7___rustc13___rdl_realloc (type 10) (param i32 i32 i32 i32) (result i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 4
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          i32.const 8
          i32.gt_u
          br_if 0 (;@3;)
          local.get 2
          local.get 3
          i32.le_u
          br_if 1 (;@2;)
        end
        i32.const 0
        local.set 5
        local.get 4
        i32.const 0
        i32.store offset=12
        local.get 4
        i32.const 12
        i32.add
        local.get 2
        i32.const 4
        local.get 2
        i32.const 4
        i32.gt_u
        select
        local.get 3
        call $posix_memalign
        br_if 1 (;@1;)
        local.get 4
        i32.load offset=12
        local.tee 2
        i32.eqz
        br_if 1 (;@1;)
        block  ;; label = @3
          local.get 3
          local.get 1
          local.get 3
          local.get 1
          i32.lt_u
          select
          local.tee 3
          i32.eqz
          br_if 0 (;@3;)
          local.get 2
          local.get 0
          local.get 3
          memory.copy
        end
        local.get 0
        call $free
        local.get 2
        local.set 5
        br 1 (;@1;)
      end
      local.get 0
      local.get 3
      call $realloc
      local.set 5
    end
    local.get 4
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 5)
  (func $_ZN3std9panicking14payload_as_str17h7f1efc6f20392d51E (type 4) (param i32 i32 i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    local.get 1
    local.get 2
    i32.load offset=12
    local.tee 4
    call_indirect (type 6)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          i64.load
          i64.const -5076933981314334344
          i64.ne
          br_if 0 (;@3;)
          i32.const 4
          local.set 2
          local.get 1
          local.set 5
          local.get 3
          i64.load offset=8
          i64.const 7199936582794304877
          i64.eq
          br_if 1 (;@2;)
        end
        local.get 3
        local.get 1
        local.get 4
        call_indirect (type 6)
        i32.const 1055616
        local.set 2
        i32.const 12
        local.set 4
        local.get 3
        i64.load
        i64.const -5190768330908619786
        i64.ne
        br_if 1 (;@1;)
        local.get 3
        i64.load offset=8
        i64.const 3353964679774260343
        i64.ne
        br_if 1 (;@1;)
        local.get 1
        i32.const 4
        i32.add
        local.set 5
        i32.const 8
        local.set 2
      end
      local.get 1
      local.get 2
      i32.add
      i32.load
      local.set 4
      local.get 5
      i32.load
      local.set 2
    end
    local.get 0
    local.get 4
    i32.store offset=4
    local.get 0
    local.get 2
    i32.store
    local.get 3
    i32.const 16
    i32.add
    global.set $__stack_pointer)
  (func $_ZN3std9panicking12default_hook28_$u7b$$u7b$closure$u7d$$u7d$17h10e421fa9b730a1bE (type 4) (param i32 i32 i32)
    (local i32 i32 i64 i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    call $_ZN3std3sys9backtrace4lock17h8474d9d758c64cbdE
    local.set 4
    local.get 0
    i64.load align=4
    local.set 5
    local.get 3
    local.get 2
    i32.store offset=20
    local.get 3
    local.get 1
    i32.store offset=16
    local.get 3
    local.get 5
    i64.store offset=8 align=4
    block  ;; label = @1
      block  ;; label = @2
        i32.const 0
        i32.load offset=1062300
        local.tee 6
        i32.const 2
        i32.gt_u
        br_if 0 (;@2;)
        block  ;; label = @3
          block  ;; label = @4
            i32.const 0
            i64.load offset=1062280
            local.tee 5
            i64.eqz
            br_if 0 (;@4;)
            i32.const 0
            i64.load offset=1062264
            local.get 5
            i64.eq
            br_if 1 (;@3;)
          end
          local.get 3
          i32.const 8
          i32.add
          i32.const 0
          local.get 3
          call $_ZN3std9panicking12default_hook28_$u7b$$u7b$closure$u7d$$u7d$28_$u7b$$u7b$closure$u7d$$u7d$17hccb33f13232af7f9E
          br 2 (;@1;)
        end
        local.get 3
        i32.const 8
        i32.add
        i32.const 1053160
        i32.const 4
        call $_ZN3std9panicking12default_hook28_$u7b$$u7b$closure$u7d$$u7d$28_$u7b$$u7b$closure$u7d$$u7d$17hccb33f13232af7f9E
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 6
        i32.load offset=8
        local.tee 7
        i32.eqz
        br_if 0 (;@2;)
        local.get 3
        i32.const 8
        i32.add
        local.get 7
        local.get 6
        i32.const 12
        i32.add
        i32.load
        i32.const -1
        i32.add
        call $_ZN3std9panicking12default_hook28_$u7b$$u7b$closure$u7d$$u7d$28_$u7b$$u7b$closure$u7d$$u7d$17hccb33f13232af7f9E
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 6
        i64.load
        i32.const 0
        i64.load offset=1062280
        i64.ne
        br_if 0 (;@2;)
        local.get 3
        i32.const 8
        i32.add
        i32.const 1053160
        i32.const 4
        call $_ZN3std9panicking12default_hook28_$u7b$$u7b$closure$u7d$$u7d$28_$u7b$$u7b$closure$u7d$$u7d$17hccb33f13232af7f9E
        br 1 (;@1;)
      end
      local.get 3
      i32.const 8
      i32.add
      i32.const 0
      local.get 3
      call $_ZN3std9panicking12default_hook28_$u7b$$u7b$closure$u7d$$u7d$28_$u7b$$u7b$closure$u7d$$u7d$17hccb33f13232af7f9E
    end
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            i32.load offset=8
            i32.load8_u
            br_table 0 (;@4;) 1 (;@3;) 2 (;@2;) 3 (;@1;) 0 (;@4;)
          end
          local.get 3
          i32.const 8
          i32.add
          local.get 1
          local.get 2
          i32.load offset=36
          i32.const 0
          call $_ZN3std3sys9backtrace13BacktraceLock5print17h61f80b5fff84970cE
          local.get 3
          i32.load8_u offset=8
          local.get 3
          i32.load offset=12
          call $_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h3da6fe1468662fefE
          br 2 (;@1;)
        end
        local.get 3
        i32.const 8
        i32.add
        local.get 1
        local.get 2
        i32.load offset=36
        i32.const 1
        call $_ZN3std3sys9backtrace13BacktraceLock5print17h61f80b5fff84970cE
        local.get 3
        i32.load8_u offset=8
        local.get 3
        i32.load offset=12
        call $_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h3da6fe1468662fefE
        br 1 (;@1;)
      end
      i32.const 0
      i32.load8_u offset=1062172
      local.set 0
      i32.const 0
      i32.const 0
      i32.store8 offset=1062172
      local.get 0
      i32.eqz
      br_if 0 (;@1;)
      local.get 3
      i32.const 0
      i32.store offset=24
      local.get 3
      i32.const 1
      i32.store offset=12
      local.get 3
      i32.const 1055436
      i32.store offset=8
      local.get 3
      i64.const 4
      i64.store offset=16 align=4
      local.get 3
      local.get 1
      local.get 3
      i32.const 8
      i32.add
      local.get 2
      i32.load offset=36
      call_indirect (type 4)
      local.get 3
      i32.load8_u
      local.get 3
      i32.load offset=4
      call $_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h3da6fe1468662fefE
    end
    local.get 4
    i32.const 0
    i32.store8
    local.get 3
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN3std9panicking12default_hook28_$u7b$$u7b$closure$u7d$$u7d$28_$u7b$$u7b$closure$u7d$$u7d$17hccb33f13232af7f9E (type 4) (param i32 i32 i32)
    (local i32 i64 i64 i64 i32 i32)
    global.get $__stack_pointer
    i32.const 592
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    local.get 2
    i32.const 9
    local.get 1
    select
    i32.store offset=4
    local.get 3
    local.get 1
    i32.const 1055444
    local.get 1
    select
    i32.store
    block  ;; label = @1
      i32.const 512
      i32.eqz
      br_if 0 (;@1;)
      local.get 3
      i32.const 8
      i32.add
      i32.const 0
      i32.const 512
      memory.fill
    end
    local.get 3
    i64.const 0
    i64.store offset=528
    local.get 3
    i32.const 512
    i32.store offset=524
    local.get 3
    local.get 3
    i32.const 8
    i32.add
    i32.store offset=520
    local.get 0
    i64.load32_u
    local.set 4
    local.get 0
    i64.load32_u offset=4
    local.set 5
    local.get 3
    i32.const 1055496
    i32.store offset=544
    local.get 3
    i64.const 3
    i64.store offset=556 align=4
    local.get 3
    local.get 5
    i32.const 12
    i64.extend_i32_u
    i64.const 32
    i64.shl
    local.tee 6
    i64.or
    local.tee 5
    i64.store offset=584
    local.get 3
    local.get 4
    i32.const 18
    i64.extend_i32_u
    i64.const 32
    i64.shl
    i64.or
    local.tee 4
    i64.store offset=576
    local.get 3
    local.get 6
    local.get 3
    i64.extend_i32_u
    i64.or
    local.tee 6
    i64.store offset=568
    local.get 3
    local.get 3
    i32.const 568
    i32.add
    i32.store offset=552
    local.get 3
    i32.const 4
    i32.store offset=548
    local.get 3
    i32.const 536
    i32.add
    local.get 3
    i32.const 520
    i32.add
    local.get 3
    i32.const 544
    i32.add
    call $_ZN3std2io5Write9write_fmt17h8b2dfcfe3f286d05E
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          i32.load8_u offset=536
          local.tee 1
          i32.const 4
          i32.ne
          br_if 0 (;@3;)
          local.get 3
          i32.load offset=528
          local.tee 1
          i32.const 513
          i32.ge_u
          br_if 2 (;@1;)
          local.get 3
          i32.const 568
          i32.add
          local.get 0
          i32.load offset=8
          local.get 3
          i32.const 8
          i32.add
          local.get 1
          local.get 0
          i32.load offset=12
          i32.load offset=28
          call_indirect (type 7)
          local.get 3
          i32.load offset=572
          local.set 1
          block  ;; label = @4
            local.get 3
            i32.load8_u offset=568
            local.tee 0
            i32.const 4
            i32.gt_u
            br_if 0 (;@4;)
            local.get 0
            i32.const 3
            i32.ne
            br_if 2 (;@2;)
          end
          local.get 1
          i32.load
          local.set 2
          block  ;; label = @4
            local.get 1
            i32.const 4
            i32.add
            i32.load
            local.tee 0
            i32.load
            local.tee 7
            i32.eqz
            br_if 0 (;@4;)
            local.get 2
            local.get 7
            call_indirect (type 1)
          end
          block  ;; label = @4
            local.get 0
            i32.load offset=4
            local.tee 7
            i32.eqz
            br_if 0 (;@4;)
            local.get 2
            local.get 7
            local.get 0
            i32.load offset=8
            call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
          end
          local.get 1
          i32.const 12
          i32.const 4
          call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
          br 1 (;@2;)
        end
        block  ;; label = @3
          local.get 1
          i32.const 3
          i32.lt_u
          br_if 0 (;@3;)
          local.get 3
          i32.load offset=540
          local.tee 1
          i32.load
          local.set 7
          block  ;; label = @4
            local.get 1
            i32.const 4
            i32.add
            i32.load
            local.tee 2
            i32.load
            local.tee 8
            i32.eqz
            br_if 0 (;@4;)
            local.get 7
            local.get 8
            call_indirect (type 1)
          end
          block  ;; label = @4
            local.get 2
            i32.load offset=4
            local.tee 8
            i32.eqz
            br_if 0 (;@4;)
            local.get 7
            local.get 8
            local.get 2
            i32.load offset=8
            call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
          end
          local.get 1
          i32.const 12
          i32.const 4
          call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        end
        local.get 0
        i32.load offset=12
        i32.const 36
        i32.add
        i32.load
        local.set 1
        local.get 0
        i32.load offset=8
        local.set 0
        local.get 3
        i32.const 1055496
        i32.store offset=544
        local.get 3
        i64.const 3
        i64.store offset=556 align=4
        local.get 3
        local.get 5
        i64.store offset=584
        local.get 3
        local.get 4
        i64.store offset=576
        local.get 3
        local.get 6
        i64.store offset=568
        local.get 3
        local.get 3
        i32.const 568
        i32.add
        i32.store offset=552
        local.get 3
        i32.const 4
        i32.store offset=548
        local.get 3
        i32.const 536
        i32.add
        local.get 0
        local.get 3
        i32.const 544
        i32.add
        local.get 1
        call_indirect (type 4)
        local.get 3
        i32.load offset=540
        local.set 1
        block  ;; label = @3
          local.get 3
          i32.load8_u offset=536
          local.tee 0
          i32.const 4
          i32.gt_u
          br_if 0 (;@3;)
          local.get 0
          i32.const 3
          i32.ne
          br_if 1 (;@2;)
        end
        local.get 1
        i32.load
        local.set 2
        block  ;; label = @3
          local.get 1
          i32.const 4
          i32.add
          i32.load
          local.tee 0
          i32.load
          local.tee 7
          i32.eqz
          br_if 0 (;@3;)
          local.get 2
          local.get 7
          call_indirect (type 1)
        end
        block  ;; label = @3
          local.get 0
          i32.load offset=4
          local.tee 7
          i32.eqz
          br_if 0 (;@3;)
          local.get 2
          local.get 7
          local.get 0
          i32.load offset=8
          call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        end
        local.get 1
        i32.const 12
        i32.const 4
        call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
      end
      local.get 3
      i32.const 592
      i32.add
      global.set $__stack_pointer
      return
    end
    local.get 1
    i32.const 512
    i32.const 1055456
    call $_ZN4core5slice5index24slice_end_index_len_fail17hc7943372990115c8E
    unreachable)
  (func $_ZN3std9panicking11panic_count8increase17h8f96eac579e666bcE (type 3) (param i32) (result i32)
    (local i32 i32)
    i32.const 0
    local.set 1
    i32.const 0
    i32.const 0
    i32.load offset=1062260
    local.tee 2
    i32.const 1
    i32.add
    i32.store offset=1062260
    block  ;; label = @1
      local.get 2
      i32.const 0
      i32.lt_s
      br_if 0 (;@1;)
      i32.const 1
      local.set 1
      i32.const 0
      i32.load8_u offset=1062292
      br_if 0 (;@1;)
      i32.const 0
      local.get 0
      i32.store8 offset=1062292
      i32.const 0
      i32.const 0
      i32.load offset=1062288
      i32.const 1
      i32.add
      i32.store offset=1062288
      i32.const 2
      local.set 1
    end
    local.get 1)
  (func $_RNvCs691rhTbG0Ee_7___rustc17rust_begin_unwind (type 1) (param i32)
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
    call $_ZN3std3sys9backtrace26__rust_end_short_backtrace17heed88f70267ff169E
    unreachable)
  (func $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17h91eecedfd0f5623eE (type 6) (param i32 i32)
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
      i32.const 1052896
      local.get 2
      i32.const 40
      i32.add
      call $_ZN4core3fmt5write17hb4e267bf92503392E
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
    i32.load8_u offset=1062189
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
      call $_ZN5alloc5alloc18handle_alloc_error17hcc35c2aed22157a6E
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
    i32.const 1055528
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store
    local.get 2
    i32.const 64
    i32.add
    global.set $__stack_pointer)
  (func $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17h6cc4b8d5c4351f3cE (type 6) (param i32 i32)
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
      i32.const 1052896
      local.get 2
      i32.const 24
      i32.add
      call $_ZN4core3fmt5write17hb4e267bf92503392E
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
    i32.const 1055528
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store
    local.get 2
    i32.const 48
    i32.add
    global.set $__stack_pointer)
  (func $_ZN95_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..fmt..Display$GT$3fmt17h698b05d4ac7f59faE (type 2) (param i32 i32) (result i32)
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
        call $_ZN4core3fmt9Formatter9write_str17hdf9d14a3fcabff76E
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
      call $_ZN4core3fmt5write17hb4e267bf92503392E
      local.set 0
    end
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17hda4884f51fc1d63cE (type 6) (param i32 i32)
    (local i32 i32)
    i32.const 0
    i32.load8_u offset=1062189
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
      call $_ZN5alloc5alloc18handle_alloc_error17hcc35c2aed22157a6E
      unreachable
    end
    local.get 1
    local.get 2
    i32.store offset=4
    local.get 1
    local.get 3
    i32.store
    local.get 0
    i32.const 1055544
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store)
  (func $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17hc9ba6339c6f888eeE (type 6) (param i32 i32)
    local.get 0
    i32.const 1055544
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store)
  (func $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$6as_str17hacc42b4685d93ce5E (type 6) (param i32 i32)
    local.get 0
    local.get 1
    i64.load align=4
    i64.store)
  (func $_ZN92_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..fmt..Display$GT$3fmt17ha2cf78d2946fbf30E (type 2) (param i32 i32) (result i32)
    local.get 1
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    call $_ZN4core3fmt9Formatter9write_str17hdf9d14a3fcabff76E)
  (func $_ZN3std9panicking20rust_panic_with_hook17hd6db915a7ab98bd5E (type 12) (param i32 i32 i32 i32 i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 96
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    local.get 5
    local.get 1
    i32.store offset=32
    local.get 5
    local.get 0
    i32.store offset=28
    local.get 5
    local.get 2
    i32.store offset=36
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            i32.const 1
            call $_ZN3std9panicking11panic_count8increase17h8f96eac579e666bcE
            i32.const 255
            i32.and
            local.tee 6
            i32.const 2
            i32.eq
            br_if 0 (;@4;)
            local.get 6
            i32.const 1
            i32.and
            i32.eqz
            br_if 1 (;@3;)
            local.get 5
            i32.const 16
            i32.add
            local.get 0
            local.get 1
            i32.load offset=24
            call_indirect (type 6)
            local.get 5
            local.get 5
            i32.load offset=20
            i32.const 0
            local.get 5
            i32.load offset=16
            local.tee 1
            select
            i32.store offset=44
            local.get 5
            local.get 1
            i32.const 1
            local.get 1
            select
            i32.store offset=40
            local.get 5
            i32.const 3
            i32.store offset=76
            local.get 5
            i32.const 1055732
            i32.store offset=72
            local.get 5
            i64.const 2
            i64.store offset=84 align=4
            local.get 5
            i32.const 12
            i64.extend_i32_u
            i64.const 32
            i64.shl
            local.get 5
            i32.const 40
            i32.add
            i64.extend_i32_u
            i64.or
            i64.store offset=64
            local.get 5
            i32.const 18
            i64.extend_i32_u
            i64.const 32
            i64.shl
            local.get 5
            i32.const 36
            i32.add
            i64.extend_i32_u
            i64.or
            i64.store offset=56
            local.get 5
            local.get 5
            i32.const 56
            i32.add
            i32.store offset=80
            local.get 5
            i32.const 48
            i32.add
            local.get 5
            i32.const 48
            i32.add
            local.get 5
            i32.const 72
            i32.add
            call $_ZN3std2io5Write9write_fmt17he070a5b119ee3d3cE
            local.get 5
            i32.load8_u offset=48
            local.get 5
            i32.load offset=52
            call $_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h3da6fe1468662fefE
            br 3 (;@1;)
          end
          i32.const 0
          i32.load offset=1062248
          local.tee 6
          i32.const -1
          i32.gt_s
          br_if 1 (;@2;)
          local.get 5
          i32.const 1
          i32.store offset=76
          local.get 5
          i32.const 1056212
          i32.store offset=72
          local.get 5
          i64.const 0
          i64.store offset=84 align=4
          local.get 5
          local.get 5
          i32.const 48
          i32.add
          i32.store offset=80
          local.get 5
          i32.const 56
          i32.add
          local.get 5
          i32.const 48
          i32.add
          local.get 5
          i32.const 72
          i32.add
          call $_ZN3std2io5Write9write_fmt17he070a5b119ee3d3cE
          local.get 5
          i32.load8_u offset=56
          local.get 5
          i32.load offset=60
          call $_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h3da6fe1468662fefE
          br 2 (;@1;)
        end
        local.get 5
        i32.const 3
        i32.store offset=76
        local.get 5
        i32.const 1055656
        i32.store offset=72
        local.get 5
        i64.const 2
        i64.store offset=84 align=4
        local.get 5
        i32.const 19
        i64.extend_i32_u
        i64.const 32
        i64.shl
        local.get 5
        i32.const 28
        i32.add
        i64.extend_i32_u
        i64.or
        i64.store offset=64
        local.get 5
        i32.const 18
        i64.extend_i32_u
        i64.const 32
        i64.shl
        local.get 5
        i32.const 36
        i32.add
        i64.extend_i32_u
        i64.or
        i64.store offset=56
        local.get 5
        local.get 5
        i32.const 56
        i32.add
        i32.store offset=80
        local.get 5
        i32.const 48
        i32.add
        local.get 5
        i32.const 48
        i32.add
        local.get 5
        i32.const 72
        i32.add
        call $_ZN3std2io5Write9write_fmt17he070a5b119ee3d3cE
        local.get 5
        i32.load8_u offset=48
        local.get 5
        i32.load offset=52
        call $_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h3da6fe1468662fefE
        br 1 (;@1;)
      end
      i32.const 0
      local.get 6
      i32.const 1
      i32.add
      i32.store offset=1062248
      block  ;; label = @2
        block  ;; label = @3
          i32.const 0
          i32.load offset=1062252
          i32.eqz
          br_if 0 (;@3;)
          local.get 5
          i32.const 8
          i32.add
          local.get 0
          local.get 1
          i32.load offset=20
          call_indirect (type 6)
          local.get 5
          local.get 4
          i32.store8 offset=85
          local.get 5
          local.get 3
          i32.store8 offset=84
          local.get 5
          local.get 2
          i32.store offset=80
          local.get 5
          local.get 5
          i64.load offset=8
          i64.store offset=72 align=4
          i32.const 0
          i32.load offset=1062252
          local.get 5
          i32.const 72
          i32.add
          i32.const 0
          i32.load offset=1062256
          i32.load offset=20
          call_indirect (type 6)
          br 1 (;@2;)
        end
        local.get 5
        local.get 0
        local.get 1
        i32.load offset=20
        call_indirect (type 6)
        local.get 5
        local.get 4
        i32.store8 offset=85
        local.get 5
        local.get 3
        i32.store8 offset=84
        local.get 5
        local.get 2
        i32.store offset=80
        local.get 5
        local.get 5
        i64.load
        i64.store offset=72 align=4
        local.get 5
        i32.const 72
        i32.add
        call $_ZN3std9panicking12default_hook17ha7cb01911cb0a911E
      end
      i32.const 0
      i32.const 0
      i32.load offset=1062248
      i32.const -1
      i32.add
      i32.store offset=1062248
      i32.const 0
      i32.const 0
      i32.store8 offset=1062292
      block  ;; label = @2
        local.get 3
        br_if 0 (;@2;)
        local.get 5
        i32.const 0
        i32.store offset=88
        local.get 5
        i32.const 1
        i32.store offset=76
        local.get 5
        i32.const 1055804
        i32.store offset=72
        local.get 5
        i64.const 4
        i64.store offset=80 align=4
        local.get 5
        i32.const 56
        i32.add
        local.get 5
        i32.const 48
        i32.add
        local.get 5
        i32.const 72
        i32.add
        call $_ZN3std2io5Write9write_fmt17he070a5b119ee3d3cE
        local.get 5
        i32.load8_u offset=56
        local.get 5
        i32.load offset=60
        call $_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h3da6fe1468662fefE
        br 1 (;@1;)
      end
      local.get 0
      local.get 1
      call $_RNvCs691rhTbG0Ee_7___rustc10rust_panic
      unreachable
    end
    call $_ZN3std3sys3pal4wasi7helpers14abort_internal17he7a2be67736436b7E
    unreachable)
  (func $_RNvCs691rhTbG0Ee_7___rustc10rust_panic (type 6) (param i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 64
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    local.get 0
    local.get 1
    call $_RNvCs691rhTbG0Ee_7___rustc18___rust_start_panic
    i32.store offset=12
    local.get 2
    i32.const 2
    i32.store offset=28
    local.get 2
    i32.const 1055876
    i32.store offset=24
    local.get 2
    i64.const 1
    i64.store offset=36 align=4
    local.get 2
    i32.const 13
    i64.extend_i32_u
    i64.const 32
    i64.shl
    local.get 2
    i32.const 12
    i32.add
    i64.extend_i32_u
    i64.or
    i64.store offset=48
    local.get 2
    local.get 2
    i32.const 48
    i32.add
    i32.store offset=32
    local.get 2
    i32.const 16
    i32.add
    local.get 2
    i32.const 63
    i32.add
    local.get 2
    i32.const 24
    i32.add
    call $_ZN3std2io5Write9write_fmt17he070a5b119ee3d3cE
    local.get 2
    i32.load8_u offset=16
    local.get 2
    i32.load offset=20
    call $_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h3da6fe1468662fefE
    call $_ZN3std3sys3pal4wasi7helpers14abort_internal17he7a2be67736436b7E
    unreachable)
  (func $_ZN64_$LT$std..sys..stdio..wasi..Stderr$u20$as$u20$std..io..Write$GT$5write17h9130e91513ae60a2E (type 7) (param i32 i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 4
    global.set $__stack_pointer
    local.get 4
    local.get 3
    i32.store offset=4
    local.get 4
    local.get 2
    i32.store
    local.get 4
    i32.const 8
    i32.add
    i32.const 2
    local.get 4
    i32.const 1
    call $_ZN4wasi13lib_generated8fd_write17h8e36e57726d845e0E
    block  ;; label = @1
      block  ;; label = @2
        local.get 4
        i32.load16_u offset=8
        i32.const 1
        i32.ne
        br_if 0 (;@2;)
        local.get 0
        local.get 4
        i64.load16_u offset=10
        i64.const 32
        i64.shl
        i64.store align=4
        br 1 (;@1;)
      end
      local.get 0
      local.get 4
      i32.load offset=12
      i32.store offset=4
      local.get 0
      i32.const 4
      i32.store8
    end
    local.get 4
    i32.const 16
    i32.add
    global.set $__stack_pointer)
  (func $_ZN64_$LT$std..sys..stdio..wasi..Stderr$u20$as$u20$std..io..Write$GT$14write_vectored17h8711081ec37d5f23E (type 7) (param i32 i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 4
    global.set $__stack_pointer
    local.get 4
    i32.const 8
    i32.add
    i32.const 2
    local.get 2
    local.get 3
    call $_ZN4wasi13lib_generated8fd_write17h8e36e57726d845e0E
    block  ;; label = @1
      block  ;; label = @2
        local.get 4
        i32.load16_u offset=8
        i32.const 1
        i32.ne
        br_if 0 (;@2;)
        local.get 0
        local.get 4
        i64.load16_u offset=10
        i64.const 32
        i64.shl
        i64.store align=4
        br 1 (;@1;)
      end
      local.get 0
      local.get 4
      i32.load offset=12
      i32.store offset=4
      local.get 0
      i32.const 4
      i32.store8
    end
    local.get 4
    i32.const 16
    i32.add
    global.set $__stack_pointer)
  (func $_ZN64_$LT$std..sys..stdio..wasi..Stderr$u20$as$u20$std..io..Write$GT$17is_write_vectored17h4a91ce14e3ddc646E (type 3) (param i32) (result i32)
    i32.const 1)
  (func $_ZN64_$LT$std..sys..stdio..wasi..Stderr$u20$as$u20$std..io..Write$GT$5flush17h7bd1b0dc5a2382a0E (type 6) (param i32 i32)
    local.get 0
    i32.const 4
    i32.store8)
  (func $_ZN3std5alloc8rust_oom17h293069cf3a87ceb7E (type 6) (param i32 i32)
    (local i32)
    local.get 0
    local.get 1
    i32.const 0
    i32.load offset=1062244
    local.tee 2
    i32.const 20
    local.get 2
    select
    call_indirect (type 6)
    call $_ZN3std7process5abort17hb229e5783e2ded8dE
    unreachable)
  (func $_RNvCs691rhTbG0Ee_7___rustc8___rg_oom (type 6) (param i32 i32)
    local.get 1
    local.get 0
    call $_ZN3std5alloc8rust_oom17h293069cf3a87ceb7E
    unreachable)
  (func $_RNvCs691rhTbG0Ee_7___rustc18___rust_start_panic (type 2) (param i32 i32) (result i32)
    unreachable)
  (func $_ZN4wasi13lib_generated8fd_write17h8e36e57726d845e0E (type 7) (param i32 i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 4
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        local.get 2
        local.get 3
        local.get 4
        i32.const 12
        i32.add
        call $_ZN4wasi13lib_generated22wasi_snapshot_preview18fd_write17h33aeb12ec25abb21E
        local.tee 3
        br_if 0 (;@2;)
        local.get 0
        local.get 4
        i32.load offset=12
        i32.store offset=4
        i32.const 0
        local.set 3
        br 1 (;@1;)
      end
      local.get 0
      local.get 3
      i32.store16 offset=2
      i32.const 1
      local.set 3
    end
    local.get 0
    local.get 3
    i32.store16
    local.get 4
    i32.const 16
    i32.add
    global.set $__stack_pointer)
  (func $malloc (type 3) (param i32) (result i32)
    local.get 0
    call $dlmalloc)
  (func $dlmalloc (type 3) (param i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
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
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              i32.const 0
                              i32.load offset=1062328
                              local.tee 2
                              br_if 0 (;@13;)
                              block  ;; label = @14
                                i32.const 0
                                i32.load offset=1062776
                                local.tee 3
                                br_if 0 (;@14;)
                                i32.const 0
                                i64.const -1
                                i64.store offset=1062788 align=4
                                i32.const 0
                                i64.const 281474976776192
                                i64.store offset=1062780 align=4
                                i32.const 0
                                local.get 1
                                i32.const 8
                                i32.add
                                i32.const -16
                                i32.and
                                i32.const 1431655768
                                i32.xor
                                local.tee 3
                                i32.store offset=1062776
                                i32.const 0
                                i32.const 0
                                i32.store offset=1062796
                                i32.const 0
                                i32.const 0
                                i32.store offset=1062748
                              end
                              i32.const 1114112
                              i32.const 1062848
                              i32.lt_u
                              br_if 1 (;@12;)
                              i32.const 0
                              local.set 2
                              i32.const 1114112
                              i32.const 1062848
                              i32.sub
                              i32.const 89
                              i32.lt_u
                              br_if 0 (;@13;)
                              i32.const 0
                              local.set 4
                              i32.const 0
                              i32.const 1062848
                              i32.store offset=1062752
                              i32.const 0
                              i32.const 1062848
                              i32.store offset=1062320
                              i32.const 0
                              local.get 3
                              i32.store offset=1062340
                              i32.const 0
                              i32.const -1
                              i32.store offset=1062336
                              i32.const 0
                              i32.const 1114112
                              i32.const 1062848
                              i32.sub
                              local.tee 3
                              i32.store offset=1062756
                              i32.const 0
                              local.get 3
                              i32.store offset=1062740
                              i32.const 0
                              local.get 3
                              i32.store offset=1062736
                              loop  ;; label = @14
                                local.get 4
                                i32.const 1062364
                                i32.add
                                local.get 4
                                i32.const 1062352
                                i32.add
                                local.tee 3
                                i32.store
                                local.get 3
                                local.get 4
                                i32.const 1062344
                                i32.add
                                local.tee 5
                                i32.store
                                local.get 4
                                i32.const 1062356
                                i32.add
                                local.get 5
                                i32.store
                                local.get 4
                                i32.const 1062372
                                i32.add
                                local.get 4
                                i32.const 1062360
                                i32.add
                                local.tee 5
                                i32.store
                                local.get 5
                                local.get 3
                                i32.store
                                local.get 4
                                i32.const 1062380
                                i32.add
                                local.get 4
                                i32.const 1062368
                                i32.add
                                local.tee 3
                                i32.store
                                local.get 3
                                local.get 5
                                i32.store
                                local.get 4
                                i32.const 1062376
                                i32.add
                                local.get 3
                                i32.store
                                local.get 4
                                i32.const 32
                                i32.add
                                local.tee 4
                                i32.const 256
                                i32.ne
                                br_if 0 (;@14;)
                              end
                              i32.const 1114112
                              i32.const -52
                              i32.add
                              i32.const 56
                              i32.store
                              i32.const 0
                              i32.const 0
                              i32.load offset=1062792
                              i32.store offset=1062332
                              i32.const 0
                              i32.const 1062848
                              i32.const -8
                              i32.const 1062848
                              i32.sub
                              i32.const 15
                              i32.and
                              local.tee 4
                              i32.add
                              local.tee 2
                              i32.store offset=1062328
                              i32.const 0
                              i32.const 1114112
                              i32.const 1062848
                              i32.sub
                              local.get 4
                              i32.sub
                              i32.const -56
                              i32.add
                              local.tee 4
                              i32.store offset=1062316
                              local.get 2
                              local.get 4
                              i32.const 1
                              i32.or
                              i32.store offset=4
                            end
                            block  ;; label = @13
                              block  ;; label = @14
                                local.get 0
                                i32.const 236
                                i32.gt_u
                                br_if 0 (;@14;)
                                block  ;; label = @15
                                  i32.const 0
                                  i32.load offset=1062304
                                  local.tee 6
                                  i32.const 16
                                  local.get 0
                                  i32.const 19
                                  i32.add
                                  i32.const 496
                                  i32.and
                                  local.get 0
                                  i32.const 11
                                  i32.lt_u
                                  select
                                  local.tee 5
                                  i32.const 3
                                  i32.shr_u
                                  local.tee 3
                                  i32.shr_u
                                  local.tee 4
                                  i32.const 3
                                  i32.and
                                  i32.eqz
                                  br_if 0 (;@15;)
                                  block  ;; label = @16
                                    block  ;; label = @17
                                      local.get 4
                                      i32.const 1
                                      i32.and
                                      local.get 3
                                      i32.or
                                      i32.const 1
                                      i32.xor
                                      local.tee 5
                                      i32.const 3
                                      i32.shl
                                      local.tee 3
                                      i32.const 1062344
                                      i32.add
                                      local.tee 4
                                      local.get 3
                                      i32.const 1062352
                                      i32.add
                                      i32.load
                                      local.tee 3
                                      i32.load offset=8
                                      local.tee 0
                                      i32.ne
                                      br_if 0 (;@17;)
                                      i32.const 0
                                      local.get 6
                                      i32.const -2
                                      local.get 5
                                      i32.rotl
                                      i32.and
                                      i32.store offset=1062304
                                      br 1 (;@16;)
                                    end
                                    local.get 4
                                    local.get 0
                                    i32.store offset=8
                                    local.get 0
                                    local.get 4
                                    i32.store offset=12
                                  end
                                  local.get 3
                                  i32.const 8
                                  i32.add
                                  local.set 4
                                  local.get 3
                                  local.get 5
                                  i32.const 3
                                  i32.shl
                                  local.tee 5
                                  i32.const 3
                                  i32.or
                                  i32.store offset=4
                                  local.get 3
                                  local.get 5
                                  i32.add
                                  local.tee 3
                                  local.get 3
                                  i32.load offset=4
                                  i32.const 1
                                  i32.or
                                  i32.store offset=4
                                  br 14 (;@1;)
                                end
                                local.get 5
                                i32.const 0
                                i32.load offset=1062312
                                local.tee 7
                                i32.le_u
                                br_if 1 (;@13;)
                                block  ;; label = @15
                                  local.get 4
                                  i32.eqz
                                  br_if 0 (;@15;)
                                  block  ;; label = @16
                                    block  ;; label = @17
                                      local.get 4
                                      local.get 3
                                      i32.shl
                                      i32.const 2
                                      local.get 3
                                      i32.shl
                                      local.tee 4
                                      i32.const 0
                                      local.get 4
                                      i32.sub
                                      i32.or
                                      i32.and
                                      i32.ctz
                                      local.tee 3
                                      i32.const 3
                                      i32.shl
                                      local.tee 4
                                      i32.const 1062344
                                      i32.add
                                      local.tee 0
                                      local.get 4
                                      i32.const 1062352
                                      i32.add
                                      i32.load
                                      local.tee 4
                                      i32.load offset=8
                                      local.tee 8
                                      i32.ne
                                      br_if 0 (;@17;)
                                      i32.const 0
                                      local.get 6
                                      i32.const -2
                                      local.get 3
                                      i32.rotl
                                      i32.and
                                      local.tee 6
                                      i32.store offset=1062304
                                      br 1 (;@16;)
                                    end
                                    local.get 0
                                    local.get 8
                                    i32.store offset=8
                                    local.get 8
                                    local.get 0
                                    i32.store offset=12
                                  end
                                  local.get 4
                                  local.get 5
                                  i32.const 3
                                  i32.or
                                  i32.store offset=4
                                  local.get 4
                                  local.get 3
                                  i32.const 3
                                  i32.shl
                                  local.tee 3
                                  i32.add
                                  local.get 3
                                  local.get 5
                                  i32.sub
                                  local.tee 0
                                  i32.store
                                  local.get 4
                                  local.get 5
                                  i32.add
                                  local.tee 8
                                  local.get 0
                                  i32.const 1
                                  i32.or
                                  i32.store offset=4
                                  block  ;; label = @16
                                    local.get 7
                                    i32.eqz
                                    br_if 0 (;@16;)
                                    local.get 7
                                    i32.const -8
                                    i32.and
                                    i32.const 1062344
                                    i32.add
                                    local.set 5
                                    i32.const 0
                                    i32.load offset=1062324
                                    local.set 3
                                    block  ;; label = @17
                                      block  ;; label = @18
                                        local.get 6
                                        i32.const 1
                                        local.get 7
                                        i32.const 3
                                        i32.shr_u
                                        i32.shl
                                        local.tee 9
                                        i32.and
                                        br_if 0 (;@18;)
                                        i32.const 0
                                        local.get 6
                                        local.get 9
                                        i32.or
                                        i32.store offset=1062304
                                        local.get 5
                                        local.set 9
                                        br 1 (;@17;)
                                      end
                                      local.get 5
                                      i32.load offset=8
                                      local.set 9
                                    end
                                    local.get 9
                                    local.get 3
                                    i32.store offset=12
                                    local.get 5
                                    local.get 3
                                    i32.store offset=8
                                    local.get 3
                                    local.get 5
                                    i32.store offset=12
                                    local.get 3
                                    local.get 9
                                    i32.store offset=8
                                  end
                                  local.get 4
                                  i32.const 8
                                  i32.add
                                  local.set 4
                                  i32.const 0
                                  local.get 8
                                  i32.store offset=1062324
                                  i32.const 0
                                  local.get 0
                                  i32.store offset=1062312
                                  br 14 (;@1;)
                                end
                                i32.const 0
                                i32.load offset=1062308
                                local.tee 10
                                i32.eqz
                                br_if 1 (;@13;)
                                local.get 10
                                i32.ctz
                                i32.const 2
                                i32.shl
                                i32.const 1062608
                                i32.add
                                i32.load
                                local.tee 8
                                i32.load offset=4
                                i32.const -8
                                i32.and
                                local.get 5
                                i32.sub
                                local.set 3
                                local.get 8
                                local.set 0
                                block  ;; label = @15
                                  loop  ;; label = @16
                                    block  ;; label = @17
                                      local.get 0
                                      i32.load offset=16
                                      local.tee 4
                                      br_if 0 (;@17;)
                                      local.get 0
                                      i32.load offset=20
                                      local.tee 4
                                      i32.eqz
                                      br_if 2 (;@15;)
                                    end
                                    local.get 4
                                    i32.load offset=4
                                    i32.const -8
                                    i32.and
                                    local.get 5
                                    i32.sub
                                    local.tee 0
                                    local.get 3
                                    local.get 0
                                    local.get 3
                                    i32.lt_u
                                    local.tee 0
                                    select
                                    local.set 3
                                    local.get 4
                                    local.get 8
                                    local.get 0
                                    select
                                    local.set 8
                                    local.get 4
                                    local.set 0
                                    br 0 (;@16;)
                                  end
                                end
                                local.get 8
                                i32.load offset=24
                                local.set 2
                                block  ;; label = @15
                                  local.get 8
                                  i32.load offset=12
                                  local.tee 4
                                  local.get 8
                                  i32.eq
                                  br_if 0 (;@15;)
                                  local.get 8
                                  i32.load offset=8
                                  local.tee 0
                                  local.get 4
                                  i32.store offset=12
                                  local.get 4
                                  local.get 0
                                  i32.store offset=8
                                  br 13 (;@2;)
                                end
                                block  ;; label = @15
                                  block  ;; label = @16
                                    local.get 8
                                    i32.load offset=20
                                    local.tee 0
                                    i32.eqz
                                    br_if 0 (;@16;)
                                    local.get 8
                                    i32.const 20
                                    i32.add
                                    local.set 9
                                    br 1 (;@15;)
                                  end
                                  local.get 8
                                  i32.load offset=16
                                  local.tee 0
                                  i32.eqz
                                  br_if 4 (;@11;)
                                  local.get 8
                                  i32.const 16
                                  i32.add
                                  local.set 9
                                end
                                loop  ;; label = @15
                                  local.get 9
                                  local.set 11
                                  local.get 0
                                  local.tee 4
                                  i32.const 20
                                  i32.add
                                  local.set 9
                                  local.get 4
                                  i32.load offset=20
                                  local.tee 0
                                  br_if 0 (;@15;)
                                  local.get 4
                                  i32.const 16
                                  i32.add
                                  local.set 9
                                  local.get 4
                                  i32.load offset=16
                                  local.tee 0
                                  br_if 0 (;@15;)
                                end
                                local.get 11
                                i32.const 0
                                i32.store
                                br 12 (;@2;)
                              end
                              i32.const -1
                              local.set 5
                              local.get 0
                              i32.const -65
                              i32.gt_u
                              br_if 0 (;@13;)
                              local.get 0
                              i32.const 19
                              i32.add
                              local.tee 4
                              i32.const -16
                              i32.and
                              local.set 5
                              i32.const 0
                              i32.load offset=1062308
                              local.tee 10
                              i32.eqz
                              br_if 0 (;@13;)
                              i32.const 31
                              local.set 7
                              block  ;; label = @14
                                local.get 0
                                i32.const 16777196
                                i32.gt_u
                                br_if 0 (;@14;)
                                local.get 5
                                i32.const 38
                                local.get 4
                                i32.const 8
                                i32.shr_u
                                i32.clz
                                local.tee 4
                                i32.sub
                                i32.shr_u
                                i32.const 1
                                i32.and
                                local.get 4
                                i32.const 1
                                i32.shl
                                i32.sub
                                i32.const 62
                                i32.add
                                local.set 7
                              end
                              i32.const 0
                              local.get 5
                              i32.sub
                              local.set 3
                              block  ;; label = @14
                                block  ;; label = @15
                                  block  ;; label = @16
                                    block  ;; label = @17
                                      local.get 7
                                      i32.const 2
                                      i32.shl
                                      i32.const 1062608
                                      i32.add
                                      i32.load
                                      local.tee 0
                                      br_if 0 (;@17;)
                                      i32.const 0
                                      local.set 4
                                      i32.const 0
                                      local.set 9
                                      br 1 (;@16;)
                                    end
                                    i32.const 0
                                    local.set 4
                                    local.get 5
                                    i32.const 0
                                    i32.const 25
                                    local.get 7
                                    i32.const 1
                                    i32.shr_u
                                    i32.sub
                                    local.get 7
                                    i32.const 31
                                    i32.eq
                                    select
                                    i32.shl
                                    local.set 8
                                    i32.const 0
                                    local.set 9
                                    loop  ;; label = @17
                                      block  ;; label = @18
                                        local.get 0
                                        i32.load offset=4
                                        i32.const -8
                                        i32.and
                                        local.get 5
                                        i32.sub
                                        local.tee 6
                                        local.get 3
                                        i32.ge_u
                                        br_if 0 (;@18;)
                                        local.get 6
                                        local.set 3
                                        local.get 0
                                        local.set 9
                                        local.get 6
                                        br_if 0 (;@18;)
                                        i32.const 0
                                        local.set 3
                                        local.get 0
                                        local.set 9
                                        local.get 0
                                        local.set 4
                                        br 3 (;@15;)
                                      end
                                      local.get 4
                                      local.get 0
                                      i32.load offset=20
                                      local.tee 6
                                      local.get 6
                                      local.get 0
                                      local.get 8
                                      i32.const 29
                                      i32.shr_u
                                      i32.const 4
                                      i32.and
                                      i32.add
                                      i32.const 16
                                      i32.add
                                      i32.load
                                      local.tee 11
                                      i32.eq
                                      select
                                      local.get 4
                                      local.get 6
                                      select
                                      local.set 4
                                      local.get 8
                                      i32.const 1
                                      i32.shl
                                      local.set 8
                                      local.get 11
                                      local.set 0
                                      local.get 11
                                      br_if 0 (;@17;)
                                    end
                                  end
                                  block  ;; label = @16
                                    local.get 4
                                    local.get 9
                                    i32.or
                                    br_if 0 (;@16;)
                                    i32.const 0
                                    local.set 9
                                    i32.const 2
                                    local.get 7
                                    i32.shl
                                    local.tee 4
                                    i32.const 0
                                    local.get 4
                                    i32.sub
                                    i32.or
                                    local.get 10
                                    i32.and
                                    local.tee 4
                                    i32.eqz
                                    br_if 3 (;@13;)
                                    local.get 4
                                    i32.ctz
                                    i32.const 2
                                    i32.shl
                                    i32.const 1062608
                                    i32.add
                                    i32.load
                                    local.set 4
                                  end
                                  local.get 4
                                  i32.eqz
                                  br_if 1 (;@14;)
                                end
                                loop  ;; label = @15
                                  local.get 4
                                  i32.load offset=4
                                  i32.const -8
                                  i32.and
                                  local.get 5
                                  i32.sub
                                  local.tee 6
                                  local.get 3
                                  i32.lt_u
                                  local.set 8
                                  block  ;; label = @16
                                    local.get 4
                                    i32.load offset=16
                                    local.tee 0
                                    br_if 0 (;@16;)
                                    local.get 4
                                    i32.load offset=20
                                    local.set 0
                                  end
                                  local.get 6
                                  local.get 3
                                  local.get 8
                                  select
                                  local.set 3
                                  local.get 4
                                  local.get 9
                                  local.get 8
                                  select
                                  local.set 9
                                  local.get 0
                                  local.set 4
                                  local.get 0
                                  br_if 0 (;@15;)
                                end
                              end
                              local.get 9
                              i32.eqz
                              br_if 0 (;@13;)
                              local.get 3
                              i32.const 0
                              i32.load offset=1062312
                              local.get 5
                              i32.sub
                              i32.ge_u
                              br_if 0 (;@13;)
                              local.get 9
                              i32.load offset=24
                              local.set 11
                              block  ;; label = @14
                                local.get 9
                                i32.load offset=12
                                local.tee 4
                                local.get 9
                                i32.eq
                                br_if 0 (;@14;)
                                local.get 9
                                i32.load offset=8
                                local.tee 0
                                local.get 4
                                i32.store offset=12
                                local.get 4
                                local.get 0
                                i32.store offset=8
                                br 11 (;@3;)
                              end
                              block  ;; label = @14
                                block  ;; label = @15
                                  local.get 9
                                  i32.load offset=20
                                  local.tee 0
                                  i32.eqz
                                  br_if 0 (;@15;)
                                  local.get 9
                                  i32.const 20
                                  i32.add
                                  local.set 8
                                  br 1 (;@14;)
                                end
                                local.get 9
                                i32.load offset=16
                                local.tee 0
                                i32.eqz
                                br_if 4 (;@10;)
                                local.get 9
                                i32.const 16
                                i32.add
                                local.set 8
                              end
                              loop  ;; label = @14
                                local.get 8
                                local.set 6
                                local.get 0
                                local.tee 4
                                i32.const 20
                                i32.add
                                local.set 8
                                local.get 4
                                i32.load offset=20
                                local.tee 0
                                br_if 0 (;@14;)
                                local.get 4
                                i32.const 16
                                i32.add
                                local.set 8
                                local.get 4
                                i32.load offset=16
                                local.tee 0
                                br_if 0 (;@14;)
                              end
                              local.get 6
                              i32.const 0
                              i32.store
                              br 10 (;@3;)
                            end
                            block  ;; label = @13
                              i32.const 0
                              i32.load offset=1062312
                              local.tee 4
                              local.get 5
                              i32.lt_u
                              br_if 0 (;@13;)
                              i32.const 0
                              i32.load offset=1062324
                              local.set 3
                              block  ;; label = @14
                                block  ;; label = @15
                                  local.get 4
                                  local.get 5
                                  i32.sub
                                  local.tee 0
                                  i32.const 16
                                  i32.lt_u
                                  br_if 0 (;@15;)
                                  local.get 3
                                  local.get 5
                                  i32.add
                                  local.tee 8
                                  local.get 0
                                  i32.const 1
                                  i32.or
                                  i32.store offset=4
                                  local.get 3
                                  local.get 4
                                  i32.add
                                  local.get 0
                                  i32.store
                                  local.get 3
                                  local.get 5
                                  i32.const 3
                                  i32.or
                                  i32.store offset=4
                                  br 1 (;@14;)
                                end
                                local.get 3
                                local.get 4
                                i32.const 3
                                i32.or
                                i32.store offset=4
                                local.get 3
                                local.get 4
                                i32.add
                                local.tee 4
                                local.get 4
                                i32.load offset=4
                                i32.const 1
                                i32.or
                                i32.store offset=4
                                i32.const 0
                                local.set 8
                                i32.const 0
                                local.set 0
                              end
                              i32.const 0
                              local.get 0
                              i32.store offset=1062312
                              i32.const 0
                              local.get 8
                              i32.store offset=1062324
                              local.get 3
                              i32.const 8
                              i32.add
                              local.set 4
                              br 12 (;@1;)
                            end
                            block  ;; label = @13
                              i32.const 0
                              i32.load offset=1062316
                              local.tee 0
                              local.get 5
                              i32.le_u
                              br_if 0 (;@13;)
                              local.get 2
                              local.get 5
                              i32.add
                              local.tee 4
                              local.get 0
                              local.get 5
                              i32.sub
                              local.tee 3
                              i32.const 1
                              i32.or
                              i32.store offset=4
                              i32.const 0
                              local.get 4
                              i32.store offset=1062328
                              i32.const 0
                              local.get 3
                              i32.store offset=1062316
                              local.get 2
                              local.get 5
                              i32.const 3
                              i32.or
                              i32.store offset=4
                              local.get 2
                              i32.const 8
                              i32.add
                              local.set 4
                              br 12 (;@1;)
                            end
                            block  ;; label = @13
                              block  ;; label = @14
                                i32.const 0
                                i32.load offset=1062776
                                i32.eqz
                                br_if 0 (;@14;)
                                i32.const 0
                                i32.load offset=1062784
                                local.set 3
                                br 1 (;@13;)
                              end
                              i32.const 0
                              i64.const -1
                              i64.store offset=1062788 align=4
                              i32.const 0
                              i64.const 281474976776192
                              i64.store offset=1062780 align=4
                              i32.const 0
                              local.get 1
                              i32.const 12
                              i32.add
                              i32.const -16
                              i32.and
                              i32.const 1431655768
                              i32.xor
                              i32.store offset=1062776
                              i32.const 0
                              i32.const 0
                              i32.store offset=1062796
                              i32.const 0
                              i32.const 0
                              i32.store offset=1062748
                              i32.const 65536
                              local.set 3
                            end
                            i32.const 0
                            local.set 4
                            block  ;; label = @13
                              local.get 3
                              local.get 5
                              i32.const 71
                              i32.add
                              local.tee 11
                              i32.add
                              local.tee 8
                              i32.const 0
                              local.get 3
                              i32.sub
                              local.tee 6
                              i32.and
                              local.tee 9
                              local.get 5
                              i32.gt_u
                              br_if 0 (;@13;)
                              i32.const 0
                              i32.const 48
                              i32.store offset=1062800
                              br 12 (;@1;)
                            end
                            block  ;; label = @13
                              i32.const 0
                              i32.load offset=1062744
                              local.tee 4
                              i32.eqz
                              br_if 0 (;@13;)
                              block  ;; label = @14
                                i32.const 0
                                i32.load offset=1062736
                                local.tee 3
                                local.get 9
                                i32.add
                                local.tee 7
                                local.get 3
                                i32.le_u
                                br_if 0 (;@14;)
                                local.get 7
                                local.get 4
                                i32.le_u
                                br_if 1 (;@13;)
                              end
                              i32.const 0
                              local.set 4
                              i32.const 0
                              i32.const 48
                              i32.store offset=1062800
                              br 12 (;@1;)
                            end
                            i32.const 0
                            i32.load8_u offset=1062748
                            i32.const 4
                            i32.and
                            br_if 5 (;@7;)
                            block  ;; label = @13
                              block  ;; label = @14
                                block  ;; label = @15
                                  local.get 2
                                  i32.eqz
                                  br_if 0 (;@15;)
                                  i32.const 1062752
                                  local.set 4
                                  loop  ;; label = @16
                                    block  ;; label = @17
                                      local.get 4
                                      i32.load
                                      local.tee 3
                                      local.get 2
                                      i32.gt_u
                                      br_if 0 (;@17;)
                                      local.get 3
                                      local.get 4
                                      i32.load offset=4
                                      i32.add
                                      local.get 2
                                      i32.gt_u
                                      br_if 3 (;@14;)
                                    end
                                    local.get 4
                                    i32.load offset=8
                                    local.tee 4
                                    br_if 0 (;@16;)
                                  end
                                end
                                i32.const 0
                                call $sbrk
                                local.tee 8
                                i32.const -1
                                i32.eq
                                br_if 6 (;@8;)
                                local.get 9
                                local.set 6
                                block  ;; label = @15
                                  i32.const 0
                                  i32.load offset=1062780
                                  local.tee 4
                                  i32.const -1
                                  i32.add
                                  local.tee 3
                                  local.get 8
                                  i32.and
                                  i32.eqz
                                  br_if 0 (;@15;)
                                  local.get 9
                                  local.get 8
                                  i32.sub
                                  local.get 3
                                  local.get 8
                                  i32.add
                                  i32.const 0
                                  local.get 4
                                  i32.sub
                                  i32.and
                                  i32.add
                                  local.set 6
                                end
                                local.get 6
                                local.get 5
                                i32.le_u
                                br_if 6 (;@8;)
                                local.get 6
                                i32.const 2147483646
                                i32.gt_u
                                br_if 6 (;@8;)
                                block  ;; label = @15
                                  i32.const 0
                                  i32.load offset=1062744
                                  local.tee 4
                                  i32.eqz
                                  br_if 0 (;@15;)
                                  i32.const 0
                                  i32.load offset=1062736
                                  local.tee 3
                                  local.get 6
                                  i32.add
                                  local.tee 0
                                  local.get 3
                                  i32.le_u
                                  br_if 7 (;@8;)
                                  local.get 0
                                  local.get 4
                                  i32.gt_u
                                  br_if 7 (;@8;)
                                end
                                local.get 6
                                call $sbrk
                                local.tee 4
                                local.get 8
                                i32.ne
                                br_if 1 (;@13;)
                                br 8 (;@6;)
                              end
                              local.get 8
                              local.get 0
                              i32.sub
                              local.get 6
                              i32.and
                              local.tee 6
                              i32.const 2147483646
                              i32.gt_u
                              br_if 5 (;@8;)
                              local.get 6
                              call $sbrk
                              local.tee 8
                              local.get 4
                              i32.load
                              local.get 4
                              i32.load offset=4
                              i32.add
                              i32.eq
                              br_if 4 (;@9;)
                              local.get 8
                              local.set 4
                            end
                            block  ;; label = @13
                              local.get 6
                              local.get 5
                              i32.const 72
                              i32.add
                              i32.ge_u
                              br_if 0 (;@13;)
                              local.get 4
                              i32.const -1
                              i32.eq
                              br_if 0 (;@13;)
                              block  ;; label = @14
                                local.get 11
                                local.get 6
                                i32.sub
                                i32.const 0
                                i32.load offset=1062784
                                local.tee 3
                                i32.add
                                i32.const 0
                                local.get 3
                                i32.sub
                                i32.and
                                local.tee 3
                                i32.const 2147483646
                                i32.le_u
                                br_if 0 (;@14;)
                                local.get 4
                                local.set 8
                                br 8 (;@6;)
                              end
                              block  ;; label = @14
                                local.get 3
                                call $sbrk
                                i32.const -1
                                i32.eq
                                br_if 0 (;@14;)
                                local.get 3
                                local.get 6
                                i32.add
                                local.set 6
                                local.get 4
                                local.set 8
                                br 8 (;@6;)
                              end
                              i32.const 0
                              local.get 6
                              i32.sub
                              call $sbrk
                              drop
                              br 5 (;@8;)
                            end
                            local.get 4
                            local.set 8
                            local.get 4
                            i32.const -1
                            i32.ne
                            br_if 6 (;@6;)
                            br 4 (;@8;)
                          end
                          unreachable
                        end
                        i32.const 0
                        local.set 4
                        br 8 (;@2;)
                      end
                      i32.const 0
                      local.set 4
                      br 6 (;@3;)
                    end
                    local.get 8
                    i32.const -1
                    i32.ne
                    br_if 2 (;@6;)
                  end
                  i32.const 0
                  i32.const 0
                  i32.load offset=1062748
                  i32.const 4
                  i32.or
                  i32.store offset=1062748
                end
                local.get 9
                i32.const 2147483646
                i32.gt_u
                br_if 1 (;@5;)
                local.get 9
                call $sbrk
                local.set 8
                i32.const 0
                call $sbrk
                local.set 4
                local.get 8
                i32.const -1
                i32.eq
                br_if 1 (;@5;)
                local.get 4
                i32.const -1
                i32.eq
                br_if 1 (;@5;)
                local.get 8
                local.get 4
                i32.ge_u
                br_if 1 (;@5;)
                local.get 4
                local.get 8
                i32.sub
                local.tee 6
                local.get 5
                i32.const 56
                i32.add
                i32.le_u
                br_if 1 (;@5;)
              end
              i32.const 0
              i32.const 0
              i32.load offset=1062736
              local.get 6
              i32.add
              local.tee 4
              i32.store offset=1062736
              block  ;; label = @6
                local.get 4
                i32.const 0
                i32.load offset=1062740
                i32.le_u
                br_if 0 (;@6;)
                i32.const 0
                local.get 4
                i32.store offset=1062740
              end
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      i32.const 0
                      i32.load offset=1062328
                      local.tee 3
                      i32.eqz
                      br_if 0 (;@9;)
                      i32.const 1062752
                      local.set 4
                      loop  ;; label = @10
                        local.get 8
                        local.get 4
                        i32.load
                        local.tee 0
                        local.get 4
                        i32.load offset=4
                        local.tee 9
                        i32.add
                        i32.eq
                        br_if 2 (;@8;)
                        local.get 4
                        i32.load offset=8
                        local.tee 4
                        br_if 0 (;@10;)
                        br 3 (;@7;)
                      end
                    end
                    block  ;; label = @9
                      block  ;; label = @10
                        i32.const 0
                        i32.load offset=1062320
                        local.tee 4
                        i32.eqz
                        br_if 0 (;@10;)
                        local.get 8
                        local.get 4
                        i32.ge_u
                        br_if 1 (;@9;)
                      end
                      i32.const 0
                      local.get 8
                      i32.store offset=1062320
                    end
                    i32.const 0
                    local.set 4
                    i32.const 0
                    local.get 6
                    i32.store offset=1062756
                    i32.const 0
                    local.get 8
                    i32.store offset=1062752
                    i32.const 0
                    i32.const -1
                    i32.store offset=1062336
                    i32.const 0
                    i32.const 0
                    i32.load offset=1062776
                    i32.store offset=1062340
                    i32.const 0
                    i32.const 0
                    i32.store offset=1062764
                    loop  ;; label = @9
                      local.get 4
                      i32.const 1062364
                      i32.add
                      local.get 4
                      i32.const 1062352
                      i32.add
                      local.tee 3
                      i32.store
                      local.get 3
                      local.get 4
                      i32.const 1062344
                      i32.add
                      local.tee 0
                      i32.store
                      local.get 4
                      i32.const 1062356
                      i32.add
                      local.get 0
                      i32.store
                      local.get 4
                      i32.const 1062372
                      i32.add
                      local.get 4
                      i32.const 1062360
                      i32.add
                      local.tee 0
                      i32.store
                      local.get 0
                      local.get 3
                      i32.store
                      local.get 4
                      i32.const 1062380
                      i32.add
                      local.get 4
                      i32.const 1062368
                      i32.add
                      local.tee 3
                      i32.store
                      local.get 3
                      local.get 0
                      i32.store
                      local.get 4
                      i32.const 1062376
                      i32.add
                      local.get 3
                      i32.store
                      local.get 4
                      i32.const 32
                      i32.add
                      local.tee 4
                      i32.const 256
                      i32.ne
                      br_if 0 (;@9;)
                    end
                    local.get 8
                    i32.const -8
                    local.get 8
                    i32.sub
                    i32.const 15
                    i32.and
                    local.tee 4
                    i32.add
                    local.tee 3
                    local.get 6
                    i32.const -56
                    i32.add
                    local.tee 0
                    local.get 4
                    i32.sub
                    local.tee 4
                    i32.const 1
                    i32.or
                    i32.store offset=4
                    i32.const 0
                    i32.const 0
                    i32.load offset=1062792
                    i32.store offset=1062332
                    i32.const 0
                    local.get 4
                    i32.store offset=1062316
                    i32.const 0
                    local.get 3
                    i32.store offset=1062328
                    local.get 8
                    local.get 0
                    i32.add
                    i32.const 56
                    i32.store offset=4
                    br 2 (;@6;)
                  end
                  local.get 3
                  local.get 8
                  i32.ge_u
                  br_if 0 (;@7;)
                  local.get 3
                  local.get 0
                  i32.lt_u
                  br_if 0 (;@7;)
                  local.get 4
                  i32.load offset=12
                  i32.const 8
                  i32.and
                  br_if 0 (;@7;)
                  local.get 3
                  i32.const -8
                  local.get 3
                  i32.sub
                  i32.const 15
                  i32.and
                  local.tee 0
                  i32.add
                  local.tee 8
                  i32.const 0
                  i32.load offset=1062316
                  local.get 6
                  i32.add
                  local.tee 11
                  local.get 0
                  i32.sub
                  local.tee 0
                  i32.const 1
                  i32.or
                  i32.store offset=4
                  local.get 4
                  local.get 9
                  local.get 6
                  i32.add
                  i32.store offset=4
                  i32.const 0
                  i32.const 0
                  i32.load offset=1062792
                  i32.store offset=1062332
                  i32.const 0
                  local.get 0
                  i32.store offset=1062316
                  i32.const 0
                  local.get 8
                  i32.store offset=1062328
                  local.get 3
                  local.get 11
                  i32.add
                  i32.const 56
                  i32.store offset=4
                  br 1 (;@6;)
                end
                block  ;; label = @7
                  local.get 8
                  i32.const 0
                  i32.load offset=1062320
                  i32.ge_u
                  br_if 0 (;@7;)
                  i32.const 0
                  local.get 8
                  i32.store offset=1062320
                end
                local.get 8
                local.get 6
                i32.add
                local.set 0
                i32.const 1062752
                local.set 4
                block  ;; label = @7
                  block  ;; label = @8
                    loop  ;; label = @9
                      local.get 4
                      i32.load
                      local.tee 9
                      local.get 0
                      i32.eq
                      br_if 1 (;@8;)
                      local.get 4
                      i32.load offset=8
                      local.tee 4
                      br_if 0 (;@9;)
                      br 2 (;@7;)
                    end
                  end
                  local.get 4
                  i32.load8_u offset=12
                  i32.const 8
                  i32.and
                  i32.eqz
                  br_if 3 (;@4;)
                end
                i32.const 1062752
                local.set 4
                block  ;; label = @7
                  loop  ;; label = @8
                    block  ;; label = @9
                      local.get 4
                      i32.load
                      local.tee 0
                      local.get 3
                      i32.gt_u
                      br_if 0 (;@9;)
                      local.get 0
                      local.get 4
                      i32.load offset=4
                      i32.add
                      local.tee 0
                      local.get 3
                      i32.gt_u
                      br_if 2 (;@7;)
                    end
                    local.get 4
                    i32.load offset=8
                    local.set 4
                    br 0 (;@8;)
                  end
                end
                local.get 8
                i32.const -8
                local.get 8
                i32.sub
                i32.const 15
                i32.and
                local.tee 4
                i32.add
                local.tee 11
                local.get 6
                i32.const -56
                i32.add
                local.tee 9
                local.get 4
                i32.sub
                local.tee 4
                i32.const 1
                i32.or
                i32.store offset=4
                local.get 8
                local.get 9
                i32.add
                i32.const 56
                i32.store offset=4
                local.get 3
                local.get 0
                i32.const 55
                local.get 0
                i32.sub
                i32.const 15
                i32.and
                i32.add
                i32.const -63
                i32.add
                local.tee 9
                local.get 9
                local.get 3
                i32.const 16
                i32.add
                i32.lt_u
                select
                local.tee 9
                i32.const 35
                i32.store offset=4
                i32.const 0
                i32.const 0
                i32.load offset=1062792
                i32.store offset=1062332
                i32.const 0
                local.get 4
                i32.store offset=1062316
                i32.const 0
                local.get 11
                i32.store offset=1062328
                local.get 9
                i32.const 16
                i32.add
                i32.const 0
                i64.load offset=1062760 align=4
                i64.store align=4
                local.get 9
                i32.const 0
                i64.load offset=1062752 align=4
                i64.store offset=8 align=4
                i32.const 0
                local.get 9
                i32.const 8
                i32.add
                i32.store offset=1062760
                i32.const 0
                local.get 6
                i32.store offset=1062756
                i32.const 0
                local.get 8
                i32.store offset=1062752
                i32.const 0
                i32.const 0
                i32.store offset=1062764
                local.get 9
                i32.const 36
                i32.add
                local.set 4
                loop  ;; label = @7
                  local.get 4
                  i32.const 7
                  i32.store
                  local.get 4
                  i32.const 4
                  i32.add
                  local.tee 4
                  local.get 0
                  i32.lt_u
                  br_if 0 (;@7;)
                end
                local.get 9
                local.get 3
                i32.eq
                br_if 0 (;@6;)
                local.get 9
                local.get 9
                i32.load offset=4
                i32.const -2
                i32.and
                i32.store offset=4
                local.get 9
                local.get 9
                local.get 3
                i32.sub
                local.tee 8
                i32.store
                local.get 3
                local.get 8
                i32.const 1
                i32.or
                i32.store offset=4
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 8
                    i32.const 255
                    i32.gt_u
                    br_if 0 (;@8;)
                    local.get 8
                    i32.const -8
                    i32.and
                    i32.const 1062344
                    i32.add
                    local.set 4
                    block  ;; label = @9
                      block  ;; label = @10
                        i32.const 0
                        i32.load offset=1062304
                        local.tee 0
                        i32.const 1
                        local.get 8
                        i32.const 3
                        i32.shr_u
                        i32.shl
                        local.tee 8
                        i32.and
                        br_if 0 (;@10;)
                        i32.const 0
                        local.get 0
                        local.get 8
                        i32.or
                        i32.store offset=1062304
                        local.get 4
                        local.set 0
                        br 1 (;@9;)
                      end
                      local.get 4
                      i32.load offset=8
                      local.set 0
                    end
                    local.get 0
                    local.get 3
                    i32.store offset=12
                    local.get 4
                    local.get 3
                    i32.store offset=8
                    i32.const 12
                    local.set 8
                    i32.const 8
                    local.set 9
                    br 1 (;@7;)
                  end
                  i32.const 31
                  local.set 4
                  block  ;; label = @8
                    local.get 8
                    i32.const 16777215
                    i32.gt_u
                    br_if 0 (;@8;)
                    local.get 8
                    i32.const 38
                    local.get 8
                    i32.const 8
                    i32.shr_u
                    i32.clz
                    local.tee 4
                    i32.sub
                    i32.shr_u
                    i32.const 1
                    i32.and
                    local.get 4
                    i32.const 1
                    i32.shl
                    i32.sub
                    i32.const 62
                    i32.add
                    local.set 4
                  end
                  local.get 3
                  local.get 4
                  i32.store offset=28
                  local.get 3
                  i64.const 0
                  i64.store offset=16 align=4
                  local.get 4
                  i32.const 2
                  i32.shl
                  i32.const 1062608
                  i32.add
                  local.set 0
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        i32.const 0
                        i32.load offset=1062308
                        local.tee 9
                        i32.const 1
                        local.get 4
                        i32.shl
                        local.tee 6
                        i32.and
                        br_if 0 (;@10;)
                        local.get 0
                        local.get 3
                        i32.store
                        i32.const 0
                        local.get 9
                        local.get 6
                        i32.or
                        i32.store offset=1062308
                        local.get 3
                        local.get 0
                        i32.store offset=24
                        br 1 (;@9;)
                      end
                      local.get 8
                      i32.const 0
                      i32.const 25
                      local.get 4
                      i32.const 1
                      i32.shr_u
                      i32.sub
                      local.get 4
                      i32.const 31
                      i32.eq
                      select
                      i32.shl
                      local.set 4
                      local.get 0
                      i32.load
                      local.set 9
                      loop  ;; label = @10
                        local.get 9
                        local.tee 0
                        i32.load offset=4
                        i32.const -8
                        i32.and
                        local.get 8
                        i32.eq
                        br_if 2 (;@8;)
                        local.get 4
                        i32.const 29
                        i32.shr_u
                        local.set 9
                        local.get 4
                        i32.const 1
                        i32.shl
                        local.set 4
                        local.get 0
                        local.get 9
                        i32.const 4
                        i32.and
                        i32.add
                        i32.const 16
                        i32.add
                        local.tee 6
                        i32.load
                        local.tee 9
                        br_if 0 (;@10;)
                      end
                      local.get 6
                      local.get 3
                      i32.store
                      local.get 3
                      local.get 0
                      i32.store offset=24
                    end
                    i32.const 8
                    local.set 8
                    i32.const 12
                    local.set 9
                    local.get 3
                    local.set 0
                    local.get 3
                    local.set 4
                    br 1 (;@7;)
                  end
                  local.get 0
                  i32.load offset=8
                  local.set 4
                  local.get 0
                  local.get 3
                  i32.store offset=8
                  local.get 4
                  local.get 3
                  i32.store offset=12
                  local.get 3
                  local.get 4
                  i32.store offset=8
                  i32.const 0
                  local.set 4
                  i32.const 24
                  local.set 8
                  i32.const 12
                  local.set 9
                end
                local.get 3
                local.get 9
                i32.add
                local.get 0
                i32.store
                local.get 3
                local.get 8
                i32.add
                local.get 4
                i32.store
              end
              i32.const 0
              i32.load offset=1062316
              local.tee 4
              local.get 5
              i32.le_u
              br_if 0 (;@5;)
              i32.const 0
              i32.load offset=1062328
              local.tee 3
              local.get 5
              i32.add
              local.tee 0
              local.get 4
              local.get 5
              i32.sub
              local.tee 4
              i32.const 1
              i32.or
              i32.store offset=4
              i32.const 0
              local.get 4
              i32.store offset=1062316
              i32.const 0
              local.get 0
              i32.store offset=1062328
              local.get 3
              local.get 5
              i32.const 3
              i32.or
              i32.store offset=4
              local.get 3
              i32.const 8
              i32.add
              local.set 4
              br 4 (;@1;)
            end
            i32.const 0
            local.set 4
            i32.const 0
            i32.const 48
            i32.store offset=1062800
            br 3 (;@1;)
          end
          local.get 4
          local.get 8
          i32.store
          local.get 4
          local.get 4
          i32.load offset=4
          local.get 6
          i32.add
          i32.store offset=4
          local.get 8
          local.get 9
          local.get 5
          call $prepend_alloc
          local.set 4
          br 2 (;@1;)
        end
        block  ;; label = @3
          local.get 11
          i32.eqz
          br_if 0 (;@3;)
          block  ;; label = @4
            block  ;; label = @5
              local.get 9
              local.get 9
              i32.load offset=28
              local.tee 8
              i32.const 2
              i32.shl
              i32.const 1062608
              i32.add
              local.tee 0
              i32.load
              i32.ne
              br_if 0 (;@5;)
              local.get 0
              local.get 4
              i32.store
              local.get 4
              br_if 1 (;@4;)
              i32.const 0
              local.get 10
              i32.const -2
              local.get 8
              i32.rotl
              i32.and
              local.tee 10
              i32.store offset=1062308
              br 2 (;@3;)
            end
            local.get 11
            i32.const 16
            i32.const 20
            local.get 11
            i32.load offset=16
            local.get 9
            i32.eq
            select
            i32.add
            local.get 4
            i32.store
            local.get 4
            i32.eqz
            br_if 1 (;@3;)
          end
          local.get 4
          local.get 11
          i32.store offset=24
          block  ;; label = @4
            local.get 9
            i32.load offset=16
            local.tee 0
            i32.eqz
            br_if 0 (;@4;)
            local.get 4
            local.get 0
            i32.store offset=16
            local.get 0
            local.get 4
            i32.store offset=24
          end
          local.get 9
          i32.load offset=20
          local.tee 0
          i32.eqz
          br_if 0 (;@3;)
          local.get 4
          local.get 0
          i32.store offset=20
          local.get 0
          local.get 4
          i32.store offset=24
        end
        block  ;; label = @3
          block  ;; label = @4
            local.get 3
            i32.const 15
            i32.gt_u
            br_if 0 (;@4;)
            local.get 9
            local.get 3
            local.get 5
            i32.or
            local.tee 4
            i32.const 3
            i32.or
            i32.store offset=4
            local.get 9
            local.get 4
            i32.add
            local.tee 4
            local.get 4
            i32.load offset=4
            i32.const 1
            i32.or
            i32.store offset=4
            br 1 (;@3;)
          end
          local.get 9
          local.get 5
          i32.add
          local.tee 8
          local.get 3
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 9
          local.get 5
          i32.const 3
          i32.or
          i32.store offset=4
          local.get 8
          local.get 3
          i32.add
          local.get 3
          i32.store
          block  ;; label = @4
            local.get 3
            i32.const 255
            i32.gt_u
            br_if 0 (;@4;)
            local.get 3
            i32.const -8
            i32.and
            i32.const 1062344
            i32.add
            local.set 4
            block  ;; label = @5
              block  ;; label = @6
                i32.const 0
                i32.load offset=1062304
                local.tee 5
                i32.const 1
                local.get 3
                i32.const 3
                i32.shr_u
                i32.shl
                local.tee 3
                i32.and
                br_if 0 (;@6;)
                i32.const 0
                local.get 5
                local.get 3
                i32.or
                i32.store offset=1062304
                local.get 4
                local.set 3
                br 1 (;@5;)
              end
              local.get 4
              i32.load offset=8
              local.set 3
            end
            local.get 3
            local.get 8
            i32.store offset=12
            local.get 4
            local.get 8
            i32.store offset=8
            local.get 8
            local.get 4
            i32.store offset=12
            local.get 8
            local.get 3
            i32.store offset=8
            br 1 (;@3;)
          end
          i32.const 31
          local.set 4
          block  ;; label = @4
            local.get 3
            i32.const 16777215
            i32.gt_u
            br_if 0 (;@4;)
            local.get 3
            i32.const 38
            local.get 3
            i32.const 8
            i32.shr_u
            i32.clz
            local.tee 4
            i32.sub
            i32.shr_u
            i32.const 1
            i32.and
            local.get 4
            i32.const 1
            i32.shl
            i32.sub
            i32.const 62
            i32.add
            local.set 4
          end
          local.get 8
          local.get 4
          i32.store offset=28
          local.get 8
          i64.const 0
          i64.store offset=16 align=4
          local.get 4
          i32.const 2
          i32.shl
          i32.const 1062608
          i32.add
          local.set 5
          block  ;; label = @4
            local.get 10
            i32.const 1
            local.get 4
            i32.shl
            local.tee 0
            i32.and
            br_if 0 (;@4;)
            local.get 5
            local.get 8
            i32.store
            i32.const 0
            local.get 10
            local.get 0
            i32.or
            i32.store offset=1062308
            local.get 8
            local.get 5
            i32.store offset=24
            local.get 8
            local.get 8
            i32.store offset=8
            local.get 8
            local.get 8
            i32.store offset=12
            br 1 (;@3;)
          end
          local.get 3
          i32.const 0
          i32.const 25
          local.get 4
          i32.const 1
          i32.shr_u
          i32.sub
          local.get 4
          i32.const 31
          i32.eq
          select
          i32.shl
          local.set 4
          local.get 5
          i32.load
          local.set 0
          block  ;; label = @4
            loop  ;; label = @5
              local.get 0
              local.tee 5
              i32.load offset=4
              i32.const -8
              i32.and
              local.get 3
              i32.eq
              br_if 1 (;@4;)
              local.get 4
              i32.const 29
              i32.shr_u
              local.set 0
              local.get 4
              i32.const 1
              i32.shl
              local.set 4
              local.get 5
              local.get 0
              i32.const 4
              i32.and
              i32.add
              i32.const 16
              i32.add
              local.tee 6
              i32.load
              local.tee 0
              br_if 0 (;@5;)
            end
            local.get 6
            local.get 8
            i32.store
            local.get 8
            local.get 5
            i32.store offset=24
            local.get 8
            local.get 8
            i32.store offset=12
            local.get 8
            local.get 8
            i32.store offset=8
            br 1 (;@3;)
          end
          local.get 5
          i32.load offset=8
          local.tee 4
          local.get 8
          i32.store offset=12
          local.get 5
          local.get 8
          i32.store offset=8
          local.get 8
          i32.const 0
          i32.store offset=24
          local.get 8
          local.get 5
          i32.store offset=12
          local.get 8
          local.get 4
          i32.store offset=8
        end
        local.get 9
        i32.const 8
        i32.add
        local.set 4
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 2
        i32.eqz
        br_if 0 (;@2;)
        block  ;; label = @3
          block  ;; label = @4
            local.get 8
            local.get 8
            i32.load offset=28
            local.tee 9
            i32.const 2
            i32.shl
            i32.const 1062608
            i32.add
            local.tee 0
            i32.load
            i32.ne
            br_if 0 (;@4;)
            local.get 0
            local.get 4
            i32.store
            local.get 4
            br_if 1 (;@3;)
            i32.const 0
            local.get 10
            i32.const -2
            local.get 9
            i32.rotl
            i32.and
            i32.store offset=1062308
            br 2 (;@2;)
          end
          local.get 2
          i32.const 16
          i32.const 20
          local.get 2
          i32.load offset=16
          local.get 8
          i32.eq
          select
          i32.add
          local.get 4
          i32.store
          local.get 4
          i32.eqz
          br_if 1 (;@2;)
        end
        local.get 4
        local.get 2
        i32.store offset=24
        block  ;; label = @3
          local.get 8
          i32.load offset=16
          local.tee 0
          i32.eqz
          br_if 0 (;@3;)
          local.get 4
          local.get 0
          i32.store offset=16
          local.get 0
          local.get 4
          i32.store offset=24
        end
        local.get 8
        i32.load offset=20
        local.tee 0
        i32.eqz
        br_if 0 (;@2;)
        local.get 4
        local.get 0
        i32.store offset=20
        local.get 0
        local.get 4
        i32.store offset=24
      end
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          i32.const 15
          i32.gt_u
          br_if 0 (;@3;)
          local.get 8
          local.get 3
          local.get 5
          i32.or
          local.tee 4
          i32.const 3
          i32.or
          i32.store offset=4
          local.get 8
          local.get 4
          i32.add
          local.tee 4
          local.get 4
          i32.load offset=4
          i32.const 1
          i32.or
          i32.store offset=4
          br 1 (;@2;)
        end
        local.get 8
        local.get 5
        i32.add
        local.tee 0
        local.get 3
        i32.const 1
        i32.or
        i32.store offset=4
        local.get 8
        local.get 5
        i32.const 3
        i32.or
        i32.store offset=4
        local.get 0
        local.get 3
        i32.add
        local.get 3
        i32.store
        block  ;; label = @3
          local.get 7
          i32.eqz
          br_if 0 (;@3;)
          local.get 7
          i32.const -8
          i32.and
          i32.const 1062344
          i32.add
          local.set 5
          i32.const 0
          i32.load offset=1062324
          local.set 4
          block  ;; label = @4
            block  ;; label = @5
              i32.const 1
              local.get 7
              i32.const 3
              i32.shr_u
              i32.shl
              local.tee 9
              local.get 6
              i32.and
              br_if 0 (;@5;)
              i32.const 0
              local.get 9
              local.get 6
              i32.or
              i32.store offset=1062304
              local.get 5
              local.set 9
              br 1 (;@4;)
            end
            local.get 5
            i32.load offset=8
            local.set 9
          end
          local.get 9
          local.get 4
          i32.store offset=12
          local.get 5
          local.get 4
          i32.store offset=8
          local.get 4
          local.get 5
          i32.store offset=12
          local.get 4
          local.get 9
          i32.store offset=8
        end
        i32.const 0
        local.get 0
        i32.store offset=1062324
        i32.const 0
        local.get 3
        i32.store offset=1062312
      end
      local.get 8
      i32.const 8
      i32.add
      local.set 4
    end
    local.get 1
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 4)
  (func $prepend_alloc (type 5) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    local.get 0
    i32.const -8
    local.get 0
    i32.sub
    i32.const 15
    i32.and
    i32.add
    local.tee 3
    local.get 2
    i32.const 3
    i32.or
    i32.store offset=4
    local.get 1
    i32.const -8
    local.get 1
    i32.sub
    i32.const 15
    i32.and
    i32.add
    local.tee 4
    local.get 3
    local.get 2
    i32.add
    local.tee 5
    i32.sub
    local.set 0
    block  ;; label = @1
      block  ;; label = @2
        local.get 4
        i32.const 0
        i32.load offset=1062328
        i32.ne
        br_if 0 (;@2;)
        i32.const 0
        local.get 5
        i32.store offset=1062328
        i32.const 0
        i32.const 0
        i32.load offset=1062316
        local.get 0
        i32.add
        local.tee 2
        i32.store offset=1062316
        local.get 5
        local.get 2
        i32.const 1
        i32.or
        i32.store offset=4
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 4
        i32.const 0
        i32.load offset=1062324
        i32.ne
        br_if 0 (;@2;)
        i32.const 0
        local.get 5
        i32.store offset=1062324
        i32.const 0
        i32.const 0
        i32.load offset=1062312
        local.get 0
        i32.add
        local.tee 2
        i32.store offset=1062312
        local.get 5
        local.get 2
        i32.const 1
        i32.or
        i32.store offset=4
        local.get 5
        local.get 2
        i32.add
        local.get 2
        i32.store
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 4
        i32.load offset=4
        local.tee 1
        i32.const 3
        i32.and
        i32.const 1
        i32.ne
        br_if 0 (;@2;)
        local.get 1
        i32.const -8
        i32.and
        local.set 6
        local.get 4
        i32.load offset=12
        local.set 2
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            i32.const 255
            i32.gt_u
            br_if 0 (;@4;)
            block  ;; label = @5
              local.get 2
              local.get 4
              i32.load offset=8
              local.tee 7
              i32.ne
              br_if 0 (;@5;)
              i32.const 0
              i32.const 0
              i32.load offset=1062304
              i32.const -2
              local.get 1
              i32.const 3
              i32.shr_u
              i32.rotl
              i32.and
              i32.store offset=1062304
              br 2 (;@3;)
            end
            local.get 2
            local.get 7
            i32.store offset=8
            local.get 7
            local.get 2
            i32.store offset=12
            br 1 (;@3;)
          end
          local.get 4
          i32.load offset=24
          local.set 8
          block  ;; label = @4
            block  ;; label = @5
              local.get 2
              local.get 4
              i32.eq
              br_if 0 (;@5;)
              local.get 4
              i32.load offset=8
              local.tee 1
              local.get 2
              i32.store offset=12
              local.get 2
              local.get 1
              i32.store offset=8
              br 1 (;@4;)
            end
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 4
                  i32.load offset=20
                  local.tee 1
                  i32.eqz
                  br_if 0 (;@7;)
                  local.get 4
                  i32.const 20
                  i32.add
                  local.set 7
                  br 1 (;@6;)
                end
                local.get 4
                i32.load offset=16
                local.tee 1
                i32.eqz
                br_if 1 (;@5;)
                local.get 4
                i32.const 16
                i32.add
                local.set 7
              end
              loop  ;; label = @6
                local.get 7
                local.set 9
                local.get 1
                local.tee 2
                i32.const 20
                i32.add
                local.set 7
                local.get 2
                i32.load offset=20
                local.tee 1
                br_if 0 (;@6;)
                local.get 2
                i32.const 16
                i32.add
                local.set 7
                local.get 2
                i32.load offset=16
                local.tee 1
                br_if 0 (;@6;)
              end
              local.get 9
              i32.const 0
              i32.store
              br 1 (;@4;)
            end
            i32.const 0
            local.set 2
          end
          local.get 8
          i32.eqz
          br_if 0 (;@3;)
          block  ;; label = @4
            block  ;; label = @5
              local.get 4
              local.get 4
              i32.load offset=28
              local.tee 7
              i32.const 2
              i32.shl
              i32.const 1062608
              i32.add
              local.tee 1
              i32.load
              i32.ne
              br_if 0 (;@5;)
              local.get 1
              local.get 2
              i32.store
              local.get 2
              br_if 1 (;@4;)
              i32.const 0
              i32.const 0
              i32.load offset=1062308
              i32.const -2
              local.get 7
              i32.rotl
              i32.and
              i32.store offset=1062308
              br 2 (;@3;)
            end
            local.get 8
            i32.const 16
            i32.const 20
            local.get 8
            i32.load offset=16
            local.get 4
            i32.eq
            select
            i32.add
            local.get 2
            i32.store
            local.get 2
            i32.eqz
            br_if 1 (;@3;)
          end
          local.get 2
          local.get 8
          i32.store offset=24
          block  ;; label = @4
            local.get 4
            i32.load offset=16
            local.tee 1
            i32.eqz
            br_if 0 (;@4;)
            local.get 2
            local.get 1
            i32.store offset=16
            local.get 1
            local.get 2
            i32.store offset=24
          end
          local.get 4
          i32.load offset=20
          local.tee 1
          i32.eqz
          br_if 0 (;@3;)
          local.get 2
          local.get 1
          i32.store offset=20
          local.get 1
          local.get 2
          i32.store offset=24
        end
        local.get 6
        local.get 0
        i32.add
        local.set 0
        local.get 4
        local.get 6
        i32.add
        local.tee 4
        i32.load offset=4
        local.set 1
      end
      local.get 4
      local.get 1
      i32.const -2
      i32.and
      i32.store offset=4
      local.get 5
      local.get 0
      i32.add
      local.get 0
      i32.store
      local.get 5
      local.get 0
      i32.const 1
      i32.or
      i32.store offset=4
      block  ;; label = @2
        local.get 0
        i32.const 255
        i32.gt_u
        br_if 0 (;@2;)
        local.get 0
        i32.const -8
        i32.and
        i32.const 1062344
        i32.add
        local.set 2
        block  ;; label = @3
          block  ;; label = @4
            i32.const 0
            i32.load offset=1062304
            local.tee 1
            i32.const 1
            local.get 0
            i32.const 3
            i32.shr_u
            i32.shl
            local.tee 0
            i32.and
            br_if 0 (;@4;)
            i32.const 0
            local.get 1
            local.get 0
            i32.or
            i32.store offset=1062304
            local.get 2
            local.set 0
            br 1 (;@3;)
          end
          local.get 2
          i32.load offset=8
          local.set 0
        end
        local.get 0
        local.get 5
        i32.store offset=12
        local.get 2
        local.get 5
        i32.store offset=8
        local.get 5
        local.get 2
        i32.store offset=12
        local.get 5
        local.get 0
        i32.store offset=8
        br 1 (;@1;)
      end
      i32.const 31
      local.set 2
      block  ;; label = @2
        local.get 0
        i32.const 16777215
        i32.gt_u
        br_if 0 (;@2;)
        local.get 0
        i32.const 38
        local.get 0
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
      local.get 5
      local.get 2
      i32.store offset=28
      local.get 5
      i64.const 0
      i64.store offset=16 align=4
      local.get 2
      i32.const 2
      i32.shl
      i32.const 1062608
      i32.add
      local.set 1
      block  ;; label = @2
        i32.const 0
        i32.load offset=1062308
        local.tee 7
        i32.const 1
        local.get 2
        i32.shl
        local.tee 4
        i32.and
        br_if 0 (;@2;)
        local.get 1
        local.get 5
        i32.store
        i32.const 0
        local.get 7
        local.get 4
        i32.or
        i32.store offset=1062308
        local.get 5
        local.get 1
        i32.store offset=24
        local.get 5
        local.get 5
        i32.store offset=8
        local.get 5
        local.get 5
        i32.store offset=12
        br 1 (;@1;)
      end
      local.get 0
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
      local.set 2
      local.get 1
      i32.load
      local.set 7
      block  ;; label = @2
        loop  ;; label = @3
          local.get 7
          local.tee 1
          i32.load offset=4
          i32.const -8
          i32.and
          local.get 0
          i32.eq
          br_if 1 (;@2;)
          local.get 2
          i32.const 29
          i32.shr_u
          local.set 7
          local.get 2
          i32.const 1
          i32.shl
          local.set 2
          local.get 1
          local.get 7
          i32.const 4
          i32.and
          i32.add
          i32.const 16
          i32.add
          local.tee 4
          i32.load
          local.tee 7
          br_if 0 (;@3;)
        end
        local.get 4
        local.get 5
        i32.store
        local.get 5
        local.get 1
        i32.store offset=24
        local.get 5
        local.get 5
        i32.store offset=12
        local.get 5
        local.get 5
        i32.store offset=8
        br 1 (;@1;)
      end
      local.get 1
      i32.load offset=8
      local.tee 2
      local.get 5
      i32.store offset=12
      local.get 1
      local.get 5
      i32.store offset=8
      local.get 5
      i32.const 0
      i32.store offset=24
      local.get 5
      local.get 1
      i32.store offset=12
      local.get 5
      local.get 2
      i32.store offset=8
    end
    local.get 3
    i32.const 8
    i32.add)
  (func $free (type 1) (param i32)
    local.get 0
    call $dlfree)
  (func $dlfree (type 1) (param i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      local.get 0
      i32.eqz
      br_if 0 (;@1;)
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
        local.get 1
        i32.load
        local.tee 4
        i32.sub
        local.tee 1
        i32.const 0
        i32.load offset=1062320
        i32.lt_u
        br_if 1 (;@1;)
        local.get 4
        local.get 0
        i32.add
        local.set 0
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 1
                i32.const 0
                i32.load offset=1062324
                i32.eq
                br_if 0 (;@6;)
                local.get 1
                i32.load offset=12
                local.set 2
                block  ;; label = @7
                  local.get 4
                  i32.const 255
                  i32.gt_u
                  br_if 0 (;@7;)
                  local.get 2
                  local.get 1
                  i32.load offset=8
                  local.tee 5
                  i32.ne
                  br_if 2 (;@5;)
                  i32.const 0
                  i32.const 0
                  i32.load offset=1062304
                  i32.const -2
                  local.get 4
                  i32.const 3
                  i32.shr_u
                  i32.rotl
                  i32.and
                  i32.store offset=1062304
                  br 5 (;@2;)
                end
                local.get 1
                i32.load offset=24
                local.set 6
                block  ;; label = @7
                  local.get 2
                  local.get 1
                  i32.eq
                  br_if 0 (;@7;)
                  local.get 1
                  i32.load offset=8
                  local.tee 4
                  local.get 2
                  i32.store offset=12
                  local.get 2
                  local.get 4
                  i32.store offset=8
                  br 4 (;@3;)
                end
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 1
                    i32.load offset=20
                    local.tee 4
                    i32.eqz
                    br_if 0 (;@8;)
                    local.get 1
                    i32.const 20
                    i32.add
                    local.set 5
                    br 1 (;@7;)
                  end
                  local.get 1
                  i32.load offset=16
                  local.tee 4
                  i32.eqz
                  br_if 3 (;@4;)
                  local.get 1
                  i32.const 16
                  i32.add
                  local.set 5
                end
                loop  ;; label = @7
                  local.get 5
                  local.set 7
                  local.get 4
                  local.tee 2
                  i32.const 20
                  i32.add
                  local.set 5
                  local.get 2
                  i32.load offset=20
                  local.tee 4
                  br_if 0 (;@7;)
                  local.get 2
                  i32.const 16
                  i32.add
                  local.set 5
                  local.get 2
                  i32.load offset=16
                  local.tee 4
                  br_if 0 (;@7;)
                end
                local.get 7
                i32.const 0
                i32.store
                br 3 (;@3;)
              end
              local.get 3
              i32.load offset=4
              local.tee 2
              i32.const 3
              i32.and
              i32.const 3
              i32.ne
              br_if 3 (;@2;)
              local.get 3
              local.get 2
              i32.const -2
              i32.and
              i32.store offset=4
              i32.const 0
              local.get 0
              i32.store offset=1062312
              local.get 3
              local.get 0
              i32.store
              local.get 1
              local.get 0
              i32.const 1
              i32.or
              i32.store offset=4
              return
            end
            local.get 2
            local.get 5
            i32.store offset=8
            local.get 5
            local.get 2
            i32.store offset=12
            br 2 (;@2;)
          end
          i32.const 0
          local.set 2
        end
        local.get 6
        i32.eqz
        br_if 0 (;@2;)
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            local.get 1
            i32.load offset=28
            local.tee 5
            i32.const 2
            i32.shl
            i32.const 1062608
            i32.add
            local.tee 4
            i32.load
            i32.ne
            br_if 0 (;@4;)
            local.get 4
            local.get 2
            i32.store
            local.get 2
            br_if 1 (;@3;)
            i32.const 0
            i32.const 0
            i32.load offset=1062308
            i32.const -2
            local.get 5
            i32.rotl
            i32.and
            i32.store offset=1062308
            br 2 (;@2;)
          end
          local.get 6
          i32.const 16
          i32.const 20
          local.get 6
          i32.load offset=16
          local.get 1
          i32.eq
          select
          i32.add
          local.get 2
          i32.store
          local.get 2
          i32.eqz
          br_if 1 (;@2;)
        end
        local.get 2
        local.get 6
        i32.store offset=24
        block  ;; label = @3
          local.get 1
          i32.load offset=16
          local.tee 4
          i32.eqz
          br_if 0 (;@3;)
          local.get 2
          local.get 4
          i32.store offset=16
          local.get 4
          local.get 2
          i32.store offset=24
        end
        local.get 1
        i32.load offset=20
        local.tee 4
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        local.get 4
        i32.store offset=20
        local.get 4
        local.get 2
        i32.store offset=24
      end
      local.get 1
      local.get 3
      i32.ge_u
      br_if 0 (;@1;)
      local.get 3
      i32.load offset=4
      local.tee 4
      i32.const 1
      i32.and
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 4
                i32.const 2
                i32.and
                br_if 0 (;@6;)
                block  ;; label = @7
                  local.get 3
                  i32.const 0
                  i32.load offset=1062328
                  i32.ne
                  br_if 0 (;@7;)
                  i32.const 0
                  local.get 1
                  i32.store offset=1062328
                  i32.const 0
                  i32.const 0
                  i32.load offset=1062316
                  local.get 0
                  i32.add
                  local.tee 0
                  i32.store offset=1062316
                  local.get 1
                  local.get 0
                  i32.const 1
                  i32.or
                  i32.store offset=4
                  local.get 1
                  i32.const 0
                  i32.load offset=1062324
                  i32.ne
                  br_if 6 (;@1;)
                  i32.const 0
                  i32.const 0
                  i32.store offset=1062312
                  i32.const 0
                  i32.const 0
                  i32.store offset=1062324
                  return
                end
                block  ;; label = @7
                  local.get 3
                  i32.const 0
                  i32.load offset=1062324
                  i32.ne
                  br_if 0 (;@7;)
                  i32.const 0
                  local.get 1
                  i32.store offset=1062324
                  i32.const 0
                  i32.const 0
                  i32.load offset=1062312
                  local.get 0
                  i32.add
                  local.tee 0
                  i32.store offset=1062312
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
                local.get 4
                i32.const -8
                i32.and
                local.get 0
                i32.add
                local.set 0
                local.get 3
                i32.load offset=12
                local.set 2
                block  ;; label = @7
                  local.get 4
                  i32.const 255
                  i32.gt_u
                  br_if 0 (;@7;)
                  block  ;; label = @8
                    local.get 2
                    local.get 3
                    i32.load offset=8
                    local.tee 5
                    i32.ne
                    br_if 0 (;@8;)
                    i32.const 0
                    i32.const 0
                    i32.load offset=1062304
                    i32.const -2
                    local.get 4
                    i32.const 3
                    i32.shr_u
                    i32.rotl
                    i32.and
                    i32.store offset=1062304
                    br 5 (;@3;)
                  end
                  local.get 2
                  local.get 5
                  i32.store offset=8
                  local.get 5
                  local.get 2
                  i32.store offset=12
                  br 4 (;@3;)
                end
                local.get 3
                i32.load offset=24
                local.set 6
                block  ;; label = @7
                  local.get 2
                  local.get 3
                  i32.eq
                  br_if 0 (;@7;)
                  local.get 3
                  i32.load offset=8
                  local.tee 4
                  local.get 2
                  i32.store offset=12
                  local.get 2
                  local.get 4
                  i32.store offset=8
                  br 3 (;@4;)
                end
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 3
                    i32.load offset=20
                    local.tee 4
                    i32.eqz
                    br_if 0 (;@8;)
                    local.get 3
                    i32.const 20
                    i32.add
                    local.set 5
                    br 1 (;@7;)
                  end
                  local.get 3
                  i32.load offset=16
                  local.tee 4
                  i32.eqz
                  br_if 2 (;@5;)
                  local.get 3
                  i32.const 16
                  i32.add
                  local.set 5
                end
                loop  ;; label = @7
                  local.get 5
                  local.set 7
                  local.get 4
                  local.tee 2
                  i32.const 20
                  i32.add
                  local.set 5
                  local.get 2
                  i32.load offset=20
                  local.tee 4
                  br_if 0 (;@7;)
                  local.get 2
                  i32.const 16
                  i32.add
                  local.set 5
                  local.get 2
                  i32.load offset=16
                  local.tee 4
                  br_if 0 (;@7;)
                end
                local.get 7
                i32.const 0
                i32.store
                br 2 (;@4;)
              end
              local.get 3
              local.get 4
              i32.const -2
              i32.and
              i32.store offset=4
              local.get 1
              local.get 0
              i32.add
              local.get 0
              i32.store
              local.get 1
              local.get 0
              i32.const 1
              i32.or
              i32.store offset=4
              br 3 (;@2;)
            end
            i32.const 0
            local.set 2
          end
          local.get 6
          i32.eqz
          br_if 0 (;@3;)
          block  ;; label = @4
            block  ;; label = @5
              local.get 3
              local.get 3
              i32.load offset=28
              local.tee 5
              i32.const 2
              i32.shl
              i32.const 1062608
              i32.add
              local.tee 4
              i32.load
              i32.ne
              br_if 0 (;@5;)
              local.get 4
              local.get 2
              i32.store
              local.get 2
              br_if 1 (;@4;)
              i32.const 0
              i32.const 0
              i32.load offset=1062308
              i32.const -2
              local.get 5
              i32.rotl
              i32.and
              i32.store offset=1062308
              br 2 (;@3;)
            end
            local.get 6
            i32.const 16
            i32.const 20
            local.get 6
            i32.load offset=16
            local.get 3
            i32.eq
            select
            i32.add
            local.get 2
            i32.store
            local.get 2
            i32.eqz
            br_if 1 (;@3;)
          end
          local.get 2
          local.get 6
          i32.store offset=24
          block  ;; label = @4
            local.get 3
            i32.load offset=16
            local.tee 4
            i32.eqz
            br_if 0 (;@4;)
            local.get 2
            local.get 4
            i32.store offset=16
            local.get 4
            local.get 2
            i32.store offset=24
          end
          local.get 3
          i32.load offset=20
          local.tee 4
          i32.eqz
          br_if 0 (;@3;)
          local.get 2
          local.get 4
          i32.store offset=20
          local.get 4
          local.get 2
          i32.store offset=24
        end
        local.get 1
        local.get 0
        i32.add
        local.get 0
        i32.store
        local.get 1
        local.get 0
        i32.const 1
        i32.or
        i32.store offset=4
        local.get 1
        i32.const 0
        i32.load offset=1062324
        i32.ne
        br_if 0 (;@2;)
        i32.const 0
        local.get 0
        i32.store offset=1062312
        return
      end
      block  ;; label = @2
        local.get 0
        i32.const 255
        i32.gt_u
        br_if 0 (;@2;)
        local.get 0
        i32.const -8
        i32.and
        i32.const 1062344
        i32.add
        local.set 2
        block  ;; label = @3
          block  ;; label = @4
            i32.const 0
            i32.load offset=1062304
            local.tee 4
            i32.const 1
            local.get 0
            i32.const 3
            i32.shr_u
            i32.shl
            local.tee 0
            i32.and
            br_if 0 (;@4;)
            i32.const 0
            local.get 4
            local.get 0
            i32.or
            i32.store offset=1062304
            local.get 2
            local.set 0
            br 1 (;@3;)
          end
          local.get 2
          i32.load offset=8
          local.set 0
        end
        local.get 0
        local.get 1
        i32.store offset=12
        local.get 2
        local.get 1
        i32.store offset=8
        local.get 1
        local.get 2
        i32.store offset=12
        local.get 1
        local.get 0
        i32.store offset=8
        return
      end
      i32.const 31
      local.set 2
      block  ;; label = @2
        local.get 0
        i32.const 16777215
        i32.gt_u
        br_if 0 (;@2;)
        local.get 0
        i32.const 38
        local.get 0
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
      local.get 1
      local.get 2
      i32.store offset=28
      local.get 1
      i64.const 0
      i64.store offset=16 align=4
      local.get 2
      i32.const 2
      i32.shl
      i32.const 1062608
      i32.add
      local.set 3
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              i32.const 0
              i32.load offset=1062308
              local.tee 4
              i32.const 1
              local.get 2
              i32.shl
              local.tee 5
              i32.and
              br_if 0 (;@5;)
              i32.const 0
              local.get 4
              local.get 5
              i32.or
              i32.store offset=1062308
              i32.const 8
              local.set 0
              i32.const 24
              local.set 2
              local.get 3
              local.set 5
              br 1 (;@4;)
            end
            local.get 0
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
            local.set 2
            local.get 3
            i32.load
            local.set 5
            loop  ;; label = @5
              local.get 5
              local.tee 4
              i32.load offset=4
              i32.const -8
              i32.and
              local.get 0
              i32.eq
              br_if 2 (;@3;)
              local.get 2
              i32.const 29
              i32.shr_u
              local.set 5
              local.get 2
              i32.const 1
              i32.shl
              local.set 2
              local.get 4
              local.get 5
              i32.const 4
              i32.and
              i32.add
              i32.const 16
              i32.add
              local.tee 3
              i32.load
              local.tee 5
              br_if 0 (;@5;)
            end
            i32.const 8
            local.set 0
            i32.const 24
            local.set 2
            local.get 4
            local.set 5
          end
          local.get 1
          local.set 4
          local.get 1
          local.set 7
          br 1 (;@2;)
        end
        local.get 4
        i32.load offset=8
        local.tee 5
        local.get 1
        i32.store offset=12
        i32.const 8
        local.set 2
        local.get 4
        i32.const 8
        i32.add
        local.set 3
        i32.const 0
        local.set 7
        i32.const 24
        local.set 0
      end
      local.get 3
      local.get 1
      i32.store
      local.get 1
      local.get 2
      i32.add
      local.get 5
      i32.store
      local.get 1
      local.get 4
      i32.store offset=12
      local.get 1
      local.get 0
      i32.add
      local.get 7
      i32.store
      i32.const 0
      i32.const 0
      i32.load offset=1062336
      i32.const -1
      i32.add
      local.tee 1
      i32.const -1
      local.get 1
      select
      i32.store offset=1062336
    end)
  (func $calloc (type 2) (param i32 i32) (result i32)
    (local i32 i64)
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        br_if 0 (;@2;)
        i32.const 0
        local.set 2
        br 1 (;@1;)
      end
      local.get 0
      i64.extend_i32_u
      local.get 1
      i64.extend_i32_u
      i64.mul
      local.tee 3
      i32.wrap_i64
      local.set 2
      local.get 1
      local.get 0
      i32.or
      i32.const 65536
      i32.lt_u
      br_if 0 (;@1;)
      i32.const -1
      local.get 2
      local.get 3
      i64.const 32
      i64.shr_u
      i32.wrap_i64
      i32.const 0
      i32.ne
      select
      local.set 2
    end
    block  ;; label = @1
      local.get 2
      call $dlmalloc
      local.tee 0
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      i32.const -4
      i32.add
      i32.load8_u
      i32.const 3
      i32.and
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      i32.const 0
      local.get 2
      call $memset
      drop
    end
    local.get 0)
  (func $realloc (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      local.get 0
      br_if 0 (;@1;)
      local.get 1
      call $dlmalloc
      return
    end
    block  ;; label = @1
      local.get 1
      i32.const -64
      i32.lt_u
      br_if 0 (;@1;)
      i32.const 0
      i32.const 48
      i32.store offset=1062800
      i32.const 0
      return
    end
    i32.const 16
    local.get 1
    i32.const 19
    i32.add
    i32.const -16
    i32.and
    local.get 1
    i32.const 11
    i32.lt_u
    select
    local.set 2
    local.get 0
    i32.const -4
    i32.add
    local.tee 3
    i32.load
    local.tee 4
    i32.const -8
    i32.and
    local.set 5
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 4
          i32.const 3
          i32.and
          br_if 0 (;@3;)
          local.get 2
          i32.const 256
          i32.lt_u
          br_if 1 (;@2;)
          local.get 5
          local.get 2
          i32.const 4
          i32.or
          i32.lt_u
          br_if 1 (;@2;)
          local.get 5
          local.get 2
          i32.sub
          i32.const 0
          i32.load offset=1062784
          i32.const 1
          i32.shl
          i32.le_u
          br_if 2 (;@1;)
          br 1 (;@2;)
        end
        local.get 0
        i32.const -8
        i32.add
        local.tee 6
        local.get 5
        i32.add
        local.set 7
        block  ;; label = @3
          local.get 5
          local.get 2
          i32.lt_u
          br_if 0 (;@3;)
          local.get 5
          local.get 2
          i32.sub
          local.tee 1
          i32.const 16
          i32.lt_u
          br_if 2 (;@1;)
          local.get 3
          local.get 2
          local.get 4
          i32.const 1
          i32.and
          i32.or
          i32.const 2
          i32.or
          i32.store
          local.get 6
          local.get 2
          i32.add
          local.tee 2
          local.get 1
          i32.const 3
          i32.or
          i32.store offset=4
          local.get 7
          local.get 7
          i32.load offset=4
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 2
          local.get 1
          call $dispose_chunk
          local.get 0
          return
        end
        block  ;; label = @3
          local.get 7
          i32.const 0
          i32.load offset=1062328
          i32.ne
          br_if 0 (;@3;)
          i32.const 0
          i32.load offset=1062316
          local.get 5
          i32.add
          local.tee 5
          local.get 2
          i32.le_u
          br_if 1 (;@2;)
          local.get 3
          local.get 2
          local.get 4
          i32.const 1
          i32.and
          i32.or
          i32.const 2
          i32.or
          i32.store
          i32.const 0
          local.get 6
          local.get 2
          i32.add
          local.tee 1
          i32.store offset=1062328
          i32.const 0
          local.get 5
          local.get 2
          i32.sub
          local.tee 2
          i32.store offset=1062316
          local.get 1
          local.get 2
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 0
          return
        end
        block  ;; label = @3
          local.get 7
          i32.const 0
          i32.load offset=1062324
          i32.ne
          br_if 0 (;@3;)
          i32.const 0
          i32.load offset=1062312
          local.get 5
          i32.add
          local.tee 5
          local.get 2
          i32.lt_u
          br_if 1 (;@2;)
          block  ;; label = @4
            block  ;; label = @5
              local.get 5
              local.get 2
              i32.sub
              local.tee 1
              i32.const 16
              i32.lt_u
              br_if 0 (;@5;)
              local.get 3
              local.get 2
              local.get 4
              i32.const 1
              i32.and
              i32.or
              i32.const 2
              i32.or
              i32.store
              local.get 6
              local.get 2
              i32.add
              local.tee 2
              local.get 1
              i32.const 1
              i32.or
              i32.store offset=4
              local.get 6
              local.get 5
              i32.add
              local.tee 5
              local.get 1
              i32.store
              local.get 5
              local.get 5
              i32.load offset=4
              i32.const -2
              i32.and
              i32.store offset=4
              br 1 (;@4;)
            end
            local.get 3
            local.get 4
            i32.const 1
            i32.and
            local.get 5
            i32.or
            i32.const 2
            i32.or
            i32.store
            local.get 6
            local.get 5
            i32.add
            local.tee 1
            local.get 1
            i32.load offset=4
            i32.const 1
            i32.or
            i32.store offset=4
            i32.const 0
            local.set 1
            i32.const 0
            local.set 2
          end
          i32.const 0
          local.get 2
          i32.store offset=1062324
          i32.const 0
          local.get 1
          i32.store offset=1062312
          local.get 0
          return
        end
        local.get 7
        i32.load offset=4
        local.tee 8
        i32.const 2
        i32.and
        br_if 0 (;@2;)
        local.get 8
        i32.const -8
        i32.and
        local.get 5
        i32.add
        local.tee 9
        local.get 2
        i32.lt_u
        br_if 0 (;@2;)
        local.get 9
        local.get 2
        i32.sub
        local.set 10
        local.get 7
        i32.load offset=12
        local.set 1
        block  ;; label = @3
          block  ;; label = @4
            local.get 8
            i32.const 255
            i32.gt_u
            br_if 0 (;@4;)
            block  ;; label = @5
              local.get 1
              local.get 7
              i32.load offset=8
              local.tee 5
              i32.ne
              br_if 0 (;@5;)
              i32.const 0
              i32.const 0
              i32.load offset=1062304
              i32.const -2
              local.get 8
              i32.const 3
              i32.shr_u
              i32.rotl
              i32.and
              i32.store offset=1062304
              br 2 (;@3;)
            end
            local.get 1
            local.get 5
            i32.store offset=8
            local.get 5
            local.get 1
            i32.store offset=12
            br 1 (;@3;)
          end
          local.get 7
          i32.load offset=24
          local.set 11
          block  ;; label = @4
            block  ;; label = @5
              local.get 1
              local.get 7
              i32.eq
              br_if 0 (;@5;)
              local.get 7
              i32.load offset=8
              local.tee 5
              local.get 1
              i32.store offset=12
              local.get 1
              local.get 5
              i32.store offset=8
              br 1 (;@4;)
            end
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 7
                  i32.load offset=20
                  local.tee 5
                  i32.eqz
                  br_if 0 (;@7;)
                  local.get 7
                  i32.const 20
                  i32.add
                  local.set 8
                  br 1 (;@6;)
                end
                local.get 7
                i32.load offset=16
                local.tee 5
                i32.eqz
                br_if 1 (;@5;)
                local.get 7
                i32.const 16
                i32.add
                local.set 8
              end
              loop  ;; label = @6
                local.get 8
                local.set 12
                local.get 5
                local.tee 1
                i32.const 20
                i32.add
                local.set 8
                local.get 1
                i32.load offset=20
                local.tee 5
                br_if 0 (;@6;)
                local.get 1
                i32.const 16
                i32.add
                local.set 8
                local.get 1
                i32.load offset=16
                local.tee 5
                br_if 0 (;@6;)
              end
              local.get 12
              i32.const 0
              i32.store
              br 1 (;@4;)
            end
            i32.const 0
            local.set 1
          end
          local.get 11
          i32.eqz
          br_if 0 (;@3;)
          block  ;; label = @4
            block  ;; label = @5
              local.get 7
              local.get 7
              i32.load offset=28
              local.tee 8
              i32.const 2
              i32.shl
              i32.const 1062608
              i32.add
              local.tee 5
              i32.load
              i32.ne
              br_if 0 (;@5;)
              local.get 5
              local.get 1
              i32.store
              local.get 1
              br_if 1 (;@4;)
              i32.const 0
              i32.const 0
              i32.load offset=1062308
              i32.const -2
              local.get 8
              i32.rotl
              i32.and
              i32.store offset=1062308
              br 2 (;@3;)
            end
            local.get 11
            i32.const 16
            i32.const 20
            local.get 11
            i32.load offset=16
            local.get 7
            i32.eq
            select
            i32.add
            local.get 1
            i32.store
            local.get 1
            i32.eqz
            br_if 1 (;@3;)
          end
          local.get 1
          local.get 11
          i32.store offset=24
          block  ;; label = @4
            local.get 7
            i32.load offset=16
            local.tee 5
            i32.eqz
            br_if 0 (;@4;)
            local.get 1
            local.get 5
            i32.store offset=16
            local.get 5
            local.get 1
            i32.store offset=24
          end
          local.get 7
          i32.load offset=20
          local.tee 5
          i32.eqz
          br_if 0 (;@3;)
          local.get 1
          local.get 5
          i32.store offset=20
          local.get 5
          local.get 1
          i32.store offset=24
        end
        block  ;; label = @3
          local.get 10
          i32.const 15
          i32.gt_u
          br_if 0 (;@3;)
          local.get 3
          local.get 4
          i32.const 1
          i32.and
          local.get 9
          i32.or
          i32.const 2
          i32.or
          i32.store
          local.get 6
          local.get 9
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
        local.get 3
        local.get 2
        local.get 4
        i32.const 1
        i32.and
        i32.or
        i32.const 2
        i32.or
        i32.store
        local.get 6
        local.get 2
        i32.add
        local.tee 1
        local.get 10
        i32.const 3
        i32.or
        i32.store offset=4
        local.get 6
        local.get 9
        i32.add
        local.tee 2
        local.get 2
        i32.load offset=4
        i32.const 1
        i32.or
        i32.store offset=4
        local.get 1
        local.get 10
        call $dispose_chunk
        local.get 0
        return
      end
      block  ;; label = @2
        local.get 1
        call $dlmalloc
        local.tee 2
        br_if 0 (;@2;)
        i32.const 0
        return
      end
      local.get 2
      local.get 0
      i32.const -4
      i32.const -8
      local.get 3
      i32.load
      local.tee 5
      i32.const 3
      i32.and
      select
      local.get 5
      i32.const -8
      i32.and
      i32.add
      local.tee 5
      local.get 1
      local.get 5
      local.get 1
      i32.lt_u
      select
      call $memcpy
      local.set 1
      local.get 0
      call $dlfree
      local.get 1
      local.set 0
    end
    local.get 0)
  (func $dispose_chunk (type 6) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32)
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
        local.tee 4
        local.get 1
        i32.add
        local.set 1
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 0
                local.get 4
                i32.sub
                local.tee 0
                i32.const 0
                i32.load offset=1062324
                i32.eq
                br_if 0 (;@6;)
                local.get 0
                i32.load offset=12
                local.set 3
                block  ;; label = @7
                  local.get 4
                  i32.const 255
                  i32.gt_u
                  br_if 0 (;@7;)
                  local.get 3
                  local.get 0
                  i32.load offset=8
                  local.tee 5
                  i32.ne
                  br_if 2 (;@5;)
                  i32.const 0
                  i32.const 0
                  i32.load offset=1062304
                  i32.const -2
                  local.get 4
                  i32.const 3
                  i32.shr_u
                  i32.rotl
                  i32.and
                  i32.store offset=1062304
                  br 5 (;@2;)
                end
                local.get 0
                i32.load offset=24
                local.set 6
                block  ;; label = @7
                  local.get 3
                  local.get 0
                  i32.eq
                  br_if 0 (;@7;)
                  local.get 0
                  i32.load offset=8
                  local.tee 4
                  local.get 3
                  i32.store offset=12
                  local.get 3
                  local.get 4
                  i32.store offset=8
                  br 4 (;@3;)
                end
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 0
                    i32.load offset=20
                    local.tee 4
                    i32.eqz
                    br_if 0 (;@8;)
                    local.get 0
                    i32.const 20
                    i32.add
                    local.set 5
                    br 1 (;@7;)
                  end
                  local.get 0
                  i32.load offset=16
                  local.tee 4
                  i32.eqz
                  br_if 3 (;@4;)
                  local.get 0
                  i32.const 16
                  i32.add
                  local.set 5
                end
                loop  ;; label = @7
                  local.get 5
                  local.set 7
                  local.get 4
                  local.tee 3
                  i32.const 20
                  i32.add
                  local.set 5
                  local.get 3
                  i32.load offset=20
                  local.tee 4
                  br_if 0 (;@7;)
                  local.get 3
                  i32.const 16
                  i32.add
                  local.set 5
                  local.get 3
                  i32.load offset=16
                  local.tee 4
                  br_if 0 (;@7;)
                end
                local.get 7
                i32.const 0
                i32.store
                br 3 (;@3;)
              end
              local.get 2
              i32.load offset=4
              local.tee 3
              i32.const 3
              i32.and
              i32.const 3
              i32.ne
              br_if 3 (;@2;)
              local.get 2
              local.get 3
              i32.const -2
              i32.and
              i32.store offset=4
              i32.const 0
              local.get 1
              i32.store offset=1062312
              local.get 2
              local.get 1
              i32.store
              local.get 0
              local.get 1
              i32.const 1
              i32.or
              i32.store offset=4
              return
            end
            local.get 3
            local.get 5
            i32.store offset=8
            local.get 5
            local.get 3
            i32.store offset=12
            br 2 (;@2;)
          end
          i32.const 0
          local.set 3
        end
        local.get 6
        i32.eqz
        br_if 0 (;@2;)
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            local.get 0
            i32.load offset=28
            local.tee 5
            i32.const 2
            i32.shl
            i32.const 1062608
            i32.add
            local.tee 4
            i32.load
            i32.ne
            br_if 0 (;@4;)
            local.get 4
            local.get 3
            i32.store
            local.get 3
            br_if 1 (;@3;)
            i32.const 0
            i32.const 0
            i32.load offset=1062308
            i32.const -2
            local.get 5
            i32.rotl
            i32.and
            i32.store offset=1062308
            br 2 (;@2;)
          end
          local.get 6
          i32.const 16
          i32.const 20
          local.get 6
          i32.load offset=16
          local.get 0
          i32.eq
          select
          i32.add
          local.get 3
          i32.store
          local.get 3
          i32.eqz
          br_if 1 (;@2;)
        end
        local.get 3
        local.get 6
        i32.store offset=24
        block  ;; label = @3
          local.get 0
          i32.load offset=16
          local.tee 4
          i32.eqz
          br_if 0 (;@3;)
          local.get 3
          local.get 4
          i32.store offset=16
          local.get 4
          local.get 3
          i32.store offset=24
        end
        local.get 0
        i32.load offset=20
        local.tee 4
        i32.eqz
        br_if 0 (;@2;)
        local.get 3
        local.get 4
        i32.store offset=20
        local.get 4
        local.get 3
        i32.store offset=24
      end
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 2
                i32.load offset=4
                local.tee 4
                i32.const 2
                i32.and
                br_if 0 (;@6;)
                block  ;; label = @7
                  local.get 2
                  i32.const 0
                  i32.load offset=1062328
                  i32.ne
                  br_if 0 (;@7;)
                  i32.const 0
                  local.get 0
                  i32.store offset=1062328
                  i32.const 0
                  i32.const 0
                  i32.load offset=1062316
                  local.get 1
                  i32.add
                  local.tee 1
                  i32.store offset=1062316
                  local.get 0
                  local.get 1
                  i32.const 1
                  i32.or
                  i32.store offset=4
                  local.get 0
                  i32.const 0
                  i32.load offset=1062324
                  i32.ne
                  br_if 6 (;@1;)
                  i32.const 0
                  i32.const 0
                  i32.store offset=1062312
                  i32.const 0
                  i32.const 0
                  i32.store offset=1062324
                  return
                end
                block  ;; label = @7
                  local.get 2
                  i32.const 0
                  i32.load offset=1062324
                  i32.ne
                  br_if 0 (;@7;)
                  i32.const 0
                  local.get 0
                  i32.store offset=1062324
                  i32.const 0
                  i32.const 0
                  i32.load offset=1062312
                  local.get 1
                  i32.add
                  local.tee 1
                  i32.store offset=1062312
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
                end
                local.get 4
                i32.const -8
                i32.and
                local.get 1
                i32.add
                local.set 1
                local.get 2
                i32.load offset=12
                local.set 3
                block  ;; label = @7
                  local.get 4
                  i32.const 255
                  i32.gt_u
                  br_if 0 (;@7;)
                  block  ;; label = @8
                    local.get 3
                    local.get 2
                    i32.load offset=8
                    local.tee 5
                    i32.ne
                    br_if 0 (;@8;)
                    i32.const 0
                    i32.const 0
                    i32.load offset=1062304
                    i32.const -2
                    local.get 4
                    i32.const 3
                    i32.shr_u
                    i32.rotl
                    i32.and
                    i32.store offset=1062304
                    br 5 (;@3;)
                  end
                  local.get 3
                  local.get 5
                  i32.store offset=8
                  local.get 5
                  local.get 3
                  i32.store offset=12
                  br 4 (;@3;)
                end
                local.get 2
                i32.load offset=24
                local.set 6
                block  ;; label = @7
                  local.get 3
                  local.get 2
                  i32.eq
                  br_if 0 (;@7;)
                  local.get 2
                  i32.load offset=8
                  local.tee 4
                  local.get 3
                  i32.store offset=12
                  local.get 3
                  local.get 4
                  i32.store offset=8
                  br 3 (;@4;)
                end
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 2
                    i32.load offset=20
                    local.tee 4
                    i32.eqz
                    br_if 0 (;@8;)
                    local.get 2
                    i32.const 20
                    i32.add
                    local.set 5
                    br 1 (;@7;)
                  end
                  local.get 2
                  i32.load offset=16
                  local.tee 4
                  i32.eqz
                  br_if 2 (;@5;)
                  local.get 2
                  i32.const 16
                  i32.add
                  local.set 5
                end
                loop  ;; label = @7
                  local.get 5
                  local.set 7
                  local.get 4
                  local.tee 3
                  i32.const 20
                  i32.add
                  local.set 5
                  local.get 3
                  i32.load offset=20
                  local.tee 4
                  br_if 0 (;@7;)
                  local.get 3
                  i32.const 16
                  i32.add
                  local.set 5
                  local.get 3
                  i32.load offset=16
                  local.tee 4
                  br_if 0 (;@7;)
                end
                local.get 7
                i32.const 0
                i32.store
                br 2 (;@4;)
              end
              local.get 2
              local.get 4
              i32.const -2
              i32.and
              i32.store offset=4
              local.get 0
              local.get 1
              i32.add
              local.get 1
              i32.store
              local.get 0
              local.get 1
              i32.const 1
              i32.or
              i32.store offset=4
              br 3 (;@2;)
            end
            i32.const 0
            local.set 3
          end
          local.get 6
          i32.eqz
          br_if 0 (;@3;)
          block  ;; label = @4
            block  ;; label = @5
              local.get 2
              local.get 2
              i32.load offset=28
              local.tee 5
              i32.const 2
              i32.shl
              i32.const 1062608
              i32.add
              local.tee 4
              i32.load
              i32.ne
              br_if 0 (;@5;)
              local.get 4
              local.get 3
              i32.store
              local.get 3
              br_if 1 (;@4;)
              i32.const 0
              i32.const 0
              i32.load offset=1062308
              i32.const -2
              local.get 5
              i32.rotl
              i32.and
              i32.store offset=1062308
              br 2 (;@3;)
            end
            local.get 6
            i32.const 16
            i32.const 20
            local.get 6
            i32.load offset=16
            local.get 2
            i32.eq
            select
            i32.add
            local.get 3
            i32.store
            local.get 3
            i32.eqz
            br_if 1 (;@3;)
          end
          local.get 3
          local.get 6
          i32.store offset=24
          block  ;; label = @4
            local.get 2
            i32.load offset=16
            local.tee 4
            i32.eqz
            br_if 0 (;@4;)
            local.get 3
            local.get 4
            i32.store offset=16
            local.get 4
            local.get 3
            i32.store offset=24
          end
          local.get 2
          i32.load offset=20
          local.tee 4
          i32.eqz
          br_if 0 (;@3;)
          local.get 3
          local.get 4
          i32.store offset=20
          local.get 4
          local.get 3
          i32.store offset=24
        end
        local.get 0
        local.get 1
        i32.add
        local.get 1
        i32.store
        local.get 0
        local.get 1
        i32.const 1
        i32.or
        i32.store offset=4
        local.get 0
        i32.const 0
        i32.load offset=1062324
        i32.ne
        br_if 0 (;@2;)
        i32.const 0
        local.get 1
        i32.store offset=1062312
        return
      end
      block  ;; label = @2
        local.get 1
        i32.const 255
        i32.gt_u
        br_if 0 (;@2;)
        local.get 1
        i32.const -8
        i32.and
        i32.const 1062344
        i32.add
        local.set 3
        block  ;; label = @3
          block  ;; label = @4
            i32.const 0
            i32.load offset=1062304
            local.tee 4
            i32.const 1
            local.get 1
            i32.const 3
            i32.shr_u
            i32.shl
            local.tee 1
            i32.and
            br_if 0 (;@4;)
            i32.const 0
            local.get 4
            local.get 1
            i32.or
            i32.store offset=1062304
            local.get 3
            local.set 1
            br 1 (;@3;)
          end
          local.get 3
          i32.load offset=8
          local.set 1
        end
        local.get 1
        local.get 0
        i32.store offset=12
        local.get 3
        local.get 0
        i32.store offset=8
        local.get 0
        local.get 3
        i32.store offset=12
        local.get 0
        local.get 1
        i32.store offset=8
        return
      end
      i32.const 31
      local.set 3
      block  ;; label = @2
        local.get 1
        i32.const 16777215
        i32.gt_u
        br_if 0 (;@2;)
        local.get 1
        i32.const 38
        local.get 1
        i32.const 8
        i32.shr_u
        i32.clz
        local.tee 3
        i32.sub
        i32.shr_u
        i32.const 1
        i32.and
        local.get 3
        i32.const 1
        i32.shl
        i32.sub
        i32.const 62
        i32.add
        local.set 3
      end
      local.get 0
      local.get 3
      i32.store offset=28
      local.get 0
      i64.const 0
      i64.store offset=16 align=4
      local.get 3
      i32.const 2
      i32.shl
      i32.const 1062608
      i32.add
      local.set 4
      block  ;; label = @2
        i32.const 0
        i32.load offset=1062308
        local.tee 5
        i32.const 1
        local.get 3
        i32.shl
        local.tee 2
        i32.and
        br_if 0 (;@2;)
        local.get 4
        local.get 0
        i32.store
        i32.const 0
        local.get 5
        local.get 2
        i32.or
        i32.store offset=1062308
        local.get 0
        local.get 4
        i32.store offset=24
        local.get 0
        local.get 0
        i32.store offset=8
        local.get 0
        local.get 0
        i32.store offset=12
        return
      end
      local.get 1
      i32.const 0
      i32.const 25
      local.get 3
      i32.const 1
      i32.shr_u
      i32.sub
      local.get 3
      i32.const 31
      i32.eq
      select
      i32.shl
      local.set 3
      local.get 4
      i32.load
      local.set 5
      block  ;; label = @2
        loop  ;; label = @3
          local.get 5
          local.tee 4
          i32.load offset=4
          i32.const -8
          i32.and
          local.get 1
          i32.eq
          br_if 1 (;@2;)
          local.get 3
          i32.const 29
          i32.shr_u
          local.set 5
          local.get 3
          i32.const 1
          i32.shl
          local.set 3
          local.get 4
          local.get 5
          i32.const 4
          i32.and
          i32.add
          i32.const 16
          i32.add
          local.tee 2
          i32.load
          local.tee 5
          br_if 0 (;@3;)
        end
        local.get 2
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
        i32.store offset=8
        return
      end
      local.get 4
      i32.load offset=8
      local.tee 1
      local.get 0
      i32.store offset=12
      local.get 4
      local.get 0
      i32.store offset=8
      local.get 0
      i32.const 0
      i32.store offset=24
      local.get 0
      local.get 4
      i32.store offset=12
      local.get 0
      local.get 1
      i32.store offset=8
    end)
  (func $posix_memalign (type 5) (param i32 i32 i32) (result i32)
    (local i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          i32.const 16
          i32.ne
          br_if 0 (;@3;)
          local.get 2
          call $dlmalloc
          local.set 1
          br 1 (;@2;)
        end
        i32.const 28
        local.set 3
        local.get 1
        i32.const 4
        i32.lt_u
        br_if 1 (;@1;)
        local.get 1
        i32.const 3
        i32.and
        br_if 1 (;@1;)
        local.get 1
        i32.const 2
        i32.shr_u
        local.tee 4
        local.get 4
        i32.const -1
        i32.add
        i32.and
        br_if 1 (;@1;)
        block  ;; label = @3
          i32.const -64
          local.get 1
          i32.sub
          local.get 2
          i32.ge_u
          br_if 0 (;@3;)
          i32.const 48
          return
        end
        local.get 1
        i32.const 16
        local.get 1
        i32.const 16
        i32.gt_u
        select
        local.get 2
        call $internal_memalign
        local.set 1
      end
      block  ;; label = @2
        local.get 1
        br_if 0 (;@2;)
        i32.const 48
        return
      end
      local.get 0
      local.get 1
      i32.store
      i32.const 0
      local.set 3
    end
    local.get 3)
  (func $internal_memalign (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.const 16
        local.get 0
        i32.const 16
        i32.gt_u
        select
        local.tee 2
        local.get 2
        i32.const -1
        i32.add
        i32.and
        br_if 0 (;@2;)
        local.get 2
        local.set 0
        br 1 (;@1;)
      end
      i32.const 32
      local.set 3
      loop  ;; label = @2
        local.get 3
        local.tee 0
        i32.const 1
        i32.shl
        local.set 3
        local.get 0
        local.get 2
        i32.lt_u
        br_if 0 (;@2;)
      end
    end
    block  ;; label = @1
      i32.const -64
      local.get 0
      i32.sub
      local.get 1
      i32.gt_u
      br_if 0 (;@1;)
      i32.const 0
      i32.const 48
      i32.store offset=1062800
      i32.const 0
      return
    end
    block  ;; label = @1
      local.get 0
      i32.const 16
      local.get 1
      i32.const 19
      i32.add
      i32.const -16
      i32.and
      local.get 1
      i32.const 11
      i32.lt_u
      select
      local.tee 1
      i32.add
      i32.const 12
      i32.add
      call $dlmalloc
      local.tee 3
      br_if 0 (;@1;)
      i32.const 0
      return
    end
    local.get 3
    i32.const -8
    i32.add
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.const -1
        i32.add
        local.get 3
        i32.and
        br_if 0 (;@2;)
        local.get 2
        local.set 0
        br 1 (;@1;)
      end
      local.get 3
      i32.const -4
      i32.add
      local.tee 4
      i32.load
      local.tee 5
      i32.const -8
      i32.and
      local.get 3
      local.get 0
      i32.add
      i32.const -1
      i32.add
      i32.const 0
      local.get 0
      i32.sub
      i32.and
      i32.const -8
      i32.add
      local.tee 3
      i32.const 0
      local.get 0
      local.get 3
      local.get 2
      i32.sub
      i32.const 15
      i32.gt_u
      select
      i32.add
      local.tee 0
      local.get 2
      i32.sub
      local.tee 3
      i32.sub
      local.set 6
      block  ;; label = @2
        local.get 5
        i32.const 3
        i32.and
        br_if 0 (;@2;)
        local.get 0
        local.get 6
        i32.store offset=4
        local.get 0
        local.get 2
        i32.load
        local.get 3
        i32.add
        i32.store
        br 1 (;@1;)
      end
      local.get 0
      local.get 6
      local.get 0
      i32.load offset=4
      i32.const 1
      i32.and
      i32.or
      i32.const 2
      i32.or
      i32.store offset=4
      local.get 0
      local.get 6
      i32.add
      local.tee 6
      local.get 6
      i32.load offset=4
      i32.const 1
      i32.or
      i32.store offset=4
      local.get 4
      local.get 3
      local.get 4
      i32.load
      i32.const 1
      i32.and
      i32.or
      i32.const 2
      i32.or
      i32.store
      local.get 2
      local.get 3
      i32.add
      local.tee 6
      local.get 6
      i32.load offset=4
      i32.const 1
      i32.or
      i32.store offset=4
      local.get 2
      local.get 3
      call $dispose_chunk
    end
    block  ;; label = @1
      local.get 0
      i32.load offset=4
      local.tee 3
      i32.const 3
      i32.and
      i32.eqz
      br_if 0 (;@1;)
      local.get 3
      i32.const -8
      i32.and
      local.tee 2
      local.get 1
      i32.const 16
      i32.add
      i32.le_u
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      local.get 3
      i32.const 1
      i32.and
      i32.or
      i32.const 2
      i32.or
      i32.store offset=4
      local.get 0
      local.get 1
      i32.add
      local.tee 3
      local.get 2
      local.get 1
      i32.sub
      local.tee 1
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
      local.get 3
      local.get 1
      call $dispose_chunk
    end
    local.get 0
    i32.const 8
    i32.add)
  (func $_Exit (type 1) (param i32)
    local.get 0
    call $__wasi_proc_exit
    unreachable)
  (func $__wasilibc_ensure_environ (type 0)
    block  ;; label = @1
      i32.const 0
      i32.load offset=1062176
      i32.const -1
      i32.ne
      br_if 0 (;@1;)
      call $__wasilibc_initialize_environ
    end)
  (func $__wasilibc_initialize_environ (type 0)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 0
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.const 12
        i32.add
        local.get 0
        i32.const 8
        i32.add
        call $__wasi_environ_sizes_get
        br_if 0 (;@2;)
        block  ;; label = @3
          local.get 0
          i32.load offset=12
          local.tee 1
          br_if 0 (;@3;)
          i32.const 1062804
          local.set 1
          br 2 (;@1;)
        end
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            i32.const 1
            i32.add
            local.tee 1
            i32.eqz
            br_if 0 (;@4;)
            local.get 0
            i32.load offset=8
            call $malloc
            local.tee 2
            i32.eqz
            br_if 0 (;@4;)
            local.get 1
            i32.const 4
            call $calloc
            local.tee 1
            br_if 1 (;@3;)
            local.get 2
            call $free
          end
          i32.const 70
          call $_Exit
          unreachable
        end
        local.get 1
        local.get 2
        call $__wasi_environ_get
        i32.eqz
        br_if 1 (;@1;)
        local.get 2
        call $free
        local.get 1
        call $free
      end
      i32.const 71
      call $_Exit
      unreachable
    end
    i32.const 0
    local.get 1
    i32.store offset=1062176
    local.get 0
    i32.const 16
    i32.add
    global.set $__stack_pointer)
  (func $__wasi_environ_get (type 2) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    call $__imported_wasi_snapshot_preview1_environ_get
    i32.const 65535
    i32.and)
  (func $__wasi_environ_sizes_get (type 2) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    call $__imported_wasi_snapshot_preview1_environ_sizes_get
    i32.const 65535
    i32.and)
  (func $__wasi_proc_exit (type 1) (param i32)
    local.get 0
    call $__imported_wasi_snapshot_preview1_proc_exit
    unreachable)
  (func $abort (type 0)
    unreachable)
  (func $getcwd (type 2) (param i32 i32) (result i32)
    (local i32)
    i32.const 0
    i32.load offset=1062180
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        br_if 0 (;@2;)
        local.get 2
        call $strdup
        local.tee 0
        br_if 1 (;@1;)
        i32.const 0
        i32.const 48
        i32.store offset=1062800
        i32.const 0
        return
      end
      block  ;; label = @2
        local.get 2
        call $strlen
        i32.const 1
        i32.add
        local.get 1
        i32.le_u
        br_if 0 (;@2;)
        i32.const 0
        i32.const 68
        i32.store offset=1062800
        i32.const 0
        return
      end
      local.get 0
      local.get 2
      call $strcpy
      local.set 0
    end
    local.get 0)
  (func $sbrk (type 3) (param i32) (result i32)
    block  ;; label = @1
      local.get 0
      br_if 0 (;@1;)
      memory.size
      i32.const 16
      i32.shl
      return
    end
    block  ;; label = @1
      local.get 0
      i32.const 65535
      i32.and
      br_if 0 (;@1;)
      local.get 0
      i32.const -1
      i32.le_s
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 0
        i32.const 16
        i32.shr_u
        memory.grow
        local.tee 0
        i32.const -1
        i32.ne
        br_if 0 (;@2;)
        i32.const 0
        i32.const 48
        i32.store offset=1062800
        i32.const -1
        return
      end
      local.get 0
      i32.const 16
      i32.shl
      return
    end
    call $abort
    unreachable)
  (func $getenv (type 3) (param i32) (result i32)
    (local i32 i32 i32 i32)
    call $__wasilibc_ensure_environ
    block  ;; label = @1
      local.get 0
      i32.const 61
      call $__strchrnul
      local.tee 1
      local.get 0
      i32.ne
      br_if 0 (;@1;)
      i32.const 0
      return
    end
    i32.const 0
    local.set 2
    block  ;; label = @1
      local.get 0
      local.get 1
      local.get 0
      i32.sub
      local.tee 3
      i32.add
      i32.load8_u
      br_if 0 (;@1;)
      i32.const 0
      i32.load offset=1062176
      local.tee 4
      i32.eqz
      br_if 0 (;@1;)
      local.get 4
      i32.load
      local.tee 1
      i32.eqz
      br_if 0 (;@1;)
      local.get 4
      i32.const 4
      i32.add
      local.set 4
      block  ;; label = @2
        loop  ;; label = @3
          block  ;; label = @4
            local.get 0
            local.get 1
            local.get 3
            call $strncmp
            br_if 0 (;@4;)
            local.get 1
            local.get 3
            i32.add
            local.tee 1
            i32.load8_u
            i32.const 61
            i32.eq
            br_if 2 (;@2;)
          end
          local.get 4
          i32.load
          local.set 1
          local.get 4
          i32.const 4
          i32.add
          local.set 4
          local.get 1
          br_if 0 (;@3;)
          br 2 (;@1;)
        end
      end
      local.get 1
      i32.const 1
      i32.add
      local.set 2
    end
    local.get 2)
  (func $dummy (type 0))
  (func $__wasm_call_dtors (type 0)
    call $dummy
    call $dummy)
  (func $memcpy (type 5) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          i32.const 32
          i32.gt_u
          br_if 0 (;@3;)
          local.get 1
          i32.const 3
          i32.and
          i32.eqz
          br_if 1 (;@2;)
          local.get 2
          i32.eqz
          br_if 1 (;@2;)
          local.get 0
          local.get 1
          i32.load8_u
          i32.store8
          local.get 2
          i32.const -1
          i32.add
          local.set 3
          local.get 0
          i32.const 1
          i32.add
          local.set 4
          local.get 1
          i32.const 1
          i32.add
          local.tee 5
          i32.const 3
          i32.and
          i32.eqz
          br_if 2 (;@1;)
          local.get 3
          i32.eqz
          br_if 2 (;@1;)
          local.get 0
          local.get 1
          i32.load8_u offset=1
          i32.store8 offset=1
          local.get 2
          i32.const -2
          i32.add
          local.set 3
          local.get 0
          i32.const 2
          i32.add
          local.set 4
          local.get 1
          i32.const 2
          i32.add
          local.tee 5
          i32.const 3
          i32.and
          i32.eqz
          br_if 2 (;@1;)
          local.get 3
          i32.eqz
          br_if 2 (;@1;)
          local.get 0
          local.get 1
          i32.load8_u offset=2
          i32.store8 offset=2
          local.get 2
          i32.const -3
          i32.add
          local.set 3
          local.get 0
          i32.const 3
          i32.add
          local.set 4
          local.get 1
          i32.const 3
          i32.add
          local.tee 5
          i32.const 3
          i32.and
          i32.eqz
          br_if 2 (;@1;)
          local.get 3
          i32.eqz
          br_if 2 (;@1;)
          local.get 0
          local.get 1
          i32.load8_u offset=3
          i32.store8 offset=3
          local.get 2
          i32.const -4
          i32.add
          local.set 3
          local.get 0
          i32.const 4
          i32.add
          local.set 4
          local.get 1
          i32.const 4
          i32.add
          local.set 5
          br 2 (;@1;)
        end
        local.get 0
        local.get 1
        local.get 2
        memory.copy
        local.get 0
        return
      end
      local.get 2
      local.set 3
      local.get 0
      local.set 4
      local.get 1
      local.set 5
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 4
        i32.const 3
        i32.and
        local.tee 2
        br_if 0 (;@2;)
        block  ;; label = @3
          block  ;; label = @4
            local.get 3
            i32.const 16
            i32.ge_u
            br_if 0 (;@4;)
            local.get 3
            local.set 2
            br 1 (;@3;)
          end
          block  ;; label = @4
            local.get 3
            i32.const -16
            i32.add
            local.tee 2
            i32.const 16
            i32.and
            br_if 0 (;@4;)
            local.get 4
            local.get 5
            i64.load align=4
            i64.store align=4
            local.get 4
            local.get 5
            i64.load offset=8 align=4
            i64.store offset=8 align=4
            local.get 4
            i32.const 16
            i32.add
            local.set 4
            local.get 5
            i32.const 16
            i32.add
            local.set 5
            local.get 2
            local.set 3
          end
          local.get 2
          i32.const 16
          i32.lt_u
          br_if 0 (;@3;)
          local.get 3
          local.set 2
          loop  ;; label = @4
            local.get 4
            local.get 5
            i64.load align=4
            i64.store align=4
            local.get 4
            local.get 5
            i64.load offset=8 align=4
            i64.store offset=8 align=4
            local.get 4
            local.get 5
            i64.load offset=16 align=4
            i64.store offset=16 align=4
            local.get 4
            local.get 5
            i64.load offset=24 align=4
            i64.store offset=24 align=4
            local.get 4
            i32.const 32
            i32.add
            local.set 4
            local.get 5
            i32.const 32
            i32.add
            local.set 5
            local.get 2
            i32.const -32
            i32.add
            local.tee 2
            i32.const 15
            i32.gt_u
            br_if 0 (;@4;)
          end
        end
        block  ;; label = @3
          local.get 2
          i32.const 8
          i32.lt_u
          br_if 0 (;@3;)
          local.get 4
          local.get 5
          i64.load align=4
          i64.store align=4
          local.get 5
          i32.const 8
          i32.add
          local.set 5
          local.get 4
          i32.const 8
          i32.add
          local.set 4
        end
        block  ;; label = @3
          local.get 2
          i32.const 4
          i32.and
          i32.eqz
          br_if 0 (;@3;)
          local.get 4
          local.get 5
          i32.load
          i32.store
          local.get 5
          i32.const 4
          i32.add
          local.set 5
          local.get 4
          i32.const 4
          i32.add
          local.set 4
        end
        block  ;; label = @3
          local.get 2
          i32.const 2
          i32.and
          i32.eqz
          br_if 0 (;@3;)
          local.get 4
          local.get 5
          i32.load16_u align=1
          i32.store16 align=1
          local.get 4
          i32.const 2
          i32.add
          local.set 4
          local.get 5
          i32.const 2
          i32.add
          local.set 5
        end
        local.get 2
        i32.const 1
        i32.and
        i32.eqz
        br_if 1 (;@1;)
        local.get 4
        local.get 5
        i32.load8_u
        i32.store8
        local.get 0
        return
      end
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 3
                i32.const 32
                i32.lt_u
                br_if 0 (;@6;)
                local.get 4
                local.get 5
                i32.load
                local.tee 3
                i32.store8
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 2
                    i32.const -1
                    i32.add
                    br_table 3 (;@5;) 0 (;@8;) 1 (;@7;) 3 (;@5;)
                  end
                  local.get 4
                  local.get 3
                  i32.const 8
                  i32.shr_u
                  i32.store8 offset=1
                  local.get 4
                  local.get 5
                  i32.const 6
                  i32.add
                  i64.load align=2
                  i64.store offset=6 align=4
                  local.get 4
                  local.get 5
                  i32.load offset=4
                  i32.const 16
                  i32.shl
                  local.get 3
                  i32.const 16
                  i32.shr_u
                  i32.or
                  i32.store offset=2
                  local.get 4
                  i32.const 18
                  i32.add
                  local.set 2
                  local.get 5
                  i32.const 18
                  i32.add
                  local.set 1
                  i32.const 14
                  local.set 6
                  local.get 5
                  i32.const 14
                  i32.add
                  i32.load align=2
                  local.set 5
                  i32.const 14
                  local.set 3
                  br 3 (;@4;)
                end
                local.get 4
                local.get 5
                i32.const 5
                i32.add
                i64.load align=1
                i64.store offset=5 align=4
                local.get 4
                local.get 5
                i32.load offset=4
                i32.const 24
                i32.shl
                local.get 3
                i32.const 8
                i32.shr_u
                i32.or
                i32.store offset=1
                local.get 4
                i32.const 17
                i32.add
                local.set 2
                local.get 5
                i32.const 17
                i32.add
                local.set 1
                i32.const 13
                local.set 6
                local.get 5
                i32.const 13
                i32.add
                i32.load align=1
                local.set 5
                i32.const 15
                local.set 3
                br 2 (;@4;)
              end
              block  ;; label = @6
                block  ;; label = @7
                  local.get 3
                  i32.const 16
                  i32.ge_u
                  br_if 0 (;@7;)
                  local.get 4
                  local.set 2
                  local.get 5
                  local.set 1
                  br 1 (;@6;)
                end
                local.get 4
                local.get 5
                i32.load8_u
                i32.store8
                local.get 4
                local.get 5
                i32.load offset=1 align=1
                i32.store offset=1 align=1
                local.get 4
                local.get 5
                i64.load offset=5 align=1
                i64.store offset=5 align=1
                local.get 4
                local.get 5
                i32.load16_u offset=13 align=1
                i32.store16 offset=13 align=1
                local.get 4
                local.get 5
                i32.load8_u offset=15
                i32.store8 offset=15
                local.get 4
                i32.const 16
                i32.add
                local.set 2
                local.get 5
                i32.const 16
                i32.add
                local.set 1
              end
              local.get 3
              i32.const 8
              i32.and
              br_if 2 (;@3;)
              br 3 (;@2;)
            end
            local.get 4
            local.get 3
            i32.const 16
            i32.shr_u
            i32.store8 offset=2
            local.get 4
            local.get 3
            i32.const 8
            i32.shr_u
            i32.store8 offset=1
            local.get 4
            local.get 5
            i32.const 7
            i32.add
            i64.load align=1
            i64.store offset=7 align=4
            local.get 4
            local.get 5
            i32.load offset=4
            i32.const 8
            i32.shl
            local.get 3
            i32.const 24
            i32.shr_u
            i32.or
            i32.store offset=3
            local.get 4
            i32.const 19
            i32.add
            local.set 2
            local.get 5
            i32.const 19
            i32.add
            local.set 1
            i32.const 15
            local.set 6
            local.get 5
            i32.const 15
            i32.add
            i32.load align=1
            local.set 5
            i32.const 13
            local.set 3
          end
          local.get 4
          local.get 6
          i32.add
          local.get 5
          i32.store
        end
        local.get 2
        local.get 1
        i64.load align=1
        i64.store align=1
        local.get 2
        i32.const 8
        i32.add
        local.set 2
        local.get 1
        i32.const 8
        i32.add
        local.set 1
      end
      block  ;; label = @2
        local.get 3
        i32.const 4
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        local.get 1
        i32.load align=1
        i32.store align=1
        local.get 2
        i32.const 4
        i32.add
        local.set 2
        local.get 1
        i32.const 4
        i32.add
        local.set 1
      end
      block  ;; label = @2
        local.get 3
        i32.const 2
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        local.get 1
        i32.load16_u align=1
        i32.store16 align=1
        local.get 2
        i32.const 2
        i32.add
        local.set 2
        local.get 1
        i32.const 2
        i32.add
        local.set 1
      end
      local.get 3
      i32.const 1
      i32.and
      i32.eqz
      br_if 0 (;@1;)
      local.get 2
      local.get 1
      i32.load8_u
      i32.store8
    end
    local.get 0)
  (func $memset (type 5) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i64)
    block  ;; label = @1
      local.get 2
      i32.const 33
      i32.lt_u
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      local.get 2
      memory.fill
      local.get 0
      return
    end
    block  ;; label = @1
      local.get 2
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      i32.store8
      local.get 0
      local.get 2
      i32.add
      local.tee 3
      i32.const -1
      i32.add
      local.get 1
      i32.store8
      local.get 2
      i32.const 3
      i32.lt_u
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      i32.store8 offset=2
      local.get 0
      local.get 1
      i32.store8 offset=1
      local.get 3
      i32.const -3
      i32.add
      local.get 1
      i32.store8
      local.get 3
      i32.const -2
      i32.add
      local.get 1
      i32.store8
      local.get 2
      i32.const 7
      i32.lt_u
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      i32.store8 offset=3
      local.get 3
      i32.const -4
      i32.add
      local.get 1
      i32.store8
      local.get 2
      i32.const 9
      i32.lt_u
      br_if 0 (;@1;)
      local.get 0
      i32.const 0
      local.get 0
      i32.sub
      i32.const 3
      i32.and
      local.tee 4
      i32.add
      local.tee 5
      local.get 1
      i32.const 255
      i32.and
      i32.const 16843009
      i32.mul
      local.tee 3
      i32.store
      local.get 5
      local.get 2
      local.get 4
      i32.sub
      i32.const 60
      i32.and
      local.tee 1
      i32.add
      local.tee 2
      i32.const -4
      i32.add
      local.get 3
      i32.store
      local.get 1
      i32.const 9
      i32.lt_u
      br_if 0 (;@1;)
      local.get 5
      local.get 3
      i32.store offset=8
      local.get 5
      local.get 3
      i32.store offset=4
      local.get 2
      i32.const -8
      i32.add
      local.get 3
      i32.store
      local.get 2
      i32.const -12
      i32.add
      local.get 3
      i32.store
      local.get 1
      i32.const 25
      i32.lt_u
      br_if 0 (;@1;)
      local.get 5
      local.get 3
      i32.store offset=24
      local.get 5
      local.get 3
      i32.store offset=20
      local.get 5
      local.get 3
      i32.store offset=16
      local.get 5
      local.get 3
      i32.store offset=12
      local.get 2
      i32.const -16
      i32.add
      local.get 3
      i32.store
      local.get 2
      i32.const -20
      i32.add
      local.get 3
      i32.store
      local.get 2
      i32.const -24
      i32.add
      local.get 3
      i32.store
      local.get 2
      i32.const -28
      i32.add
      local.get 3
      i32.store
      local.get 1
      local.get 5
      i32.const 4
      i32.and
      i32.const 24
      i32.or
      local.tee 2
      i32.sub
      local.tee 1
      i32.const 32
      i32.lt_u
      br_if 0 (;@1;)
      local.get 3
      i64.extend_i32_u
      i64.const 4294967297
      i64.mul
      local.set 6
      local.get 5
      local.get 2
      i32.add
      local.set 2
      loop  ;; label = @2
        local.get 2
        local.get 6
        i64.store offset=24
        local.get 2
        local.get 6
        i64.store offset=16
        local.get 2
        local.get 6
        i64.store offset=8
        local.get 2
        local.get 6
        i64.store
        local.get 2
        i32.const 32
        i32.add
        local.set 2
        local.get 1
        i32.const -32
        i32.add
        local.tee 1
        i32.const 31
        i32.gt_u
        br_if 0 (;@2;)
      end
    end
    local.get 0)
  (func $__strchrnul (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            i32.const 255
            i32.and
            local.tee 2
            i32.eqz
            br_if 0 (;@4;)
            local.get 0
            i32.const 3
            i32.and
            i32.eqz
            br_if 2 (;@2;)
            block  ;; label = @5
              local.get 0
              i32.load8_u
              local.tee 3
              br_if 0 (;@5;)
              local.get 0
              return
            end
            local.get 3
            local.get 1
            i32.const 255
            i32.and
            i32.ne
            br_if 1 (;@3;)
            local.get 0
            return
          end
          local.get 0
          local.get 0
          call $strlen
          i32.add
          return
        end
        block  ;; label = @3
          local.get 0
          i32.const 1
          i32.add
          local.tee 3
          i32.const 3
          i32.and
          br_if 0 (;@3;)
          local.get 3
          local.set 0
          br 1 (;@2;)
        end
        local.get 3
        i32.load8_u
        local.tee 4
        i32.eqz
        br_if 1 (;@1;)
        local.get 4
        local.get 1
        i32.const 255
        i32.and
        i32.eq
        br_if 1 (;@1;)
        block  ;; label = @3
          local.get 0
          i32.const 2
          i32.add
          local.tee 3
          i32.const 3
          i32.and
          br_if 0 (;@3;)
          local.get 3
          local.set 0
          br 1 (;@2;)
        end
        local.get 3
        i32.load8_u
        local.tee 4
        i32.eqz
        br_if 1 (;@1;)
        local.get 4
        local.get 1
        i32.const 255
        i32.and
        i32.eq
        br_if 1 (;@1;)
        block  ;; label = @3
          local.get 0
          i32.const 3
          i32.add
          local.tee 3
          i32.const 3
          i32.and
          br_if 0 (;@3;)
          local.get 3
          local.set 0
          br 1 (;@2;)
        end
        local.get 3
        i32.load8_u
        local.tee 4
        i32.eqz
        br_if 1 (;@1;)
        local.get 4
        local.get 1
        i32.const 255
        i32.and
        i32.eq
        br_if 1 (;@1;)
        local.get 0
        i32.const 4
        i32.add
        local.set 0
      end
      block  ;; label = @2
        block  ;; label = @3
          i32.const 16843008
          local.get 0
          i32.load
          local.tee 3
          i32.sub
          local.get 3
          i32.or
          i32.const -2139062144
          i32.and
          i32.const -2139062144
          i32.eq
          br_if 0 (;@3;)
          local.get 0
          local.set 2
          br 1 (;@2;)
        end
        local.get 2
        i32.const 16843009
        i32.mul
        local.set 4
        loop  ;; label = @3
          block  ;; label = @4
            i32.const 16843008
            local.get 3
            local.get 4
            i32.xor
            local.tee 3
            i32.sub
            local.get 3
            i32.or
            i32.const -2139062144
            i32.and
            i32.const -2139062144
            i32.eq
            br_if 0 (;@4;)
            local.get 0
            local.set 2
            br 2 (;@2;)
          end
          local.get 0
          i32.load offset=4
          local.set 3
          local.get 0
          i32.const 4
          i32.add
          local.tee 2
          local.set 0
          local.get 3
          i32.const 16843008
          local.get 3
          i32.sub
          i32.or
          i32.const -2139062144
          i32.and
          i32.const -2139062144
          i32.eq
          br_if 0 (;@3;)
        end
      end
      local.get 2
      i32.const -1
      i32.add
      local.set 3
      loop  ;; label = @2
        local.get 3
        i32.const 1
        i32.add
        local.tee 3
        i32.load8_u
        local.tee 0
        i32.eqz
        br_if 1 (;@1;)
        local.get 0
        local.get 1
        i32.const 255
        i32.and
        i32.ne
        br_if 0 (;@2;)
      end
    end
    local.get 3)
  (func $__stpcpy (type 2) (param i32 i32) (result i32)
    (local i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          local.get 0
          i32.xor
          i32.const 3
          i32.and
          i32.eqz
          br_if 0 (;@3;)
          local.get 1
          i32.load8_u
          local.set 2
          br 1 (;@2;)
        end
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            i32.const 3
            i32.and
            br_if 0 (;@4;)
            local.get 1
            local.set 3
            br 1 (;@3;)
          end
          local.get 0
          local.get 1
          i32.load8_u
          local.tee 2
          i32.store8
          block  ;; label = @4
            local.get 2
            br_if 0 (;@4;)
            local.get 0
            return
          end
          local.get 0
          i32.const 1
          i32.add
          local.set 2
          block  ;; label = @4
            local.get 1
            i32.const 1
            i32.add
            local.tee 3
            i32.const 3
            i32.and
            br_if 0 (;@4;)
            local.get 2
            local.set 0
            br 1 (;@3;)
          end
          local.get 2
          local.get 3
          i32.load8_u
          local.tee 3
          i32.store8
          local.get 3
          i32.eqz
          br_if 2 (;@1;)
          local.get 0
          i32.const 2
          i32.add
          local.set 2
          block  ;; label = @4
            local.get 1
            i32.const 2
            i32.add
            local.tee 3
            i32.const 3
            i32.and
            br_if 0 (;@4;)
            local.get 2
            local.set 0
            br 1 (;@3;)
          end
          local.get 2
          local.get 3
          i32.load8_u
          local.tee 3
          i32.store8
          local.get 3
          i32.eqz
          br_if 2 (;@1;)
          local.get 0
          i32.const 3
          i32.add
          local.set 2
          block  ;; label = @4
            local.get 1
            i32.const 3
            i32.add
            local.tee 3
            i32.const 3
            i32.and
            br_if 0 (;@4;)
            local.get 2
            local.set 0
            br 1 (;@3;)
          end
          local.get 2
          local.get 3
          i32.load8_u
          local.tee 3
          i32.store8
          local.get 3
          i32.eqz
          br_if 2 (;@1;)
          local.get 0
          i32.const 4
          i32.add
          local.set 0
          local.get 1
          i32.const 4
          i32.add
          local.set 3
        end
        block  ;; label = @3
          i32.const 16843008
          local.get 3
          i32.load
          local.tee 2
          i32.sub
          local.get 2
          i32.or
          i32.const -2139062144
          i32.and
          i32.const -2139062144
          i32.eq
          br_if 0 (;@3;)
          local.get 3
          local.set 1
          br 1 (;@2;)
        end
        loop  ;; label = @3
          local.get 0
          local.get 2
          i32.store
          local.get 0
          i32.const 4
          i32.add
          local.set 0
          local.get 3
          i32.load offset=4
          local.set 2
          local.get 3
          i32.const 4
          i32.add
          local.tee 1
          local.set 3
          local.get 2
          i32.const 16843008
          local.get 2
          i32.sub
          i32.or
          i32.const -2139062144
          i32.and
          i32.const -2139062144
          i32.eq
          br_if 0 (;@3;)
        end
      end
      local.get 0
      local.get 2
      i32.store8
      block  ;; label = @2
        local.get 2
        i32.const 255
        i32.and
        br_if 0 (;@2;)
        local.get 0
        return
      end
      local.get 1
      i32.const 1
      i32.add
      local.set 3
      local.get 0
      local.set 2
      loop  ;; label = @2
        local.get 2
        local.get 3
        i32.load8_u
        local.tee 0
        i32.store8 offset=1
        local.get 3
        i32.const 1
        i32.add
        local.set 3
        local.get 2
        i32.const 1
        i32.add
        local.set 2
        local.get 0
        br_if 0 (;@2;)
      end
    end
    local.get 2)
  (func $strcpy (type 2) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    call $__stpcpy
    drop
    local.get 0)
  (func $strdup (type 3) (param i32) (result i32)
    (local i32 i32)
    block  ;; label = @1
      local.get 0
      call $strlen
      i32.const 1
      i32.add
      local.tee 1
      call $malloc
      local.tee 2
      i32.eqz
      br_if 0 (;@1;)
      local.get 2
      local.get 0
      local.get 1
      call $memcpy
      drop
    end
    local.get 2)
  (func $dummy.1 (type 2) (param i32 i32) (result i32)
    local.get 0)
  (func $__lctrans (type 2) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    call $dummy.1)
  (func $strerror (type 3) (param i32) (result i32)
    (local i32)
    block  ;; label = @1
      i32.const 0
      i32.load offset=1062832
      local.tee 1
      br_if 0 (;@1;)
      i32.const 1062808
      local.set 1
      i32.const 0
      i32.const 1062808
      i32.store offset=1062832
    end
    i32.const 0
    local.get 0
    local.get 0
    i32.const 76
    i32.gt_u
    select
    i32.const 1
    i32.shl
    i32.const 1058128
    i32.add
    i32.load16_u
    i32.const 1056562
    i32.add
    local.get 1
    i32.load offset=20
    call $__lctrans)
  (func $strerror_r (type 5) (param i32 i32 i32) (result i32)
    (local i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        call $strerror
        local.tee 0
        call $strlen
        local.tee 3
        local.get 2
        i32.lt_u
        br_if 0 (;@2;)
        i32.const 68
        local.set 3
        local.get 2
        i32.eqz
        br_if 1 (;@1;)
        local.get 1
        local.get 0
        local.get 2
        i32.const -1
        i32.add
        local.tee 2
        call $memcpy
        local.get 2
        i32.add
        i32.const 0
        i32.store8
        i32.const 68
        return
      end
      local.get 1
      local.get 0
      local.get 3
      i32.const 1
      i32.add
      call $memcpy
      drop
      i32.const 0
      local.set 3
    end
    local.get 3)
  (func $strlen (type 3) (param i32) (result i32)
    (local i32 i32 i32)
    local.get 0
    local.set 1
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.const 3
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        block  ;; label = @3
          local.get 0
          i32.load8_u
          br_if 0 (;@3;)
          local.get 0
          local.get 0
          i32.sub
          return
        end
        local.get 0
        i32.const 1
        i32.add
        local.tee 1
        i32.const 3
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        i32.load8_u
        i32.eqz
        br_if 1 (;@1;)
        local.get 0
        i32.const 2
        i32.add
        local.tee 1
        i32.const 3
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        i32.load8_u
        i32.eqz
        br_if 1 (;@1;)
        local.get 0
        i32.const 3
        i32.add
        local.tee 1
        i32.const 3
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        i32.load8_u
        i32.eqz
        br_if 1 (;@1;)
        local.get 0
        i32.const 4
        i32.add
        local.tee 1
        i32.const 3
        i32.and
        br_if 1 (;@1;)
      end
      local.get 1
      i32.const -4
      i32.add
      local.set 2
      local.get 1
      i32.const -5
      i32.add
      local.set 1
      loop  ;; label = @2
        local.get 1
        i32.const 4
        i32.add
        local.set 1
        i32.const 16843008
        local.get 2
        i32.const 4
        i32.add
        local.tee 2
        i32.load
        local.tee 3
        i32.sub
        local.get 3
        i32.or
        i32.const -2139062144
        i32.and
        i32.const -2139062144
        i32.eq
        br_if 0 (;@2;)
      end
      loop  ;; label = @2
        local.get 1
        i32.const 1
        i32.add
        local.set 1
        local.get 2
        i32.load8_u
        local.set 3
        local.get 2
        i32.const 1
        i32.add
        local.set 2
        local.get 3
        br_if 0 (;@2;)
      end
    end
    local.get 1
    local.get 0
    i32.sub)
  (func $strncmp (type 5) (param i32 i32 i32) (result i32)
    (local i32 i32)
    block  ;; label = @1
      local.get 2
      br_if 0 (;@1;)
      i32.const 0
      return
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load8_u
        local.tee 3
        br_if 0 (;@2;)
        i32.const 0
        local.set 3
        br 1 (;@1;)
      end
      local.get 0
      i32.const 1
      i32.add
      local.set 0
      local.get 2
      i32.const -1
      i32.add
      local.set 2
      block  ;; label = @2
        loop  ;; label = @3
          local.get 3
          i32.const 255
          i32.and
          local.get 1
          i32.load8_u
          local.tee 4
          i32.ne
          br_if 1 (;@2;)
          local.get 4
          i32.eqz
          br_if 1 (;@2;)
          local.get 2
          i32.const 0
          i32.eq
          br_if 1 (;@2;)
          local.get 2
          i32.const -1
          i32.add
          local.set 2
          local.get 1
          i32.const 1
          i32.add
          local.set 1
          local.get 0
          i32.load8_u
          local.set 3
          local.get 0
          i32.const 1
          i32.add
          local.set 0
          local.get 3
          br_if 0 (;@3;)
        end
        i32.const 0
        local.set 3
      end
      local.get 3
      i32.const 255
      i32.and
      local.set 3
    end
    local.get 3
    local.get 1
    i32.load8_u
    i32.sub)
  (func $_ZN5alloc7raw_vec17capacity_overflow17h9658cfb2639ec95eE (type 1) (param i32)
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
    i32.const 1058300
    i32.store offset=8
    local.get 1
    i64.const 4
    i64.store offset=16 align=4
    local.get 1
    i32.const 8
    i32.add
    local.get 0
    call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
    unreachable)
  (func $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E (type 4) (param i32 i32 i32)
    block  ;; label = @1
      local.get 0
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      call $_ZN5alloc5alloc18handle_alloc_error17hcc35c2aed22157a6E
      unreachable
    end
    local.get 2
    call $_ZN5alloc7raw_vec17capacity_overflow17h9658cfb2639ec95eE
    unreachable)
  (func $_ZN5alloc7raw_vec11finish_grow17hfbb7e2842f19eb9bE (type 7) (param i32 i32 i32 i32)
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
              i32.load8_u offset=1062189
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
          i32.load8_u offset=1062189
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
  (func $_ZN5alloc5alloc18handle_alloc_error17hcc35c2aed22157a6E (type 6) (param i32 i32)
    local.get 1
    local.get 0
    call $_RNvCs691rhTbG0Ee_7___rustc26___rust_alloc_error_handler
    unreachable)
  (func $_ZN72_$LT$$RF$str$u20$as$u20$alloc..ffi..c_str..CString..new..SpecNewImpl$GT$13spec_new_impl17he8931c3ef0642905E (type 4) (param i32 i32 i32)
    (local i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          i32.const -1
          i32.eq
          br_if 0 (;@3;)
          i32.const 0
          local.set 4
          block  ;; label = @4
            local.get 2
            i32.const 1
            i32.add
            local.tee 5
            i32.const 0
            i32.lt_s
            br_if 0 (;@4;)
            i32.const 0
            i32.load8_u offset=1062189
            drop
            i32.const 1
            local.set 4
            local.get 5
            i32.const 1
            call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
            local.tee 6
            i32.eqz
            br_if 0 (;@4;)
            block  ;; label = @5
              local.get 2
              i32.eqz
              br_if 0 (;@5;)
              local.get 6
              local.get 1
              local.get 2
              memory.copy
            end
            block  ;; label = @5
              block  ;; label = @6
                local.get 2
                i32.const 7
                i32.gt_u
                br_if 0 (;@6;)
                local.get 2
                i32.eqz
                br_if 4 (;@2;)
                block  ;; label = @7
                  local.get 1
                  i32.load8_u
                  br_if 0 (;@7;)
                  i32.const 0
                  local.set 4
                  br 2 (;@5;)
                end
                i32.const 1
                local.set 4
                local.get 2
                i32.const 1
                i32.eq
                br_if 4 (;@2;)
                local.get 1
                i32.load8_u offset=1
                i32.eqz
                br_if 1 (;@5;)
                i32.const 2
                local.set 4
                local.get 2
                i32.const 2
                i32.eq
                br_if 4 (;@2;)
                local.get 1
                i32.load8_u offset=2
                i32.eqz
                br_if 1 (;@5;)
                i32.const 3
                local.set 4
                local.get 2
                i32.const 3
                i32.eq
                br_if 4 (;@2;)
                local.get 1
                i32.load8_u offset=3
                i32.eqz
                br_if 1 (;@5;)
                i32.const 4
                local.set 4
                local.get 2
                i32.const 4
                i32.eq
                br_if 4 (;@2;)
                local.get 1
                i32.load8_u offset=4
                i32.eqz
                br_if 1 (;@5;)
                i32.const 5
                local.set 4
                local.get 2
                i32.const 5
                i32.eq
                br_if 4 (;@2;)
                local.get 1
                i32.load8_u offset=5
                i32.eqz
                br_if 1 (;@5;)
                i32.const 6
                local.set 4
                local.get 2
                i32.const 6
                i32.eq
                br_if 4 (;@2;)
                local.get 1
                i32.load8_u offset=6
                i32.eqz
                br_if 1 (;@5;)
                br 4 (;@2;)
              end
              local.get 3
              i32.const 8
              i32.add
              i32.const 0
              local.get 1
              local.get 2
              call $_ZN4core5slice6memchr14memchr_aligned17hc1073447135eebe4E
              local.get 3
              i32.load offset=8
              i32.const 1
              i32.and
              i32.eqz
              br_if 3 (;@2;)
              local.get 3
              i32.load offset=12
              local.set 4
            end
            local.get 0
            local.get 4
            i32.store offset=12
            local.get 0
            local.get 2
            i32.store offset=8
            local.get 0
            local.get 6
            i32.store offset=4
            local.get 0
            local.get 5
            i32.store
            br 3 (;@1;)
          end
          local.get 4
          local.get 5
          i32.const 1058340
          call $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E
          unreachable
        end
        i32.const 1058356
        call $_ZN4core6option13unwrap_failed17habb842812e602dc6E
        unreachable
      end
      local.get 3
      local.get 2
      i32.store offset=28
      local.get 3
      local.get 6
      i32.store offset=24
      local.get 3
      local.get 5
      i32.store offset=20
      local.get 3
      local.get 3
      i32.const 20
      i32.add
      call $_ZN5alloc3ffi5c_str7CString19_from_vec_unchecked17h444898f7bcaf2199E
      local.get 0
      local.get 3
      i64.load
      i64.store offset=4 align=4
      local.get 0
      i32.const -2147483648
      i32.store
    end
    local.get 3
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN5alloc3ffi5c_str7CString19_from_vec_unchecked17h444898f7bcaf2199E (type 6) (param i32 i32)
    (local i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      local.get 1
      i32.load
      local.tee 3
      local.get 1
      i32.load offset=8
      local.tee 4
      i32.ne
      br_if 0 (;@1;)
      i32.const 0
      local.set 5
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 4
            i32.const 1
            i32.add
            local.tee 3
            i32.const 0
            i32.ge_s
            br_if 0 (;@4;)
            br 1 (;@3;)
          end
          i32.const 0
          local.set 5
          block  ;; label = @4
            local.get 4
            i32.eqz
            br_if 0 (;@4;)
            local.get 2
            local.get 4
            i32.store offset=28
            local.get 2
            local.get 1
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
          local.get 3
          local.get 2
          i32.const 20
          i32.add
          call $_ZN5alloc7raw_vec11finish_grow17hfbb7e2842f19eb9bE
          local.get 2
          i32.load offset=8
          i32.const 1
          i32.ne
          br_if 1 (;@2;)
          local.get 2
          i32.load offset=16
          local.set 1
          local.get 2
          i32.load offset=12
          local.set 5
        end
        local.get 5
        local.get 1
        i32.const 1058372
        call $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E
        unreachable
      end
      local.get 2
      i32.load offset=12
      local.set 5
      local.get 1
      local.get 3
      i32.store
      local.get 1
      local.get 5
      i32.store offset=4
    end
    local.get 1
    local.get 4
    i32.const 1
    i32.add
    local.tee 5
    i32.store offset=8
    local.get 1
    i32.load offset=4
    local.tee 1
    local.get 4
    i32.add
    i32.const 0
    i32.store8
    block  ;; label = @1
      block  ;; label = @2
        local.get 3
        local.get 5
        i32.gt_u
        br_if 0 (;@2;)
        local.get 1
        local.set 4
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 5
        br_if 0 (;@2;)
        i32.const 1
        local.set 4
        local.get 1
        local.get 3
        i32.const 1
        call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        br 1 (;@1;)
      end
      local.get 1
      local.get 3
      i32.const 1
      local.get 5
      call $_RNvCs691rhTbG0Ee_7___rustc14___rust_realloc
      local.tee 4
      br_if 0 (;@1;)
      i32.const 1
      local.get 5
      call $_ZN5alloc5alloc18handle_alloc_error17hcc35c2aed22157a6E
      unreachable
    end
    local.get 0
    local.get 5
    i32.store offset=4
    local.get 0
    local.get 4
    i32.store
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN4core5slice5index26slice_start_index_len_fail17hcb91b9a11352b54bE (type 4) (param i32 i32 i32)
    local.get 0
    local.get 1
    local.get 2
    call $_ZN4core5slice5index26slice_start_index_len_fail8do_panic7runtime17h48bf4e38c81b8765E
    unreachable)
  (func $_ZN4core5slice5index24slice_end_index_len_fail17hc7943372990115c8E (type 4) (param i32 i32 i32)
    local.get 0
    local.get 1
    local.get 2
    call $_ZN4core5slice5index24slice_end_index_len_fail8do_panic7runtime17h4fdd0b90f95e57b9E
    unreachable)
  (func $_ZN4core3fmt9Formatter3pad17hcc32532bfecc9527E (type 5) (param i32 i32 i32) (result i32)
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
                  call $_ZN4core3str5count14do_count_chars17h3f21c085b7864607E
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
            call_indirect (type 2)
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
        call_indirect (type 5)
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
          call_indirect (type 2)
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
      call_indirect (type 5)
      local.set 8
    end
    local.get 8)
  (func $_ZN4core9panicking5panic17h9346bb367bb316daE (type 4) (param i32 i32 i32)
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
    call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
    unreachable)
  (func $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E (type 6) (param i32 i32)
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
  (func $_ZN4core3fmt5write17hb4e267bf92503392E (type 5) (param i32 i32 i32) (result i32)
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
                call_indirect (type 5)
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
                call_indirect (type 2)
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
              call_indirect (type 5)
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
              call_indirect (type 2)
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
        call_indirect (type 5)
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
  (func $_ZN71_$LT$core..ops..range..Range$LT$Idx$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hcaf36282d85189a7E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 128
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 1
            i32.load offset=8
            local.tee 3
            i32.const 33554432
            i32.and
            br_if 0 (;@4;)
            local.get 3
            i32.const 67108864
            i32.and
            br_if 1 (;@3;)
            i32.const 1
            local.set 3
            local.get 0
            i32.load
            i32.const 1
            local.get 1
            call $_ZN4core3fmt3num3imp21_$LT$impl$u20$u32$GT$4_fmt17hc1581077febdde3aE
            i32.eqz
            br_if 2 (;@2;)
            br 3 (;@1;)
          end
          local.get 0
          i32.load
          local.set 3
          i32.const 0
          local.set 4
          loop  ;; label = @4
            local.get 2
            local.get 4
            i32.add
            i32.const 127
            i32.add
            local.get 3
            i32.const 15
            i32.and
            local.tee 5
            i32.const 48
            i32.or
            local.get 5
            i32.const 87
            i32.add
            local.get 5
            i32.const 10
            i32.lt_u
            select
            i32.store8
            local.get 4
            i32.const -1
            i32.add
            local.set 4
            local.get 3
            i32.const 16
            i32.lt_u
            local.set 5
            local.get 3
            i32.const 4
            i32.shr_u
            local.set 3
            local.get 5
            i32.eqz
            br_if 0 (;@4;)
          end
          i32.const 1
          local.set 3
          local.get 1
          i32.const 1
          i32.const 1059477
          i32.const 2
          local.get 2
          local.get 4
          i32.add
          i32.const 128
          i32.add
          i32.const 0
          local.get 4
          i32.sub
          call $_ZN4core3fmt9Formatter12pad_integral17h57e359ed883e3df4E
          i32.eqz
          br_if 1 (;@2;)
          br 2 (;@1;)
        end
        local.get 0
        i32.load
        local.set 3
        i32.const 0
        local.set 4
        loop  ;; label = @3
          local.get 2
          local.get 4
          i32.add
          i32.const 127
          i32.add
          local.get 3
          i32.const 15
          i32.and
          local.tee 5
          i32.const 48
          i32.or
          local.get 5
          i32.const 55
          i32.add
          local.get 5
          i32.const 10
          i32.lt_u
          select
          i32.store8
          local.get 4
          i32.const -1
          i32.add
          local.set 4
          local.get 3
          i32.const 15
          i32.gt_u
          local.set 5
          local.get 3
          i32.const 4
          i32.shr_u
          local.set 3
          local.get 5
          br_if 0 (;@3;)
        end
        i32.const 1
        local.set 3
        local.get 1
        i32.const 1
        i32.const 1059477
        i32.const 2
        local.get 2
        local.get 4
        i32.add
        i32.const 128
        i32.add
        i32.const 0
        local.get 4
        i32.sub
        call $_ZN4core3fmt9Formatter12pad_integral17h57e359ed883e3df4E
        br_if 1 (;@1;)
      end
      i32.const 1
      local.set 3
      local.get 1
      i32.load
      i32.const 1059140
      i32.const 2
      local.get 1
      i32.load offset=4
      i32.load offset=12
      call_indirect (type 5)
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          i32.load offset=8
          local.tee 3
          i32.const 33554432
          i32.and
          br_if 0 (;@3;)
          local.get 3
          i32.const 67108864
          i32.and
          br_if 1 (;@2;)
          local.get 0
          i32.load offset=4
          i32.const 1
          local.get 1
          call $_ZN4core3fmt3num3imp21_$LT$impl$u20$u32$GT$4_fmt17hc1581077febdde3aE
          local.set 3
          br 2 (;@1;)
        end
        local.get 0
        i32.load offset=4
        local.set 3
        i32.const 0
        local.set 4
        loop  ;; label = @3
          local.get 2
          local.get 4
          i32.add
          i32.const 127
          i32.add
          local.get 3
          i32.const 15
          i32.and
          local.tee 5
          i32.const 48
          i32.or
          local.get 5
          i32.const 87
          i32.add
          local.get 5
          i32.const 10
          i32.lt_u
          select
          i32.store8
          local.get 4
          i32.const -1
          i32.add
          local.set 4
          local.get 3
          i32.const 15
          i32.gt_u
          local.set 5
          local.get 3
          i32.const 4
          i32.shr_u
          local.set 3
          local.get 5
          br_if 0 (;@3;)
        end
        local.get 1
        i32.const 1
        i32.const 1059477
        i32.const 2
        local.get 2
        local.get 4
        i32.add
        i32.const 128
        i32.add
        i32.const 0
        local.get 4
        i32.sub
        call $_ZN4core3fmt9Formatter12pad_integral17h57e359ed883e3df4E
        local.set 3
        br 1 (;@1;)
      end
      local.get 0
      i32.load offset=4
      local.set 3
      i32.const 0
      local.set 4
      loop  ;; label = @2
        local.get 2
        local.get 4
        i32.add
        i32.const 127
        i32.add
        local.get 3
        i32.const 15
        i32.and
        local.tee 5
        i32.const 48
        i32.or
        local.get 5
        i32.const 55
        i32.add
        local.get 5
        i32.const 10
        i32.lt_u
        select
        i32.store8
        local.get 4
        i32.const -1
        i32.add
        local.set 4
        local.get 3
        i32.const 15
        i32.gt_u
        local.set 5
        local.get 3
        i32.const 4
        i32.shr_u
        local.set 3
        local.get 5
        br_if 0 (;@2;)
      end
      local.get 1
      i32.const 1
      i32.const 1059477
      i32.const 2
      local.get 2
      local.get 4
      i32.add
      i32.const 128
      i32.add
      i32.const 0
      local.get 4
      i32.sub
      call $_ZN4core3fmt9Formatter12pad_integral17h57e359ed883e3df4E
      local.set 3
    end
    local.get 2
    i32.const 128
    i32.add
    global.set $__stack_pointer
    local.get 3)
  (func $_ZN4core3fmt3num3imp21_$LT$impl$u20$u32$GT$4_fmt17hc1581077febdde3aE (type 5) (param i32 i32 i32) (result i32)
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
        i32.const 1059480
        i32.add
        i32.load8_u
        i32.store8
        local.get 7
        i32.const -4
        i32.add
        local.get 10
        i32.const 1059479
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
        i32.const 1059480
        i32.add
        i32.load8_u
        i32.store8
        local.get 7
        i32.const -2
        i32.add
        local.get 8
        i32.const 1059479
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
      i32.const 1059480
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
      i32.const 1059479
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
      i32.const 1059480
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
    call $_ZN4core3fmt9Formatter12pad_integral17h57e359ed883e3df4E
    local.set 6
    local.get 3
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 6)
  (func $_ZN4core3fmt9Formatter12pad_integral17h57e359ed883e3df4E (type 8) (param i32 i32 i32 i32 i32 i32) (result i32)
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
          call $_ZN4core3str5count14do_count_chars17h3f21c085b7864607E
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
                call_indirect (type 2)
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
            call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17hc60e160547463b96E
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
              call_indirect (type 2)
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
          call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17hc60e160547463b96E
          br_if 2 (;@1;)
          local.get 10
          local.get 4
          local.get 5
          local.get 9
          i32.load offset=12
          call_indirect (type 5)
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
            call_indirect (type 2)
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
        call_indirect (type 5)
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
      call $_ZN4core3fmt9Formatter12pad_integral12write_prefix17hc60e160547463b96E
      br_if 0 (;@1;)
      local.get 1
      local.get 4
      local.get 5
      local.get 10
      i32.load offset=12
      call_indirect (type 5)
      local.set 12
    end
    local.get 12)
  (func $_ZN4core4char7methods22_$LT$impl$u20$char$GT$16escape_debug_ext17h61165eeecc9cfe60E (type 4) (param i32 i32 i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 32
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
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            local.get 1
                            br_table 6 (;@6;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 2 (;@10;) 4 (;@8;) 1 (;@11;) 1 (;@11;) 3 (;@9;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 8 (;@4;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 1 (;@11;) 7 (;@5;) 0 (;@12;)
                          end
                          local.get 1
                          i32.const 92
                          i32.eq
                          br_if 4 (;@7;)
                        end
                        local.get 2
                        i32.const 1
                        i32.and
                        i32.eqz
                        br_if 7 (;@3;)
                        local.get 1
                        i32.const 767
                        i32.le_u
                        br_if 7 (;@3;)
                        local.get 1
                        call $_ZN4core7unicode12unicode_data15grapheme_extend11lookup_slow17h8ec48f5652b05045E
                        i32.eqz
                        br_if 7 (;@3;)
                        local.get 3
                        i32.const 0
                        i32.store8 offset=10
                        local.get 3
                        i32.const 0
                        i32.store16 offset=8
                        local.get 3
                        local.get 1
                        i32.const 20
                        i32.shr_u
                        i32.const 1059142
                        i32.add
                        i32.load8_u
                        i32.store8 offset=11
                        local.get 3
                        local.get 1
                        i32.const 4
                        i32.shr_u
                        i32.const 15
                        i32.and
                        i32.const 1059142
                        i32.add
                        i32.load8_u
                        i32.store8 offset=15
                        local.get 3
                        local.get 1
                        i32.const 8
                        i32.shr_u
                        i32.const 15
                        i32.and
                        i32.const 1059142
                        i32.add
                        i32.load8_u
                        i32.store8 offset=14
                        local.get 3
                        local.get 1
                        i32.const 12
                        i32.shr_u
                        i32.const 15
                        i32.and
                        i32.const 1059142
                        i32.add
                        i32.load8_u
                        i32.store8 offset=13
                        local.get 3
                        local.get 1
                        i32.const 16
                        i32.shr_u
                        i32.const 15
                        i32.and
                        i32.const 1059142
                        i32.add
                        i32.load8_u
                        i32.store8 offset=12
                        local.get 3
                        i32.const 8
                        i32.add
                        local.get 1
                        i32.const 1
                        i32.or
                        i32.clz
                        i32.const 2
                        i32.shr_u
                        local.tee 2
                        i32.add
                        local.tee 4
                        i32.const 123
                        i32.store8
                        local.get 4
                        i32.const -1
                        i32.add
                        i32.const 117
                        i32.store8
                        local.get 3
                        i32.const 8
                        i32.add
                        local.get 2
                        i32.const -2
                        i32.add
                        local.tee 2
                        i32.add
                        i32.const 92
                        i32.store8
                        local.get 3
                        i32.const 8
                        i32.add
                        i32.const 8
                        i32.add
                        local.tee 4
                        local.get 1
                        i32.const 15
                        i32.and
                        i32.const 1059142
                        i32.add
                        i32.load8_u
                        i32.store8
                        local.get 0
                        i32.const 10
                        i32.store8 offset=11
                        local.get 0
                        local.get 2
                        i32.store8 offset=10
                        local.get 0
                        local.get 3
                        i64.load offset=8 align=4
                        i64.store align=4
                        local.get 3
                        i32.const 125
                        i32.store8 offset=17
                        local.get 0
                        i32.const 8
                        i32.add
                        local.get 4
                        i32.load16_u
                        i32.store16
                        br 9 (;@1;)
                      end
                      local.get 0
                      i32.const 512
                      i32.store16 offset=10
                      local.get 0
                      i64.const 0
                      i64.store offset=2 align=2
                      local.get 0
                      i32.const 29788
                      i32.store16
                      br 8 (;@1;)
                    end
                    local.get 0
                    i32.const 512
                    i32.store16 offset=10
                    local.get 0
                    i64.const 0
                    i64.store offset=2 align=2
                    local.get 0
                    i32.const 29276
                    i32.store16
                    br 7 (;@1;)
                  end
                  local.get 0
                  i32.const 512
                  i32.store16 offset=10
                  local.get 0
                  i64.const 0
                  i64.store offset=2 align=2
                  local.get 0
                  i32.const 28252
                  i32.store16
                  br 6 (;@1;)
                end
                local.get 0
                i32.const 512
                i32.store16 offset=10
                local.get 0
                i64.const 0
                i64.store offset=2 align=2
                local.get 0
                i32.const 23644
                i32.store16
                br 5 (;@1;)
              end
              local.get 0
              i32.const 512
              i32.store16 offset=10
              local.get 0
              i64.const 0
              i64.store offset=2 align=2
              local.get 0
              i32.const 12380
              i32.store16
              br 4 (;@1;)
            end
            local.get 2
            i32.const 256
            i32.and
            i32.eqz
            br_if 1 (;@3;)
            local.get 0
            i32.const 512
            i32.store16 offset=10
            local.get 0
            i64.const 0
            i64.store offset=2 align=2
            local.get 0
            i32.const 10076
            i32.store16
            br 3 (;@1;)
          end
          local.get 2
          i32.const 16777215
          i32.and
          i32.const 65536
          i32.ge_u
          br_if 1 (;@2;)
        end
        block  ;; label = @3
          local.get 1
          call $_ZN4core7unicode9printable12is_printable17h341793aa4c76ac40E
          br_if 0 (;@3;)
          local.get 3
          i32.const 0
          i32.store8 offset=22
          local.get 3
          i32.const 0
          i32.store16 offset=20
          local.get 3
          local.get 1
          i32.const 20
          i32.shr_u
          i32.const 1059142
          i32.add
          i32.load8_u
          i32.store8 offset=23
          local.get 3
          local.get 1
          i32.const 4
          i32.shr_u
          i32.const 15
          i32.and
          i32.const 1059142
          i32.add
          i32.load8_u
          i32.store8 offset=27
          local.get 3
          local.get 1
          i32.const 8
          i32.shr_u
          i32.const 15
          i32.and
          i32.const 1059142
          i32.add
          i32.load8_u
          i32.store8 offset=26
          local.get 3
          local.get 1
          i32.const 12
          i32.shr_u
          i32.const 15
          i32.and
          i32.const 1059142
          i32.add
          i32.load8_u
          i32.store8 offset=25
          local.get 3
          local.get 1
          i32.const 16
          i32.shr_u
          i32.const 15
          i32.and
          i32.const 1059142
          i32.add
          i32.load8_u
          i32.store8 offset=24
          local.get 3
          i32.const 20
          i32.add
          local.get 1
          i32.const 1
          i32.or
          i32.clz
          i32.const 2
          i32.shr_u
          local.tee 2
          i32.add
          local.tee 4
          i32.const 123
          i32.store8
          local.get 4
          i32.const -1
          i32.add
          i32.const 117
          i32.store8
          local.get 3
          i32.const 20
          i32.add
          local.get 2
          i32.const -2
          i32.add
          local.tee 2
          i32.add
          i32.const 92
          i32.store8
          local.get 3
          i32.const 20
          i32.add
          i32.const 8
          i32.add
          local.tee 4
          local.get 1
          i32.const 15
          i32.and
          i32.const 1059142
          i32.add
          i32.load8_u
          i32.store8
          local.get 0
          i32.const 10
          i32.store8 offset=11
          local.get 0
          local.get 2
          i32.store8 offset=10
          local.get 0
          local.get 3
          i64.load offset=20 align=4
          i64.store align=4
          local.get 3
          i32.const 125
          i32.store8 offset=29
          local.get 0
          i32.const 8
          i32.add
          local.get 4
          i32.load16_u
          i32.store16
          br 2 (;@1;)
        end
        local.get 0
        local.get 1
        i32.store offset=4
        local.get 0
        i32.const 128
        i32.store8
        br 1 (;@1;)
      end
      local.get 0
      i32.const 512
      i32.store16 offset=10
      local.get 0
      i64.const 0
      i64.store offset=2 align=2
      local.get 0
      i32.const 8796
      i32.store16
    end
    local.get 3
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN4core3str5count14do_count_chars17h3f21c085b7864607E (type 2) (param i32 i32) (result i32)
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
  (func $_ZN63_$LT$core..cell..BorrowMutError$u20$as$u20$core..fmt..Debug$GT$3fmt17h222c0dff95342636E (type 2) (param i32 i32) (result i32)
    local.get 1
    i32.load
    i32.const 1059168
    i32.const 14
    local.get 1
    i32.load offset=4
    i32.load offset=12
    call_indirect (type 5))
  (func $_ZN4core4cell22panic_already_borrowed17h95614011b014b567E (type 1) (param i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    local.get 1
    i32.const 1
    i32.store offset=12
    local.get 1
    i32.const 1059200
    i32.store offset=8
    local.get 1
    i64.const 1
    i64.store offset=20 align=4
    local.get 1
    i32.const 69
    i64.extend_i32_u
    i64.const 32
    i64.shl
    local.get 1
    i32.const 47
    i32.add
    i64.extend_i32_u
    i64.or
    i64.store offset=32
    local.get 1
    local.get 1
    i32.const 32
    i32.add
    i32.store offset=16
    local.get 1
    i32.const 8
    i32.add
    local.get 0
    call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
    unreachable)
  (func $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i16$GT$3fmt17hd4aea400ca6ba288E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 128
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 0
    i32.load16_u
    local.set 3
    i32.const 0
    local.set 0
    loop  ;; label = @1
      local.get 2
      local.get 0
      i32.add
      i32.const 127
      i32.add
      local.get 3
      i32.const 15
      i32.and
      local.tee 4
      i32.const 48
      i32.or
      local.get 4
      i32.const 87
      i32.add
      local.get 4
      i32.const 10
      i32.lt_u
      select
      i32.store8
      local.get 0
      i32.const -1
      i32.add
      local.set 0
      local.get 3
      i32.const 65535
      i32.and
      local.tee 4
      i32.const 4
      i32.shr_u
      local.set 3
      local.get 4
      i32.const 15
      i32.gt_u
      br_if 0 (;@1;)
    end
    local.get 1
    i32.const 1
    i32.const 1059477
    i32.const 2
    local.get 2
    local.get 0
    i32.add
    i32.const 128
    i32.add
    i32.const 0
    local.get 0
    i32.sub
    call $_ZN4core3fmt9Formatter12pad_integral17h57e359ed883e3df4E
    local.set 0
    local.get 2
    i32.const 128
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN4core7unicode12unicode_data15grapheme_extend11lookup_slow17h8ec48f5652b05045E (type 3) (param i32) (result i32)
    (local i32 i32 i32 i32 i32)
    i32.const 0
    local.set 1
    i32.const 0
    i32.const 17
    local.get 0
    i32.const 71727
    i32.lt_u
    select
    local.tee 2
    local.get 2
    i32.const 8
    i32.or
    local.tee 2
    local.get 2
    i32.const 2
    i32.shl
    i32.const 1062012
    i32.add
    i32.load
    i32.const 11
    i32.shl
    local.get 0
    i32.const 11
    i32.shl
    local.tee 2
    i32.gt_u
    select
    local.tee 3
    local.get 3
    i32.const 4
    i32.or
    local.tee 3
    local.get 3
    i32.const 2
    i32.shl
    i32.const 1062012
    i32.add
    i32.load
    i32.const 11
    i32.shl
    local.get 2
    i32.gt_u
    select
    local.tee 3
    local.get 3
    i32.const 2
    i32.or
    local.tee 3
    local.get 3
    i32.const 2
    i32.shl
    i32.const 1062012
    i32.add
    i32.load
    i32.const 11
    i32.shl
    local.get 2
    i32.gt_u
    select
    local.tee 3
    local.get 3
    i32.const 1
    i32.add
    local.tee 3
    local.get 3
    i32.const 2
    i32.shl
    i32.const 1062012
    i32.add
    i32.load
    i32.const 11
    i32.shl
    local.get 2
    i32.gt_u
    select
    local.tee 3
    local.get 3
    i32.const 1
    i32.add
    local.tee 3
    local.get 3
    i32.const 2
    i32.shl
    i32.const 1062012
    i32.add
    i32.load
    i32.const 11
    i32.shl
    local.get 2
    i32.gt_u
    select
    local.tee 3
    i32.const 2
    i32.shl
    i32.const 1062012
    i32.add
    i32.load
    i32.const 11
    i32.shl
    local.tee 4
    local.get 2
    i32.eq
    local.get 4
    local.get 2
    i32.lt_u
    i32.add
    local.get 3
    i32.add
    local.tee 3
    i32.const 2
    i32.shl
    i32.const 1062012
    i32.add
    local.tee 5
    i32.load
    i32.const 21
    i32.shr_u
    local.set 2
    i32.const 751
    local.set 4
    block  ;; label = @1
      block  ;; label = @2
        local.get 3
        i32.const 32
        i32.gt_u
        br_if 0 (;@2;)
        local.get 5
        i32.load offset=4
        i32.const 21
        i32.shr_u
        local.set 4
        local.get 3
        i32.eqz
        br_if 1 (;@1;)
      end
      local.get 5
      i32.const -4
      i32.add
      i32.load
      i32.const 2097151
      i32.and
      local.set 1
    end
    block  ;; label = @1
      local.get 4
      local.get 2
      i32.const 1
      i32.add
      i32.eq
      br_if 0 (;@1;)
      local.get 0
      local.get 1
      i32.sub
      local.set 3
      local.get 4
      i32.const -1
      i32.add
      local.set 4
      i32.const 0
      local.set 0
      loop  ;; label = @2
        local.get 0
        local.get 2
        i32.const 1058388
        i32.add
        i32.load8_u
        i32.add
        local.tee 0
        local.get 3
        i32.gt_u
        br_if 1 (;@1;)
        local.get 4
        local.get 2
        i32.const 1
        i32.add
        local.tee 2
        i32.ne
        br_if 0 (;@2;)
      end
    end
    local.get 2
    i32.const 1
    i32.and)
  (func $_ZN4core7unicode9printable12is_printable17h341793aa4c76ac40E (type 3) (param i32) (result i32)
    block  ;; label = @1
      local.get 0
      i32.const 32
      i32.ge_u
      br_if 0 (;@1;)
      i32.const 0
      return
    end
    block  ;; label = @1
      local.get 0
      i32.const 127
      i32.ge_u
      br_if 0 (;@1;)
      i32.const 1
      return
    end
    block  ;; label = @1
      local.get 0
      i32.const 65536
      i32.lt_u
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 0
        i32.const 131072
        i32.lt_u
        br_if 0 (;@2;)
        local.get 0
        i32.const 2097120
        i32.and
        i32.const 173792
        i32.ne
        local.get 0
        i32.const 2097150
        i32.and
        i32.const 178206
        i32.ne
        i32.and
        local.get 0
        i32.const -177984
        i32.add
        i32.const -6
        i32.lt_u
        i32.and
        local.get 0
        i32.const -183984
        i32.add
        i32.const -14
        i32.lt_u
        i32.and
        local.get 0
        i32.const -191472
        i32.add
        i32.const -15
        i32.lt_u
        i32.and
        local.get 0
        i32.const -194560
        i32.add
        i32.const -2466
        i32.lt_u
        i32.and
        local.get 0
        i32.const -196608
        i32.add
        i32.const -1506
        i32.lt_u
        i32.and
        local.get 0
        i32.const -201552
        i32.add
        i32.const -5
        i32.lt_u
        i32.and
        local.get 0
        i32.const -917760
        i32.add
        i32.const -712016
        i32.lt_u
        i32.and
        local.get 0
        i32.const 918000
        i32.lt_u
        i32.and
        return
      end
      local.get 0
      i32.const 1060408
      i32.const 44
      i32.const 1060496
      i32.const 208
      i32.const 1060704
      i32.const 486
      call $_ZN4core7unicode9printable5check17h8bb7cfb0a6a631caE
      return
    end
    local.get 0
    i32.const 1061190
    i32.const 40
    i32.const 1061270
    i32.const 290
    i32.const 1061560
    i32.const 297
    call $_ZN4core7unicode9printable5check17h8bb7cfb0a6a631caE)
  (func $_ZN4core3ffi5c_str4CStr19from_bytes_with_nul17h21af397fb9054b6dE (type 4) (param i32 i32 i32)
    (local i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 2
              i32.const 7
              i32.gt_u
              br_if 0 (;@5;)
              local.get 2
              i32.eqz
              br_if 3 (;@2;)
              local.get 1
              i32.load8_u
              br_if 1 (;@4;)
              i32.const 0
              local.set 3
              br 4 (;@1;)
            end
            block  ;; label = @5
              block  ;; label = @6
                local.get 1
                i32.const 3
                i32.add
                i32.const -4
                i32.and
                local.get 1
                i32.sub
                local.tee 4
                i32.eqz
                br_if 0 (;@6;)
                i32.const 0
                local.set 3
                loop  ;; label = @7
                  local.get 1
                  local.get 3
                  i32.add
                  i32.load8_u
                  i32.eqz
                  br_if 6 (;@1;)
                  local.get 4
                  local.get 3
                  i32.const 1
                  i32.add
                  local.tee 3
                  i32.ne
                  br_if 0 (;@7;)
                end
                local.get 4
                local.get 2
                i32.const -8
                i32.add
                local.tee 5
                i32.le_u
                br_if 1 (;@5;)
                br 3 (;@3;)
              end
              local.get 2
              i32.const -8
              i32.add
              local.set 5
            end
            loop  ;; label = @5
              i32.const 16843008
              local.get 1
              local.get 4
              i32.add
              local.tee 3
              i32.load
              local.tee 6
              i32.sub
              local.get 6
              i32.or
              i32.const 16843008
              local.get 3
              i32.const 4
              i32.add
              i32.load
              local.tee 3
              i32.sub
              local.get 3
              i32.or
              i32.and
              i32.const -2139062144
              i32.and
              i32.const -2139062144
              i32.ne
              br_if 2 (;@3;)
              local.get 4
              i32.const 8
              i32.add
              local.tee 4
              local.get 5
              i32.le_u
              br_if 0 (;@5;)
              br 2 (;@3;)
            end
          end
          i32.const 1
          local.set 3
          local.get 2
          i32.const 1
          i32.eq
          br_if 1 (;@2;)
          local.get 1
          i32.load8_u offset=1
          i32.eqz
          br_if 2 (;@1;)
          i32.const 2
          local.set 3
          local.get 2
          i32.const 2
          i32.eq
          br_if 1 (;@2;)
          local.get 1
          i32.load8_u offset=2
          i32.eqz
          br_if 2 (;@1;)
          i32.const 3
          local.set 3
          local.get 2
          i32.const 3
          i32.eq
          br_if 1 (;@2;)
          local.get 1
          i32.load8_u offset=3
          i32.eqz
          br_if 2 (;@1;)
          i32.const 4
          local.set 3
          local.get 2
          i32.const 4
          i32.eq
          br_if 1 (;@2;)
          local.get 1
          i32.load8_u offset=4
          i32.eqz
          br_if 2 (;@1;)
          i32.const 5
          local.set 3
          local.get 2
          i32.const 5
          i32.eq
          br_if 1 (;@2;)
          local.get 1
          i32.load8_u offset=5
          i32.eqz
          br_if 2 (;@1;)
          i32.const 6
          local.set 3
          local.get 2
          i32.const 6
          i32.eq
          br_if 1 (;@2;)
          local.get 1
          i32.load8_u offset=6
          br_if 1 (;@2;)
          br 2 (;@1;)
        end
        local.get 2
        local.get 4
        i32.eq
        br_if 0 (;@2;)
        loop  ;; label = @3
          block  ;; label = @4
            local.get 1
            local.get 4
            i32.add
            i32.load8_u
            br_if 0 (;@4;)
            local.get 4
            local.set 3
            br 3 (;@1;)
          end
          local.get 2
          local.get 4
          i32.const 1
          i32.add
          local.tee 4
          i32.ne
          br_if 0 (;@3;)
        end
      end
      local.get 0
      i32.const 1
      i32.store offset=4
      local.get 0
      i32.const 1
      i32.store
      return
    end
    block  ;; label = @1
      local.get 3
      i32.const 1
      i32.add
      local.get 2
      i32.eq
      br_if 0 (;@1;)
      local.get 0
      local.get 3
      i32.store offset=8
      local.get 0
      i32.const 0
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
    local.get 1
    i32.store offset=4
    local.get 0
    i32.const 0
    i32.store)
  (func $_ZN4core3str8converts9from_utf817hb5c7d3e2ee61e867E (type 4) (param i32 i32 i32)
    (local i32 i32 i32 i32 i32 i64 i64 i32)
    block  ;; label = @1
      local.get 2
      i32.eqz
      br_if 0 (;@1;)
      i32.const 0
      local.get 2
      i32.const -7
      i32.add
      local.tee 3
      local.get 3
      local.get 2
      i32.gt_u
      select
      local.set 4
      local.get 1
      i32.const 3
      i32.add
      i32.const -4
      i32.and
      local.get 1
      i32.sub
      local.set 5
      i32.const 0
      local.set 3
      loop  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 1
                local.get 3
                i32.add
                i32.load8_u
                local.tee 6
                i32.extend8_s
                local.tee 7
                i32.const 0
                i32.lt_s
                br_if 0 (;@6;)
                local.get 5
                local.get 3
                i32.sub
                i32.const 3
                i32.and
                br_if 1 (;@5;)
                local.get 3
                local.get 4
                i32.ge_u
                br_if 2 (;@4;)
                loop  ;; label = @7
                  local.get 1
                  local.get 3
                  i32.add
                  local.tee 6
                  i32.const 4
                  i32.add
                  i32.load
                  local.get 6
                  i32.load
                  i32.or
                  i32.const -2139062144
                  i32.and
                  br_if 3 (;@4;)
                  local.get 3
                  i32.const 8
                  i32.add
                  local.tee 3
                  local.get 4
                  i32.lt_u
                  br_if 0 (;@7;)
                  br 3 (;@4;)
                end
              end
              i64.const 1099511627776
              local.set 8
              i64.const 4294967296
              local.set 9
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                block  ;; label = @15
                                  block  ;; label = @16
                                    block  ;; label = @17
                                      local.get 6
                                      i32.const 1059839
                                      i32.add
                                      i32.load8_u
                                      i32.const -2
                                      i32.add
                                      br_table 0 (;@17;) 1 (;@16;) 2 (;@15;) 10 (;@7;)
                                    end
                                    local.get 3
                                    i32.const 1
                                    i32.add
                                    local.tee 6
                                    local.get 2
                                    i32.lt_u
                                    br_if 2 (;@14;)
                                    i64.const 0
                                    local.set 8
                                    i64.const 0
                                    local.set 9
                                    br 9 (;@7;)
                                  end
                                  i64.const 0
                                  local.set 8
                                  local.get 3
                                  i32.const 1
                                  i32.add
                                  local.tee 10
                                  local.get 2
                                  i32.lt_u
                                  br_if 2 (;@13;)
                                  i64.const 0
                                  local.set 9
                                  br 8 (;@7;)
                                end
                                i64.const 0
                                local.set 8
                                local.get 3
                                i32.const 1
                                i32.add
                                local.tee 10
                                local.get 2
                                i32.lt_u
                                br_if 2 (;@12;)
                                i64.const 0
                                local.set 9
                                br 7 (;@7;)
                              end
                              i64.const 1099511627776
                              local.set 8
                              i64.const 4294967296
                              local.set 9
                              local.get 1
                              local.get 6
                              i32.add
                              i32.load8_s
                              i32.const -65
                              i32.gt_s
                              br_if 6 (;@7;)
                              br 7 (;@6;)
                            end
                            local.get 1
                            local.get 10
                            i32.add
                            i32.load8_s
                            local.set 10
                            block  ;; label = @13
                              block  ;; label = @14
                                block  ;; label = @15
                                  local.get 6
                                  i32.const -224
                                  i32.add
                                  br_table 0 (;@15;) 2 (;@13;) 2 (;@13;) 2 (;@13;) 2 (;@13;) 2 (;@13;) 2 (;@13;) 2 (;@13;) 2 (;@13;) 2 (;@13;) 2 (;@13;) 2 (;@13;) 2 (;@13;) 1 (;@14;) 2 (;@13;)
                                end
                                local.get 10
                                i32.const -32
                                i32.and
                                i32.const -96
                                i32.eq
                                br_if 4 (;@10;)
                                br 3 (;@11;)
                              end
                              local.get 10
                              i32.const -97
                              i32.gt_s
                              br_if 2 (;@11;)
                              br 3 (;@10;)
                            end
                            block  ;; label = @13
                              local.get 7
                              i32.const 31
                              i32.add
                              i32.const 255
                              i32.and
                              i32.const 12
                              i32.lt_u
                              br_if 0 (;@13;)
                              local.get 7
                              i32.const -2
                              i32.and
                              i32.const -18
                              i32.ne
                              br_if 2 (;@11;)
                              local.get 10
                              i32.const -64
                              i32.lt_s
                              br_if 3 (;@10;)
                              br 2 (;@11;)
                            end
                            local.get 10
                            i32.const -64
                            i32.lt_s
                            br_if 2 (;@10;)
                            br 1 (;@11;)
                          end
                          local.get 1
                          local.get 10
                          i32.add
                          i32.load8_s
                          local.set 10
                          block  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                block  ;; label = @15
                                  local.get 6
                                  i32.const -240
                                  i32.add
                                  br_table 1 (;@14;) 0 (;@15;) 0 (;@15;) 0 (;@15;) 2 (;@13;) 0 (;@15;)
                                end
                                local.get 7
                                i32.const 15
                                i32.add
                                i32.const 255
                                i32.and
                                i32.const 2
                                i32.gt_u
                                br_if 3 (;@11;)
                                local.get 10
                                i32.const -64
                                i32.ge_s
                                br_if 3 (;@11;)
                                br 2 (;@12;)
                              end
                              local.get 10
                              i32.const 112
                              i32.add
                              i32.const 255
                              i32.and
                              i32.const 48
                              i32.ge_u
                              br_if 2 (;@11;)
                              br 1 (;@12;)
                            end
                            local.get 10
                            i32.const -113
                            i32.gt_s
                            br_if 1 (;@11;)
                          end
                          block  ;; label = @12
                            local.get 3
                            i32.const 2
                            i32.add
                            local.tee 6
                            local.get 2
                            i32.lt_u
                            br_if 0 (;@12;)
                            i64.const 0
                            local.set 9
                            br 5 (;@7;)
                          end
                          local.get 1
                          local.get 6
                          i32.add
                          i32.load8_s
                          i32.const -65
                          i32.gt_s
                          br_if 2 (;@9;)
                          i64.const 0
                          local.set 9
                          local.get 3
                          i32.const 3
                          i32.add
                          local.tee 6
                          local.get 2
                          i32.ge_u
                          br_if 4 (;@7;)
                          local.get 1
                          local.get 6
                          i32.add
                          i32.load8_s
                          i32.const -64
                          i32.lt_s
                          br_if 5 (;@6;)
                          i64.const 3298534883328
                          local.set 8
                          br 3 (;@8;)
                        end
                        i64.const 1099511627776
                        local.set 8
                        br 2 (;@8;)
                      end
                      i64.const 0
                      local.set 9
                      local.get 3
                      i32.const 2
                      i32.add
                      local.tee 6
                      local.get 2
                      i32.ge_u
                      br_if 2 (;@7;)
                      local.get 1
                      local.get 6
                      i32.add
                      i32.load8_s
                      i32.const -65
                      i32.le_s
                      br_if 3 (;@6;)
                    end
                    i64.const 2199023255552
                    local.set 8
                  end
                  i64.const 4294967296
                  local.set 9
                end
                local.get 0
                local.get 8
                local.get 3
                i64.extend_i32_u
                i64.or
                local.get 9
                i64.or
                i64.store offset=4 align=4
                local.get 0
                i32.const 1
                i32.store
                return
              end
              local.get 6
              i32.const 1
              i32.add
              local.set 3
              br 2 (;@3;)
            end
            local.get 3
            i32.const 1
            i32.add
            local.set 3
            br 1 (;@3;)
          end
          local.get 3
          local.get 2
          i32.ge_u
          br_if 0 (;@3;)
          loop  ;; label = @4
            local.get 1
            local.get 3
            i32.add
            i32.load8_s
            i32.const 0
            i32.lt_s
            br_if 1 (;@3;)
            local.get 2
            local.get 3
            i32.const 1
            i32.add
            local.tee 3
            i32.ne
            br_if 0 (;@4;)
            br 3 (;@1;)
          end
        end
        local.get 3
        local.get 2
        i32.lt_u
        br_if 0 (;@2;)
      end
    end
    local.get 0
    local.get 2
    i32.store offset=8
    local.get 0
    local.get 1
    i32.store offset=4
    local.get 0
    i32.const 0
    i32.store)
  (func $_ZN4core3fmt8builders11DebugStruct5field17h13f66060f544090dE (type 9) (param i32 i32 i32 i32 i32) (result i32)
    (local i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    i32.const 1
    local.set 6
    block  ;; label = @1
      local.get 0
      i32.load8_u offset=4
      br_if 0 (;@1;)
      local.get 0
      i32.load8_u offset=5
      local.set 7
      block  ;; label = @2
        local.get 0
        i32.load
        local.tee 8
        i32.load8_u offset=10
        i32.const 128
        i32.and
        br_if 0 (;@2;)
        i32.const 1
        local.set 6
        local.get 8
        i32.load
        i32.const 1059463
        i32.const 1059460
        local.get 7
        i32.const 1
        i32.and
        local.tee 7
        select
        i32.const 2
        i32.const 3
        local.get 7
        select
        local.get 8
        i32.load offset=4
        i32.load offset=12
        call_indirect (type 5)
        br_if 1 (;@1;)
        local.get 8
        i32.load
        local.get 1
        local.get 2
        local.get 8
        i32.load offset=4
        i32.load offset=12
        call_indirect (type 5)
        br_if 1 (;@1;)
        local.get 8
        i32.load
        i32.const 1059412
        i32.const 2
        local.get 8
        i32.load offset=4
        i32.load offset=12
        call_indirect (type 5)
        br_if 1 (;@1;)
        local.get 3
        local.get 8
        local.get 4
        i32.load offset=12
        call_indirect (type 2)
        local.set 6
        br 1 (;@1;)
      end
      i32.const 1
      local.set 6
      block  ;; label = @2
        local.get 7
        i32.const 1
        i32.and
        br_if 0 (;@2;)
        local.get 8
        i32.load
        i32.const 1059465
        i32.const 3
        local.get 8
        i32.load offset=4
        i32.load offset=12
        call_indirect (type 5)
        br_if 1 (;@1;)
      end
      i32.const 1
      local.set 6
      local.get 5
      i32.const 1
      i32.store8 offset=15
      local.get 5
      i32.const 1059432
      i32.store offset=20
      local.get 5
      local.get 8
      i64.load align=4
      i64.store align=4
      local.get 5
      local.get 8
      i64.load offset=8 align=4
      i64.store offset=24 align=4
      local.get 5
      local.get 5
      i32.const 15
      i32.add
      i32.store offset=8
      local.get 5
      local.get 5
      i32.store offset=16
      local.get 5
      local.get 1
      local.get 2
      call $_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h21cf2d4c44ad3142E
      br_if 0 (;@1;)
      local.get 5
      i32.const 1059412
      i32.const 2
      call $_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h21cf2d4c44ad3142E
      br_if 0 (;@1;)
      local.get 3
      local.get 5
      i32.const 16
      i32.add
      local.get 4
      i32.load offset=12
      call_indirect (type 2)
      br_if 0 (;@1;)
      local.get 5
      i32.load offset=16
      i32.const 1059468
      i32.const 2
      local.get 5
      i32.load offset=20
      i32.load offset=12
      call_indirect (type 5)
      local.set 6
    end
    local.get 0
    i32.const 1
    i32.store8 offset=5
    local.get 0
    local.get 6
    i32.store8 offset=4
    local.get 5
    i32.const 32
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN4core3fmt3num3imp51_$LT$impl$u20$core..fmt..Display$u20$for$u20$u8$GT$3fmt17h3aee1a4af9b1cd21E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    i32.const 3
    local.set 3
    local.get 0
    i32.load8_u
    local.tee 0
    local.set 4
    block  ;; label = @1
      local.get 0
      i32.const 10
      i32.lt_u
      br_if 0 (;@1;)
      i32.const 1
      local.set 3
      local.get 2
      local.get 0
      local.get 0
      i32.const 100
      i32.div_u
      local.tee 4
      i32.const 100
      i32.mul
      i32.sub
      i32.const 255
      i32.and
      i32.const 1
      i32.shl
      local.tee 5
      i32.const 1059480
      i32.add
      i32.load8_u
      i32.store8 offset=15
      local.get 2
      local.get 5
      i32.const 1059479
      i32.add
      i32.load8_u
      i32.store8 offset=14
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.eqz
        br_if 0 (;@2;)
        local.get 4
        i32.eqz
        br_if 1 (;@1;)
      end
      local.get 2
      i32.const 13
      i32.add
      local.get 3
      i32.const -1
      i32.add
      local.tee 3
      i32.add
      local.get 4
      i32.const 1
      i32.shl
      i32.const 254
      i32.and
      i32.const 1059480
      i32.add
      i32.load8_u
      i32.store8
    end
    local.get 1
    i32.const 1
    i32.const 1
    i32.const 0
    local.get 2
    i32.const 13
    i32.add
    local.get 3
    i32.add
    i32.const 3
    local.get 3
    i32.sub
    call $_ZN4core3fmt9Formatter12pad_integral17h57e359ed883e3df4E
    local.set 3
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 3)
  (func $_ZN4core6result13unwrap_failed17h398ddd55d54bb216E (type 12) (param i32 i32 i32 i32 i32)
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
    i32.const 1059416
    i32.store offset=24
    local.get 5
    i64.const 2
    i64.store offset=36 align=4
    local.get 5
    i32.const 70
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
    i32.const 71
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
    call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
    unreachable)
  (func $_ZN4core5slice5index22slice_index_order_fail17hacfaea8d0e6739e4E (type 4) (param i32 i32 i32)
    local.get 0
    local.get 1
    local.get 2
    call $_ZN4core5slice5index22slice_index_order_fail8do_panic7runtime17h1b06a677f422cc0dE
    unreachable)
  (func $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u16$GT$3fmt17h0a70fcf6ae4f6af2E (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.load16_u
    i32.const 1
    local.get 1
    call $_ZN4core3fmt3num3imp21_$LT$impl$u20$u16$GT$4_fmt17hc210f2c273d7f4f1E)
  (func $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h5cd5bf496cf18c08E (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.load
    i32.const 1
    local.get 1
    call $_ZN4core3fmt3num3imp21_$LT$impl$u20$u32$GT$4_fmt17hc1581077febdde3aE)
  (func $_ZN4core6option13unwrap_failed17habb842812e602dc6E (type 1) (param i32)
    i32.const 1059208
    i32.const 43
    local.get 0
    call $_ZN4core9panicking5panic17h9346bb367bb316daE
    unreachable)
  (func $_ZN4core6option13expect_failed17hbb79b61f61810248E (type 4) (param i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    local.get 1
    i32.store offset=12
    local.get 3
    local.get 0
    i32.store offset=8
    local.get 3
    i32.const 1
    i32.store offset=20
    local.get 3
    i32.const 1059160
    i32.store offset=16
    local.get 3
    i64.const 1
    i64.store offset=28 align=4
    local.get 3
    i32.const 71
    i64.extend_i32_u
    i64.const 32
    i64.shl
    local.get 3
    i32.const 8
    i32.add
    i64.extend_i32_u
    i64.or
    i64.store offset=40
    local.get 3
    local.get 3
    i32.const 40
    i32.add
    i32.store offset=24
    local.get 3
    i32.const 16
    i32.add
    local.get 2
    call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
    unreachable)
  (func $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h2efaf87080996a5eE (type 2) (param i32 i32) (result i32)
    local.get 1
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    call $_ZN4core3fmt9Formatter3pad17hcc32532bfecc9527E)
  (func $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i32$GT$3fmt17h33f159b23376b92cE (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 128
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 0
    i32.load
    local.set 0
    i32.const 0
    local.set 3
    loop  ;; label = @1
      local.get 2
      local.get 3
      i32.add
      i32.const 127
      i32.add
      local.get 0
      i32.const 15
      i32.and
      local.tee 4
      i32.const 48
      i32.or
      local.get 4
      i32.const 87
      i32.add
      local.get 4
      i32.const 10
      i32.lt_u
      select
      i32.store8
      local.get 3
      i32.const -1
      i32.add
      local.set 3
      local.get 0
      i32.const 15
      i32.gt_u
      local.set 4
      local.get 0
      i32.const 4
      i32.shr_u
      local.set 0
      local.get 4
      br_if 0 (;@1;)
    end
    local.get 1
    i32.const 1
    i32.const 1059477
    i32.const 2
    local.get 2
    local.get 3
    i32.add
    i32.const 128
    i32.add
    i32.const 0
    local.get 3
    i32.sub
    call $_ZN4core3fmt9Formatter12pad_integral17h57e359ed883e3df4E
    local.set 0
    local.get 2
    i32.const 128
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN4core9panicking19assert_failed_inner17ha727a1f35658cb19E (type 13) (param i32 i32 i32 i32 i32 i32 i32)
    (local i32 i64)
    global.get $__stack_pointer
    i32.const 112
    i32.sub
    local.tee 7
    global.set $__stack_pointer
    local.get 7
    local.get 2
    i32.store offset=12
    local.get 7
    local.get 1
    i32.store offset=8
    local.get 7
    local.get 4
    i32.store offset=20
    local.get 7
    local.get 3
    i32.store offset=16
    local.get 7
    local.get 0
    i32.const 255
    i32.and
    i32.const 2
    i32.shl
    local.tee 2
    i32.const 1062160
    i32.add
    i32.load
    i32.store offset=28
    local.get 7
    local.get 2
    i32.const 1062148
    i32.add
    i32.load
    i32.store offset=24
    block  ;; label = @1
      local.get 5
      i32.load
      i32.eqz
      br_if 0 (;@1;)
      local.get 7
      i32.const 32
      i32.add
      i32.const 16
      i32.add
      local.get 5
      i32.const 16
      i32.add
      i64.load align=4
      i64.store
      local.get 7
      i32.const 32
      i32.add
      i32.const 8
      i32.add
      local.get 5
      i32.const 8
      i32.add
      i64.load align=4
      i64.store
      local.get 7
      local.get 5
      i64.load align=4
      i64.store offset=32
      local.get 7
      i32.const 4
      i32.store offset=92
      local.get 7
      i32.const 1059380
      i32.store offset=88
      local.get 7
      i64.const 4
      i64.store offset=100 align=4
      local.get 7
      i32.const 70
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.tee 8
      local.get 7
      i32.const 16
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=80
      local.get 7
      local.get 8
      local.get 7
      i32.const 8
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=72
      local.get 7
      i32.const 72
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.get 7
      i32.const 32
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=64
      local.get 7
      i32.const 71
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.get 7
      i32.const 24
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=56
      local.get 7
      local.get 7
      i32.const 56
      i32.add
      i32.store offset=96
      local.get 7
      i32.const 88
      i32.add
      local.get 6
      call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
      unreachable
    end
    local.get 7
    i32.const 3
    i32.store offset=92
    local.get 7
    i32.const 1059328
    i32.store offset=88
    local.get 7
    i64.const 3
    i64.store offset=100 align=4
    local.get 7
    i32.const 70
    i64.extend_i32_u
    i64.const 32
    i64.shl
    local.tee 8
    local.get 7
    i32.const 16
    i32.add
    i64.extend_i32_u
    i64.or
    i64.store offset=72
    local.get 7
    local.get 8
    local.get 7
    i32.const 8
    i32.add
    i64.extend_i32_u
    i64.or
    i64.store offset=64
    local.get 7
    i32.const 71
    i64.extend_i32_u
    i64.const 32
    i64.shl
    local.get 7
    i32.const 24
    i32.add
    i64.extend_i32_u
    i64.or
    i64.store offset=56
    local.get 7
    local.get 7
    i32.const 56
    i32.add
    i32.store offset=96
    local.get 7
    i32.const 88
    i32.add
    local.get 6
    call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
    unreachable)
  (func $_ZN4core9panicking13assert_failed17h40a15157b46eef88E (type 12) (param i32 i32 i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    local.get 5
    local.get 2
    i32.store offset=12
    local.get 5
    local.get 1
    i32.store offset=8
    local.get 0
    local.get 5
    i32.const 8
    i32.add
    i32.const 1059252
    local.get 5
    i32.const 12
    i32.add
    i32.const 1059252
    local.get 3
    local.get 4
    call $_ZN4core9panicking19assert_failed_inner17ha727a1f35658cb19E
    unreachable)
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h7b5d3569f767cb83E (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 1
    local.get 0
    i32.load offset=4
    i32.load offset=12
    call_indirect (type 2))
  (func $_ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17h511711e1bbf1c9f9E (type 2) (param i32 i32) (result i32)
    local.get 1
    i32.load
    local.get 1
    i32.load offset=4
    local.get 0
    call $_ZN4core3fmt5write17hb4e267bf92503392E)
  (func $_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h21cf2d4c44ad3142E (type 5) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    local.get 1
    i32.const -1
    i32.add
    local.set 3
    local.get 0
    i32.load offset=4
    local.set 4
    local.get 0
    i32.load
    local.set 5
    local.get 0
    i32.load offset=8
    local.set 6
    i32.const 0
    local.set 7
    i32.const 0
    local.set 8
    i32.const 0
    local.set 9
    i32.const 0
    local.set 10
    block  ;; label = @1
      loop  ;; label = @2
        local.get 10
        i32.const 1
        i32.and
        br_if 1 (;@1;)
        block  ;; label = @3
          block  ;; label = @4
            local.get 2
            local.get 9
            i32.lt_u
            br_if 0 (;@4;)
            loop  ;; label = @5
              local.get 1
              local.get 9
              i32.add
              local.set 10
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 2
                      local.get 9
                      i32.sub
                      local.tee 11
                      i32.const 7
                      i32.gt_u
                      br_if 0 (;@9;)
                      local.get 2
                      local.get 9
                      i32.ne
                      br_if 1 (;@8;)
                      local.get 2
                      local.set 9
                      br 5 (;@4;)
                    end
                    block  ;; label = @9
                      block  ;; label = @10
                        local.get 10
                        i32.const 3
                        i32.add
                        i32.const -4
                        i32.and
                        local.tee 12
                        local.get 10
                        i32.sub
                        local.tee 13
                        i32.eqz
                        br_if 0 (;@10;)
                        i32.const 0
                        local.set 0
                        loop  ;; label = @11
                          local.get 10
                          local.get 0
                          i32.add
                          i32.load8_u
                          i32.const 10
                          i32.eq
                          br_if 5 (;@6;)
                          local.get 13
                          local.get 0
                          i32.const 1
                          i32.add
                          local.tee 0
                          i32.ne
                          br_if 0 (;@11;)
                        end
                        local.get 13
                        local.get 11
                        i32.const -8
                        i32.add
                        local.tee 14
                        i32.le_u
                        br_if 1 (;@9;)
                        br 3 (;@7;)
                      end
                      local.get 11
                      i32.const -8
                      i32.add
                      local.set 14
                    end
                    loop  ;; label = @9
                      i32.const 16843008
                      local.get 12
                      i32.load
                      local.tee 0
                      i32.const 168430090
                      i32.xor
                      i32.sub
                      local.get 0
                      i32.or
                      i32.const 16843008
                      local.get 12
                      i32.const 4
                      i32.add
                      i32.load
                      local.tee 0
                      i32.const 168430090
                      i32.xor
                      i32.sub
                      local.get 0
                      i32.or
                      i32.and
                      i32.const -2139062144
                      i32.and
                      i32.const -2139062144
                      i32.ne
                      br_if 2 (;@7;)
                      local.get 12
                      i32.const 8
                      i32.add
                      local.set 12
                      local.get 13
                      i32.const 8
                      i32.add
                      local.tee 13
                      local.get 14
                      i32.le_u
                      br_if 0 (;@9;)
                      br 2 (;@7;)
                    end
                  end
                  i32.const 0
                  local.set 0
                  loop  ;; label = @8
                    local.get 10
                    local.get 0
                    i32.add
                    i32.load8_u
                    i32.const 10
                    i32.eq
                    br_if 2 (;@6;)
                    local.get 11
                    local.get 0
                    i32.const 1
                    i32.add
                    local.tee 0
                    i32.ne
                    br_if 0 (;@8;)
                  end
                  local.get 2
                  local.set 9
                  br 3 (;@4;)
                end
                block  ;; label = @7
                  local.get 11
                  local.get 13
                  i32.ne
                  br_if 0 (;@7;)
                  local.get 2
                  local.set 9
                  br 3 (;@4;)
                end
                loop  ;; label = @7
                  block  ;; label = @8
                    local.get 10
                    local.get 13
                    i32.add
                    i32.load8_u
                    i32.const 10
                    i32.ne
                    br_if 0 (;@8;)
                    local.get 13
                    local.set 0
                    br 2 (;@6;)
                  end
                  local.get 11
                  local.get 13
                  i32.const 1
                  i32.add
                  local.tee 13
                  i32.ne
                  br_if 0 (;@7;)
                end
                local.get 2
                local.set 9
                br 2 (;@4;)
              end
              local.get 0
              local.get 9
              i32.add
              local.tee 13
              i32.const 1
              i32.add
              local.set 9
              block  ;; label = @6
                local.get 13
                local.get 2
                i32.ge_u
                br_if 0 (;@6;)
                local.get 10
                local.get 0
                i32.add
                i32.load8_u
                i32.const 10
                i32.ne
                br_if 0 (;@6;)
                i32.const 0
                local.set 10
                local.get 9
                local.set 12
                local.get 9
                local.set 0
                br 3 (;@3;)
              end
              local.get 9
              local.get 2
              i32.le_u
              br_if 0 (;@5;)
            end
          end
          local.get 2
          local.get 8
          i32.eq
          br_if 2 (;@1;)
          i32.const 1
          local.set 10
          local.get 8
          local.set 12
          local.get 2
          local.set 0
        end
        block  ;; label = @3
          block  ;; label = @4
            local.get 6
            i32.load8_u
            i32.eqz
            br_if 0 (;@4;)
            local.get 5
            i32.const 1059456
            i32.const 4
            local.get 4
            i32.load offset=12
            call_indirect (type 5)
            br_if 1 (;@3;)
          end
          local.get 0
          local.get 8
          i32.sub
          local.set 11
          i32.const 0
          local.set 13
          block  ;; label = @4
            local.get 0
            local.get 8
            i32.eq
            br_if 0 (;@4;)
            local.get 3
            local.get 0
            i32.add
            i32.load8_u
            i32.const 10
            i32.eq
            local.set 13
          end
          local.get 1
          local.get 8
          i32.add
          local.set 0
          local.get 6
          local.get 13
          i32.store8
          local.get 12
          local.set 8
          local.get 5
          local.get 0
          local.get 11
          local.get 4
          i32.load offset=12
          call_indirect (type 5)
          i32.eqz
          br_if 1 (;@2;)
        end
      end
      i32.const 1
      local.set 7
    end
    local.get 7)
  (func $_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$10write_char17he1f0cb056f10b73fE (type 2) (param i32 i32) (result i32)
    (local i32 i32)
    local.get 0
    i32.load offset=4
    local.set 2
    local.get 0
    i32.load
    local.set 3
    block  ;; label = @1
      local.get 0
      i32.load offset=8
      local.tee 0
      i32.load8_u
      i32.eqz
      br_if 0 (;@1;)
      local.get 3
      i32.const 1059456
      i32.const 4
      local.get 2
      i32.load offset=12
      call_indirect (type 5)
      i32.eqz
      br_if 0 (;@1;)
      i32.const 1
      return
    end
    local.get 0
    local.get 1
    i32.const 10
    i32.eq
    i32.store8
    local.get 3
    local.get 1
    local.get 2
    i32.load offset=16
    call_indirect (type 2))
  (func $_ZN4core3fmt8builders11DebugStruct6finish17h9c0eaac50360f7e7E (type 3) (param i32) (result i32)
    (local i32 i32)
    local.get 0
    i32.load8_u offset=4
    local.tee 1
    local.set 2
    block  ;; label = @1
      local.get 0
      i32.load8_u offset=5
      i32.eqz
      br_if 0 (;@1;)
      i32.const 1
      local.set 2
      block  ;; label = @2
        local.get 1
        i32.const 1
        i32.and
        br_if 0 (;@2;)
        block  ;; label = @3
          local.get 0
          i32.load
          local.tee 2
          i32.load8_u offset=10
          i32.const 128
          i32.and
          br_if 0 (;@3;)
          local.get 2
          i32.load
          i32.const 1059471
          i32.const 2
          local.get 2
          i32.load offset=4
          i32.load offset=12
          call_indirect (type 5)
          local.set 2
          br 1 (;@2;)
        end
        local.get 2
        i32.load
        i32.const 1059470
        i32.const 1
        local.get 2
        i32.load offset=4
        i32.load offset=12
        call_indirect (type 5)
        local.set 2
      end
      local.get 0
      local.get 2
      i32.store8 offset=4
    end
    local.get 2
    i32.const 1
    i32.and)
  (func $_ZN4core3fmt5Write9write_fmt17h1155b5ded69ce2afE (type 2) (param i32 i32) (result i32)
    local.get 0
    i32.const 1059432
    local.get 1
    call $_ZN4core3fmt5write17hb4e267bf92503392E)
  (func $_ZN4core3fmt9Formatter12pad_integral12write_prefix17hc60e160547463b96E (type 9) (param i32 i32 i32 i32 i32) (result i32)
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
    call_indirect (type 5))
  (func $_ZN4core3fmt9Formatter9write_str17hdf9d14a3fcabff76E (type 5) (param i32 i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 1
    local.get 2
    local.get 0
    i32.load offset=4
    i32.load offset=12
    call_indirect (type 5))
  (func $_ZN4core3fmt9Formatter12debug_struct17h8b04cc0c27469750E (type 7) (param i32 i32 i32 i32)
    local.get 1
    i32.load
    local.get 2
    local.get 3
    local.get 1
    i32.load offset=4
    i32.load offset=12
    call_indirect (type 5)
    local.set 3
    local.get 0
    i32.const 0
    i32.store8 offset=5
    local.get 0
    local.get 3
    i32.store8 offset=4
    local.get 0
    local.get 1
    i32.store)
  (func $_ZN4core3fmt9Formatter26debug_struct_field2_finish17h05c90c1de6f82831E (type 14) (param i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 11
    global.set $__stack_pointer
    local.get 0
    i32.load
    local.get 1
    local.get 2
    local.get 0
    i32.load offset=4
    i32.load offset=12
    call_indirect (type 5)
    local.set 2
    local.get 11
    i32.const 0
    i32.store8 offset=13
    local.get 11
    local.get 2
    i32.store8 offset=12
    local.get 11
    local.get 0
    i32.store offset=8
    local.get 11
    i32.const 8
    i32.add
    local.get 3
    local.get 4
    local.get 5
    local.get 6
    call $_ZN4core3fmt8builders11DebugStruct5field17h13f66060f544090dE
    local.get 7
    local.get 8
    local.get 9
    local.get 10
    call $_ZN4core3fmt8builders11DebugStruct5field17h13f66060f544090dE
    local.set 10
    local.get 11
    i32.load8_u offset=13
    local.tee 2
    local.get 11
    i32.load8_u offset=12
    local.tee 1
    i32.or
    local.set 0
    block  ;; label = @1
      local.get 2
      i32.const 1
      i32.ne
      br_if 0 (;@1;)
      local.get 1
      i32.const 1
      i32.and
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 10
        i32.load
        local.tee 0
        i32.load8_u offset=10
        i32.const 128
        i32.and
        br_if 0 (;@2;)
        local.get 0
        i32.load
        i32.const 1059471
        i32.const 2
        local.get 0
        i32.load offset=4
        i32.load offset=12
        call_indirect (type 5)
        local.set 0
        br 1 (;@1;)
      end
      local.get 0
      i32.load
      i32.const 1059470
      i32.const 1
      local.get 0
      i32.load offset=4
      i32.load offset=12
      call_indirect (type 5)
      local.set 0
    end
    local.get 11
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 0
    i32.const 1
    i32.and)
  (func $_ZN4core3fmt9Formatter25debug_tuple_field1_finish17h820928a379ff3ec2E (type 9) (param i32 i32 i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    i32.const 1
    local.set 6
    block  ;; label = @1
      local.get 0
      i32.load
      local.tee 7
      local.get 1
      local.get 2
      local.get 0
      i32.load offset=4
      local.tee 8
      i32.load offset=12
      local.tee 9
      call_indirect (type 5)
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          local.get 0
          i32.load8_u offset=10
          i32.const 128
          i32.and
          br_if 0 (;@3;)
          i32.const 1
          local.set 6
          local.get 7
          i32.const 1059473
          i32.const 1
          local.get 9
          call_indirect (type 5)
          br_if 2 (;@1;)
          local.get 3
          local.get 0
          local.get 4
          i32.load offset=12
          call_indirect (type 2)
          i32.eqz
          br_if 1 (;@2;)
          br 2 (;@1;)
        end
        local.get 7
        i32.const 1059474
        i32.const 2
        local.get 9
        call_indirect (type 5)
        br_if 1 (;@1;)
        i32.const 1
        local.set 6
        local.get 5
        i32.const 1
        i32.store8 offset=15
        local.get 5
        local.get 8
        i32.store offset=4
        local.get 5
        local.get 7
        i32.store
        local.get 5
        i32.const 1059432
        i32.store offset=20
        local.get 5
        local.get 0
        i64.load offset=8 align=4
        i64.store offset=24 align=4
        local.get 5
        local.get 5
        i32.const 15
        i32.add
        i32.store offset=8
        local.get 5
        local.get 5
        i32.store offset=16
        local.get 3
        local.get 5
        i32.const 16
        i32.add
        local.get 4
        i32.load offset=12
        call_indirect (type 2)
        br_if 1 (;@1;)
        local.get 5
        i32.load offset=16
        i32.const 1059468
        i32.const 2
        local.get 5
        i32.load offset=20
        i32.load offset=12
        call_indirect (type 5)
        br_if 1 (;@1;)
      end
      block  ;; label = @2
        local.get 2
        br_if 0 (;@2;)
        local.get 0
        i32.load8_u offset=10
        i32.const 128
        i32.and
        br_if 0 (;@2;)
        i32.const 1
        local.set 6
        local.get 0
        i32.load
        i32.const 1059476
        i32.const 1
        local.get 0
        i32.load offset=4
        i32.load offset=12
        call_indirect (type 5)
        br_if 1 (;@1;)
      end
      local.get 0
      i32.load
      i32.const 1059139
      i32.const 1
      local.get 0
      i32.load offset=4
      i32.load offset=12
      call_indirect (type 5)
      local.set 6
    end
    local.get 5
    i32.const 32
    i32.add
    global.set $__stack_pointer
    local.get 6)
  (func $_ZN43_$LT$bool$u20$as$u20$core..fmt..Display$GT$3fmt17he3b1fcab12cb0898E (type 2) (param i32 i32) (result i32)
    block  ;; label = @1
      local.get 0
      i32.load8_u
      br_if 0 (;@1;)
      local.get 1
      i32.const 1059706
      i32.const 5
      call $_ZN4core3fmt9Formatter3pad17hcc32532bfecc9527E
      return
    end
    local.get 1
    i32.const 1059711
    i32.const 4
    call $_ZN4core3fmt9Formatter3pad17hcc32532bfecc9527E)
  (func $_ZN40_$LT$str$u20$as$u20$core..fmt..Debug$GT$3fmt17he4df7632dab5ca2aE (type 5) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    i32.const 1
    local.set 4
    block  ;; label = @1
      local.get 2
      i32.load
      local.tee 5
      i32.const 34
      local.get 2
      i32.load offset=4
      local.tee 6
      i32.load offset=16
      local.tee 7
      call_indirect (type 2)
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          br_if 0 (;@3;)
          i32.const 0
          local.set 8
          i32.const 0
          local.set 2
          br 1 (;@2;)
        end
        i32.const 0
        local.set 9
        i32.const 0
        local.get 1
        i32.sub
        local.set 10
        i32.const 0
        local.set 8
        local.get 0
        local.set 11
        local.get 1
        local.set 12
        block  ;; label = @3
          loop  ;; label = @4
            local.get 11
            local.get 12
            i32.add
            local.set 13
            i32.const 0
            local.set 2
            block  ;; label = @5
              loop  ;; label = @6
                local.get 11
                local.get 2
                i32.add
                local.tee 14
                i32.load8_u
                local.tee 15
                i32.const -127
                i32.add
                i32.const 255
                i32.and
                i32.const 161
                i32.lt_u
                br_if 1 (;@5;)
                local.get 15
                i32.const 34
                i32.eq
                br_if 1 (;@5;)
                local.get 15
                i32.const 92
                i32.eq
                br_if 1 (;@5;)
                local.get 12
                local.get 2
                i32.const 1
                i32.add
                local.tee 2
                i32.ne
                br_if 0 (;@6;)
              end
              local.get 8
              local.get 12
              i32.add
              local.set 8
              br 2 (;@3;)
            end
            local.get 14
            i32.const 1
            i32.add
            local.set 11
            local.get 8
            local.get 2
            i32.add
            local.set 12
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 14
                    i32.load8_s
                    local.tee 15
                    i32.const -1
                    i32.le_s
                    br_if 0 (;@8;)
                    local.get 15
                    i32.const 255
                    i32.and
                    local.set 15
                    br 1 (;@7;)
                  end
                  local.get 11
                  i32.load8_u
                  i32.const 63
                  i32.and
                  local.set 16
                  local.get 15
                  i32.const 31
                  i32.and
                  local.set 17
                  local.get 14
                  i32.const 2
                  i32.add
                  local.set 11
                  block  ;; label = @8
                    local.get 15
                    i32.const -33
                    i32.gt_u
                    br_if 0 (;@8;)
                    local.get 17
                    i32.const 6
                    i32.shl
                    local.get 16
                    i32.or
                    local.set 15
                    br 1 (;@7;)
                  end
                  local.get 16
                  i32.const 6
                  i32.shl
                  local.get 11
                  i32.load8_u
                  i32.const 63
                  i32.and
                  i32.or
                  local.set 16
                  local.get 14
                  i32.const 3
                  i32.add
                  local.set 11
                  block  ;; label = @8
                    local.get 15
                    i32.const -16
                    i32.ge_u
                    br_if 0 (;@8;)
                    local.get 16
                    local.get 17
                    i32.const 12
                    i32.shl
                    i32.or
                    local.set 15
                    br 1 (;@7;)
                  end
                  local.get 11
                  i32.load8_u
                  local.set 15
                  local.get 14
                  i32.const 4
                  i32.add
                  local.set 11
                  local.get 16
                  i32.const 6
                  i32.shl
                  local.get 15
                  i32.const 63
                  i32.and
                  i32.or
                  local.get 17
                  i32.const 18
                  i32.shl
                  i32.const 1835008
                  i32.and
                  i32.or
                  local.tee 15
                  i32.const 1114112
                  i32.ne
                  br_if 0 (;@7;)
                  local.get 12
                  local.set 8
                  br 1 (;@6;)
                end
                local.get 3
                i32.const 4
                i32.add
                local.get 15
                i32.const 65537
                call $_ZN4core4char7methods22_$LT$impl$u20$char$GT$16escape_debug_ext17h61165eeecc9cfe60E
                block  ;; label = @7
                  local.get 3
                  i32.load8_u offset=4
                  i32.const 128
                  i32.eq
                  br_if 0 (;@7;)
                  local.get 3
                  i32.load8_u offset=15
                  local.get 3
                  i32.load8_u offset=14
                  i32.sub
                  i32.const 255
                  i32.and
                  i32.const 1
                  i32.eq
                  br_if 0 (;@7;)
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 9
                      local.get 12
                      i32.gt_u
                      br_if 0 (;@9;)
                      block  ;; label = @10
                        local.get 9
                        i32.eqz
                        br_if 0 (;@10;)
                        block  ;; label = @11
                          local.get 9
                          local.get 1
                          i32.lt_u
                          br_if 0 (;@11;)
                          local.get 9
                          local.get 1
                          i32.ne
                          br_if 2 (;@9;)
                          br 1 (;@10;)
                        end
                        local.get 0
                        local.get 9
                        i32.add
                        i32.load8_s
                        i32.const -65
                        i32.le_s
                        br_if 1 (;@9;)
                      end
                      block  ;; label = @10
                        local.get 12
                        i32.eqz
                        br_if 0 (;@10;)
                        block  ;; label = @11
                          local.get 12
                          local.get 1
                          i32.lt_u
                          br_if 0 (;@11;)
                          local.get 12
                          local.get 10
                          i32.add
                          i32.eqz
                          br_if 1 (;@10;)
                          br 2 (;@9;)
                        end
                        local.get 0
                        local.get 8
                        i32.add
                        local.get 2
                        i32.add
                        i32.load8_s
                        i32.const -64
                        i32.lt_s
                        br_if 1 (;@9;)
                      end
                      local.get 5
                      local.get 0
                      local.get 9
                      i32.add
                      local.get 8
                      local.get 9
                      i32.sub
                      local.get 2
                      i32.add
                      local.get 6
                      i32.load offset=12
                      local.tee 14
                      call_indirect (type 5)
                      i32.eqz
                      br_if 1 (;@8;)
                      br 4 (;@5;)
                    end
                    local.get 0
                    local.get 1
                    local.get 9
                    local.get 8
                    local.get 2
                    i32.add
                    i32.const 1059716
                    call $_ZN4core3str16slice_error_fail17hdf53459d42311535E
                    unreachable
                  end
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 3
                      i32.load8_u offset=4
                      i32.const 128
                      i32.ne
                      br_if 0 (;@9;)
                      local.get 5
                      local.get 3
                      i32.load offset=8
                      local.get 7
                      call_indirect (type 2)
                      br_if 4 (;@5;)
                      br 1 (;@8;)
                    end
                    local.get 5
                    local.get 3
                    i32.const 4
                    i32.add
                    local.get 3
                    i32.load8_u offset=14
                    local.tee 12
                    i32.add
                    local.get 3
                    i32.load8_u offset=15
                    local.get 12
                    i32.sub
                    local.get 14
                    call_indirect (type 5)
                    br_if 3 (;@5;)
                  end
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 15
                      i32.const 128
                      i32.ge_u
                      br_if 0 (;@9;)
                      i32.const 1
                      local.set 14
                      br 1 (;@8;)
                    end
                    block  ;; label = @9
                      local.get 15
                      i32.const 2048
                      i32.ge_u
                      br_if 0 (;@9;)
                      i32.const 2
                      local.set 14
                      br 1 (;@8;)
                    end
                    i32.const 3
                    i32.const 4
                    local.get 15
                    i32.const 65536
                    i32.lt_u
                    select
                    local.set 14
                  end
                  local.get 14
                  local.get 8
                  i32.add
                  local.get 2
                  i32.add
                  local.set 9
                end
                block  ;; label = @7
                  block  ;; label = @8
                    local.get 15
                    i32.const 128
                    i32.ge_u
                    br_if 0 (;@8;)
                    i32.const 1
                    local.set 15
                    br 1 (;@7;)
                  end
                  block  ;; label = @8
                    local.get 15
                    i32.const 2048
                    i32.ge_u
                    br_if 0 (;@8;)
                    i32.const 2
                    local.set 15
                    br 1 (;@7;)
                  end
                  i32.const 3
                  i32.const 4
                  local.get 15
                  i32.const 65536
                  i32.lt_u
                  select
                  local.set 15
                end
                local.get 15
                local.get 8
                i32.add
                local.get 2
                i32.add
                local.set 8
              end
              local.get 13
              local.get 11
              i32.sub
              local.tee 12
              br_if 1 (;@4;)
              br 2 (;@3;)
            end
          end
          i32.const 1
          local.set 4
          br 2 (;@1;)
        end
        block  ;; label = @3
          local.get 9
          local.get 8
          i32.gt_u
          br_if 0 (;@3;)
          i32.const 0
          local.set 2
          block  ;; label = @4
            local.get 9
            i32.eqz
            br_if 0 (;@4;)
            block  ;; label = @5
              local.get 9
              local.get 1
              i32.lt_u
              br_if 0 (;@5;)
              local.get 9
              local.set 2
              local.get 9
              local.get 1
              i32.ne
              br_if 2 (;@3;)
              br 1 (;@4;)
            end
            local.get 9
            local.set 2
            local.get 0
            local.get 9
            i32.add
            i32.load8_s
            i32.const -65
            i32.le_s
            br_if 1 (;@3;)
          end
          block  ;; label = @4
            local.get 8
            br_if 0 (;@4;)
            i32.const 0
            local.set 8
            br 2 (;@2;)
          end
          block  ;; label = @4
            local.get 8
            local.get 1
            i32.lt_u
            br_if 0 (;@4;)
            local.get 8
            local.get 1
            i32.eq
            br_if 2 (;@2;)
            local.get 2
            local.set 9
            br 1 (;@3;)
          end
          local.get 0
          local.get 8
          i32.add
          i32.load8_s
          i32.const -65
          i32.gt_s
          br_if 1 (;@2;)
          local.get 2
          local.set 9
        end
        local.get 0
        local.get 1
        local.get 9
        local.get 8
        i32.const 1059732
        call $_ZN4core3str16slice_error_fail17hdf53459d42311535E
        unreachable
      end
      local.get 5
      local.get 0
      local.get 2
      i32.add
      local.get 8
      local.get 2
      i32.sub
      local.get 6
      i32.load offset=12
      call_indirect (type 5)
      br_if 0 (;@1;)
      local.get 5
      i32.const 34
      local.get 7
      call_indirect (type 2)
      local.set 4
    end
    local.get 3
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 4)
  (func $_ZN4core3str16slice_error_fail17hdf53459d42311535E (type 12) (param i32 i32 i32 i32 i32)
    local.get 0
    local.get 1
    local.get 2
    local.get 3
    local.get 4
    call $_ZN4core3str19slice_error_fail_rt17ha139c978b4ba67a8E
    unreachable)
  (func $_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17hf7f012776df7e14cE (type 5) (param i32 i32 i32) (result i32)
    local.get 2
    local.get 0
    local.get 1
    call $_ZN4core3fmt9Formatter3pad17hcc32532bfecc9527E)
  (func $_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h67599d50c3692507E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    i32.const 1
    local.set 3
    block  ;; label = @1
      local.get 1
      i32.load
      local.tee 4
      i32.const 39
      local.get 1
      i32.load offset=4
      local.tee 5
      i32.load offset=16
      local.tee 1
      call_indirect (type 2)
      br_if 0 (;@1;)
      local.get 2
      i32.const 4
      i32.add
      local.get 0
      i32.load
      i32.const 257
      call $_ZN4core4char7methods22_$LT$impl$u20$char$GT$16escape_debug_ext17h61165eeecc9cfe60E
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          i32.load8_u offset=4
          i32.const 128
          i32.ne
          br_if 0 (;@3;)
          local.get 4
          local.get 2
          i32.load offset=8
          local.get 1
          call_indirect (type 2)
          i32.eqz
          br_if 1 (;@2;)
          i32.const 1
          local.set 3
          br 2 (;@1;)
        end
        local.get 4
        local.get 2
        i32.const 4
        i32.add
        local.get 2
        i32.load8_u offset=14
        local.tee 3
        i32.add
        local.get 2
        i32.load8_u offset=15
        local.get 3
        i32.sub
        local.get 5
        i32.load offset=12
        call_indirect (type 5)
        i32.eqz
        br_if 0 (;@2;)
        i32.const 1
        local.set 3
        br 1 (;@1;)
      end
      local.get 4
      i32.const 39
      local.get 1
      call_indirect (type 2)
      local.set 3
    end
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 3)
  (func $_ZN4core5slice6memchr14memchr_aligned17hc1073447135eebe4E (type 7) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 2
            i32.const 3
            i32.add
            i32.const -4
            i32.and
            local.tee 4
            local.get 2
            i32.eq
            br_if 0 (;@4;)
            local.get 3
            local.get 4
            local.get 2
            i32.sub
            local.tee 4
            local.get 3
            local.get 4
            i32.lt_u
            select
            local.tee 4
            i32.eqz
            br_if 0 (;@4;)
            i32.const 0
            local.set 5
            local.get 1
            i32.const 255
            i32.and
            local.set 6
            i32.const 1
            local.set 7
            loop  ;; label = @5
              local.get 2
              local.get 5
              i32.add
              i32.load8_u
              local.get 6
              i32.eq
              br_if 4 (;@1;)
              local.get 4
              local.get 5
              i32.const 1
              i32.add
              local.tee 5
              i32.ne
              br_if 0 (;@5;)
            end
            local.get 4
            local.get 3
            i32.const -8
            i32.add
            local.tee 8
            i32.gt_u
            br_if 2 (;@2;)
            br 1 (;@3;)
          end
          local.get 3
          i32.const -8
          i32.add
          local.set 8
          i32.const 0
          local.set 4
        end
        local.get 1
        i32.const 255
        i32.and
        i32.const 16843009
        i32.mul
        local.set 5
        loop  ;; label = @3
          i32.const 16843008
          local.get 2
          local.get 4
          i32.add
          local.tee 6
          i32.load
          local.get 5
          i32.xor
          local.tee 7
          i32.sub
          local.get 7
          i32.or
          i32.const 16843008
          local.get 6
          i32.const 4
          i32.add
          i32.load
          local.get 5
          i32.xor
          local.tee 6
          i32.sub
          local.get 6
          i32.or
          i32.and
          i32.const -2139062144
          i32.and
          i32.const -2139062144
          i32.ne
          br_if 1 (;@2;)
          local.get 4
          i32.const 8
          i32.add
          local.tee 4
          local.get 8
          i32.le_u
          br_if 0 (;@3;)
        end
      end
      block  ;; label = @2
        local.get 3
        local.get 4
        i32.eq
        br_if 0 (;@2;)
        local.get 1
        i32.const 255
        i32.and
        local.set 5
        i32.const 1
        local.set 7
        loop  ;; label = @3
          block  ;; label = @4
            local.get 2
            local.get 4
            i32.add
            i32.load8_u
            local.get 5
            i32.ne
            br_if 0 (;@4;)
            local.get 4
            local.set 5
            br 3 (;@1;)
          end
          local.get 3
          local.get 4
          i32.const 1
          i32.add
          local.tee 4
          i32.ne
          br_if 0 (;@3;)
        end
      end
      i32.const 0
      local.set 7
    end
    local.get 0
    local.get 5
    i32.store offset=4
    local.get 0
    local.get 7
    i32.store)
  (func $_ZN4core5slice6memchr7memrchr17h3f286f71ea91eee5E (type 7) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32)
    local.get 3
    i32.const 0
    local.get 3
    local.get 2
    i32.const 3
    i32.add
    i32.const -4
    i32.and
    local.get 2
    i32.sub
    local.tee 4
    i32.sub
    i32.const 7
    i32.and
    local.get 3
    local.get 4
    i32.lt_u
    select
    local.tee 5
    i32.sub
    local.set 6
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 3
            local.get 5
            i32.lt_u
            br_if 0 (;@4;)
            block  ;; label = @5
              local.get 5
              i32.eqz
              br_if 0 (;@5;)
              block  ;; label = @6
                block  ;; label = @7
                  local.get 2
                  local.get 3
                  i32.add
                  local.tee 7
                  i32.const -1
                  i32.add
                  local.tee 8
                  i32.load8_u
                  local.get 1
                  i32.const 255
                  i32.and
                  i32.ne
                  br_if 0 (;@7;)
                  local.get 5
                  i32.const -1
                  i32.add
                  local.set 5
                  br 1 (;@6;)
                end
                local.get 2
                local.get 6
                i32.add
                local.tee 9
                local.get 8
                i32.eq
                br_if 1 (;@5;)
                block  ;; label = @7
                  local.get 7
                  i32.const -2
                  i32.add
                  local.tee 8
                  i32.load8_u
                  local.get 1
                  i32.const 255
                  i32.and
                  i32.ne
                  br_if 0 (;@7;)
                  local.get 5
                  i32.const -2
                  i32.add
                  local.set 5
                  br 1 (;@6;)
                end
                local.get 9
                local.get 8
                i32.eq
                br_if 1 (;@5;)
                block  ;; label = @7
                  local.get 7
                  i32.const -3
                  i32.add
                  local.tee 8
                  i32.load8_u
                  local.get 1
                  i32.const 255
                  i32.and
                  i32.ne
                  br_if 0 (;@7;)
                  local.get 5
                  i32.const -3
                  i32.add
                  local.set 5
                  br 1 (;@6;)
                end
                local.get 9
                local.get 8
                i32.eq
                br_if 1 (;@5;)
                block  ;; label = @7
                  local.get 7
                  i32.const -4
                  i32.add
                  local.tee 8
                  i32.load8_u
                  local.get 1
                  i32.const 255
                  i32.and
                  i32.ne
                  br_if 0 (;@7;)
                  local.get 5
                  i32.const -4
                  i32.add
                  local.set 5
                  br 1 (;@6;)
                end
                local.get 9
                local.get 8
                i32.eq
                br_if 1 (;@5;)
                block  ;; label = @7
                  local.get 7
                  i32.const -5
                  i32.add
                  local.tee 8
                  i32.load8_u
                  local.get 1
                  i32.const 255
                  i32.and
                  i32.ne
                  br_if 0 (;@7;)
                  local.get 5
                  i32.const -5
                  i32.add
                  local.set 5
                  br 1 (;@6;)
                end
                local.get 9
                local.get 8
                i32.eq
                br_if 1 (;@5;)
                block  ;; label = @7
                  local.get 7
                  i32.const -6
                  i32.add
                  local.tee 8
                  i32.load8_u
                  local.get 1
                  i32.const 255
                  i32.and
                  i32.ne
                  br_if 0 (;@7;)
                  local.get 5
                  i32.const -6
                  i32.add
                  local.set 5
                  br 1 (;@6;)
                end
                local.get 9
                local.get 8
                i32.eq
                br_if 1 (;@5;)
                block  ;; label = @7
                  local.get 7
                  i32.const -7
                  i32.add
                  local.tee 8
                  i32.load8_u
                  local.get 1
                  i32.const 255
                  i32.and
                  i32.ne
                  br_if 0 (;@7;)
                  local.get 5
                  i32.const -7
                  i32.add
                  local.set 5
                  br 1 (;@6;)
                end
                local.get 9
                local.get 8
                i32.eq
                br_if 1 (;@5;)
                local.get 5
                i32.const -8
                i32.or
                local.set 5
              end
              local.get 5
              local.get 6
              i32.add
              local.set 5
              br 3 (;@2;)
            end
            local.get 4
            local.get 3
            local.get 3
            local.get 4
            i32.gt_u
            select
            local.set 9
            local.get 1
            i32.const 255
            i32.and
            i32.const 16843009
            i32.mul
            local.set 4
            block  ;; label = @5
              loop  ;; label = @6
                local.get 6
                local.tee 5
                local.get 9
                i32.le_u
                br_if 1 (;@5;)
                local.get 5
                i32.const -8
                i32.add
                local.set 6
                i32.const 16843008
                local.get 2
                local.get 5
                i32.add
                local.tee 8
                i32.const -8
                i32.add
                i32.load
                local.get 4
                i32.xor
                local.tee 7
                i32.sub
                local.get 7
                i32.or
                i32.const 16843008
                local.get 8
                i32.const -4
                i32.add
                i32.load
                local.get 4
                i32.xor
                local.tee 8
                i32.sub
                local.get 8
                i32.or
                i32.and
                i32.const -2139062144
                i32.and
                i32.const -2139062144
                i32.eq
                br_if 0 (;@6;)
              end
            end
            local.get 5
            local.get 3
            i32.gt_u
            br_if 1 (;@3;)
            local.get 2
            i32.const -1
            i32.add
            local.set 4
            local.get 1
            i32.const 255
            i32.and
            local.set 8
            loop  ;; label = @5
              block  ;; label = @6
                local.get 5
                br_if 0 (;@6;)
                i32.const 0
                local.set 6
                br 5 (;@1;)
              end
              local.get 4
              local.get 5
              i32.add
              local.set 6
              local.get 5
              i32.const -1
              i32.add
              local.set 5
              local.get 6
              i32.load8_u
              local.get 8
              i32.eq
              br_if 3 (;@2;)
              br 0 (;@5;)
            end
          end
          local.get 6
          local.get 3
          i32.const 1059780
          call $_ZN4core5slice5index26slice_start_index_len_fail17hcb91b9a11352b54bE
          unreachable
        end
        local.get 5
        local.get 3
        i32.const 1059796
        call $_ZN4core5slice5index24slice_end_index_len_fail17hc7943372990115c8E
        unreachable
      end
      i32.const 1
      local.set 6
    end
    local.get 0
    local.get 5
    i32.store offset=4
    local.get 0
    local.get 6
    i32.store)
  (func $_ZN4core5slice5index26slice_start_index_len_fail8do_panic7runtime17h48bf4e38c81b8765E (type 4) (param i32 i32 i32)
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
    i32.const 1061912
    i32.store offset=8
    local.get 3
    i64.const 2
    i64.store offset=20 align=4
    local.get 3
    i32.const 13
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
    call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
    unreachable)
  (func $_ZN4core5slice5index24slice_end_index_len_fail8do_panic7runtime17h4fdd0b90f95e57b9E (type 4) (param i32 i32 i32)
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
    i32.const 1061944
    i32.store offset=8
    local.get 3
    i64.const 2
    i64.store offset=20 align=4
    local.get 3
    i32.const 13
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
    call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
    unreachable)
  (func $_ZN4core5slice5index22slice_index_order_fail8do_panic7runtime17h1b06a677f422cc0dE (type 4) (param i32 i32 i32)
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
    i32.const 1061996
    i32.store offset=8
    local.get 3
    i64.const 2
    i64.store offset=20 align=4
    local.get 3
    i32.const 13
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
    call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
    unreachable)
  (func $_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i8$GT$3fmt17h41ed9124bb676b3fE (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 128
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 0
    i32.load8_u
    local.set 3
    i32.const 0
    local.set 0
    loop  ;; label = @1
      local.get 2
      local.get 0
      i32.add
      i32.const 127
      i32.add
      local.get 3
      i32.const 15
      i32.and
      local.tee 4
      i32.const 48
      i32.or
      local.get 4
      i32.const 55
      i32.add
      local.get 4
      i32.const 10
      i32.lt_u
      select
      i32.store8
      local.get 0
      i32.const -1
      i32.add
      local.set 0
      local.get 3
      i32.const 255
      i32.and
      local.tee 4
      i32.const 4
      i32.shr_u
      local.set 3
      local.get 4
      i32.const 15
      i32.gt_u
      br_if 0 (;@1;)
    end
    local.get 1
    i32.const 1
    i32.const 1059477
    i32.const 2
    local.get 2
    local.get 0
    i32.add
    i32.const 128
    i32.add
    i32.const 0
    local.get 0
    i32.sub
    call $_ZN4core3fmt9Formatter12pad_integral17h57e359ed883e3df4E
    local.set 0
    local.get 2
    i32.const 128
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN4core3str19slice_error_fail_rt17ha139c978b4ba67a8E (type 12) (param i32 i32 i32 i32 i32)
    (local i32 i32 i32 i32 i64)
    global.get $__stack_pointer
    i32.const 112
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    local.get 5
    local.get 3
    i32.store offset=12
    local.get 5
    local.get 2
    i32.store offset=8
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.const 257
        i32.lt_u
        br_if 0 (;@2;)
        block  ;; label = @3
          block  ;; label = @4
            local.get 0
            i32.load8_s offset=256
            i32.const -65
            i32.le_s
            br_if 0 (;@4;)
            i32.const 256
            local.set 6
            br 1 (;@3;)
          end
          block  ;; label = @4
            local.get 0
            i32.load8_s offset=255
            i32.const -65
            i32.le_s
            br_if 0 (;@4;)
            i32.const 255
            local.set 6
            br 1 (;@3;)
          end
          i32.const 254
          i32.const 253
          local.get 0
          i32.load8_s offset=254
          i32.const -65
          i32.gt_s
          select
          local.set 6
        end
        block  ;; label = @3
          local.get 0
          local.get 6
          i32.add
          i32.load8_s
          i32.const -65
          i32.le_s
          br_if 0 (;@3;)
          i32.const 5
          local.set 7
          i32.const 1060095
          local.set 8
          br 2 (;@1;)
        end
        local.get 0
        local.get 1
        i32.const 0
        local.get 6
        local.get 4
        call $_ZN4core3str16slice_error_fail17hdf53459d42311535E
        unreachable
      end
      i32.const 0
      local.set 7
      i32.const 1
      local.set 8
      local.get 1
      local.set 6
    end
    local.get 5
    local.get 6
    i32.store offset=20
    local.get 5
    local.get 0
    i32.store offset=16
    local.get 5
    local.get 7
    i32.store offset=28
    local.get 5
    local.get 8
    i32.store offset=24
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 2
            local.get 1
            i32.gt_u
            local.tee 6
            br_if 0 (;@4;)
            local.get 3
            local.get 1
            i32.gt_u
            br_if 0 (;@4;)
            local.get 2
            local.get 3
            i32.gt_u
            br_if 1 (;@3;)
            block  ;; label = @5
              local.get 2
              i32.eqz
              br_if 0 (;@5;)
              local.get 2
              local.get 1
              i32.ge_u
              br_if 0 (;@5;)
              local.get 5
              i32.const 12
              i32.add
              local.get 5
              i32.const 8
              i32.add
              local.get 0
              local.get 2
              i32.add
              i32.load8_s
              i32.const -65
              i32.gt_s
              select
              i32.load
              local.set 3
            end
            local.get 5
            local.get 3
            i32.store offset=32
            local.get 1
            local.set 2
            block  ;; label = @5
              local.get 3
              local.get 1
              i32.ge_u
              br_if 0 (;@5;)
              local.get 3
              i32.const 1
              i32.add
              local.tee 6
              i32.const 0
              local.get 3
              i32.const -3
              i32.add
              local.tee 2
              local.get 2
              local.get 3
              i32.gt_u
              select
              local.tee 2
              i32.lt_u
              br_if 3 (;@2;)
              local.get 6
              local.get 2
              i32.sub
              local.set 7
              block  ;; label = @6
                block  ;; label = @7
                  local.get 0
                  local.get 3
                  i32.add
                  i32.load8_s
                  i32.const -65
                  i32.le_s
                  br_if 0 (;@7;)
                  local.get 7
                  i32.const -1
                  i32.add
                  local.set 3
                  br 1 (;@6;)
                end
                block  ;; label = @7
                  local.get 0
                  local.get 6
                  i32.add
                  local.tee 3
                  i32.const -2
                  i32.add
                  i32.load8_s
                  i32.const -65
                  i32.le_s
                  br_if 0 (;@7;)
                  local.get 7
                  i32.const -2
                  i32.add
                  local.set 3
                  br 1 (;@6;)
                end
                block  ;; label = @7
                  local.get 3
                  i32.const -3
                  i32.add
                  i32.load8_s
                  i32.const -65
                  i32.le_s
                  br_if 0 (;@7;)
                  local.get 7
                  i32.const -3
                  i32.add
                  local.set 3
                  br 1 (;@6;)
                end
                local.get 7
                i32.const -4
                i32.const -5
                local.get 3
                i32.const -4
                i32.add
                i32.load8_s
                i32.const -65
                i32.gt_s
                select
                i32.add
                local.set 3
              end
              local.get 3
              local.get 2
              i32.add
              local.set 2
            end
            block  ;; label = @5
              local.get 2
              i32.eqz
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 2
                local.get 1
                i32.lt_u
                br_if 0 (;@6;)
                local.get 2
                local.get 1
                i32.eq
                br_if 1 (;@5;)
                br 5 (;@1;)
              end
              local.get 0
              local.get 2
              i32.add
              i32.load8_s
              i32.const -65
              i32.le_s
              br_if 4 (;@1;)
            end
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 2
                  local.get 1
                  i32.eq
                  br_if 0 (;@7;)
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        local.get 0
                        local.get 2
                        i32.add
                        local.tee 3
                        i32.load8_s
                        local.tee 1
                        i32.const -1
                        i32.gt_s
                        br_if 0 (;@10;)
                        local.get 3
                        i32.load8_u offset=1
                        i32.const 63
                        i32.and
                        local.set 0
                        local.get 1
                        i32.const 31
                        i32.and
                        local.set 6
                        local.get 1
                        i32.const -33
                        i32.gt_u
                        br_if 1 (;@9;)
                        local.get 6
                        i32.const 6
                        i32.shl
                        local.get 0
                        i32.or
                        local.set 1
                        br 2 (;@8;)
                      end
                      local.get 5
                      local.get 1
                      i32.const 255
                      i32.and
                      i32.store offset=36
                      i32.const 1
                      local.set 1
                      br 4 (;@5;)
                    end
                    local.get 0
                    i32.const 6
                    i32.shl
                    local.get 3
                    i32.load8_u offset=2
                    i32.const 63
                    i32.and
                    i32.or
                    local.set 0
                    block  ;; label = @9
                      local.get 1
                      i32.const -16
                      i32.ge_u
                      br_if 0 (;@9;)
                      local.get 0
                      local.get 6
                      i32.const 12
                      i32.shl
                      i32.or
                      local.set 1
                      br 1 (;@8;)
                    end
                    local.get 0
                    i32.const 6
                    i32.shl
                    local.get 3
                    i32.load8_u offset=3
                    i32.const 63
                    i32.and
                    i32.or
                    local.get 6
                    i32.const 18
                    i32.shl
                    i32.const 1835008
                    i32.and
                    i32.or
                    local.tee 1
                    i32.const 1114112
                    i32.eq
                    br_if 1 (;@7;)
                  end
                  local.get 5
                  local.get 1
                  i32.store offset=36
                  local.get 1
                  i32.const 128
                  i32.ge_u
                  br_if 1 (;@6;)
                  i32.const 1
                  local.set 1
                  br 2 (;@5;)
                end
                local.get 4
                call $_ZN4core6option13unwrap_failed17habb842812e602dc6E
                unreachable
              end
              block  ;; label = @6
                local.get 1
                i32.const 2048
                i32.ge_u
                br_if 0 (;@6;)
                i32.const 2
                local.set 1
                br 1 (;@5;)
              end
              i32.const 3
              i32.const 4
              local.get 1
              i32.const 65536
              i32.lt_u
              select
              local.set 1
            end
            local.get 5
            local.get 2
            i32.store offset=40
            local.get 5
            local.get 1
            local.get 2
            i32.add
            i32.store offset=44
            local.get 5
            i32.const 5
            i32.store offset=52
            local.get 5
            i32.const 1060232
            i32.store offset=48
            local.get 5
            i64.const 5
            i64.store offset=60 align=4
            local.get 5
            i32.const 71
            i64.extend_i32_u
            i64.const 32
            i64.shl
            local.tee 9
            local.get 5
            i32.const 24
            i32.add
            i64.extend_i32_u
            i64.or
            i64.store offset=104
            local.get 5
            local.get 9
            local.get 5
            i32.const 16
            i32.add
            i64.extend_i32_u
            i64.or
            i64.store offset=96
            local.get 5
            i32.const 73
            i64.extend_i32_u
            i64.const 32
            i64.shl
            local.get 5
            i32.const 40
            i32.add
            i64.extend_i32_u
            i64.or
            i64.store offset=88
            local.get 5
            i32.const 74
            i64.extend_i32_u
            i64.const 32
            i64.shl
            local.get 5
            i32.const 36
            i32.add
            i64.extend_i32_u
            i64.or
            i64.store offset=80
            local.get 5
            i32.const 13
            i64.extend_i32_u
            i64.const 32
            i64.shl
            local.get 5
            i32.const 32
            i32.add
            i64.extend_i32_u
            i64.or
            i64.store offset=72
            local.get 5
            local.get 5
            i32.const 72
            i32.add
            i32.store offset=56
            local.get 5
            i32.const 48
            i32.add
            local.get 4
            call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
            unreachable
          end
          local.get 5
          local.get 2
          local.get 3
          local.get 6
          select
          i32.store offset=40
          local.get 5
          i32.const 3
          i32.store offset=52
          local.get 5
          i32.const 1060296
          i32.store offset=48
          local.get 5
          i64.const 3
          i64.store offset=60 align=4
          local.get 5
          i32.const 71
          i64.extend_i32_u
          i64.const 32
          i64.shl
          local.tee 9
          local.get 5
          i32.const 24
          i32.add
          i64.extend_i32_u
          i64.or
          i64.store offset=88
          local.get 5
          local.get 9
          local.get 5
          i32.const 16
          i32.add
          i64.extend_i32_u
          i64.or
          i64.store offset=80
          local.get 5
          i32.const 13
          i64.extend_i32_u
          i64.const 32
          i64.shl
          local.get 5
          i32.const 40
          i32.add
          i64.extend_i32_u
          i64.or
          i64.store offset=72
          local.get 5
          local.get 5
          i32.const 72
          i32.add
          i32.store offset=56
          local.get 5
          i32.const 48
          i32.add
          local.get 4
          call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
          unreachable
        end
        local.get 5
        i32.const 4
        i32.store offset=52
        local.get 5
        i32.const 1060136
        i32.store offset=48
        local.get 5
        i64.const 4
        i64.store offset=60 align=4
        local.get 5
        i32.const 71
        i64.extend_i32_u
        i64.const 32
        i64.shl
        local.tee 9
        local.get 5
        i32.const 24
        i32.add
        i64.extend_i32_u
        i64.or
        i64.store offset=96
        local.get 5
        local.get 9
        local.get 5
        i32.const 16
        i32.add
        i64.extend_i32_u
        i64.or
        i64.store offset=88
        local.get 5
        i32.const 13
        i64.extend_i32_u
        i64.const 32
        i64.shl
        local.tee 9
        local.get 5
        i32.const 12
        i32.add
        i64.extend_i32_u
        i64.or
        i64.store offset=80
        local.get 5
        local.get 9
        local.get 5
        i32.const 8
        i32.add
        i64.extend_i32_u
        i64.or
        i64.store offset=72
        local.get 5
        local.get 5
        i32.const 72
        i32.add
        i32.store offset=56
        local.get 5
        i32.const 48
        i32.add
        local.get 4
        call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
        unreachable
      end
      local.get 2
      local.get 6
      i32.const 1060320
      call $_ZN4core5slice5index22slice_index_order_fail17hacfaea8d0e6739e4E
      unreachable
    end
    local.get 0
    local.get 1
    local.get 2
    local.get 1
    local.get 4
    call $_ZN4core3str16slice_error_fail17hdf53459d42311535E
    unreachable)
  (func $_ZN4core3str21_$LT$impl$u20$str$GT$9from_utf817h384f8df377c8756eE (type 4) (param i32 i32 i32)
    local.get 0
    local.get 1
    local.get 2
    call $_ZN4core3str8converts9from_utf817hb5c7d3e2ee61e867E)
  (func $_ZN4core7unicode9printable5check17h8bb7cfb0a6a631caE (type 15) (param i32 i32 i32 i32 i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32)
    local.get 1
    local.get 2
    i32.const 1
    i32.shl
    i32.add
    local.set 7
    local.get 0
    i32.const 65280
    i32.and
    i32.const 8
    i32.shr_u
    local.set 8
    i32.const 0
    local.set 9
    local.get 0
    i32.const 255
    i32.and
    local.set 10
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            loop  ;; label = @5
              local.get 1
              i32.const 2
              i32.add
              local.set 11
              local.get 9
              local.get 1
              i32.load8_u offset=1
              local.tee 2
              i32.add
              local.set 12
              block  ;; label = @6
                local.get 1
                i32.load8_u
                local.tee 1
                local.get 8
                i32.eq
                br_if 0 (;@6;)
                local.get 1
                local.get 8
                i32.gt_u
                br_if 4 (;@2;)
                local.get 12
                local.set 9
                local.get 11
                local.set 1
                local.get 11
                local.get 7
                i32.ne
                br_if 1 (;@5;)
                br 4 (;@2;)
              end
              local.get 12
              local.get 9
              i32.lt_u
              br_if 1 (;@4;)
              local.get 12
              local.get 4
              i32.gt_u
              br_if 2 (;@3;)
              local.get 3
              local.get 9
              i32.add
              local.set 1
              loop  ;; label = @6
                block  ;; label = @7
                  local.get 2
                  br_if 0 (;@7;)
                  local.get 12
                  local.set 9
                  local.get 11
                  local.set 1
                  local.get 11
                  local.get 7
                  i32.ne
                  br_if 2 (;@5;)
                  br 5 (;@2;)
                end
                local.get 2
                i32.const -1
                i32.add
                local.set 2
                local.get 1
                i32.load8_u
                local.set 9
                local.get 1
                i32.const 1
                i32.add
                local.set 1
                local.get 9
                local.get 10
                i32.ne
                br_if 0 (;@6;)
              end
            end
            i32.const 0
            local.set 2
            br 3 (;@1;)
          end
          local.get 9
          local.get 12
          i32.const 1060392
          call $_ZN4core5slice5index22slice_index_order_fail17hacfaea8d0e6739e4E
          unreachable
        end
        local.get 12
        local.get 4
        i32.const 1060392
        call $_ZN4core5slice5index24slice_end_index_len_fail17hc7943372990115c8E
        unreachable
      end
      local.get 0
      i32.const 65535
      i32.and
      local.set 9
      local.get 5
      local.get 6
      i32.add
      local.set 12
      i32.const 1
      local.set 2
      loop  ;; label = @2
        local.get 5
        i32.const 1
        i32.add
        local.set 10
        block  ;; label = @3
          block  ;; label = @4
            local.get 5
            i32.load8_s
            local.tee 1
            i32.const 0
            i32.lt_s
            br_if 0 (;@4;)
            local.get 10
            local.set 5
            br 1 (;@3;)
          end
          block  ;; label = @4
            local.get 10
            local.get 12
            i32.eq
            br_if 0 (;@4;)
            local.get 1
            i32.const 127
            i32.and
            i32.const 8
            i32.shl
            local.get 5
            i32.load8_u offset=1
            i32.or
            local.set 1
            local.get 5
            i32.const 2
            i32.add
            local.set 5
            br 1 (;@3;)
          end
          i32.const 1060376
          call $_ZN4core6option13unwrap_failed17habb842812e602dc6E
          unreachable
        end
        local.get 9
        local.get 1
        i32.sub
        local.tee 9
        i32.const 0
        i32.lt_s
        br_if 1 (;@1;)
        local.get 2
        i32.const 1
        i32.xor
        local.set 2
        local.get 5
        local.get 12
        i32.ne
        br_if 0 (;@2;)
      end
    end
    local.get 2
    i32.const 1
    i32.and)
  (func $_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i8$GT$3fmt17he7063fd2fe3493f9E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 128
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 0
    i32.load8_u
    local.set 3
    i32.const 0
    local.set 0
    loop  ;; label = @1
      local.get 2
      local.get 0
      i32.add
      i32.const 127
      i32.add
      local.get 3
      i32.const 15
      i32.and
      local.tee 4
      i32.const 48
      i32.or
      local.get 4
      i32.const 87
      i32.add
      local.get 4
      i32.const 10
      i32.lt_u
      select
      i32.store8
      local.get 0
      i32.const -1
      i32.add
      local.set 0
      local.get 3
      i32.const 255
      i32.and
      local.tee 4
      i32.const 4
      i32.shr_u
      local.set 3
      local.get 4
      i32.const 15
      i32.gt_u
      br_if 0 (;@1;)
    end
    local.get 1
    i32.const 1
    i32.const 1059477
    i32.const 2
    local.get 2
    local.get 0
    i32.add
    i32.const 128
    i32.add
    i32.const 0
    local.get 0
    i32.sub
    call $_ZN4core3fmt9Formatter12pad_integral17h57e359ed883e3df4E
    local.set 0
    local.get 2
    i32.const 128
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN4core3fmt3num3imp21_$LT$impl$u20$u16$GT$4_fmt17hc210f2c273d7f4f1E (type 5) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.const 65535
        i32.and
        local.tee 4
        i32.const 1000
        i32.lt_u
        br_if 0 (;@2;)
        i32.const 1
        local.set 5
        local.get 3
        local.get 0
        local.get 4
        i32.const 10000
        i32.div_u
        local.tee 6
        i32.const 10000
        i32.mul
        i32.sub
        local.tee 4
        i32.const 65535
        i32.and
        i32.const 100
        i32.div_u
        local.tee 7
        i32.const 1
        i32.shl
        local.tee 8
        i32.const 1059480
        i32.add
        i32.load8_u
        i32.store8 offset=13
        local.get 3
        local.get 8
        i32.const 1059479
        i32.add
        i32.load8_u
        i32.store8 offset=12
        local.get 3
        local.get 4
        local.get 7
        i32.const 100
        i32.mul
        i32.sub
        i32.const 65535
        i32.and
        i32.const 1
        i32.shl
        local.tee 4
        i32.const 1059480
        i32.add
        i32.load8_u
        i32.store8 offset=15
        local.get 3
        local.get 4
        i32.const 1059479
        i32.add
        i32.load8_u
        i32.store8 offset=14
        br 1 (;@1;)
      end
      i32.const 5
      local.set 5
      local.get 0
      local.set 6
      local.get 4
      i32.const 10
      i32.lt_u
      br_if 0 (;@1;)
      local.get 3
      local.get 0
      local.get 0
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
      local.tee 5
      i32.const 1059480
      i32.add
      i32.load8_u
      i32.store8 offset=15
      local.get 3
      local.get 5
      i32.const 1059479
      i32.add
      i32.load8_u
      i32.store8 offset=14
      i32.const 3
      local.set 5
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.const 65535
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        local.get 6
        i32.const 65535
        i32.and
        i32.eqz
        br_if 1 (;@1;)
      end
      local.get 3
      i32.const 11
      i32.add
      local.get 5
      i32.const -1
      i32.add
      local.tee 5
      i32.add
      local.get 6
      i32.const 1
      i32.shl
      i32.const 30
      i32.and
      i32.const 1059480
      i32.add
      i32.load8_u
      i32.store8
    end
    local.get 2
    local.get 1
    i32.const 1
    i32.const 0
    local.get 3
    i32.const 11
    i32.add
    local.get 5
    i32.add
    i32.const 5
    local.get 5
    i32.sub
    call $_ZN4core3fmt9Formatter12pad_integral17h57e359ed883e3df4E
    local.set 0
    local.get 3
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17h2e5d1c92a54fe8a1E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 128
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 0
    i32.load
    local.set 0
    i32.const 0
    local.set 3
    loop  ;; label = @1
      local.get 2
      local.get 3
      i32.add
      i32.const 127
      i32.add
      local.get 0
      i32.const 15
      i32.and
      local.tee 4
      i32.const 48
      i32.or
      local.get 4
      i32.const 55
      i32.add
      local.get 4
      i32.const 10
      i32.lt_u
      select
      i32.store8
      local.get 3
      i32.const -1
      i32.add
      local.set 3
      local.get 0
      i32.const 15
      i32.gt_u
      local.set 4
      local.get 0
      i32.const 4
      i32.shr_u
      local.set 0
      local.get 4
      br_if 0 (;@1;)
    end
    local.get 1
    i32.const 1
    i32.const 1059477
    i32.const 2
    local.get 2
    local.get 3
    i32.add
    i32.const 128
    i32.add
    i32.const 0
    local.get 3
    i32.sub
    call $_ZN4core3fmt9Formatter12pad_integral17h57e359ed883e3df4E
    local.set 0
    local.get 2
    i32.const 128
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i16$GT$3fmt17h9bd2fb75ef2ef589E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 128
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 0
    i32.load16_u
    local.set 3
    i32.const 0
    local.set 0
    loop  ;; label = @1
      local.get 2
      local.get 0
      i32.add
      i32.const 127
      i32.add
      local.get 3
      i32.const 15
      i32.and
      local.tee 4
      i32.const 48
      i32.or
      local.get 4
      i32.const 55
      i32.add
      local.get 4
      i32.const 10
      i32.lt_u
      select
      i32.store8
      local.get 0
      i32.const -1
      i32.add
      local.set 0
      local.get 3
      i32.const 65535
      i32.and
      local.tee 4
      i32.const 4
      i32.shr_u
      local.set 3
      local.get 4
      i32.const 15
      i32.gt_u
      br_if 0 (;@1;)
    end
    local.get 1
    i32.const 1
    i32.const 1059477
    i32.const 2
    local.get 2
    local.get 0
    i32.add
    i32.const 128
    i32.add
    i32.const 0
    local.get 0
    i32.sub
    call $_ZN4core3fmt9Formatter12pad_integral17h57e359ed883e3df4E
    local.set 0
    local.get 2
    i32.const 128
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$i32$GT$3fmt17h7840b0de03a5fc94E (type 2) (param i32 i32) (result i32)
    (local i32)
    local.get 0
    i32.load
    local.tee 0
    local.get 0
    i32.const 31
    i32.shr_s
    local.tee 2
    i32.xor
    local.get 2
    i32.sub
    local.get 0
    i32.const -1
    i32.xor
    i32.const 31
    i32.shr_u
    local.get 1
    call $_ZN4core3fmt3num3imp21_$LT$impl$u20$u32$GT$4_fmt17hc1581077febdde3aE)
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17he2e24677bdb08792E (type 2) (param i32 i32) (result i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 128
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 0
    i32.load
    local.set 0
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          i32.load offset=8
          local.tee 3
          i32.const 33554432
          i32.and
          br_if 0 (;@3;)
          local.get 3
          i32.const 67108864
          i32.and
          br_if 1 (;@2;)
          local.get 0
          i32.load
          i32.const 1
          local.get 1
          call $_ZN4core3fmt3num3imp21_$LT$impl$u20$u32$GT$4_fmt17hc1581077febdde3aE
          local.set 0
          br 2 (;@1;)
        end
        local.get 0
        i32.load
        local.set 0
        i32.const 0
        local.set 3
        loop  ;; label = @3
          local.get 2
          local.get 3
          i32.add
          i32.const 127
          i32.add
          local.get 0
          i32.const 15
          i32.and
          local.tee 4
          i32.const 48
          i32.or
          local.get 4
          i32.const 87
          i32.add
          local.get 4
          i32.const 10
          i32.lt_u
          select
          i32.store8
          local.get 3
          i32.const -1
          i32.add
          local.set 3
          local.get 0
          i32.const 15
          i32.gt_u
          local.set 4
          local.get 0
          i32.const 4
          i32.shr_u
          local.set 0
          local.get 4
          br_if 0 (;@3;)
        end
        local.get 1
        i32.const 1
        i32.const 1059477
        i32.const 2
        local.get 2
        local.get 3
        i32.add
        i32.const 128
        i32.add
        i32.const 0
        local.get 3
        i32.sub
        call $_ZN4core3fmt9Formatter12pad_integral17h57e359ed883e3df4E
        local.set 0
        br 1 (;@1;)
      end
      local.get 0
      i32.load
      local.set 0
      i32.const 0
      local.set 3
      loop  ;; label = @2
        local.get 2
        local.get 3
        i32.add
        i32.const 127
        i32.add
        local.get 0
        i32.const 15
        i32.and
        local.tee 4
        i32.const 48
        i32.or
        local.get 4
        i32.const 55
        i32.add
        local.get 4
        i32.const 10
        i32.lt_u
        select
        i32.store8
        local.get 3
        i32.const -1
        i32.add
        local.set 3
        local.get 0
        i32.const 15
        i32.gt_u
        local.set 4
        local.get 0
        i32.const 4
        i32.shr_u
        local.set 0
        local.get 4
        br_if 0 (;@2;)
      end
      local.get 1
      i32.const 1
      i32.const 1059477
      i32.const 2
      local.get 2
      local.get 3
      i32.add
      i32.const 128
      i32.add
      i32.const 0
      local.get 3
      i32.sub
      call $_ZN4core3fmt9Formatter12pad_integral17h57e359ed883e3df4E
      local.set 0
    end
    local.get 2
    i32.const 128
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (table (;0;) 79 79 funcref)
  (memory (;0;) 17)
  (global $__stack_pointer (mut i32) (i32.const 1048576))
  (global $GOT.data.internal.__memory_base i32 (i32.const 0))
  (export "memory" (memory 0))
  (export "_start" (func $_start))
  (export "__main_void" (func $__main_void))
  (elem (;0;) (i32.const 1) func $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hcc5b6de86c24e41dE $_ZN12wasi_httpbin4main17he7c86e12b30448a2E $_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h1f05bfa0720339aaE $_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h141e62f8c62f75caE $_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hf3306bbd8b6bdd55E $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hdcd39cf569c7529eE $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17he465ca2c6b841884E $_ZN64_$LT$core..str..error..Utf8Error$u20$as$u20$core..fmt..Debug$GT$3fmt17he058c9f858a9d8f5E $_ZN63_$LT$wasi..lib_generated..Errno$u20$as$u20$core..fmt..Debug$GT$3fmt17hee0aaf6495e0ee2eE $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h9e1d70983b4e2748E $_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u16$GT$3fmt17hdd5627b38d8a7d3bE $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hd0fd140cfc9a36efE $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h5cd5bf496cf18c08E $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$i32$GT$3fmt17h7840b0de03a5fc94E $_ZN60_$LT$alloc..string..String$u20$as$u20$core..fmt..Display$GT$3fmt17h22c8aa5f6d5a984cE $_ZN60_$LT$std..io..error..Error$u20$as$u20$core..fmt..Display$GT$3fmt17h2ced7ae1889d6455E $_ZN98_$LT$std..sys..backtrace..BacktraceLock..print..DisplayBacktrace$u20$as$u20$core..fmt..Display$GT$3fmt17h2855f445b96d4beeE $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h98109e2d277772fbE $_ZN52_$LT$$RF$mut$u20$T$u20$as$u20$core..fmt..Display$GT$3fmt17h0531e392a94f6dbeE $_ZN3std5alloc24default_alloc_error_hook17hfe3584b28bc072faE $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h3150aa17e091748dE $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hb66487f36964aa60E $_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hf3306bbd8b6bdd55E.1 $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hf130eefae1d3725aE $_ZN4core3ptr119drop_in_place$LT$std..io..default_write_fmt..Adapter$LT$std..io..cursor..Cursor$LT$$RF$mut$u20$$u5b$u8$u5d$$GT$$GT$$GT$17haa00b3b07a295c2eE $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17hffca5ab1aa2ac1e7E $_ZN4core3fmt5Write10write_char17h52852870b95da1a0E $_ZN4core3fmt5Write9write_fmt17h345d79298f1724e6E $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17hef3d614a18d92fc0E $_ZN4core3fmt5Write10write_char17ha2bc79364991ee1dE $_ZN4core3fmt5Write9write_fmt17ha99898242d13ca1cE $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17h6c912057206b6ef0E $_ZN4core3fmt5Write10write_char17h8fdb4a4ad22d286fE $_ZN4core3fmt5Write9write_fmt17h9c16d329b6a554acE $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17h4153cc3db7e9152aE $_ZN4core3fmt5Write10write_char17hd8cddfdb4fcc7641E $_ZN4core3fmt5Write9write_fmt17ha942ff10abf664dcE $_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17he0b805fdcd295968E $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$9write_str17hb927a9f601e7c7bcE $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$10write_char17hc99d8b2b5ebe5dd6E $_ZN4core3fmt5Write9write_fmt17hd822b868a48f344bE $_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17hd9b88af97f3c2071E $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$5write17hb9727852f7c84a6aE $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$14write_vectored17h0846ae4dacdce16fE $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$17is_write_vectored17h85ccc55a9e1850d4E $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$5flush17h1f2dc7de04349823E $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$9write_all17h6bed96dfd3f6d961E $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$18write_all_vectored17ha48943a12795c360E $_ZN3std2io5Write9write_fmt17h35f31b561ea91fb1E $_ZN64_$LT$std..sys..stdio..wasi..Stderr$u20$as$u20$std..io..Write$GT$5write17h9130e91513ae60a2E $_ZN64_$LT$std..sys..stdio..wasi..Stderr$u20$as$u20$std..io..Write$GT$14write_vectored17h8711081ec37d5f23E $_ZN64_$LT$std..sys..stdio..wasi..Stderr$u20$as$u20$std..io..Write$GT$17is_write_vectored17h4a91ce14e3ddc646E $_ZN64_$LT$std..sys..stdio..wasi..Stderr$u20$as$u20$std..io..Write$GT$5flush17h7bd1b0dc5a2382a0E $_ZN3std2io5Write9write_all17h55293c4c3ff1edf7E $_ZN3std2io5Write18write_all_vectored17h0a60c130116d5293E $_ZN3std2io5Write9write_fmt17he070a5b119ee3d3cE $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h91f73deee89ea2feE $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h4efe53c54189bac6E $_ZN92_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..fmt..Display$GT$3fmt17ha2cf78d2946fbf30E $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17hda4884f51fc1d63cE $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17hc9ba6339c6f888eeE $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$6as_str17hacc42b4685d93ce5E $_ZN4core3ptr77drop_in_place$LT$std..panicking..begin_panic_handler..FormatStringPayload$GT$17ha0e54a94adfb7416E $_ZN95_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..fmt..Display$GT$3fmt17h698b05d4ac7f59faE $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17h91eecedfd0f5623eE $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17h6cc4b8d5c4351f3cE $_ZN4core5panic12PanicPayload6as_str17h72bb6430629ae496E $_ZN64_$LT$core..str..error..Utf8Error$u20$as$u20$core..fmt..Debug$GT$3fmt17he058c9f858a9d8f5E.1 $_ZN63_$LT$core..cell..BorrowMutError$u20$as$u20$core..fmt..Debug$GT$3fmt17h222c0dff95342636E $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h7b5d3569f767cb83E $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h2efaf87080996a5eE $_ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17h511711e1bbf1c9f9E $_ZN71_$LT$core..ops..range..Range$LT$Idx$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hcaf36282d85189a7E $_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h67599d50c3692507E $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17he2e24677bdb08792E $_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h21cf2d4c44ad3142E $_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$10write_char17he1f0cb056f10b73fE $_ZN4core3fmt5Write9write_fmt17h1155b5ded69ce2afE)
  (data $.rodata (i32.const 1048576) "\00\00\00\00\04\00\00\00\04\00\00\00\03\00\00\00\04\00\00\00\04\00\00\00\00\00\00\00\04\00\00\00\04\00\00\00\05\00\00\00\00\00\00\00\04\00\00\00\04\00\00\00\06\00\00\00Utf8Errorvalid_up_toerror_lenNone\00\00\00\00\00\00\00\04\00\00\00\04\00\00\00\07\00\00\00SomeGET /get HTTP/1.1\0d\0aHost: httpbin.org\0d\0aConnection: close\0d\0a\0d\0asrc/main.rs\00\00\ab\00\10\00\0b\00\00\00\12\00\00\00&\00\00\00\0a\00\00\00\01\00\00\00\00\00\00\00\c8\00\10\00\01\00\00\00\00\00\00\00\08\00\00\00\04\00\00\00\08\00\00\00called `Result::unwrap()` on an `Err` value\00\ab\00\10\00\0b\00\00\00\12\00\00\002\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00\09\00\00\00\ab\00\10\00\0b\00\00\00\11\00\00\00P\00\00\00\ab\00\10\00\0b\00\00\00\0b\00\00\00\05\00\00\00\ab\00\10\00\0b\00\00\00\0a\00\00\007\00\00\00code\00\00\00\00\08\00\00\00\04\00\00\00\0a\00\00\00namemessageSUCCESS2BIGACCESADDRINUSEADDRNOTAVAILAFNOSUPPORTAGAINALREADYBADFBADMSGBUSYCANCELEDCHILDCONNABORTEDCONNREFUSEDCONNRESETDEADLKDESTADDRREQDOMDQUOTEXISTFAULTFBIGHOSTUNREACHIDRMILSEQINPROGRESSINTRINVALIOISCONNISDIRLOOPMFILEMLINKMSGSIZEMULTIHOPNAMETOOLONGNETDOWNNETRESETNETUNREACHNFILENOBUFSNODEVNOENTNOEXECNOLCKNOLINKNOMEMNOMSGNOPROTOOPTNOSPCNOSYSNOTCONNNOTDIRNOTEMPTYNOTRECOVERABLENOTSOCKNOTSUPNOTTYNXIOOVERFLOWOWNERDEADPERMPIPEPROTOPROTONOSUPPORTPROTOTYPERANGEROFSSPIPESRCHSTALETIMEDOUTTXTBSYXDEVNOTCAPABLENo error occurred. System call completed successfully.Argument list too long.Permission denied.Address in use.Address not available.Address family not supported.Resource unavailable, or operation would block.Connection already in progress.Bad file descriptor.Bad message.Device or resource busy.Operation canceled.No child processes.Connection aborted.Connection refused.Connection reset.Resource deadlock would occur.Destination address required.Mathematics argument out of domain of function.Reserved.File exists.Bad address.File too large.Host is unreachable.Identifier removed.Illegal byte sequence.Operation in progress.Interrupted function.Invalid argument.I/O error.Socket is connected.Is a directory.Too many levels of symbolic links.File descriptor value too large.Too many links.Message too large.Filename too long.Network is down.Connection aborted by network.Network unreachable.Too many files open in system.No buffer space available.No such device.No such file or directory.Executable file format error.No locks available.Not enough space.No message of the desired type.Protocol not available.No space left on device.Function not supported.The socket is not connected.Not a directory or a symbolic link to a directory.Directory not empty.State not recoverable.Not a socket.Not supported, or operation not supported on socket.Inappropriate I/O control operation.No such device or address.Value too large to be stored in data type.Previous owner died.Operation not permitted.Broken pipe.Protocol error.Protocol not supported.Protocol wrong type for socket.Result too large.Read-only file system.Invalid seek.No such process.Connection timed out.Text file busy.Cross-device link.Extension: Capabilities insufficient.Errno\00\00\00\00\00\00\02\00\00\00\02\00\00\00\0b\00\00\00\07\00\00\00\04\00\00\00\05\00\00\00\09\00\00\00\0c\00\00\00\0b\00\00\00\05\00\00\00\07\00\00\00\04\00\00\00\06\00\00\00\04\00\00\00\08\00\00\00\05\00\00\00\0b\00\00\00\0b\00\00\00\09\00\00\00\06\00\00\00\0b\00\00\00\03\00\00\00\05\00\00\00\05\00\00\00\05\00\00\00\04\00\00\00\0b\00\00\00\04\00\00\00\05\00\00\00\0a\00\00\00\04\00\00\00\05\00\00\00\02\00\00\00\06\00\00\00\05\00\00\00\04\00\00\00\05\00\00\00\05\00\00\00\07\00\00\00\08\00\00\00\0b\00\00\00\07\00\00\00\08\00\00\00\0a\00\00\00\05\00\00\00\06\00\00\00\05\00\00\00\05\00\00\00\06\00\00\00\05\00\00\00\06\00\00\00\05\00\00\00\05\00\00\00\0a\00\00\00\05\00\00\00\05\00\00\00\07\00\00\00\06\00\00\00\08\00\00\00\0e\00\00\00\07\00\00\00\06\00\00\00\05\00\00\00\04\00\00\00\08\00\00\00\09\00\00\00\04\00\00\00\04\00\00\00\05\00\00\00\0e\00\00\00\09\00\00\00\05\00\00\00\04\00\00\00\05\00\00\00\04\00\00\00\05\00\00\00\08\00\00\00\06\00\00\00\04\00\00\00\0a\00\00\00\87\01\10\00\8e\01\10\00\92\01\10\00\97\01\10\00\a0\01\10\00\ac\01\10\00\b7\01\10\00\bc\01\10\00\c3\01\10\00\c7\01\10\00\cd\01\10\00\d1\01\10\00\d9\01\10\00\de\01\10\00\e9\01\10\00\f4\01\10\00\fd\01\10\00\03\02\10\00\0e\02\10\00\11\02\10\00\16\02\10\00\1b\02\10\00 \02\10\00$\02\10\00/\02\10\003\02\10\008\02\10\00B\02\10\00F\02\10\00K\02\10\00M\02\10\00S\02\10\00X\02\10\00\5c\02\10\00a\02\10\00f\02\10\00m\02\10\00u\02\10\00\80\02\10\00\87\02\10\00\8f\02\10\00\99\02\10\00\9e\02\10\00\a4\02\10\00\a9\02\10\00\ae\02\10\00\b4\02\10\00\b9\02\10\00\bf\02\10\00\c4\02\10\00\c9\02\10\00\d3\02\10\00\d8\02\10\00\dd\02\10\00\e4\02\10\00\ea\02\10\00\f2\02\10\00\00\03\10\00\07\03\10\00\0d\03\10\00\12\03\10\00\16\03\10\00\1e\03\10\00'\03\10\00+\03\10\00/\03\10\004\03\10\00B\03\10\00K\03\10\00P\03\10\00T\03\10\00Y\03\10\00]\03\10\00b\03\10\00j\03\10\00p\03\10\00t\03\10\006\00\00\00\17\00\00\00\12\00\00\00\0f\00\00\00\16\00\00\00\1d\00\00\00/\00\00\00\1f\00\00\00\14\00\00\00\0c\00\00\00\18\00\00\00\13\00\00\00\13\00\00\00\13\00\00\00\13\00\00\00\11\00\00\00\1e\00\00\00\1d\00\00\00/\00\00\00\09\00\00\00\0c\00\00\00\0c\00\00\00\0f\00\00\00\14\00\00\00\13\00\00\00\16\00\00\00\16\00\00\00\15\00\00\00\11\00\00\00\0a\00\00\00\14\00\00\00\0f\00\00\00\22\00\00\00 \00\00\00\0f\00\00\00\12\00\00\00\09\00\00\00\12\00\00\00\10\00\00\00\1e\00\00\00\14\00\00\00\1e\00\00\00\1a\00\00\00\0f\00\00\00\1a\00\00\00\1d\00\00\00\13\00\00\00\09\00\00\00\11\00\00\00\1f\00\00\00\17\00\00\00\18\00\00\00\17\00\00\00\1c\00\00\002\00\00\00\14\00\00\00\16\00\00\00\0d\00\00\004\00\00\00$\00\00\00\1a\00\00\00*\00\00\00\14\00\00\00\18\00\00\00\0c\00\00\00\0f\00\00\00\17\00\00\00\1f\00\00\00\11\00\00\00\16\00\00\00\0d\00\00\00\10\00\00\00\09\00\00\00\15\00\00\00\0f\00\00\00\12\00\00\00%\00\00\00~\03\10\00\b4\03\10\00\cb\03\10\00\dd\03\10\00\ec\03\10\00\02\04\10\00\1f\04\10\00N\04\10\00m\04\10\00\81\04\10\00\8d\04\10\00\a5\04\10\00\b8\04\10\00\cb\04\10\00\de\04\10\00\f1\04\10\00\02\05\10\00 \05\10\00=\05\10\00l\05\10\00u\05\10\00\81\05\10\00\8d\05\10\00\9c\05\10\00\b0\05\10\00\c3\05\10\00\d9\05\10\00\ef\05\10\00\04\06\10\00\15\06\10\00\1f\06\10\003\06\10\00B\06\10\00d\06\10\00\84\06\10\00\93\06\10\00l\05\10\00\a5\06\10\00\b7\06\10\00\c7\06\10\00\e5\06\10\00\f9\06\10\00\17\07\10\001\07\10\00@\07\10\00Z\07\10\00w\07\10\00l\05\10\00\8a\07\10\00\9b\07\10\00\ba\07\10\00\d1\07\10\00\e9\07\10\00\00\08\10\00\1c\08\10\00N\08\10\00b\08\10\00x\08\10\00\85\08\10\00\b9\08\10\00\dd\08\10\00\f7\08\10\00!\09\10\005\09\10\00M\09\10\00Y\09\10\00h\09\10\00\7f\09\10\00\9e\09\10\00\af\09\10\00\c5\09\10\00\d2\09\10\00l\05\10\00\e2\09\10\00\f7\09\10\00\06\0a\10\00\18\0a\10\00library/std/src/panicking.rs: \00\00\00\00\00\00\04\00\00\00\04\00\00\00\15\00\00\00\00\00\00\00\04\00\00\00\04\00\00\00\16\00\00\00/rustc/6b00bc3880198600130e1cf62b8f8a93494488cc/library/alloc/src/vec/mod.rsd\0f\10\00L\00\00\00V\0a\00\00$\00\00\00/rustc/6b00bc3880198600130e1cf62b8f8a93494488cc/library/alloc/src/raw_vec/mod.rs\c0\0f\10\00P\00\00\00.\02\00\00\11\00\00\00\00\00\00\00\04\00\00\00\04\00\00\00\17\00\00\00\00\00\00\00\04\00\00\00\04\00\00\00\18\00\00\00Utf8Errorvalid_up_toerror_lenNoneSome:\00\00\01\00\00\00\00\00\00\00e\10\10\00\01\00\00\00e\10\10\00\01\00\00\00\19\00\00\00\0c\00\00\00\04\00\00\00\1a\00\00\00\1b\00\00\00\1c\00\00\00\19\00\00\00\0c\00\00\00\04\00\00\00\1d\00\00\00\1e\00\00\00\1f\00\00\00\19\00\00\00\0c\00\00\00\04\00\00\00 \00\00\00!\00\00\00\22\00\00\00\19\00\00\00\0c\00\00\00\04\00\00\00#\00\00\00$\00\00\00%\00\00\00&\00\00\00\0c\00\00\00\04\00\00\00'\00\00\00(\00\00\00)\00\00\00/rustc/6b00bc3880198600130e1cf62b8f8a93494488cc/library/alloc/src/slice.rs\00\00\f8\10\10\00J\00\00\00\be\01\00\00\1d\00\00\00library/std/src/rt.rs\00\00\00T\11\10\00\15\00\00\00\86\00\00\00\0d\00\00\00library/std/src/thread/mod.rsfailed to generate unique thread ID: bitspace exhausted\99\11\10\007\00\00\00|\11\10\00\1d\00\00\00\a9\04\00\00\0d\00\00\00mainRUST_BACKTRACEcalled `Result::unwrap()` on an `Err` valuefailed to write the buffered data\00\00%\12\10\00!\00\00\00\17\00\00\00library/std/src/io/buffered/bufwriter.rs\01\00\00\00\00\00\00\00library/std/src/io/buffered/linewritershim.rsmid > len\00\00\b1\12\10\00\09\00\00\00\84\12\10\00-\00\00\00\16\01\00\00)\00\00\00failed to write whole buffer\d4\12\10\00\1c\00\00\00\17\00\00\00\00\00\00\00\02\00\00\00\f0\12\10\00entity not foundpermission deniedconnection refusedconnection resethost unreachablenetwork unreachableconnection abortednot connectedaddress in useaddress not availablenetwork downbroken pipeentity already existsoperation would blocknot a directoryis a directorydirectory not emptyread-only filesystem or storage mediumfilesystem loop or indirection limit (e.g. symlink loop)stale network file handleinvalid input parameterinvalid datatimed outwrite zerono storage spaceseek on unseekable filequota exceededfile too largeresource busyexecutable file busydeadlockcross-device link or renametoo many linksinvalid filenameargument list too longoperation interruptedunsupportedunexpected end of fileout of memoryin progressother erroruncategorized error (os error )\00\00\00\01\00\00\00\00\00\00\00\f5\15\10\00\0b\00\00\00\00\16\10\00\01\00\00\00T\12\10\00(\00\00\00z\00\00\00!\00\00\00library/std/src/io/stdio.rs\00,\16\10\00\1b\00\00\00\e3\02\00\00\13\00\00\00,\16\10\00\1b\00\00\00\5c\03\00\00\14\00\00\00failed printing to \00h\16\10\00\13\00\00\00@\0f\10\00\02\00\00\00,\16\10\00\1b\00\00\00\8d\04\00\00\09\00\00\00stdoutlibrary/std/src/io/mod.rsa formatting trait implementation returned an error when the underlying stream did not\00\00\00\bb\16\10\00V\00\00\00\a2\16\10\00\19\00\00\00\88\02\00\00\11\00\00\00\a2\16\10\00\19\00\00\00\08\06\00\00 \00\00\00advancing io slices beyond their length\00<\17\10\00'\00\00\00\a2\16\10\00\19\00\00\00\0a\06\00\00\0d\00\00\00advancing IoSlice beyond its length\00|\17\10\00#\00\00\00library/std/src/sys/io/io_slice/wasi.rs\00\a8\17\10\00'\00\00\00\14\00\00\00\0d\00\00\00\a2\16\10\00\19\00\00\00\09\07\00\00$\00\00\00panicked at :\0acannot recursively acquire mutex\00\00\fe\17\10\00 \00\00\00library/std/src/sys/sync/mutex/no_threads.rs(\18\10\00,\00\00\00\13\00\00\00\09\00\00\00library/std/src/sync/poison/once.rs\00d\18\10\00#\00\00\00\9b\00\00\002\00\00\00d\18\10\00#\00\00\00\d6\00\00\00\14\00\00\00lock count overflow in reentrant mutexlibrary/std/src/sync/reentrant_lock.rs\ce\18\10\00&\00\00\00 \01\00\00-\00\00\00file name contained an unexpected NUL byte\00\00\04\19\10\00*\00\00\00\14\00\00\00\00\00\00\00\02\00\00\000\19\10\00stack backtrace:\0anote: Some details are omitted, run with `RUST_BACKTRACE=full` for a verbose backtrace.\0amemory allocation of  bytes failed\0a\b1\19\10\00\15\00\00\00\c6\19\10\00\0e\00\00\00 bytes failed\00\00\00\b1\19\10\00\15\00\00\00\e4\19\10\00\0d\00\00\00library/std/src/alloc.rs\04\1a\10\00\18\00\00\00d\01\00\00\09\00\00\00*\00\00\00\0c\00\00\00\04\00\00\00+\00\00\00,\00\00\00-\00\00\00.\00\00\00/\00\00\000\00\00\001\00\00\00\00\00\00\00\00\00\00\00\01\00\00\002\00\00\003\00\00\004\00\00\005\00\00\006\00\00\007\00\00\008\00\00\00note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace\0a\00\00|\1a\10\00N\00\00\00<unnamed>\00\00\00$\0f\10\00\1c\00\00\00\1d\01\00\00.\00\00\00\0athread '' panicked at \0a\f0\1a\10\00\09\00\00\00\f9\1a\10\00\0e\00\00\00\fc\17\10\00\02\00\00\00\07\1b\10\00\01\00\00\00&\00\00\00\0c\00\00\00\04\00\00\009\00\00\00\00\00\00\00\08\00\00\00\04\00\00\00:\00\00\00\00\00\00\00\08\00\00\00\04\00\00\00;\00\00\00<\00\00\00=\00\00\00>\00\00\00?\00\00\00\10\00\00\00\04\00\00\00@\00\00\00A\00\00\00B\00\00\00C\00\00\00Box<dyn Any>aborting due to panic at \00\00\00\8c\1b\10\00\19\00\00\00\fc\17\10\00\02\00\00\00\07\1b\10\00\01\00\00\00\0athread panicked while processing panic. aborting.\0a\00\f0\17\10\00\0c\00\00\00\fc\17\10\00\02\00\00\00\c0\1b\10\003\00\00\00thread caused non-unwinding panic. aborting.\0a\00\00\00\0c\1c\10\00-\00\00\00fatal runtime error: failed to initiate panic, error , aborting\0aD\1c\10\005\00\00\00y\1c\10\00\0b\00\00\00\00\00\00\00\08\00\00\00\04\00\00\00D\00\00\00library/std/src/sys/pal/wasi/os.rs\00\00\a4\1c\10\00\22\00\00\00(\00\00\006\00\00\00strerror_r failure\00\00\d8\1c\10\00\12\00\00\00\a4\1c\10\00\22\00\00\00&\00\00\00\0d\00\00\00\a4\1c\10\00\22\00\00\00-\00\00\00\13\00\00\00\a4\1c\10\00\22\00\00\004\00\00\00\15\00\00\00Once instance has previously been poisoned\00\00$\1d\10\00*\00\00\00one-time initialization may not be performed recursivelyX\1d\10\008\00\00\00fatal runtime error: rwlock locked for writing, aborting\0a\00\00\00\98\1d\10\009\00\00\00\00\00\00\00\10\00\00\00\11\00\00\00\12\00\00\00\10\00\00\00\10\00\00\00\13\00\00\00\12\00\00\00\0d\00\00\00\0e\00\00\00\15\00\00\00\0c\00\00\00\0b\00\00\00\15\00\00\00\15\00\00\00\0f\00\00\00\0e\00\00\00\13\00\00\00&\00\00\008\00\00\00\19\00\00\00\17\00\00\00\0c\00\00\00\09\00\00\00\0a\00\00\00\10\00\00\00\17\00\00\00\0e\00\00\00\0e\00\00\00\0d\00\00\00\14\00\00\00\08\00\00\00\1b\00\00\00\0e\00\00\00\10\00\00\00\16\00\00\00\15\00\00\00\0b\00\00\00\16\00\00\00\0d\00\00\00\0b\00\00\00\0b\00\00\00\13\00\00\00\08\13\10\00\18\13\10\00)\13\10\00;\13\10\00K\13\10\00[\13\10\00n\13\10\00\80\13\10\00\8d\13\10\00\9b\13\10\00\b0\13\10\00\bc\13\10\00\c7\13\10\00\dc\13\10\00\f1\13\10\00\00\14\10\00\0e\14\10\00!\14\10\00G\14\10\00\7f\14\10\00\98\14\10\00\af\14\10\00\bb\14\10\00\c4\14\10\00\ce\14\10\00\de\14\10\00\f5\14\10\00\03\15\10\00\11\15\10\00\1e\15\10\002\15\10\00:\15\10\00U\15\10\00c\15\10\00s\15\10\00\89\15\10\00\9e\15\10\00\a9\15\10\00\bf\15\10\00\cc\15\10\00\d7\15\10\00\e2\15\10\00/\00Success\00Illegal byte sequence\00Domain error\00Result not representable\00Not a tty\00Permission denied\00Operation not permitted\00No such file or directory\00No such process\00File exists\00Value too large for data type\00No space left on device\00Out of memory\00Resource busy\00Interrupted system call\00Resource temporarily unavailable\00Invalid seek\00Cross-device link\00Read-only file system\00Directory not empty\00Connection reset by peer\00Operation timed out\00Connection refused\00Host is unreachable\00Address in use\00Broken pipe\00I/O error\00No such device or address\00No such device\00Not a directory\00Is a directory\00Text file busy\00Exec format error\00Invalid argument\00Argument list too long\00Symbolic link loop\00Filename too long\00Too many open files in system\00No file descriptors available\00Bad file descriptor\00No child process\00Bad address\00File too large\00Too many links\00No locks available\00Resource deadlock would occur\00State not recoverable\00Previous owner died\00Operation canceled\00Function not implemented\00No message of desired type\00Identifier removed\00Link has been severed\00Protocol error\00Bad message\00Not a socket\00Destination address required\00Message too large\00Protocol wrong type for socket\00Protocol not available\00Protocol not supported\00Not supported\00Address family not supported by protocol\00Address not available\00Network is down\00Network unreachable\00Connection reset by network\00Connection aborted\00No buffer space available\00Socket is connected\00Socket not connected\00Operation already in progress\00Operation in progress\00Stale file handle\00Quota exceeded\00Multihop attempted\00Capabilities insufficient\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00u\02N\00\d6\01\e2\04\b9\04\18\01\8e\05\ed\02\16\04\f2\00\97\03\01\038\05\af\01\82\01O\03/\04\1e\00\d4\05\a2\00\12\03\1e\03\c2\01\de\03\08\00\ac\05\00\01d\02\f1\01e\054\02\8c\02\cf\02-\03L\04\e3\05\9f\02\f8\04\1c\05\08\05\b1\02K\05\15\02x\00R\02<\03\f1\03\e4\00\c3\03}\04\cc\00\aa\03y\05$\02n\01m\03\22\04\ab\04D\00\fb\01\ae\00\83\03`\00\e5\01\07\04\94\04^\04+\00X\019\01\92\00\c2\05\9b\01C\02F\01\f6\05capacity overflow\00\ea%\10\00\11\00\00\00library/alloc/src/ffi/c_str.rs\00\00\04&\10\00\1e\00\00\00\1a\01\00\00\1e\00\00\00\04&\10\00\1e\00\00\00\16\01\00\007\00\00\00\04&\10\00\1e\00\00\00U\01\00\00\0b\00\00\00\00p\00\07\00-\01\01\01\02\01\02\01\01H\0b0\15\10\01e\07\02\06\02\02\01\04#\01\1e\1b[\0b:\09\09\01\18\04\01\09\01\03\01\05+\03;\09*\18\01 7\01\01\01\04\08\04\01\03\07\0a\02\1d\01:\01\01\01\02\04\08\01\09\01\0a\02\1a\01\02\029\01\04\02\04\02\02\03\03\01\1e\02\03\01\0b\029\01\04\05\01\02\04\01\14\02\16\06\01\01:\01\01\02\01\04\08\01\07\03\0a\02\1e\01;\01\01\01\0c\01\09\01(\01\03\017\01\01\03\05\03\01\04\07\02\0b\02\1d\01:\01\02\02\01\01\03\03\01\04\07\02\0b\02\1c\029\02\01\01\02\04\08\01\09\01\0a\02\1d\01H\01\04\01\02\03\01\01\08\01Q\01\02\07\0c\08b\01\02\09\0b\07I\02\1b\01\01\01\01\017\0e\01\05\01\02\05\0b\01$\09\01f\04\01\06\01\02\02\02\19\02\04\03\10\04\0d\01\02\02\06\01\0f\01\00\03\00\04\1c\03\1d\02\1e\02@\02\01\07\08\01\02\0b\09\01-\03\01\01u\02\22\01v\03\04\02\09\01\06\03\db\02\02\01:\01\01\07\01\01\01\01\02\08\06\0a\02\010\1f1\040\0a\04\03&\09\0c\02 \04\02\068\01\01\02\03\01\01\058\08\02\02\98\03\01\0d\01\07\04\01\06\01\03\02\c6@\00\01\c3!\00\03\8d\01` \00\06i\02\00\04\01\0a \02P\02\00\01\03\01\04\01\19\02\05\01\97\02\1a\12\0d\01&\08\19\0b\01\01,\030\01\02\04\02\02\02\01$\01C\06\02\02\02\02\0c\01\08\01/\013\01\01\03\02\02\05\02\01\01*\02\08\01\ee\01\02\01\04\01\00\01\00\10\10\10\00\02\00\01\e2\01\95\05\00\03\01\02\05\04(\03\04\01\a5\02\00\04A\05\00\02O\04F\0b1\04{\016\0f)\01\02\02\0a\031\04\02\02\07\01=\03$\05\01\08>\01\0c\024\09\01\01\08\04\02\01_\03\02\04\06\01\02\01\9d\01\03\08\15\029\02\01\01\01\01\0c\01\09\01\0e\07\03\05C\01\02\06\01\01\02\01\01\03\04\03\01\01\0e\02U\08\02\03\01\01\17\01Q\01\02\06\01\01\02\01\01\02\01\02\eb\01\02\04\06\02\01\02\1b\02U\08\02\01\01\02j\01\01\01\02\08e\01\01\01\02\04\01\05\00\09\01\02\f5\01\0a\04\04\01\90\04\02\02\04\01 \0a(\06\02\04\08\01\09\06\02\03.\0d\01\02\00\07\01\06\01\01R\16\02\07\01\02\01\02z\06\03\01\01\02\01\07\01\01H\02\03\01\01\01\00\02\0b\024\05\05\03\17\01\00\01\06\0f\00\0c\03\03\00\05;\07\00\01?\04Q\01\0b\02\00\02\00.\02\17\00\05\03\06\08\08\02\07\1e\04\94\03\007\042\08\01\0e\01\16\05\01\0f\00\07\01\11\02\07\01\02\01\05d\01\a0\07\00\01=\04\00\04\fe\02\00\07m\07\00`\80\f0\00)..0123456789abcdef\00\00\01\00\00\00\00\00\00\00BorrowMutErroralready borrowed: n)\10\00\12\00\00\00called `Option::unwrap()` on a `None` value\00\00\00\00\00\04\00\00\00\04\00\00\00K\00\00\00==!=matchesassertion `left  right` failed\0a  left: \0a right: \00\cf)\10\00\10\00\00\00\df)\10\00\17\00\00\00\f6)\10\00\09\00\00\00 right` failed: \0a  left: \00\00\00\cf)\10\00\10\00\00\00\18*\10\00\10\00\00\00(*\10\00\09\00\00\00\f6)\10\00\09\00\00\00: \00\00\01\00\00\00\00\00\00\00T*\10\00\02\00\00\00\00\00\00\00\0c\00\00\00\04\00\00\00L\00\00\00M\00\00\00N\00\00\00     { ,  {\0a,\0a} }((\0a,0x00010203040506070809101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899library/core/src/fmt/mod.rsfalsetrue\00_+\10\00\1b\00\00\00\99\0a\00\00&\00\00\00_+\10\00\1b\00\00\00\a2\0a\00\00\1a\00\00\00library/core/src/slice/memchr.rs\a4+\10\00 \00\00\00\84\00\00\00\1e\00\00\00\a4+\10\00 \00\00\00\a0\00\00\00\09\00\00\00library/core/src/str/mod.rs\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\04\04\04\04\04\00\00\00\00\00\00\00\00\00\00\00[...]begin <= end ( <= ) when slicing ``\00\04-\10\00\0e\00\00\00\12-\10\00\04\00\00\00\16-\10\00\10\00\00\00&-\10\00\01\00\00\00byte index  is not a char boundary; it is inside  (bytes ) of `\00H-\10\00\0b\00\00\00S-\10\00&\00\00\00y-\10\00\08\00\00\00\81-\10\00\06\00\00\00&-\10\00\01\00\00\00 is out of bounds of `\00\00H-\10\00\0b\00\00\00\b0-\10\00\16\00\00\00&-\10\00\01\00\00\00\e4+\10\00\1b\00\00\00\9e\01\00\00,\00\00\00library/core/src/unicode/printable.rs\00\00\00\f0-\10\00%\00\00\00\1a\00\00\006\00\00\00\f0-\10\00%\00\00\00\0a\00\00\00+\00\00\00\00\06\01\01\03\01\04\02\05\07\07\02\08\08\09\02\0a\05\0b\02\0e\04\10\01\11\02\12\05\13\1c\14\01\15\02\17\02\19\0d\1c\05\1d\08\1f\01$\01j\04k\02\af\03\b1\02\bc\02\cf\02\d1\02\d4\0c\d5\09\d6\02\d7\02\da\01\e0\05\e1\02\e7\04\e8\02\ee \f0\04\f8\02\fa\04\fb\01\0c';>NO\8f\9e\9e\9f{\8b\93\96\a2\b2\ba\86\b1\06\07\096=>V\f3\d0\d1\04\14\1867VW\7f\aa\ae\af\bd5\e0\12\87\89\8e\9e\04\0d\0e\11\12)14:EFIJNOde\8a\8c\8d\8f\b6\c1\c3\c4\c6\cb\d6\5c\b6\b7\1b\1c\07\08\0a\0b\14\1769:\a8\a9\d8\d9\097\90\91\a8\07\0a;>fi\8f\92\11o_\bf\ee\efZb\f4\fc\ffST\9a\9b./'(U\9d\a0\a1\a3\a4\a7\a8\ad\ba\bc\c4\06\0b\0c\15\1d:?EQ\a6\a7\cc\cd\a0\07\19\1a\22%>?\e7\ec\ef\ff\c5\c6\04 #%&(38:HJLPSUVXZ\5c^`cefksx}\7f\8a\a4\aa\af\b0\c0\d0\ae\afno\dd\de\93^\22{\05\03\04-\03f\03\01/.\80\82\1d\031\0f\1c\04$\09\1e\05+\05D\04\0e*\80\aa\06$\04$\04(\084\0bN\034\0c\817\09\16\0a\08\18;E9\03c\08\090\16\05!\03\1b\05\01@8\04K\05/\04\0a\07\09\07@ '\04\0c\096\03:\05\1a\07\04\0c\07PI73\0d3\07.\08\0a\06&\03\1d\08\02\80\d0R\10\037,\08*\16\1a&\1c\14\17\09N\04$\09D\0d\19\07\0a\06H\08'\09u\0bB>*\06;\05\0a\06Q\06\01\05\10\03\05\0bY\08\02\1db\1eH\08\0a\80\a6^\22E\0b\0a\06\0d\13:\06\0a\06\14\1c,\04\17\80\b9<dS\0cH\09\0aFE\1bH\08S\0dI\07\0a\80\b6\22\0e\0a\06F\0a\1d\03GI7\03\0e\08\0a\069\07\0a\816\19\07;\03\1dU\01\0f2\0d\83\9bfu\0b\80\c4\8aLc\0d\840\10\16\0a\8f\9b\05\82G\9a\b9:\86\c6\829\07*\04\5c\06&\0aF\0a(\05\13\81\b0:\80\c6[eK\049\07\11@\05\0b\02\0e\97\f8\08\84\d6)\0a\a2\e7\813\0f\01\1d\06\0e\04\08\81\8c\89\04k\05\0d\03\09\07\10\8f`\80\fa\06\81\b4LG\09t<\80\f6\0as\08p\15Fz\14\0c\14\0cW\09\19\80\87\81G\03\85B\0f\15\84P\1f\06\06\80\d5+\05>!\01p-\03\1a\04\02\81@\1f\11:\05\01\81\d0*\80\d6+\04\01\81\e0\80\f7)L\04\0a\04\02\83\11DL=\80\c2<\06\01\04U\05\1b4\02\81\0e,\04d\0cV\0a\80\ae8\1d\0d,\04\09\07\02\0e\06\80\9a\83\d8\04\11\03\0d\03w\04_\06\0c\04\01\0f\0c\048\08\0a\06(\08,\04\02>\81T\0c\1d\03\0a\058\07\1c\06\09\07\80\fa\84\06\00\01\03\05\05\06\06\02\07\06\08\07\09\11\0a\1c\0b\19\0c\1a\0d\10\0e\0c\0f\04\10\03\12\12\13\09\16\01\17\04\18\01\19\03\1a\07\1b\01\1c\02\1f\16 \03+\03-\0b.\010\041\022\01\a7\04\a9\02\aa\04\ab\08\fa\02\fb\05\fd\02\fe\03\ff\09\adxy\8b\8d\a20WX\8b\8c\90\1c\dd\0e\0fKL\fb\fc./?\5c]_\e2\84\8d\8e\91\92\a9\b1\ba\bb\c5\c6\c9\ca\de\e4\e5\ff\00\04\11\12)147:;=IJ]\84\8e\92\a9\b1\b4\ba\bb\c6\ca\ce\cf\e4\e5\00\04\0d\0e\11\12)14:;EFIJ^de\84\91\9b\9d\c9\ce\cf\0d\11):;EIW[\5c^_de\8d\91\a9\b4\ba\bb\c5\c9\df\e4\e5\f0\0d\11EIde\80\84\b2\bc\be\bf\d5\d7\f0\f1\83\85\8b\a4\a6\be\bf\c5\c7\cf\da\dbH\98\bd\cd\c6\ce\cfINOWY^_\89\8e\8f\b1\b6\b7\bf\c1\c6\c7\d7\11\16\17[\5c\f6\f7\fe\ff\80mq\de\df\0e\1fno\1c\1d_}~\ae\afM\bb\bc\16\17\1e\1fFGNOXZ\5c^~\7f\b5\c5\d4\d5\dc\f0\f1\f5rs\8ftu\96&./\a7\af\b7\bf\c7\cf\d7\df\9a\00@\97\980\8f\1f\ce\cf\d2\d4\ce\ffNOZ[\07\08\0f\10'/\ee\efno7=?BE\90\91Sgu\c8\c9\d0\d1\d8\d9\e7\fe\ff\00 _\22\82\df\04\82D\08\1b\04\06\11\81\ac\0e\80\ab\05\1f\08\81\1c\03\19\08\01\04/\044\04\07\03\01\07\06\07\11\0aP\0f\12\07U\07\03\04\1c\0a\09\03\08\03\07\03\02\03\03\03\0c\04\05\03\0b\06\01\0e\15\05N\07\1b\07W\07\02\06\17\0cP\04C\03-\03\01\04\11\06\0f\0c:\04\1d%_ m\04j%\80\c8\05\82\b0\03\1a\06\82\fd\03Y\07\16\09\18\09\14\0c\14\0cj\06\0a\06\1a\06Y\07+\05F\0a,\04\0c\04\01\031\0b,\04\1a\06\0b\03\80\ac\06\0a\06/1\80\f4\08<\03\0f\03>\058\08+\05\82\ff\11\18\08/\11-\03!\0f!\0f\80\8c\04\82\9a\16\0b\15\88\94\05/\05;\07\02\0e\18\09\80\be\22t\0c\80\d6\1a\81\10\05\80\e1\09\f2\9e\037\09\81\5c\14\80\b8\08\80\dd\15;\03\0a\068\08F\08\0c\06t\0b\1e\03Z\04Y\09\80\83\18\1c\0a\16\09L\04\80\8a\06\ab\a4\0c\17\041\a1\04\81\da&\07\0c\05\05\80\a6\10\81\f5\07\01 *\06L\04\80\8d\04\80\be\03\1b\03\0f\0drange start index  out of range for slice of length \00\00\00\e13\10\00\12\00\00\00\f33\10\00\22\00\00\00range end index (4\10\00\10\00\00\00\f33\10\00\22\00\00\00slice index starts at  but ends at \00H4\10\00\16\00\00\00^4\10\00\0d\00\00\00\00\03\00\00\83\04 \00\91\05`\00]\13\a0\00\12\17 \1f\0c `\1f\ef, +*0\a0+o\a6`,\02\a8\e0,\1e\fb\e0-\00\fe 6\9e\ff`6\fd\01\e16\01\0a!7$\0d\e17\ab\0ea9/\18\e190\1c\e1J\f3\1e\e1N@4\a1R\1ea\e1S\f0jaTOo\e1T\9d\bcaU\00\cfaVe\d1\a1V\00\da!W\00\e0\a1X\ae\e2!Z\ec\e4\e1[\d0\e8a\5c \00\ee\5c\f0\01\7f]\c4)\10\00\c6)\10\00\c8)\10\00\02\00\00\00\02\00\00\00\07\00\00\00")
  (data $.data (i32.const 1062172) "\01\00\00\00\ff\ff\ff\ff0\1f\10\00"))
