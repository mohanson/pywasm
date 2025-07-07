(module $wasi_ll-3a65216d348c1120.wasm
  (type (;0;) (func (param i32)))
  (type (;1;) (func (param i32 i32) (result i32)))
  (type (;2;) (func (param i32) (result i32)))
  (type (;3;) (func (param i32 i32)))
  (type (;4;) (func (param i32 i32 i32)))
  (type (;5;) (func (param i32 i32 i32) (result i32)))
  (type (;6;) (func (param i32 i32 i32 i32)))
  (type (;7;) (func (param i32 i32 i32 i64 i32) (result i32)))
  (type (;8;) (func (param i32 i32 i32 i32) (result i32)))
  (type (;9;) (func (param i32 i32 i32 i32 i32) (result i32)))
  (type (;10;) (func (param i32 i32 i32 i32 i32 i64 i64 i32 i32) (result i32)))
  (type (;11;) (func))
  (type (;12;) (func (result i32)))
  (type (;13;) (func (param i32 i32 i32 i32 i32)))
  (type (;14;) (func (param i32 i32 i32 i32 i64)))
  (type (;15;) (func (param i32 i32 i32 i32 i32 i32 i64 i64 i32)))
  (type (;16;) (func (param i32 i32 i32 i32 i32 i32) (result i32)))
  (type (;17;) (func (param i32 i32 i32 i32 i32 i32 i32)))
  (type (;18;) (func (param i32 i32 i32 i32 i32 i32 i32) (result i32)))
  (type (;19;) (func (param i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32) (result i32)))
  (type (;20;) (func (param i64 i32 i32) (result i32)))
  (import "wasi_snapshot_preview1" "fd_readdir" (func $_ZN4wasi13lib_generated22wasi_snapshot_preview110fd_readdir17h9023b5be0357994cE (type 7)))
  (import "wasi_snapshot_preview1" "fd_write" (func $_ZN4wasi13lib_generated22wasi_snapshot_preview18fd_write17h33aeb12ec25abb21E (type 8)))
  (import "wasi_snapshot_preview1" "path_filestat_get" (func $_ZN4wasi13lib_generated22wasi_snapshot_preview117path_filestat_get17ha1e4dd55a19006b1E (type 9)))
  (import "wasi_snapshot_preview1" "path_open" (func $_ZN4wasi13lib_generated22wasi_snapshot_preview19path_open17h24152001420e8094E (type 10)))
  (import "wasi_snapshot_preview1" "environ_get" (func $__imported_wasi_snapshot_preview1_environ_get (type 1)))
  (import "wasi_snapshot_preview1" "environ_sizes_get" (func $__imported_wasi_snapshot_preview1_environ_sizes_get (type 1)))
  (import "wasi_snapshot_preview1" "fd_close" (func $__imported_wasi_snapshot_preview1_fd_close (type 2)))
  (import "wasi_snapshot_preview1" "fd_prestat_get" (func $__imported_wasi_snapshot_preview1_fd_prestat_get (type 1)))
  (import "wasi_snapshot_preview1" "fd_prestat_dir_name" (func $__imported_wasi_snapshot_preview1_fd_prestat_dir_name (type 5)))
  (import "wasi_snapshot_preview1" "proc_exit" (func $__imported_wasi_snapshot_preview1_proc_exit (type 0)))
  (func $__wasm_call_ctors (type 11))
  (func $_start (type 11)
    (local i32)
    block  ;; label = @1
      block  ;; label = @2
        global.get $GOT.data.internal.__memory_base
        i32.const 1060568
        i32.add
        i32.load
        br_if 0 (;@2;)
        global.get $GOT.data.internal.__memory_base
        i32.const 1060568
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
  (func $_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h81cf2e14820d3a06E (type 2) (param i32) (result i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    local.get 1
    local.get 0
    i32.load
    call $_ZN3std3sys9backtrace28__rust_begin_short_backtrace17h405d2baabf8b8b1aE
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.load
        local.tee 0
        br_if 0 (;@2;)
        i32.const 0
        local.set 0
        br 1 (;@1;)
      end
      local.get 1
      i32.load offset=4
      local.set 2
      local.get 1
      local.get 0
      i32.store offset=8
      local.get 1
      local.get 2
      i32.store offset=12
      local.get 1
      i32.const 2
      i32.store offset=20
      local.get 1
      i32.const 1048676
      i32.store offset=16
      local.get 1
      i64.const 1
      i64.store offset=28 align=4
      local.get 1
      i32.const 1
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.get 1
      i32.const 8
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=40
      local.get 1
      local.get 1
      i32.const 40
      i32.add
      i32.store offset=24
      local.get 1
      i32.const 16
      i32.add
      call $_ZN3std2io5stdio23attempt_print_to_stderr17h2d57d8c4aeebfc54E
      local.get 1
      i32.load offset=8
      local.set 2
      block  ;; label = @2
        local.get 1
        i32.load offset=12
        local.tee 0
        i32.load
        local.tee 3
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        local.get 3
        call_indirect (type 0)
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
      i32.const 1
      local.set 0
    end
    local.get 1
    i32.const 48
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN3std3sys9backtrace28__rust_begin_short_backtrace17h405d2baabf8b8b1aE (type 3) (param i32 i32)
    (local i32 i64)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    i32.const 8
    i32.add
    local.get 1
    call_indirect (type 0)
    local.get 2
    i64.load offset=8
    local.set 3
    local.get 0
    local.get 3
    i64.store
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer)
  (func $_ZN67_$LT$alloc..boxed..Box$LT$T$C$A$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hf66529acfb7daac0E (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 1
    local.get 0
    i32.load offset=4
    i32.load offset=12
    call_indirect (type 1))
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h150c8b3cbd4e8b2cE (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 1
    call $_ZN43_$LT$bool$u20$as$u20$core..fmt..Display$GT$3fmt17he3b1fcab12cb0898E)
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h57ea09d893436990E (type 1) (param i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    local.get 0
    i32.load
    i32.store offset=12
    local.get 1
    i32.const 1048644
    i32.const 15
    i32.const 1048659
    i32.const 8
    local.get 2
    i32.const 12
    i32.add
    i32.const 1048628
    call $_ZN4core3fmt9Formatter26debug_struct_field1_finish17h34904a7ebe8413d1E
    local.set 0
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h52e2d67e7b195f58E (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    local.get 1
    call $_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17hf7f012776df7e14cE)
  (func $_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17h8b348b62ae96333eE (type 1) (param i32 i32) (result i32)
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
        call $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u64$GT$3fmt17hfbc1ed21c1423f7fE
        return
      end
      local.get 0
      local.get 1
      call $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i64$GT$3fmt17h2bf7fe3e6a3e1f66E
      return
    end
    local.get 0
    local.get 1
    call $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i64$GT$3fmt17h475f7bc048321a9aE)
  (func $_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17ha904373cb3145bcaE (type 2) (param i32) (result i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    local.get 1
    local.get 0
    i32.load
    call $_ZN3std3sys9backtrace28__rust_begin_short_backtrace17h405d2baabf8b8b1aE
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.load
        local.tee 0
        br_if 0 (;@2;)
        i32.const 0
        local.set 0
        br 1 (;@1;)
      end
      local.get 1
      i32.load offset=4
      local.set 2
      local.get 1
      local.get 0
      i32.store offset=8
      local.get 1
      local.get 2
      i32.store offset=12
      local.get 1
      i32.const 2
      i32.store offset=20
      local.get 1
      i32.const 1048676
      i32.store offset=16
      local.get 1
      i64.const 1
      i64.store offset=28 align=4
      local.get 1
      i32.const 1
      i64.extend_i32_u
      i64.const 32
      i64.shl
      local.get 1
      i32.const 8
      i32.add
      i64.extend_i32_u
      i64.or
      i64.store offset=40
      local.get 1
      local.get 1
      i32.const 40
      i32.add
      i32.store offset=24
      local.get 1
      i32.const 16
      i32.add
      call $_ZN3std2io5stdio23attempt_print_to_stderr17h2d57d8c4aeebfc54E
      local.get 1
      i32.load offset=8
      local.set 2
      block  ;; label = @2
        local.get 1
        i32.load offset=12
        local.tee 0
        i32.load
        local.tee 3
        i32.eqz
        br_if 0 (;@2;)
        local.get 2
        local.get 3
        call_indirect (type 0)
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
      i32.const 1
      local.set 0
    end
    local.get 1
    i32.const 48
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN4core3ptr42drop_in_place$LT$std..io..error..Error$GT$17h78a910d02a170d17E (type 0) (param i32)
    (local i32 i32 i32)
    block  ;; label = @1
      local.get 0
      i32.load8_u
      i32.const 3
      i32.ne
      br_if 0 (;@1;)
      local.get 0
      i32.load offset=4
      local.tee 0
      i32.load
      local.set 1
      block  ;; label = @2
        local.get 0
        i32.const 4
        i32.add
        i32.load
        local.tee 2
        i32.load
        local.tee 3
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        local.get 3
        call_indirect (type 0)
      end
      block  ;; label = @2
        local.get 2
        i32.load offset=4
        local.tee 3
        i32.eqz
        br_if 0 (;@2;)
        local.get 1
        local.get 3
        local.get 2
        i32.load offset=8
        call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
      end
      local.get 0
      i32.const 12
      i32.const 4
      call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
    end)
  (func $_ZN4core5error5Error7provide17h3cf740c510eafb34E (type 4) (param i32 i32 i32))
  (func $_ZN4core5error5Error7type_id17h61d20a70f528c150E (type 3) (param i32 i32)
    local.get 0
    i64.const 6292987780672174604
    i64.store offset=8
    local.get 0
    i64.const -8774313525491918143
    i64.store)
  (func $_ZN57_$LT$std..fs..Permissions$u20$as$u20$core..fmt..Debug$GT$3fmt17h31c41953cf56dc3dE (type 1) (param i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    local.get 0
    i32.store offset=12
    local.get 1
    i32.const 1048616
    i32.const 11
    local.get 2
    i32.const 12
    i32.add
    i32.const 1048600
    call $_ZN4core3fmt9Formatter25debug_tuple_field1_finish17h820928a379ff3ec2E
    local.set 0
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN7wasi_ll4main17h5aa279313bf56a05E (type 0) (param i32)
    (local i32 i64 i64 i32 i32 i32 i32 i32 i64 i64 i64 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 256
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    local.get 1
    i32.const 184
    i32.add
    i32.const 1048692
    i32.const 6
    call $_ZN3std3sys2fs8read_dir17hc38638e55dc04626E
    local.get 1
    i64.load offset=192
    local.set 2
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 1
              i64.load offset=184
              local.tee 3
              i64.const 6
              i64.ne
              br_if 0 (;@5;)
              i32.const 0
              i32.load8_u offset=1060573
              drop
              i32.const 8
              i32.const 4
              call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
              local.tee 4
              br_if 1 (;@4;)
              i32.const 4
              i32.const 8
              call $_ZN5alloc5alloc18handle_alloc_error17hcc35c2aed22157a6E
              unreachable
            end
            local.get 1
            i32.const 12
            i32.add
            local.set 5
            local.get 1
            i32.const 20
            i32.add
            local.set 6
            local.get 1
            i32.const 32
            i32.add
            local.tee 7
            local.get 1
            i32.const 184
            i32.add
            i32.const 32
            i32.add
            i64.load
            i64.store
            local.get 1
            i32.const 24
            i32.add
            local.get 1
            i32.const 184
            i32.add
            i32.const 24
            i32.add
            i64.load
            i64.store
            local.get 1
            local.get 1
            i64.load offset=200
            i64.store offset=16
            local.get 1
            local.get 2
            i64.store offset=8
            local.get 1
            local.get 3
            i64.store
            local.get 1
            i32.const 40
            i32.add
            local.get 1
            call $_ZN75_$LT$std..fs..ReadDir$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h30a3e49108035e3eE
            local.get 1
            i32.load offset=68
            local.tee 8
            i32.const -2147483647
            i32.eq
            br_if 2 (;@2;)
            i32.const 2
            i64.extend_i32_u
            i64.const 32
            i64.shl
            local.get 1
            i32.const 164
            i32.add
            i64.extend_i32_u
            i64.or
            local.set 9
            i32.const 3
            i64.extend_i32_u
            i64.const 32
            i64.shl
            local.get 1
            i32.const 152
            i32.add
            i64.extend_i32_u
            i64.or
            local.set 10
            i32.const 4
            i64.extend_i32_u
            i64.const 32
            i64.shl
            local.get 1
            i32.const 151
            i32.add
            i64.extend_i32_u
            i64.or
            local.set 11
            local.get 1
            i32.const 80
            i32.add
            i32.const 24
            i32.add
            local.set 12
            local.get 1
            i32.const 80
            i32.add
            i32.const 8
            i32.add
            local.set 4
            local.get 1
            i32.const 40
            i32.add
            i32.const 8
            i32.add
            local.set 13
            block  ;; label = @5
              block  ;; label = @6
                loop  ;; label = @7
                  local.get 1
                  i64.load offset=40
                  local.set 2
                  block  ;; label = @8
                    local.get 8
                    i32.const -2147483648
                    i32.ne
                    br_if 0 (;@8;)
                    i32.const 0
                    i32.load8_u offset=1060573
                    drop
                    i32.const 8
                    i32.const 4
                    call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
                    local.tee 4
                    br_if 3 (;@5;)
                    i32.const 4
                    i32.const 8
                    call $_ZN5alloc5alloc18handle_alloc_error17hcc35c2aed22157a6E
                    unreachable
                  end
                  local.get 1
                  i64.load offset=72
                  local.set 3
                  local.get 4
                  local.get 13
                  i64.load
                  i64.store
                  local.get 4
                  i32.const 16
                  i32.add
                  local.get 13
                  i32.const 16
                  i32.add
                  i32.load
                  i32.store
                  local.get 4
                  i32.const 8
                  i32.add
                  local.get 13
                  i32.const 8
                  i32.add
                  i64.load
                  i64.store
                  local.get 1
                  local.get 3
                  i64.store offset=112
                  local.get 1
                  local.get 8
                  i32.store offset=108
                  local.get 1
                  local.get 2
                  i64.store offset=80
                  local.get 1
                  i32.const 124
                  i32.add
                  local.get 1
                  i32.const 80
                  i32.add
                  call $_ZN3std2fs8DirEntry4path17he02e7629e32bb8a6E
                  local.get 1
                  i32.const 184
                  i32.add
                  local.get 1
                  i32.load offset=128
                  local.tee 8
                  local.get 1
                  i32.load offset=132
                  call $_ZN3std3sys2fs8metadata17h0182fd3b7e770833E
                  block  ;; label = @8
                    local.get 1
                    i32.load offset=184
                    i32.const 1
                    i32.ne
                    br_if 0 (;@8;)
                    i32.const 0
                    i32.load8_u offset=1060573
                    drop
                    local.get 1
                    i64.load offset=188 align=4
                    local.set 2
                    i32.const 8
                    i32.const 4
                    call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
                    local.tee 4
                    br_if 2 (;@6;)
                    i32.const 4
                    i32.const 8
                    call $_ZN5alloc5alloc18handle_alloc_error17hcc35c2aed22157a6E
                    unreachable
                  end
                  local.get 1
                  i64.load offset=224
                  local.set 2
                  block  ;; label = @8
                    local.get 1
                    i32.load offset=124
                    local.tee 14
                    i32.eqz
                    br_if 0 (;@8;)
                    local.get 8
                    local.get 14
                    i32.const 1
                    call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
                  end
                  local.get 1
                  i32.const 0
                  i32.store8 offset=151
                  local.get 1
                  local.get 2
                  i64.store offset=152
                  local.get 1
                  i32.const 172
                  i32.add
                  local.get 1
                  i32.const 80
                  i32.add
                  call $_ZN3std2fs8DirEntry4path17he02e7629e32bb8a6E
                  local.get 1
                  i32.const 184
                  i32.add
                  local.get 1
                  i32.load offset=176
                  local.tee 14
                  local.get 1
                  i32.load offset=180
                  call $_ZN4core3str8converts9from_utf817hb5c7d3e2ee61e867E
                  block  ;; label = @8
                    local.get 1
                    i32.load offset=184
                    br_if 0 (;@8;)
                    local.get 1
                    i32.load offset=188
                    local.set 8
                    local.get 1
                    local.get 1
                    i32.load offset=192
                    i32.store offset=168
                    local.get 1
                    local.get 8
                    i32.store offset=164
                    local.get 1
                    local.get 9
                    i64.store offset=200
                    local.get 1
                    local.get 10
                    i64.store offset=192
                    local.get 1
                    local.get 11
                    i64.store offset=184
                    local.get 1
                    i32.const 3
                    i32.store offset=144
                    local.get 1
                    i32.const 1048760
                    i32.store offset=140
                    local.get 1
                    i32.const 4
                    i32.store offset=128
                    local.get 1
                    i32.const 1048700
                    i32.store offset=124
                    local.get 1
                    i32.const 3
                    i32.store offset=136
                    local.get 1
                    local.get 1
                    i32.const 184
                    i32.add
                    i32.store offset=132
                    local.get 1
                    i32.const 124
                    i32.add
                    call $_ZN3std2io5stdio6_print17h113dc87389378e4fE
                    block  ;; label = @9
                      local.get 1
                      i32.load offset=172
                      local.tee 8
                      i32.eqz
                      br_if 0 (;@9;)
                      local.get 14
                      local.get 8
                      i32.const 1
                      call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
                    end
                    block  ;; label = @9
                      local.get 1
                      i32.load offset=108
                      local.tee 8
                      i32.eqz
                      br_if 0 (;@9;)
                      local.get 1
                      i32.load offset=112
                      local.get 8
                      i32.const 1
                      call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
                    end
                    local.get 1
                    i32.load offset=104
                    local.tee 8
                    local.get 8
                    i32.load
                    local.tee 8
                    i32.const -1
                    i32.add
                    i32.store
                    block  ;; label = @9
                      local.get 8
                      i32.const 1
                      i32.ne
                      br_if 0 (;@9;)
                      local.get 12
                      call $_ZN5alloc4sync16Arc$LT$T$C$A$GT$9drop_slow17he700f510fdc4b658E
                    end
                    local.get 1
                    i32.const 40
                    i32.add
                    local.get 1
                    call $_ZN75_$LT$std..fs..ReadDir$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h30a3e49108035e3eE
                    local.get 1
                    i32.load offset=68
                    local.tee 8
                    i32.const -2147483647
                    i32.ne
                    br_if 1 (;@7;)
                    br 6 (;@2;)
                  end
                end
                i32.const 1048744
                call $_ZN4core6option13unwrap_failed17habb842812e602dc6E
                unreachable
              end
              local.get 4
              local.get 2
              i64.store align=4
              block  ;; label = @6
                local.get 1
                i32.load offset=124
                local.tee 13
                i32.eqz
                br_if 0 (;@6;)
                local.get 8
                local.get 13
                i32.const 1
                call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
              end
              block  ;; label = @6
                local.get 1
                i32.load offset=108
                local.tee 8
                i32.eqz
                br_if 0 (;@6;)
                local.get 1
                i32.load offset=112
                local.get 8
                i32.const 1
                call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
              end
              local.get 1
              i32.load offset=104
              local.tee 8
              local.get 8
              i32.load
              local.tee 8
              i32.const -1
              i32.add
              i32.store
              local.get 8
              i32.const 1
              i32.ne
              br_if 2 (;@3;)
              local.get 12
              call $_ZN5alloc4sync16Arc$LT$T$C$A$GT$9drop_slow17he700f510fdc4b658E
              br 2 (;@3;)
            end
            local.get 4
            local.get 2
            i64.store align=4
            br 1 (;@3;)
          end
          local.get 4
          local.get 2
          i64.store align=4
          br 2 (;@1;)
        end
        local.get 1
        i32.load offset=32
        local.tee 8
        local.get 8
        i32.load
        local.tee 8
        i32.const -1
        i32.add
        i32.store
        block  ;; label = @3
          local.get 8
          i32.const 1
          i32.ne
          br_if 0 (;@3;)
          local.get 1
          i32.const 32
          i32.add
          call $_ZN5alloc4sync16Arc$LT$T$C$A$GT$9drop_slow17he700f510fdc4b658E
        end
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 1
              i64.load
              i64.const -2
              i64.add
              local.tee 2
              i32.wrap_i64
              i32.const 1
              local.get 2
              i64.const 4
              i64.lt_u
              select
              br_table 0 (;@5;) 0 (;@5;) 1 (;@4;) 4 (;@1;)
            end
            local.get 1
            i32.load offset=16
            local.tee 8
            i32.eqz
            br_if 3 (;@1;)
            br 1 (;@3;)
          end
          local.get 5
          local.set 6
          local.get 1
          i32.load offset=8
          local.tee 8
          i32.eqz
          br_if 2 (;@1;)
        end
        local.get 6
        i32.load
        local.get 8
        i32.const 1
        call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        br 1 (;@1;)
      end
      local.get 1
      i32.load offset=32
      local.tee 8
      local.get 8
      i32.load
      local.tee 8
      i32.const -1
      i32.add
      i32.store
      block  ;; label = @2
        local.get 8
        i32.const 1
        i32.ne
        br_if 0 (;@2;)
        local.get 7
        call $_ZN5alloc4sync16Arc$LT$T$C$A$GT$9drop_slow17he700f510fdc4b658E
      end
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 1
              i64.load
              i64.const -2
              i64.add
              local.tee 2
              i32.wrap_i64
              i32.const 1
              local.get 2
              i64.const 4
              i64.lt_u
              select
              br_table 0 (;@5;) 0 (;@5;) 1 (;@4;) 3 (;@2;)
            end
            local.get 1
            i32.load offset=16
            local.tee 8
            i32.eqz
            br_if 2 (;@2;)
            br 1 (;@3;)
          end
          local.get 5
          local.set 6
          local.get 1
          i32.load offset=8
          local.tee 8
          i32.eqz
          br_if 1 (;@2;)
        end
        local.get 6
        i32.load
        local.get 8
        i32.const 1
        call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
      end
      i32.const 0
      local.set 4
    end
    local.get 0
    i32.const 1048848
    i32.store offset=4
    local.get 0
    local.get 4
    i32.store
    local.get 1
    i32.const 256
    i32.add
    global.set $__stack_pointer)
  (func $__main_void (type 12) (result i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 0
    global.set $__stack_pointer
    local.get 0
    i32.const 5
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
  (func $_RNvCs691rhTbG0Ee_7___rustc14___rust_realloc (type 8) (param i32 i32 i32 i32) (result i32)
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
  (func $_RNvCs691rhTbG0Ee_7___rustc26___rust_alloc_error_handler (type 3) (param i32 i32)
    local.get 0
    local.get 1
    call $_RNvCs691rhTbG0Ee_7___rustc8___rg_oom
    return)
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h4efe53c54189bac6E (type 3) (param i32 i32)
    local.get 0
    i64.const 7199936582794304877
    i64.store offset=8
    local.get 0
    i64.const -5076933981314334344
    i64.store)
  (func $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h91f73deee89ea2feE (type 3) (param i32 i32)
    local.get 0
    i64.const 3353964679774260343
    i64.store offset=8
    local.get 0
    i64.const -5190768330908619786
    i64.store)
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h2168c0e0eebccb9dE (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.tee 0
    i32.load
    local.get 1
    local.get 0
    i32.const 4
    i32.add
    i32.load
    i32.load offset=12
    call_indirect (type 1))
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h3150aa17e091748dE (type 1) (param i32 i32) (result i32)
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
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h7999eed731dd903bE (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    local.get 1
    call $_ZN59_$LT$core..ffi..c_str..CStr$u20$as$u20$core..fmt..Debug$GT$3fmt17h7fd1a31f0b134679E)
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h8a99d8c9aca26bbbE (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    local.get 1
    call $_ZN40_$LT$str$u20$as$u20$core..fmt..Debug$GT$3fmt17he4df7632dab5ca2aE)
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hb66487f36964aa60E (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 1
    call $_ZN43_$LT$bool$u20$as$u20$core..fmt..Display$GT$3fmt17he3b1fcab12cb0898E)
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hf130eefae1d3725aE (type 1) (param i32 i32) (result i32)
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
        i32.const 1049269
        i32.const 4
        local.get 2
        i32.const 12
        i32.add
        i32.const 1048924
        call $_ZN4core3fmt9Formatter25debug_tuple_field1_finish17h820928a379ff3ec2E
        local.set 0
        br 1 (;@1;)
      end
      local.get 1
      i32.const 1049265
      i32.const 4
      call $_ZN4core3fmt9Formatter9write_str17hdf9d14a3fcabff76E
      local.set 0
    end
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h98109e2d277772fbE (type 1) (param i32 i32) (result i32)
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
    i32.const 1049276
    i32.store
    local.get 2
    i64.const 3
    i64.store offset=12 align=4
    local.get 2
    i32.const 18
    i64.extend_i32_u
    i64.const 32
    i64.shl
    local.get 1
    i64.extend_i32_u
    i64.or
    i64.store offset=24
    local.get 2
    i32.const 19
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
  (func $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hd0fd140cfc9a36efE (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    local.get 1
    call $_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17hf7f012776df7e14cE)
  (func $_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$i32$GT$3fmt17hfbe88f27a048c86dE (type 1) (param i32 i32) (result i32)
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
        call $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$i32$GT$3fmt17h7840b0de03a5fc94E
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
  (func $_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hf3306bbd8b6bdd55E (type 1) (param i32 i32) (result i32)
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
  (func $_ZN4core3fmt5Write10write_char17h52852870b95da1a0E (type 1) (param i32 i32) (result i32)
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
          call_indirect (type 0)
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
  (func $_ZN61_$LT$std..io..stdio..StdoutLock$u20$as$u20$std..io..Write$GT$9write_all17he8e1b902282633b2E (type 6) (param i32 i32 i32 i32)
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
                          i32.const 1049904
                          i32.store offset=16
                          local.get 4
                          i64.const 4
                          i64.store offset=24 align=4
                          local.get 4
                          i32.const 16
                          i32.add
                          i32.const 1049912
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
                                i32.const 1049788
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
                                i64.load offset=1049968
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
                              i32.const 1049788
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
                    i32.const 1050940
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
                i32.const 1051348
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
              i32.const 1049032
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
    i32.const 1049032
    call $_ZN4core5slice5index24slice_end_index_len_fail17hc7943372990115c8E
    unreachable)
  (func $_ZN4core3fmt5Write10write_char17h8fdb4a4ad22d286fE (type 1) (param i32 i32) (result i32)
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
  (func $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hf4e8ee5cbddfee98E (type 13) (param i32 i32 i32 i32 i32)
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
      i32.const 1049188
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
  (func $_ZN4core3fmt5Write10write_char17ha2bc79364991ee1dE (type 1) (param i32 i32) (result i32)
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
      i64.load offset=1049968
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
          call_indirect (type 0)
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
  (func $_ZN4core3fmt5Write10write_char17hd8cddfdb4fcc7641E (type 1) (param i32 i32) (result i32)
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
                i64.load offset=1049968
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
                  call_indirect (type 0)
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
    i32.const 1051348
    call $_ZN4core5slice5index26slice_start_index_len_fail17hcb91b9a11352b54bE
    unreachable)
  (func $_ZN4core3fmt5Write10write_char17hebf230d22cf70b0aE (type 1) (param i32 i32) (result i32)
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
    call $_ZN61_$LT$std..io..stdio..StderrLock$u20$as$u20$std..io..Write$GT$9write_all17h1f6036d6c3650e60E
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
          call_indirect (type 0)
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
  (func $_ZN61_$LT$std..io..stdio..StderrLock$u20$as$u20$std..io..Write$GT$9write_all17h1f6036d6c3650e60E (type 6) (param i32 i32 i32 i32)
    (local i32 i32 i64 i64)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 4
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.load
        local.tee 5
        i32.load offset=16
        br_if 0 (;@2;)
        local.get 5
        i32.const -1
        i32.store offset=16
        i64.const 0
        local.set 6
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 3
                i32.eqz
                br_if 0 (;@6;)
                loop  ;; label = @7
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
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          local.get 4
                          i32.load16_u offset=8
                          i32.const 1
                          i32.ne
                          br_if 0 (;@11;)
                          local.get 4
                          i64.load16_u offset=10
                          local.tee 7
                          i64.const 27
                          i64.eq
                          br_if 3 (;@8;)
                          local.get 7
                          i64.const 32
                          i64.shl
                          local.set 7
                          br 1 (;@10;)
                        end
                        local.get 4
                        i32.load offset=12
                        local.tee 1
                        br_if 1 (;@9;)
                        i32.const 0
                        i64.load offset=1049968
                        local.set 7
                      end
                      local.get 7
                      i64.const 32
                      i64.shr_u
                      local.set 6
                      local.get 7
                      i32.wrap_i64
                      i32.const 255
                      i32.and
                      local.tee 3
                      i32.const 4
                      i32.eq
                      br_if 4 (;@5;)
                      block  ;; label = @10
                        local.get 3
                        br_if 0 (;@10;)
                        local.get 6
                        i64.const 8
                        i64.eq
                        br_if 6 (;@4;)
                      end
                      local.get 0
                      local.get 7
                      i64.store align=4
                      br 6 (;@3;)
                    end
                    local.get 3
                    local.get 1
                    i32.lt_u
                    br_if 7 (;@1;)
                    local.get 2
                    local.get 1
                    i32.add
                    local.set 2
                    local.get 3
                    local.get 1
                    i32.sub
                    local.set 3
                  end
                  local.get 3
                  br_if 0 (;@7;)
                end
              end
              i64.const 0
              local.set 7
            end
            local.get 0
            local.get 7
            i64.const 4294967040
            i64.and
            local.get 6
            i64.const 32
            i64.shl
            i64.or
            i64.const 4
            i64.or
            i64.store align=4
            br 1 (;@3;)
          end
          local.get 0
          i32.const 4
          i32.store8
        end
        local.get 5
        local.get 5
        i32.load offset=16
        i32.const 1
        i32.add
        i32.store offset=16
        local.get 4
        i32.const 16
        i32.add
        global.set $__stack_pointer
        return
      end
      i32.const 1050956
      call $_ZN4core4cell22panic_already_borrowed17h95614011b014b567E
      unreachable
    end
    local.get 1
    local.get 3
    i32.const 1051348
    call $_ZN4core5slice5index26slice_start_index_len_fail17hcb91b9a11352b54bE
    unreachable)
  (func $_ZN4core3fmt5Write9write_fmt17h345d79298f1724e6E (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.const 1049324
    local.get 1
    call $_ZN4core3fmt5write17hb4e267bf92503392E)
  (func $_ZN4core3fmt5Write9write_fmt17h990aa971c551724cE (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.const 1049300
    local.get 1
    call $_ZN4core3fmt5write17hb4e267bf92503392E)
  (func $_ZN4core3fmt5Write9write_fmt17h9c16d329b6a554acE (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.const 1049372
    local.get 1
    call $_ZN4core3fmt5write17hb4e267bf92503392E)
  (func $_ZN4core3fmt5Write9write_fmt17ha942ff10abf664dcE (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.const 1049396
    local.get 1
    call $_ZN4core3fmt5write17hb4e267bf92503392E)
  (func $_ZN4core3fmt5Write9write_fmt17ha99898242d13ca1cE (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.const 1049348
    local.get 1
    call $_ZN4core3fmt5write17hb4e267bf92503392E)
  (func $_ZN4core3fmt5Write9write_fmt17hd822b868a48f344bE (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.const 1049420
    local.get 1
    call $_ZN4core3fmt5write17hb4e267bf92503392E)
  (func $_ZN3std9panicking12default_hook17ha7cb01911cb0a911E (type 0) (param i32)
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
      i32.load offset=1060696
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
              i32.load8_u offset=1060575
              br_if 0 (;@5;)
              local.get 1
              i64.const 0
              i64.store offset=40 align=4
              br 1 (;@4;)
            end
            i32.const 0
            i32.const 1
            i32.store8 offset=1060575
            local.get 1
            i32.const 0
            i32.store offset=40
            i32.const 0
            i32.load offset=1060704
            local.set 0
            i32.const 0
            i32.const 0
            i32.store offset=1060704
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
          i32.const 1052012
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
        i32.const 1051972
        call $_ZN3std9panicking12default_hook28_$u7b$$u7b$closure$u7d$$u7d$17h10e421fa9b730a1bE
        local.get 0
        i32.const 0
        i32.store8 offset=8
        i32.const 0
        i32.const 1
        i32.store8 offset=1060575
        i32.const 0
        i32.load offset=1060704
        local.set 2
        i32.const 0
        local.get 0
        i32.store offset=1060704
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
    i32.const 1051452
    i32.store offset=52
    i32.const 0
    local.get 1
    i32.const 51
    i32.add
    i32.const 1053668
    local.get 1
    i32.const 52
    i32.add
    i32.const 1051504
    call $_ZN4core9panicking13assert_failed17h837345b905b163c7E
    unreachable)
  (func $_ZN4core3ptr119drop_in_place$LT$std..io..default_write_fmt..Adapter$LT$std..io..cursor..Cursor$LT$$RF$mut$u20$$u5b$u8$u5d$$GT$$GT$$GT$17haa00b3b07a295c2eE (type 0) (param i32)
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
        call_indirect (type 0)
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
  (func $_ZN4core3ptr199drop_in_place$LT$core..result..Result$LT$core..option..Option$LT$alloc..sync..Arc$LT$std..sync..poison..mutex..Mutex$LT$alloc..vec..Vec$LT$u8$GT$$GT$$GT$$GT$$C$std..thread..local..AccessError$GT$$GT$17h39961923d7009e78E (type 0) (param i32)
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
  (func $_ZN5alloc4sync16Arc$LT$T$C$A$GT$9drop_slow17h3073f53b2412ac4bE (type 0) (param i32)
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
  (func $_ZN4core3ptr238drop_in_place$LT$alloc..boxed..convert..$LT$impl$u20$core..convert..From$LT$alloc..string..String$GT$$u20$for$u20$alloc..boxed..Box$LT$dyn$u20$core..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$$GT$..from..StringError$GT$17h94e06a9b9c0bb73bE (type 0) (param i32)
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
  (func $_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17he0b805fdcd295968E (type 0) (param i32)
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
  (func $_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17hd9b88af97f3c2071E (type 0) (param i32)
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
  (func $_ZN4core3ptr77drop_in_place$LT$std..panicking..begin_panic_handler..FormatStringPayload$GT$17ha0e54a94adfb7416E (type 0) (param i32)
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
  (func $_ZN4core3ptr81drop_in_place$LT$core..result..Result$LT$$LP$$RP$$C$std..io..error..Error$GT$$GT$17h3da6fe1468662fefE (type 3) (param i32 i32)
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
        call_indirect (type 0)
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
  (func $_ZN4core5error5Error5cause17h26c4b13c0a591580E (type 3) (param i32 i32)
    local.get 0
    i32.const 0
    i32.store)
  (func $_ZN4core5error5Error7provide17hdabe7bd7484a2ac5E (type 4) (param i32 i32 i32))
  (func $_ZN4core5error5Error7type_id17h66f6cc4dd903555dE (type 3) (param i32 i32)
    local.get 0
    i64.const -6749937211255641621
    i64.store offset=8
    local.get 0
    i64.const -3634914716689285116
    i64.store)
  (func $_ZN4core5panic12PanicPayload6as_str17h72bb6430629ae496E (type 3) (param i32 i32)
    local.get 0
    i32.const 0
    i32.store)
  (func $_ZN4core9panicking13assert_failed17h837345b905b163c7E (type 13) (param i32 i32 i32 i32 i32)
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
    i32.const 1048940
    local.get 5
    i32.const 12
    i32.add
    i32.const 1048940
    local.get 3
    local.get 4
    call $_ZN4core9panicking19assert_failed_inner17ha727a1f35658cb19E
    unreachable)
  (func $_ZN52_$LT$$RF$mut$u20$T$u20$as$u20$core..fmt..Display$GT$3fmt17h0531e392a94f6dbeE (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 1
    local.get 0
    i32.load offset=4
    i32.load offset=12
    call_indirect (type 1))
  (func $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Debug$GT$3fmt17ha9bb96ed4384267eE (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.load offset=4
    local.get 0
    i32.load offset=8
    local.get 1
    call $_ZN40_$LT$str$u20$as$u20$core..fmt..Debug$GT$3fmt17he4df7632dab5ca2aE)
  (func $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$10write_char17hc99d8b2b5ebe5dd6E (type 1) (param i32 i32) (result i32)
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
  (func $_ZN5alloc4sync16Arc$LT$T$C$A$GT$9drop_slow17he700f510fdc4b658E (type 0) (param i32)
    (local i32)
    block  ;; label = @1
      local.get 0
      i32.load
      local.tee 0
      i32.load offset=8
      local.tee 1
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      i32.load offset=12
      local.get 1
      i32.const 1
      call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
    end
    local.get 0
    i32.load offset=20
    call $close
    drop
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
  (func $_ZN5alloc7raw_vec11finish_grow17hdbe49ceb89f1e3aaE (type 6) (param i32 i32 i32 i32)
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
              i32.load8_u offset=1060573
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
          i32.load8_u offset=1060573
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
  (func $_ZN60_$LT$alloc..string..String$u20$as$u20$core..fmt..Display$GT$3fmt17h22c8aa5f6d5a984cE (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.load offset=4
    local.get 0
    i32.load offset=8
    local.get 1
    call $_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17hf7f012776df7e14cE)
  (func $_ZN64_$LT$core..str..error..Utf8Error$u20$as$u20$core..fmt..Debug$GT$3fmt17he058c9f858a9d8f5E (type 1) (param i32 i32) (result i32)
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
    i32.const 1049236
    i32.const 9
    i32.const 1049245
    i32.const 11
    local.get 0
    i32.const 1049204
    i32.const 1049256
    i32.const 9
    local.get 2
    i32.const 12
    i32.add
    i32.const 1049220
    call $_ZN4core3fmt9Formatter26debug_struct_field2_finish17h05c90c1de6f82831E
    local.set 0
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN87_$LT$T$u20$as$u20$alloc..slice..$LT$impl$u20$$u5b$T$u5d$$GT$..to_vec_in..ConvertVec$GT$6to_vec17h5e07232602c21a66E (type 4) (param i32 i32 i32)
    (local i32 i32)
    i32.const 0
    local.set 3
    block  ;; label = @1
      local.get 2
      i32.const 0
      i32.lt_s
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          br_if 0 (;@3;)
          i32.const 1
          local.set 4
          br 1 (;@2;)
        end
        i32.const 0
        i32.load8_u offset=1060573
        drop
        i32.const 1
        local.set 3
        local.get 2
        i32.const 1
        call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
        local.tee 4
        i32.eqz
        br_if 1 (;@1;)
      end
      block  ;; label = @2
        local.get 2
        i32.eqz
        br_if 0 (;@2;)
        local.get 4
        local.get 1
        local.get 2
        memory.copy
      end
      local.get 0
      local.get 2
      i32.store offset=8
      local.get 0
      local.get 4
      i32.store offset=4
      local.get 0
      local.get 2
      i32.store
      return
    end
    local.get 3
    local.get 2
    i32.const 1049520
    call $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E
    unreachable)
  (func $_ZN3std3sys4sync4once10no_threads4Once4call17h5c54e46b69727327E (type 0) (param i32)
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
                        i32.load8_u offset=1060574
                        br_table 0 (;@10;) 2 (;@8;) 1 (;@9;) 9 (;@1;) 0 (;@10;)
                      end
                      i32.const 0
                      i32.const 2
                      i32.store8 offset=1060574
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
                          i32.load8_u offset=1060616
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
                          i64.load offset=1060672
                          local.tee 3
                          i64.const 0
                          i64.ne
                          br_if 0 (;@11;)
                          i32.const 0
                          i64.load offset=1060680
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
                            i64.load offset=1060680
                            local.tee 5
                            local.get 5
                            local.get 4
                            i64.eq
                            local.tee 0
                            select
                            i64.store offset=1060680
                            local.get 5
                            local.set 4
                            local.get 0
                            i32.eqz
                            br_if 0 (;@12;)
                          end
                          i32.const 0
                          local.get 3
                          i64.store offset=1060672
                        end
                        block  ;; label = @11
                          block  ;; label = @12
                            local.get 3
                            i32.const 0
                            i64.load offset=1060576
                            i64.eq
                            br_if 0 (;@12;)
                            i32.const 0
                            i32.load8_u offset=1060588
                            local.set 2
                            i32.const 1
                            local.set 0
                            i32.const 0
                            i32.const 1
                            i32.store8 offset=1060588
                            local.get 2
                            br_if 10 (;@2;)
                            i32.const 0
                            local.get 3
                            i64.store offset=1060576
                            br 1 (;@11;)
                          end
                          i32.const 0
                          i32.load offset=1060584
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
                        i32.store offset=1060584
                        i32.const 0
                        i32.load offset=1060592
                        br_if 4 (;@6;)
                        i32.const 0
                        i32.const -1
                        i32.store offset=1060592
                        i32.const 0
                        i32.load8_u offset=1060608
                        br_if 7 (;@3;)
                        i32.const 0
                        local.set 0
                        i32.const 0
                        i32.load offset=1060604
                        local.tee 6
                        i32.eqz
                        br_if 7 (;@3;)
                        i32.const 0
                        i32.load offset=1060600
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
                                i32.const 1049788
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
                      i32.const 1051556
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
                    i32.const 1053592
                    i32.store offset=12
                    local.get 1
                    i64.const 4
                    i64.store offset=20 align=4
                    local.get 1
                    i32.const 12
                    i32.add
                    i32.const 1049560
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
                  i32.const 1053528
                  i32.store offset=12
                  local.get 1
                  i64.const 4
                  i64.store offset=20 align=4
                  local.get 1
                  i32.const 12
                  i32.add
                  i32.const 1049560
                  call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
                  unreachable
                end
                call $_ZN3std6thread8ThreadId3new9exhausted17h79591ad025c79bdcE
                unreachable
              end
              i32.const 1050924
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
              call_indirect (type 0)
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
          i32.const 1049032
          call $_ZN4core5slice5index24slice_end_index_len_fail17hc7943372990115c8E
          unreachable
        end
        block  ;; label = @3
          i32.const 0
          i32.load offset=1060596
          local.tee 0
          i32.eqz
          br_if 0 (;@3;)
          i32.const 0
          i32.load offset=1060600
          local.get 0
          i32.const 1
          call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        end
        i32.const 0
        i64.const 4294967296
        i64.store offset=1060596 align=4
        i32.const 0
        i32.const 0
        i32.load offset=1060592
        i32.const 1
        i32.add
        i32.store offset=1060592
        i32.const 0
        i32.const 0
        i32.load offset=1060584
        i32.const -1
        i32.add
        local.tee 0
        i32.store offset=1060584
        i32.const 0
        i32.const 0
        i32.store8 offset=1060608
        i32.const 0
        i32.const 0
        i32.store offset=1060604
        local.get 0
        br_if 0 (;@2;)
        i32.const 0
        i64.const 0
        i64.store offset=1060576
        i32.const 0
        i32.const 0
        i32.store8 offset=1060588
      end
      i32.const 0
      i32.const 3
      i32.store8 offset=1060574
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
        i64.load offset=1060672
        local.tee 6
        i64.const 0
        i64.ne
        br_if 0 (;@2;)
        i32.const 0
        i64.load offset=1060680
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
          i64.load offset=1060680
          local.tee 8
          local.get 8
          local.get 7
          i64.eq
          local.tee 9
          select
          i64.store offset=1060680
          local.get 8
          local.set 7
          local.get 9
          i32.eqz
          br_if 0 (;@3;)
        end
        i32.const 0
        local.get 6
        i64.store offset=1060672
      end
      i32.const 0
      local.get 6
      i64.store offset=1060688
      local.get 0
      local.get 1
      i32.load offset=20
      call_indirect (type 2)
      local.set 9
      block  ;; label = @2
        i32.const 0
        i32.load8_u offset=1060574
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
  (func $_ZN3std6thread8ThreadId3new9exhausted17h79591ad025c79bdcE (type 11)
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
    i32.const 1049660
    i32.store offset=8
    local.get 0
    i64.const 4
    i64.store offset=16 align=4
    local.get 0
    i32.const 8
    i32.add
    i32.const 1049668
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
          i32.const 1049396
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
          i32.const 1051144
          i32.store offset=24
          local.get 3
          i64.const 4
          i64.store offset=32 align=4
          local.get 3
          i32.const 24
          i32.add
          i32.const 1051152
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
          call_indirect (type 0)
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
  (func $_ZN3std3sys3pal4wasi7helpers14abort_internal17he7a2be67736436b7E (type 11)
    call $abort
    unreachable)
  (func $_ZN3std3env11current_dir17h4dd17025e6a63360E (type 0) (param i32)
    (local i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    i32.const 0
    i32.load8_u offset=1060573
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
                i32.load offset=1061208
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
      i32.const 1053232
      call $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E
      unreachable
    end
    i32.const 1
    local.get 4
    i32.const 1053248
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
            i64.load offset=1051736
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
            i32.load8_u offset=1060573
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
            call_indirect (type 0)
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
    i32.const 1049520
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
              i32.load8_u offset=1060573
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
        i64.load offset=1051736
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
    i32.const 1049520
    call $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E
    unreachable)
  (func $_ZN3std3sys2fs4wasi4File4open17h2ad5fb3abcd3d53dE (type 6) (param i32 i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 416
    i32.sub
    local.tee 4
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 2
        i32.const 383
        i32.gt_u
        br_if 0 (;@2;)
        block  ;; label = @3
          local.get 2
          i32.eqz
          br_if 0 (;@3;)
          local.get 4
          i32.const 20
          i32.add
          local.get 1
          local.get 2
          memory.copy
        end
        local.get 4
        i32.const 20
        i32.add
        local.get 2
        i32.add
        i32.const 0
        i32.store8
        local.get 4
        i32.const 404
        i32.add
        local.get 4
        i32.const 20
        i32.add
        local.get 2
        i32.const 1
        i32.add
        call $_ZN4core3ffi5c_str4CStr19from_bytes_with_nul17h21af397fb9054b6dE
        block  ;; label = @3
          local.get 4
          i32.load offset=404
          i32.const 1
          i32.ne
          br_if 0 (;@3;)
          local.get 4
          i32.const -2147483648
          i32.store offset=8
          local.get 4
          i32.const 0
          i64.load offset=1051736
          i64.store offset=12 align=4
          br 2 (;@1;)
        end
        local.get 4
        i32.const 4
        i32.add
        local.get 4
        local.get 4
        i32.load offset=408
        local.get 4
        i32.load offset=412
        call $_ZN3std3sys2fs4wasi11open_parent28_$u7b$$u7b$closure$u7d$$u7d$17hd7919abf9550c15bE
        br 1 (;@1;)
      end
      local.get 4
      i32.const 4
      i32.add
      local.get 1
      local.get 2
      call $_ZN3std3sys3pal6common14small_c_string24run_with_cstr_allocating17h911641b6fbcdb6f9E
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 4
        i32.load offset=8
        local.tee 2
        i32.const -2147483648
        i32.ne
        br_if 0 (;@2;)
        local.get 0
        local.get 4
        i64.load offset=12 align=4
        i64.store align=4
        br 1 (;@1;)
      end
      local.get 0
      local.get 4
      i32.load offset=4
      local.get 4
      i32.load offset=12
      local.tee 1
      local.get 4
      i32.load offset=16
      local.get 3
      call $_ZN3std3sys2fs4wasi7open_at17he0bf6f9ea5d45c95E
      local.get 2
      i32.eqz
      br_if 0 (;@1;)
      local.get 1
      local.get 2
      i32.const 1
      call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
    end
    local.get 4
    i32.const 416
    i32.add
    global.set $__stack_pointer)
  (func $_ZN3std2io5error82_$LT$impl$u20$core..fmt..Debug$u20$for$u20$std..io..error..repr_unpacked..Repr$GT$3fmt17ha582a79c9893e455E (type 1) (param i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 32
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
            i32.store offset=4
            local.get 2
            i32.const 8
            i32.add
            local.get 1
            i32.const 1050725
            i32.const 2
            call $_ZN4core3fmt9Formatter12debug_struct17h8b04cc0c27469750E
            local.get 2
            i32.const 8
            i32.add
            i32.const 1050744
            i32.const 4
            local.get 2
            i32.const 4
            i32.add
            i32.const 1050728
            call $_ZN4core3fmt8builders11DebugStruct5field17h13f66060f544090dE
            local.set 0
            local.get 2
            local.get 2
            i32.load offset=4
            call $_ZN3std3sys3pal4wasi7helpers17decode_error_kind17h50ffa1e41d3f7d36E
            i32.const 255
            i32.and
            i32.store8 offset=19
            local.get 0
            i32.const 1050764
            i32.const 4
            local.get 2
            i32.const 19
            i32.add
            i32.const 1050748
            call $_ZN4core3fmt8builders11DebugStruct5field17h13f66060f544090dE
            local.set 0
            local.get 2
            i32.const 20
            i32.add
            local.get 2
            i32.load offset=4
            call $_ZN3std3sys3pal4wasi2os12error_string17h5dc9a2a2e621b569E
            local.get 0
            i32.const 1050784
            i32.const 7
            local.get 2
            i32.const 20
            i32.add
            i32.const 1050768
            call $_ZN4core3fmt8builders11DebugStruct5field17h13f66060f544090dE
            call $_ZN4core3fmt8builders11DebugStruct6finish17h9c0eaac50360f7e7E
            local.set 0
            local.get 2
            i32.load offset=20
            local.tee 1
            i32.eqz
            br_if 3 (;@1;)
            local.get 2
            i32.load offset=24
            local.get 1
            i32.const 1
            call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
            br 3 (;@1;)
          end
          local.get 2
          local.get 0
          i32.load8_u offset=1
          i32.store8 offset=8
          local.get 2
          i32.const 20
          i32.add
          local.get 1
          i32.const 1050791
          i32.const 4
          call $_ZN4core3fmt9Formatter11debug_tuple17h3f925525b32910b2E
          local.get 2
          i32.const 20
          i32.add
          local.get 2
          i32.const 8
          i32.add
          i32.const 1050748
          call $_ZN4core3fmt8builders10DebugTuple5field17h637fae3119e1c9c0E
          call $_ZN4core3fmt8builders10DebugTuple6finish17hd2824a8dc5a513d2E
          local.set 0
          br 2 (;@1;)
        end
        local.get 0
        i32.load offset=4
        local.set 0
        local.get 2
        i32.const 20
        i32.add
        local.get 1
        i32.const 1050795
        i32.const 5
        call $_ZN4core3fmt9Formatter12debug_struct17h8b04cc0c27469750E
        local.get 2
        i32.const 20
        i32.add
        i32.const 1050764
        i32.const 4
        local.get 0
        i32.const 8
        i32.add
        i32.const 1050748
        call $_ZN4core3fmt8builders11DebugStruct5field17h13f66060f544090dE
        i32.const 1050784
        i32.const 7
        local.get 0
        i32.const 1050800
        call $_ZN4core3fmt8builders11DebugStruct5field17h13f66060f544090dE
        call $_ZN4core3fmt8builders11DebugStruct6finish17h9c0eaac50360f7e7E
        local.set 0
        br 1 (;@1;)
      end
      local.get 2
      local.get 0
      i32.load offset=4
      local.tee 0
      i32.store offset=20
      local.get 1
      i32.const 1050832
      i32.const 6
      i32.const 1050764
      i32.const 4
      local.get 0
      i32.const 8
      i32.add
      i32.const 1050748
      i32.const 1050838
      i32.const 5
      local.get 2
      i32.const 20
      i32.add
      i32.const 1050816
      call $_ZN4core3fmt9Formatter26debug_struct_field2_finish17h05c90c1de6f82831E
      local.set 0
    end
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN75_$LT$std..fs..ReadDir$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h30a3e49108035e3eE (type 3) (param i32 i32)
    (local i32 i64 i64)
    global.get $__stack_pointer
    i32.const 64
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    local.get 1
    call $_ZN86_$LT$std..sys..fs..wasi..ReadDir$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h4fd3e362ceef1daaE
    block  ;; label = @1
      block  ;; label = @2
        local.get 2
        i32.load offset=28
        local.tee 1
        i32.const -2147483647
        i32.eq
        br_if 0 (;@2;)
        local.get 2
        i64.load
        local.set 3
        block  ;; label = @3
          local.get 1
          i32.const -2147483648
          i32.eq
          br_if 0 (;@3;)
          local.get 2
          i64.load offset=32
          local.set 4
          local.get 2
          i32.const 40
          i32.add
          i32.const 16
          i32.add
          local.get 2
          i32.const 24
          i32.add
          i32.load
          i32.store
          local.get 2
          i32.const 48
          i32.add
          local.get 2
          i32.const 16
          i32.add
          i64.load
          i64.store
          local.get 2
          local.get 2
          i64.load offset=8
          i64.store offset=40
        end
        local.get 0
        local.get 3
        i64.store
        local.get 0
        local.get 2
        i64.load offset=40
        i64.store offset=8
        local.get 0
        local.get 4
        i64.store offset=32
        local.get 0
        local.get 1
        i32.store offset=28
        local.get 0
        i32.const 16
        i32.add
        local.get 2
        i32.const 48
        i32.add
        i64.load
        i64.store
        local.get 0
        i32.const 24
        i32.add
        local.get 2
        i32.const 40
        i32.add
        i32.const 16
        i32.add
        i32.load
        i32.store
        br 1 (;@1;)
      end
      local.get 0
      i32.const -2147483647
      i32.store offset=28
    end
    local.get 2
    i32.const 64
    i32.add
    global.set $__stack_pointer)
  (func $_ZN86_$LT$std..sys..fs..wasi..ReadDir$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17h4fd3e362ceef1daaE (type 3) (param i32 i32)
    (local i32 i32 i32 i64 i64 i32 i32 i32 i32 i32 i64)
    global.get $__stack_pointer
    i32.const 64
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 1
    i32.const 16
    i32.add
    local.set 3
    local.get 1
    i32.const 8
    i32.add
    local.set 4
    local.get 1
    i64.load
    local.set 5
    loop  ;; label = @1
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
                              block  ;; label = @14
                                block  ;; label = @15
                                  block  ;; label = @16
                                    block  ;; label = @17
                                      block  ;; label = @18
                                        block  ;; label = @19
                                          block  ;; label = @20
                                            block  ;; label = @21
                                              local.get 5
                                              i64.const -2
                                              i64.add
                                              local.tee 6
                                              i32.wrap_i64
                                              i32.const 1
                                              local.get 6
                                              i64.const 4
                                              i64.lt_u
                                              select
                                              br_table 0 (;@21;) 1 (;@20;) 7 (;@14;) 4 (;@17;) 0 (;@21;)
                                            end
                                            local.get 2
                                            i32.const 16
                                            i32.add
                                            local.get 1
                                            i32.load offset=32
                                            i32.load offset=20
                                            local.get 1
                                            i32.load offset=20
                                            local.get 1
                                            i32.load offset=24
                                            local.tee 7
                                            local.get 1
                                            i64.load offset=8
                                            local.tee 5
                                            call $_ZN4wasi13lib_generated10fd_readdir17hf832bfb1915260f1E
                                            local.get 2
                                            i32.load16_u offset=16
                                            br_if 1 (;@19;)
                                            local.get 5
                                            i64.const 32
                                            i64.shr_u
                                            i32.wrap_i64
                                            local.set 8
                                            local.get 5
                                            i32.wrap_i64
                                            local.set 9
                                            local.get 2
                                            i32.load offset=20
                                            local.tee 10
                                            local.get 7
                                            i32.lt_u
                                            br_if 2 (;@18;)
                                            local.get 2
                                            i32.const 16
                                            i32.add
                                            i32.const 8
                                            i32.add
                                            local.tee 7
                                            local.get 3
                                            i32.const 8
                                            i32.add
                                            local.tee 10
                                            i32.load
                                            i32.store
                                            local.get 2
                                            local.get 3
                                            i64.load
                                            i64.store offset=16
                                            block  ;; label = @21
                                              local.get 6
                                              i64.const 2
                                              i64.ne
                                              br_if 0 (;@21;)
                                              local.get 9
                                              i32.eqz
                                              br_if 0 (;@21;)
                                              local.get 8
                                              local.get 9
                                              i32.const 1
                                              call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
                                            end
                                            local.get 1
                                            local.get 5
                                            i64.store offset=8
                                            i64.const 1
                                            local.set 5
                                            local.get 1
                                            i64.const 1
                                            i64.store
                                            local.get 3
                                            local.get 2
                                            i64.load offset=16
                                            i64.store
                                            local.get 1
                                            i32.const 0
                                            i32.store offset=28
                                            local.get 10
                                            local.get 7
                                            i32.load
                                            i32.store
                                            br 19 (;@1;)
                                          end
                                          local.get 1
                                          i32.load offset=24
                                          local.tee 9
                                          local.get 1
                                          i32.load offset=28
                                          local.tee 7
                                          i32.lt_u
                                          br_if 6 (;@13;)
                                          local.get 9
                                          local.get 7
                                          i32.sub
                                          local.tee 8
                                          i32.const 23
                                          i32.gt_u
                                          br_if 4 (;@15;)
                                          local.get 5
                                          i32.wrap_i64
                                          i32.const 1
                                          i32.and
                                          i32.eqz
                                          br_if 3 (;@16;)
                                          local.get 1
                                          local.get 1
                                          i64.load offset=8
                                          i64.store offset=8
                                          br 17 (;@2;)
                                        end
                                        local.get 2
                                        i64.load16_u offset=18
                                        i64.const 32
                                        i64.shl
                                        local.set 6
                                        local.get 3
                                        i32.load
                                        local.tee 3
                                        br_if 13 (;@5;)
                                        br 14 (;@4;)
                                      end
                                      local.get 1
                                      local.get 10
                                      i32.store offset=24
                                      local.get 2
                                      i32.const 16
                                      i32.add
                                      i32.const 8
                                      i32.add
                                      local.tee 7
                                      local.get 3
                                      i32.const 8
                                      i32.add
                                      i32.load
                                      i32.store
                                      local.get 1
                                      i32.const 0
                                      i32.store offset=24
                                      local.get 2
                                      local.get 3
                                      i64.load
                                      i64.store offset=16
                                      block  ;; label = @18
                                        local.get 6
                                        i64.const 2
                                        i64.ne
                                        br_if 0 (;@18;)
                                        local.get 9
                                        i32.eqz
                                        br_if 0 (;@18;)
                                        local.get 8
                                        local.get 9
                                        i32.const 1
                                        call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
                                      end
                                      i64.const 4
                                      local.set 5
                                      local.get 1
                                      i64.const 4
                                      i64.store
                                      local.get 4
                                      local.get 2
                                      i64.load offset=16
                                      i64.store
                                      local.get 1
                                      i32.const 0
                                      i32.store offset=20
                                      local.get 4
                                      i32.const 8
                                      i32.add
                                      local.get 7
                                      i32.load
                                      i32.store
                                      br 16 (;@1;)
                                    end
                                    local.get 0
                                    i32.const -2147483647
                                    i32.store offset=28
                                    br 13 (;@3;)
                                  end
                                  local.get 3
                                  i32.load
                                  local.tee 9
                                  br_if 8 (;@7;)
                                  br 9 (;@6;)
                                end
                                block  ;; label = @15
                                  block  ;; label = @16
                                    block  ;; label = @17
                                      block  ;; label = @18
                                        block  ;; label = @19
                                          local.get 8
                                          i32.const -24
                                          i32.add
                                          local.get 1
                                          i32.load offset=20
                                          local.tee 11
                                          local.get 7
                                          i32.add
                                          local.tee 8
                                          i32.load offset=16 align=1
                                          local.tee 10
                                          i32.lt_u
                                          br_if 0 (;@19;)
                                          local.get 8
                                          i64.load align=1
                                          local.set 6
                                          block  ;; label = @20
                                            local.get 5
                                            i32.wrap_i64
                                            i32.const 1
                                            i32.and
                                            i32.eqz
                                            br_if 0 (;@20;)
                                            local.get 4
                                            local.get 6
                                            i64.store
                                          end
                                          local.get 8
                                          i32.const 24
                                          i32.add
                                          local.set 9
                                          local.get 8
                                          i32.load offset=20 align=1
                                          local.set 11
                                          local.get 8
                                          i64.load offset=8 align=1
                                          local.set 12
                                          local.get 1
                                          local.get 7
                                          local.get 10
                                          i32.add
                                          i32.const 24
                                          i32.add
                                          i32.store offset=28
                                          local.get 10
                                          i32.const -1
                                          i32.add
                                          br_table 1 (;@18;) 2 (;@17;) 3 (;@16;)
                                        end
                                        block  ;; label = @19
                                          local.get 10
                                          i32.const 24
                                          i32.add
                                          local.tee 7
                                          local.get 9
                                          i32.le_u
                                          br_if 0 (;@19;)
                                          block  ;; label = @20
                                            local.get 7
                                            local.get 9
                                            i32.sub
                                            local.tee 8
                                            local.get 3
                                            i32.load
                                            local.get 9
                                            i32.sub
                                            i32.le_u
                                            br_if 0 (;@20;)
                                            local.get 3
                                            local.get 9
                                            local.get 8
                                            i32.const 1
                                            i32.const 1
                                            call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hf4e8ee5cbddfee98E
                                            local.get 1
                                            i32.load offset=20
                                            local.set 11
                                            local.get 1
                                            i32.load offset=24
                                            local.set 9
                                          end
                                          local.get 11
                                          local.get 9
                                          i32.add
                                          local.set 7
                                          block  ;; label = @20
                                            local.get 8
                                            i32.const 2
                                            i32.lt_u
                                            br_if 0 (;@20;)
                                            block  ;; label = @21
                                              local.get 8
                                              i32.const -1
                                              i32.add
                                              local.tee 8
                                              i32.eqz
                                              br_if 0 (;@21;)
                                              local.get 7
                                              i32.const 0
                                              local.get 8
                                              memory.fill
                                            end
                                            local.get 11
                                            local.get 9
                                            local.get 8
                                            i32.add
                                            local.tee 9
                                            i32.add
                                            local.set 7
                                          end
                                          local.get 7
                                          i32.const 0
                                          i32.store8
                                          local.get 1
                                          local.get 9
                                          i32.const 1
                                          i32.add
                                          i32.store offset=24
                                          local.get 1
                                          i64.load
                                          local.set 5
                                        end
                                        local.get 5
                                        i32.wrap_i64
                                        i32.const 1
                                        i32.and
                                        i32.eqz
                                        br_if 3 (;@15;)
                                        local.get 1
                                        local.get 1
                                        i64.load offset=8
                                        i64.store offset=8
                                        br 16 (;@2;)
                                      end
                                      local.get 9
                                      i32.load8_u
                                      i32.const 46
                                      i32.eq
                                      br_if 16 (;@1;)
                                      br 6 (;@11;)
                                    end
                                    local.get 9
                                    i32.load16_u align=1
                                    i32.const 11822
                                    i32.eq
                                    br_if 15 (;@1;)
                                    i32.const 2
                                    local.set 10
                                    local.get 2
                                    i32.const 16
                                    i32.add
                                    local.get 9
                                    i32.const 2
                                    call $_ZN87_$LT$T$u20$as$u20$alloc..slice..$LT$impl$u20$$u5b$T$u5d$$GT$..to_vec_in..ConvertVec$GT$6to_vec17h5e07232602c21a66E
                                    br 8 (;@8;)
                                  end
                                  i32.const 0
                                  local.set 7
                                  local.get 10
                                  i32.const 0
                                  i32.lt_s
                                  br_if 5 (;@10;)
                                  local.get 10
                                  br_if 4 (;@11;)
                                  i32.const 1
                                  local.set 3
                                  i32.const 0
                                  local.set 10
                                  br 6 (;@9;)
                                end
                                local.get 3
                                i32.load
                                local.tee 9
                                i32.eqz
                                br_if 8 (;@6;)
                                local.get 11
                                local.get 9
                                i32.const 1
                                call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
                                br 8 (;@6;)
                              end
                              local.get 1
                              i32.load offset=20
                              local.tee 9
                              local.get 1
                              i32.load offset=16
                              i32.lt_u
                              br_if 1 (;@12;)
                              local.get 4
                              i32.load
                              local.tee 9
                              i32.eqz
                              br_if 7 (;@6;)
                              local.get 1
                              i32.load offset=12
                              local.get 9
                              i32.const 1
                              call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
                              br 7 (;@6;)
                            end
                            local.get 7
                            local.get 9
                            i32.const 1053360
                            call $_ZN4core5slice5index26slice_start_index_len_fail17hcb91b9a11352b54bE
                            unreachable
                          end
                          i64.const 0
                          local.set 5
                          local.get 1
                          i64.const 0
                          i64.store
                          local.get 1
                          local.get 9
                          i32.store offset=28
                          local.get 4
                          i32.const 8
                          i32.add
                          i32.load
                          local.set 9
                          local.get 4
                          i64.load
                          local.set 6
                          local.get 1
                          i64.const 4294967296
                          i64.store offset=8
                          local.get 3
                          local.get 6
                          i64.store
                          local.get 3
                          i32.const 8
                          i32.add
                          local.get 9
                          i32.store
                          br 10 (;@1;)
                        end
                        i32.const 0
                        i32.load8_u offset=1060573
                        drop
                        i32.const 1
                        local.set 7
                        local.get 10
                        i32.const 1
                        call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
                        local.tee 3
                        br_if 1 (;@9;)
                      end
                      local.get 7
                      local.get 10
                      i32.const 1049520
                      call $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E
                      unreachable
                    end
                    block  ;; label = @9
                      local.get 10
                      i32.eqz
                      br_if 0 (;@9;)
                      local.get 3
                      local.get 9
                      local.get 10
                      memory.copy
                    end
                    local.get 2
                    local.get 10
                    i32.store offset=24
                    local.get 2
                    local.get 3
                    i32.store offset=20
                    local.get 2
                    local.get 10
                    i32.store offset=16
                  end
                  local.get 1
                  i32.load offset=32
                  local.tee 1
                  local.get 1
                  i32.load
                  local.tee 3
                  i32.const 1
                  i32.add
                  i32.store
                  block  ;; label = @8
                    local.get 3
                    i32.const 0
                    i32.lt_s
                    br_if 0 (;@8;)
                    local.get 0
                    local.get 2
                    i64.load offset=16 align=4
                    i64.store offset=28 align=4
                    local.get 0
                    i32.const 36
                    i32.add
                    local.get 2
                    i32.const 24
                    i32.add
                    i32.load
                    i32.store
                    local.get 0
                    local.get 1
                    i32.store offset=24
                    local.get 0
                    local.get 11
                    i32.store offset=20
                    local.get 0
                    local.get 10
                    i32.store offset=16
                    local.get 0
                    local.get 12
                    i64.store offset=8
                    local.get 0
                    local.get 6
                    i64.store
                    br 5 (;@3;)
                  end
                  unreachable
                end
                local.get 1
                i32.load offset=20
                local.get 9
                i32.const 1
                call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
              end
              i64.const 5
              local.set 5
              local.get 1
              i64.const 5
              i64.store
              br 4 (;@1;)
            end
            local.get 1
            i32.load offset=20
            local.get 3
            i32.const 1
            call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
          end
          local.get 0
          i32.const -2147483648
          i32.store offset=28
          local.get 0
          local.get 6
          i64.store
          local.get 1
          i64.const 5
          i64.store
        end
        local.get 2
        i32.const 64
        i32.add
        global.set $__stack_pointer
        return
      end
      i64.const 2
      local.set 5
      local.get 1
      i64.const 2
      i64.store
      br 0 (;@1;)
    end)
  (func $_ZN3std2fs8DirEntry4path17he02e7629e32bb8a6E (type 3) (param i32 i32)
    (local i32)
    local.get 0
    local.get 1
    i32.load offset=24
    local.tee 2
    i32.load offset=12
    local.get 2
    i32.load offset=16
    local.get 1
    i32.load offset=32
    local.get 1
    i32.load offset=36
    call $_ZN3std4path4Path5_join17h485a8b158d1d1134E)
  (func $_ZN3std4path4Path5_join17h485a8b158d1d1134E (type 13) (param i32 i32 i32 i32 i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    i32.const 0
    local.set 6
    block  ;; label = @1
      local.get 2
      i32.const 0
      i32.lt_s
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          local.get 2
          br_if 0 (;@3;)
          i32.const 1
          local.set 7
          br 1 (;@2;)
        end
        i32.const 0
        i32.load8_u offset=1060573
        drop
        i32.const 1
        local.set 6
        local.get 2
        i32.const 1
        call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
        local.tee 7
        i32.eqz
        br_if 1 (;@1;)
      end
      block  ;; label = @2
        local.get 2
        i32.eqz
        br_if 0 (;@2;)
        local.get 7
        local.get 1
        local.get 2
        memory.copy
      end
      local.get 5
      local.get 2
      i32.store offset=12
      local.get 5
      local.get 7
      i32.store offset=8
      local.get 5
      local.get 2
      i32.store offset=4
      i32.const 0
      local.set 1
      block  ;; label = @2
        local.get 2
        i32.eqz
        br_if 0 (;@2;)
        local.get 7
        local.get 2
        i32.add
        i32.const -1
        i32.add
        local.tee 6
        i32.eqz
        br_if 0 (;@2;)
        local.get 6
        i32.load8_u
        i32.const 47
        i32.ne
        local.set 1
      end
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            local.get 4
            i32.eqz
            br_if 0 (;@4;)
            i32.const 0
            local.set 6
            local.get 3
            i32.load8_u
            i32.const 47
            i32.eq
            br_if 1 (;@3;)
          end
          block  ;; label = @4
            local.get 1
            br_if 0 (;@4;)
            local.get 2
            local.set 6
            br 2 (;@2;)
          end
          local.get 5
          i32.const 4
          i32.add
          local.get 2
          i32.const 1
          i32.const 1
          i32.const 1
          call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hf4e8ee5cbddfee98E
          local.get 5
          i32.load offset=8
          local.tee 7
          local.get 5
          i32.load offset=12
          local.tee 2
          i32.add
          i32.const 47
          i32.store8
          local.get 2
          i32.const 1
          i32.add
          local.set 6
          local.get 5
          i32.load offset=4
          local.set 2
        end
        local.get 5
        local.get 6
        i32.store offset=12
      end
      block  ;; label = @2
        local.get 4
        local.get 2
        local.get 6
        i32.sub
        i32.le_u
        br_if 0 (;@2;)
        local.get 5
        i32.const 4
        i32.add
        local.get 6
        local.get 4
        i32.const 1
        i32.const 1
        call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hf4e8ee5cbddfee98E
        local.get 5
        i32.load offset=8
        local.set 7
        local.get 5
        i32.load offset=12
        local.set 6
      end
      block  ;; label = @2
        local.get 4
        i32.eqz
        br_if 0 (;@2;)
        local.get 7
        local.get 6
        i32.add
        local.get 3
        local.get 4
        memory.copy
      end
      local.get 0
      i32.const 8
      i32.add
      local.get 6
      local.get 4
      i32.add
      i32.store
      local.get 0
      local.get 5
      i64.load offset=4 align=4
      i64.store align=4
      local.get 5
      i32.const 16
      i32.add
      global.set $__stack_pointer
      return
    end
    local.get 6
    local.get 2
    i32.const 1049520
    call $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E
    unreachable)
  (func $_ZN3std3sys3pal4wasi7helpers17decode_error_kind17h50ffa1e41d3f7d36E (type 2) (param i32) (result i32)
    (local i32)
    i32.const 41
    local.set 1
    block  ;; label = @1
      local.get 0
      i32.const 65535
      i32.gt_u
      br_if 0 (;@1;)
      local.get 0
      i32.const -1
      i32.add
      local.tee 0
      i32.const 65535
      i32.and
      i32.const 75
      i32.gt_u
      br_if 0 (;@1;)
      local.get 0
      i32.const 65535
      i32.and
      i32.const 1054344
      i32.add
      i32.load8_u
      local.set 1
    end
    local.get 1)
  (func $_ZN3std3sys2fs8metadata17h0182fd3b7e770833E (type 4) (param i32 i32 i32)
    (local i32 i64 i32 i32)
    global.get $__stack_pointer
    i32.const 416
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 2
        i32.const 383
        i32.gt_u
        br_if 0 (;@2;)
        block  ;; label = @3
          local.get 2
          i32.eqz
          br_if 0 (;@3;)
          local.get 3
          i32.const 16
          i32.add
          local.get 1
          local.get 2
          memory.copy
        end
        local.get 3
        i32.const 16
        i32.add
        local.get 2
        i32.add
        i32.const 0
        i32.store8
        local.get 3
        i32.const 404
        i32.add
        local.get 3
        i32.const 16
        i32.add
        local.get 2
        i32.const 1
        i32.add
        call $_ZN4core3ffi5c_str4CStr19from_bytes_with_nul17h21af397fb9054b6dE
        block  ;; label = @3
          local.get 3
          i32.load offset=404
          i32.const 1
          i32.ne
          br_if 0 (;@3;)
          local.get 3
          i32.const -2147483648
          i32.store offset=4
          local.get 3
          i32.const 0
          i64.load offset=1051736
          i64.store offset=8 align=4
          br 2 (;@1;)
        end
        local.get 3
        local.get 3
        local.get 3
        i32.load offset=408
        local.get 3
        i32.load offset=412
        call $_ZN3std3sys2fs4wasi11open_parent28_$u7b$$u7b$closure$u7d$$u7d$17hd7919abf9550c15bE
        br 1 (;@1;)
      end
      local.get 3
      local.get 1
      local.get 2
      call $_ZN3std3sys3pal6common14small_c_string24run_with_cstr_allocating17h911641b6fbcdb6f9E
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 3
        i32.load offset=4
        local.tee 2
        i32.const -2147483648
        i32.ne
        br_if 0 (;@2;)
        local.get 3
        i64.load offset=8 align=4
        local.set 4
        local.get 0
        i32.const 1
        i32.store
        local.get 0
        local.get 4
        i64.store offset=4 align=4
        br 1 (;@1;)
      end
      local.get 3
      i32.load
      local.set 5
      local.get 3
      i32.const 16
      i32.add
      local.get 3
      i32.load offset=8
      local.tee 6
      local.get 3
      i32.load offset=12
      call $_ZN4core3str8converts9from_utf817hb5c7d3e2ee61e867E
      i32.const 1
      local.set 1
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          i32.load offset=16
          i32.const 1
          i32.ne
          br_if 0 (;@3;)
          local.get 0
          i32.const 1051384
          i32.store offset=8
          local.get 0
          i32.const 2
          i32.store offset=4
          br 1 (;@2;)
        end
        local.get 3
        i32.const 16
        i32.add
        local.get 5
        i32.const 1
        local.get 3
        i32.load offset=20
        local.get 3
        i32.load offset=24
        call $_ZN4wasi13lib_generated17path_filestat_get17h52d9dede891736b6E
        block  ;; label = @3
          local.get 3
          i32.load16_u offset=16
          i32.const 1
          i32.ne
          br_if 0 (;@3;)
          local.get 0
          local.get 3
          i64.load16_u offset=18
          i64.const 32
          i64.shl
          i64.store offset=4 align=4
          i32.const 1
          local.set 1
          br 1 (;@2;)
        end
        local.get 0
        local.get 3
        i64.load offset=28 align=4
        i64.store offset=12 align=4
        local.get 0
        i32.const 20
        i32.add
        local.get 3
        i32.const 16
        i32.add
        i32.const 20
        i32.add
        i64.load align=4
        i64.store align=4
        local.get 0
        i32.const 28
        i32.add
        local.get 3
        i32.const 16
        i32.add
        i32.const 28
        i32.add
        i64.load align=4
        i64.store align=4
        local.get 0
        i32.const 36
        i32.add
        local.get 3
        i32.const 16
        i32.add
        i32.const 36
        i32.add
        i64.load align=4
        i64.store align=4
        local.get 0
        i32.const 44
        i32.add
        local.get 3
        i32.const 16
        i32.add
        i32.const 44
        i32.add
        i64.load align=4
        i64.store align=4
        local.get 0
        i32.const 52
        i32.add
        local.get 3
        i32.const 16
        i32.add
        i32.const 52
        i32.add
        i64.load align=4
        i64.store align=4
        local.get 0
        i32.const 60
        i32.add
        local.get 3
        i32.const 16
        i32.add
        i32.const 60
        i32.add
        i64.load align=4
        i64.store align=4
        local.get 0
        i32.const 68
        i32.add
        local.get 3
        i32.const 16
        i32.add
        i32.const 68
        i32.add
        i32.load
        i32.store
        local.get 0
        local.get 3
        i32.load offset=24
        i32.store offset=8
        i32.const 0
        local.set 1
      end
      local.get 0
      local.get 1
      i32.store
      local.get 2
      i32.eqz
      br_if 0 (;@1;)
      local.get 6
      local.get 2
      i32.const 1
      call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
    end
    local.get 3
    i32.const 416
    i32.add
    global.set $__stack_pointer)
  (func $_ZN3std2io8buffered9bufwriter18BufWriter$LT$W$GT$14write_all_cold17hbec3c57489ed568fE (type 6) (param i32 i32 i32 i32)
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
                    i32.const 1049788
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
                          i64.load offset=1049968
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
      i32.const 1049032
      call $_ZN4core5slice5index24slice_end_index_len_fail17hc7943372990115c8E
      unreachable
    end
    local.get 8
    local.get 3
    i32.const 1051348
    call $_ZN4core5slice5index26slice_start_index_len_fail17hcb91b9a11352b54bE
    unreachable)
  (func $_ZN58_$LT$std..io..error..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h1f889c652801a153E (type 1) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    call $_ZN3std2io5error82_$LT$impl$u20$core..fmt..Debug$u20$for$u20$std..io..error..repr_unpacked..Repr$GT$3fmt17ha582a79c9893e455E)
  (func $_ZN3std2io5error5Error3new17he87ce80ffc6f791bE (type 4) (param i32 i32 i32)
    (local i32)
    i32.const 0
    i32.load8_u offset=1060573
    drop
    block  ;; label = @1
      block  ;; label = @2
        i32.const 12
        i32.const 4
        call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
        local.tee 3
        i32.eqz
        br_if 0 (;@2;)
        local.get 3
        local.get 2
        i64.load align=4
        i64.store align=4
        local.get 3
        i32.const 8
        i32.add
        local.get 2
        i32.const 8
        i32.add
        i32.load
        i32.store
        i32.const 0
        i32.load8_u offset=1060573
        drop
        i32.const 12
        i32.const 4
        call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
        local.tee 2
        i32.eqz
        br_if 1 (;@1;)
        local.get 2
        local.get 1
        i32.store8 offset=8
        local.get 2
        i32.const 1049064
        i32.store offset=4
        local.get 2
        local.get 3
        i32.store
        local.get 0
        local.get 2
        i64.extend_i32_u
        i64.const 32
        i64.shl
        i64.const 3
        i64.or
        i64.store align=4
        return
      end
      i32.const 4
      i32.const 12
      call $_ZN5alloc5alloc18handle_alloc_error17hcc35c2aed22157a6E
      unreachable
    end
    i32.const 4
    i32.const 12
    call $_ZN5alloc5alloc18handle_alloc_error17hcc35c2aed22157a6E
    unreachable)
  (func $_ZN3std3sys3pal4wasi2os12error_string17h5dc9a2a2e621b569E (type 3) (param i32 i32)
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
            i32.load8_u offset=1060573
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
        i32.const 1053208
        i32.store offset=1024
        local.get 2
        i64.const 4
        i64.store offset=1032 align=4
        local.get 2
        i32.const 1024
        i32.add
        i32.const 1053216
        call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
        unreachable
      end
      local.get 2
      local.get 2
      i64.load offset=1028 align=4
      i64.store offset=1048
      i32.const 1049702
      i32.const 43
      local.get 2
      i32.const 1048
      i32.add
      i32.const 1053120
      i32.const 1053172
      call $_ZN4core6result13unwrap_failed17h398ddd55d54bb216E
      unreachable
    end
    local.get 3
    local.get 1
    i32.const 1049520
    call $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E
    unreachable)
  (func $_ZN60_$LT$std..io..error..Error$u20$as$u20$core..fmt..Display$GT$3fmt17h2ced7ae1889d6455E (type 1) (param i32 i32) (result i32)
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
            i32.const 1050856
            i32.store offset=40
            local.get 2
            i64.const 2
            i64.store offset=52 align=4
            local.get 2
            i32.const 20
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
            i32.const 21
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
          i32.const 1049840
          i32.store offset=40
          local.get 2
          i64.const 1
          i64.store offset=52 align=4
          local.get 2
          i32.const 18
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
          i32.const 1053672
          i32.add
          i32.load
          i32.store offset=28
          local.get 2
          local.get 0
          i32.const 1053840
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
      call_indirect (type 1)
      local.set 0
    end
    local.get 2
    i32.const 64
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN60_$LT$std..io..error..Error$u20$as$u20$core..error..Error$GT$11description17hc67db8b1160eacdcE (type 3) (param i32 i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                local.get 1
                i32.load8_u
                br_table 2 (;@4;) 3 (;@3;) 0 (;@6;) 1 (;@5;) 2 (;@4;)
              end
              local.get 1
              i32.load offset=4
              local.tee 3
              i32.load offset=4
              local.set 1
              local.get 3
              i32.load
              local.set 3
              br 4 (;@1;)
            end
            local.get 2
            i32.const 8
            i32.add
            local.get 1
            i32.load offset=4
            local.tee 1
            i32.load
            local.get 1
            i32.load offset=4
            i32.load offset=32
            call_indirect (type 3)
            local.get 2
            i32.load offset=12
            local.set 1
            local.get 2
            i32.load offset=8
            local.set 3
            br 3 (;@1;)
          end
          local.get 1
          i32.load offset=4
          call $_ZN3std3sys3pal4wasi7helpers17decode_error_kind17h50ffa1e41d3f7d36E
          i32.const 255
          i32.and
          local.set 1
          br 1 (;@2;)
        end
        local.get 1
        i32.load8_u offset=1
        local.set 1
      end
      local.get 1
      i32.const 2
      i32.shl
      i32.const 1020
      i32.and
      local.tee 3
      i32.const 1053672
      i32.add
      i32.load
      local.set 1
      local.get 3
      i32.const 1053840
      i32.add
      i32.load
      local.set 3
    end
    local.get 0
    local.get 3
    i32.store
    local.get 0
    local.get 1
    i32.store offset=4
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer)
  (func $_ZN60_$LT$std..io..error..Error$u20$as$u20$core..error..Error$GT$5cause17h3d04d7f6a477ff66E (type 3) (param i32 i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.load8_u
        i32.const 3
        i32.eq
        br_if 0 (;@2;)
        i32.const 0
        local.set 1
        br 1 (;@1;)
      end
      local.get 2
      i32.const 8
      i32.add
      local.get 1
      i32.load offset=4
      local.tee 1
      i32.load
      local.get 1
      i32.load offset=4
      i32.load offset=36
      call_indirect (type 3)
      local.get 2
      i32.load offset=12
      local.set 3
      local.get 2
      i32.load offset=8
      local.set 1
    end
    local.get 0
    local.get 3
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer)
  (func $_ZN60_$LT$std..io..error..Error$u20$as$u20$core..error..Error$GT$6source17h06ddb842e9dc45b6E (type 3) (param i32 i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        i32.load8_u
        i32.const 3
        i32.eq
        br_if 0 (;@2;)
        i32.const 0
        local.set 1
        br 1 (;@1;)
      end
      local.get 2
      i32.const 8
      i32.add
      local.get 1
      i32.load offset=4
      local.tee 1
      i32.load
      local.get 1
      i32.load offset=4
      i32.load offset=24
      call_indirect (type 3)
      local.get 2
      i32.load offset=12
      local.set 3
      local.get 2
      i32.load offset=8
      local.set 1
    end
    local.get 0
    local.get 3
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer)
  (func $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$5write17hb9727852f7c84a6aE (type 6) (param i32 i32 i32 i32)
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
  (func $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$14write_vectored17h0846ae4dacdce16fE (type 6) (param i32 i32 i32 i32)
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
  (func $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$17is_write_vectored17h85ccc55a9e1850d4E (type 2) (param i32) (result i32)
    i32.const 1)
  (func $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$9write_all17h6bed96dfd3f6d961E (type 6) (param i32 i32 i32 i32)
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
  (func $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$18write_all_vectored17ha48943a12795c360E (type 6) (param i32 i32 i32 i32)
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
  (func $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$5flush17h1f2dc7de04349823E (type 3) (param i32 i32)
    local.get 0
    i32.const 4
    i32.store8)
  (func $_ZN3std2io5Write18write_all_vectored17h0a60c130116d5293E (type 6) (param i32 i32 i32 i32)
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
                i64.load offset=1049968
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
                  i32.const 1051224
                  i32.store offset=8
                  local.get 4
                  i64.const 4
                  i64.store offset=16 align=4
                  local.get 4
                  i32.const 8
                  i32.add
                  i32.const 1051232
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
            i32.const 1051168
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
          i32.const 1051284
          i32.store offset=8
          local.get 4
          i64.const 4
          i64.store offset=16 align=4
          local.get 4
          i32.const 8
          i32.add
          i32.const 1051332
          call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
          unreachable
        end
        local.get 8
        local.get 3
        i32.const 1051168
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
  (func $_ZN3std4sync9once_lock17OnceLock$LT$T$GT$10initialize17h815954f386348f6fE (type 11)
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
            i32.load8_u offset=1060616
            br_table 0 (;@4;) 0 (;@4;) 3 (;@1;) 1 (;@3;) 0 (;@4;)
          end
          i32.const 0
          i32.const 2
          i32.store8 offset=1060616
          i32.const 0
          i32.load8_u offset=1060573
          drop
          i32.const 1024
          i32.const 1
          call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
          local.tee 1
          i32.eqz
          br_if 1 (;@2;)
          i32.const 0
          i32.const 3
          i32.store8 offset=1060616
          i32.const 0
          local.get 1
          i32.store offset=1060600
          i32.const 0
          i64.const 4398046511104
          i64.store offset=1060592
          i32.const 0
          i64.const 0
          i64.store offset=1060576
          i32.const 0
          i32.const 0
          i32.store8 offset=1060608
          i32.const 0
          i32.const 0
          i32.store offset=1060604
          i32.const 0
          i32.const 0
          i32.store8 offset=1060588
          i32.const 0
          i32.const 0
          i32.store offset=1060584
        end
        local.get 0
        i32.const 32
        i32.add
        global.set $__stack_pointer
        return
      end
      i32.const 1
      i32.const 1024
      i32.const 1050880
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
    i32.const 1053592
    i32.store offset=8
    local.get 0
    i64.const 4
    i64.store offset=16 align=4
    local.get 0
    i32.const 8
    i32.add
    i32.const 1051572
    call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
    unreachable)
  (func $_ZN3std2io5stdio6Stderr4lock17hec8a0bceb40939a8E (type 2) (param i32) (result i32)
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
        i64.load offset=1060672
        local.tee 3
        i64.const 0
        i64.ne
        br_if 0 (;@2;)
        i32.const 0
        i64.load offset=1060680
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
          i64.load offset=1060680
          local.tee 5
          local.get 5
          local.get 4
          i64.eq
          local.tee 0
          select
          i64.store offset=1060680
          local.get 5
          local.set 4
          local.get 0
          i32.eqz
          br_if 0 (;@3;)
        end
        i32.const 0
        local.get 3
        i64.store offset=1060672
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
            i32.const 1051452
            i32.store offset=8
            i32.const 0
            local.get 1
            i32.const 7
            i32.add
            i32.const 1053668
            local.get 1
            i32.const 8
            i32.add
            i32.const 1051504
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
          i32.const 1051588
          i32.const 38
          i32.const 1051664
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
          i32.const 1049324
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
          i32.const 1051144
          i32.store offset=24
          local.get 3
          i64.const 4
          i64.store offset=32 align=4
          local.get 3
          i32.const 24
          i32.add
          i32.const 1051152
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
          call_indirect (type 0)
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
  (func $_ZN61_$LT$$RF$std..io..stdio..Stderr$u20$as$u20$std..io..Write$GT$9write_fmt17h7f5a1f8128f56346E (type 4) (param i32 i32 i32)
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
          i32.const 1049300
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
          i32.const 1051144
          i32.store offset=24
          local.get 3
          i64.const 4
          i64.store offset=32 align=4
          local.get 3
          i32.const 24
          i32.add
          i32.const 1051152
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
          call_indirect (type 0)
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
  (func $_ZN3std2io5stdio31print_to_buffer_if_capture_used17h2fee8f57ff6b00a0E (type 2) (param i32) (result i32)
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
        i32.load8_u offset=1060575
        i32.eqz
        br_if 0 (;@2;)
        i32.const 0
        local.set 2
        i32.const 0
        i32.load offset=1060704
        local.set 3
        i32.const 0
        i32.const 0
        i32.store offset=1060704
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
            call_indirect (type 0)
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
        i32.load offset=1060704
        local.set 2
        i32.const 0
        local.get 3
        i32.store offset=1060704
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
    i32.const 1051452
    i32.store offset=8
    i32.const 0
    local.get 1
    i32.const 7
    i32.add
    i32.const 1053668
    local.get 1
    i32.const 8
    i32.add
    i32.const 1051504
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
          i32.const 1049372
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
          i32.const 1051144
          i32.store offset=24
          local.get 3
          i64.const 4
          i64.store offset=32 align=4
          local.get 3
          i32.const 24
          i32.add
          i32.const 1051152
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
          call_indirect (type 0)
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
  (func $_ZN3std2io5stdio23attempt_print_to_stderr17h2d57d8c4aeebfc54E (type 0) (param i32)
    (local i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 1
    global.set $__stack_pointer
    block  ;; label = @1
      local.get 0
      call $_ZN3std2io5stdio31print_to_buffer_if_capture_used17h2fee8f57ff6b00a0E
      br_if 0 (;@1;)
      local.get 1
      i32.const 1060624
      i32.store offset=8
      local.get 1
      local.get 1
      i32.const 8
      i32.add
      i32.store offset=12
      local.get 1
      local.get 1
      i32.const 12
      i32.add
      local.get 0
      call $_ZN61_$LT$$RF$std..io..stdio..Stderr$u20$as$u20$std..io..Write$GT$9write_fmt17h7f5a1f8128f56346E
      local.get 1
      i32.load offset=4
      local.set 2
      block  ;; label = @2
        local.get 1
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
      local.get 2
      i32.load
      local.set 3
      block  ;; label = @2
        local.get 2
        i32.const 4
        i32.add
        i32.load
        local.tee 0
        i32.load
        local.tee 4
        i32.eqz
        br_if 0 (;@2;)
        local.get 3
        local.get 4
        call_indirect (type 0)
      end
      block  ;; label = @2
        local.get 0
        i32.load offset=4
        local.tee 4
        i32.eqz
        br_if 0 (;@2;)
        local.get 3
        local.get 4
        local.get 0
        i32.load offset=8
        call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
      end
      local.get 2
      i32.const 12
      i32.const 4
      call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
    end
    local.get 1
    i32.const 16
    i32.add
    global.set $__stack_pointer)
  (func $_ZN3std2io5stdio6_print17h113dc87389378e4fE (type 0) (param i32)
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
    i32.const 1051024
    i32.store offset=8
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        call $_ZN3std2io5stdio31print_to_buffer_if_capture_used17h2fee8f57ff6b00a0E
        br_if 0 (;@2;)
        block  ;; label = @3
          i32.const 0
          i32.load8_u offset=1060616
          i32.const 3
          i32.eq
          br_if 0 (;@3;)
          call $_ZN3std4sync9once_lock17OnceLock$LT$T$GT$10initialize17h815954f386348f6fE
        end
        local.get 1
        i32.const 1060576
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
    i32.const 1050992
    i32.store offset=40
    local.get 1
    i64.const 2
    i64.store offset=52 align=4
    local.get 1
    i32.const 11
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
    i32.const 18
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
    i32.const 1051008
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
  (func $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17hc4a5943773967867E (type 5) (param i32 i32 i32) (result i32)
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
    call $_ZN61_$LT$std..io..stdio..StderrLock$u20$as$u20$std..io..Write$GT$9write_all17h1f6036d6c3650e60E
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
          call_indirect (type 0)
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
      i64.load offset=1049968
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
          call_indirect (type 0)
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
          call_indirect (type 0)
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
  (func $_ZN3std2io5Write9write_all17h55293c4c3ff1edf7E (type 6) (param i32 i32 i32 i32)
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
                i64.load offset=1049968
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
    i32.const 1051348
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
          i32.const 1049348
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
          i32.const 1051144
          i32.store offset=24
          local.get 3
          i64.const 4
          i64.store offset=32 align=4
          local.get 3
          i32.const 24
          i32.add
          i32.const 1051152
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
          call_indirect (type 0)
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
  (func $_ZN3std5panic19get_backtrace_style17h7d01952034be105fE (type 12) (result i32)
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
      i32.load8_u offset=1060648
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
      i32.const 1049688
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
      i32.load8_u offset=1060648
      local.tee 3
      local.get 1
      local.get 3
      select
      i32.store8 offset=1060648
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
  (func $_ZN3std7process5abort17hb229e5783e2ded8dE (type 11)
    call $_ZN3std3sys3pal4wasi7helpers14abort_internal17he7a2be67736436b7E
    unreachable)
  (func $_ZN3std4sync9once_lock17OnceLock$LT$T$GT$10initialize17h1e4f1579a1ad7072E (type 0) (param i32)
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
          i32.load8_u offset=1060616
          br_table 1 (;@2;) 1 (;@2;) 0 (;@3;) 2 (;@1;) 1 (;@2;)
        end
        local.get 1
        i32.const 0
        i32.store offset=24
        local.get 1
        i32.const 1
        i32.store offset=12
        local.get 1
        i32.const 1053592
        i32.store offset=8
        local.get 1
        i64.const 4
        i64.store offset=16 align=4
        local.get 1
        i32.const 8
        i32.add
        i32.const 1051572
        call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
        unreachable
      end
      i32.const 0
      i32.const 3
      i32.store8 offset=1060616
      i32.const 0
      i64.const 1
      i64.store offset=1060600
      i32.const 0
      i64.const 0
      i64.store offset=1060592
      i32.const 0
      i64.const 0
      i64.store offset=1060576
      local.get 0
      i32.const 1
      i32.store8
      i32.const 0
      i32.const 0
      i32.store8 offset=1060608
      i32.const 0
      i32.const 0
      i32.store8 offset=1060588
      i32.const 0
      i32.const 0
      i32.store offset=1060584
    end
    local.get 1
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN3std3sys3pal6common14small_c_string24run_with_cstr_allocating17h911641b6fbcdb6f9E (type 4) (param i32 i32 i32)
    (local i32)
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
        local.get 3
        i32.load
        local.tee 2
        i32.const -2147483648
        i32.ne
        br_if 0 (;@2;)
        local.get 0
        local.get 3
        local.get 3
        i32.load offset=4
        local.tee 2
        local.get 3
        i32.load offset=8
        local.tee 1
        call $_ZN3std3sys2fs4wasi11open_parent28_$u7b$$u7b$closure$u7d$$u7d$17hd7919abf9550c15bE
        local.get 2
        i32.const 0
        i32.store8
        local.get 1
        i32.eqz
        br_if 1 (;@1;)
        local.get 2
        local.get 1
        i32.const 1
        call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        br 1 (;@1;)
      end
      local.get 0
      i32.const -2147483648
      i32.store offset=4
      local.get 0
      i32.const 0
      i64.load offset=1051736
      i64.store offset=8 align=4
      local.get 2
      i32.eqz
      br_if 0 (;@1;)
      local.get 3
      i32.load offset=4
      local.get 2
      i32.const 1
      call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
    end
    local.get 3
    i32.const 16
    i32.add
    global.set $__stack_pointer)
  (func $_ZN3std3sys2fs4wasi11open_parent28_$u7b$$u7b$closure$u7d$$u7d$17hd7919abf9550c15bE (type 6) (param i32 i32 i32 i32)
    (local i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 80
    i32.sub
    local.tee 4
    global.set $__stack_pointer
    local.get 4
    local.get 3
    i32.store offset=12
    local.get 4
    local.get 2
    i32.store offset=8
    i32.const 0
    i32.load8_u offset=1060573
    drop
    i32.const 512
    local.set 3
    block  ;; label = @1
      block  ;; label = @2
        i32.const 512
        i32.const 1
        call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
        local.tee 5
        i32.eqz
        br_if 0 (;@2;)
        local.get 4
        local.get 5
        i32.store offset=20
        local.get 4
        i32.const 512
        i32.store offset=16
        local.get 4
        local.get 5
        i32.store offset=28
        local.get 4
        i32.const 0
        i32.store offset=32
        block  ;; label = @3
          block  ;; label = @4
            local.get 2
            local.get 4
            i32.const 32
            i32.add
            local.get 4
            i32.const 28
            i32.add
            i32.const 512
            call $__wasilibc_find_relpath
            local.tee 6
            i32.const -1
            i32.ne
            br_if 0 (;@4;)
            i32.const 512
            local.set 3
            loop  ;; label = @5
              block  ;; label = @6
                i32.const 0
                i32.load offset=1061208
                i32.const 48
                i32.eq
                br_if 0 (;@6;)
                local.get 4
                i32.const 2
                i32.store offset=52
                local.get 4
                i32.const 1053468
                i32.store offset=48
                local.get 4
                i64.const 1
                i64.store offset=60 align=4
                local.get 4
                i32.const 22
                i64.extend_i32_u
                i64.const 32
                i64.shl
                local.get 4
                i32.const 8
                i32.add
                i64.extend_i32_u
                i64.or
                i64.store offset=72
                local.get 4
                local.get 4
                i32.const 72
                i32.add
                i32.store offset=56
                local.get 4
                i32.const 36
                i32.add
                local.get 4
                i32.const 48
                i32.add
                call $_ZN5alloc3fmt6format12format_inner17h79d363dc4fdc0dbbE
                local.get 0
                i32.const 8
                i32.add
                i32.const 41
                local.get 4
                i32.const 36
                i32.add
                call $_ZN3std2io5error5Error3new17he87ce80ffc6f791bE
                i32.const -2147483648
                local.set 2
                i32.const 4
                local.set 6
                br 3 (;@3;)
              end
              local.get 4
              local.get 3
              i32.store offset=24
              local.get 4
              i32.const 16
              i32.add
              local.get 3
              i32.const 1
              i32.const 1
              i32.const 1
              call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hf4e8ee5cbddfee98E
              local.get 4
              i32.load offset=16
              local.set 3
              local.get 4
              local.get 4
              i32.load offset=20
              local.tee 5
              i32.store offset=28
              local.get 4
              i32.const 0
              i32.store offset=32
              local.get 2
              local.get 4
              i32.const 32
              i32.add
              local.get 4
              i32.const 28
              i32.add
              local.get 3
              call $__wasilibc_find_relpath
              local.tee 6
              i32.const -1
              i32.eq
              br_if 0 (;@5;)
            end
          end
          i32.const 0
          local.set 7
          local.get 4
          i32.load offset=28
          local.tee 8
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
              local.set 9
              br 1 (;@4;)
            end
            i32.const 0
            i32.load8_u offset=1060573
            drop
            i32.const 1
            local.set 7
            local.get 2
            i32.const 1
            call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
            local.tee 9
            i32.eqz
            br_if 3 (;@1;)
          end
          block  ;; label = @4
            local.get 2
            i32.eqz
            br_if 0 (;@4;)
            local.get 9
            local.get 8
            local.get 2
            memory.copy
          end
          local.get 0
          local.get 9
          i32.store offset=8
          local.get 0
          local.get 2
          i32.store offset=4
          local.get 0
          local.get 6
          i32.store
          i32.const 12
          local.set 6
        end
        local.get 0
        local.get 6
        i32.add
        local.get 2
        i32.store
        block  ;; label = @3
          local.get 3
          i32.eqz
          br_if 0 (;@3;)
          local.get 5
          local.get 3
          i32.const 1
          call $_RNvCs691rhTbG0Ee_7___rustc14___rust_dealloc
        end
        local.get 4
        i32.const 80
        i32.add
        global.set $__stack_pointer
        return
      end
      i32.const 1
      i32.const 512
      i32.const 1053376
      call $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E
      unreachable
    end
    local.get 7
    local.get 2
    i32.const 1049520
    call $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E
    unreachable)
  (func $_ZN3std3sys9backtrace4lock17h8474d9d758c64cbdE (type 12) (result i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 0
    global.set $__stack_pointer
    i32.const 0
    i32.load8_u offset=1060649
    local.set 1
    i32.const 0
    i32.const 1
    i32.store8 offset=1060649
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
      i32.const 1051452
      i32.store offset=8
      i32.const 0
      local.get 0
      i32.const 7
      i32.add
      i32.const 1053668
      local.get 0
      i32.const 8
      i32.add
      i32.const 1051504
      call $_ZN4core9panicking13assert_failed17h837345b905b163c7E
      unreachable
    end
    local.get 0
    i32.const 32
    i32.add
    global.set $__stack_pointer
    i32.const 1060649)
  (func $_ZN3std3sys9backtrace13BacktraceLock5print17h61f80b5fff84970cE (type 6) (param i32 i32 i32 i32)
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
    i32.const 1049840
    i32.store offset=8
    local.get 4
    i64.const 1
    i64.store offset=20 align=4
    local.get 4
    local.get 3
    i32.store8 offset=47
    local.get 4
    i32.const 23
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
  (func $_ZN98_$LT$std..sys..backtrace..BacktraceLock..print..DisplayBacktrace$u20$as$u20$core..fmt..Display$GT$3fmt17h2855f445b96d4beeE (type 1) (param i32 i32) (result i32)
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
        call_indirect (type 0)
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
          i32.const 1051744
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
            i32.const 1051761
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
  (func $_ZN3std3sys9backtrace26__rust_end_short_backtrace17heed88f70267ff169E (type 0) (param i32)
    local.get 0
    call $_ZN3std9panicking19begin_panic_handler28_$u7b$$u7b$closure$u7d$$u7d$17h03e6674a89ab6ac2E
    unreachable)
  (func $_ZN3std9panicking19begin_panic_handler28_$u7b$$u7b$closure$u7d$$u7d$17h03e6674a89ab6ac2E (type 0) (param i32)
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
      i32.const 1052284
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
    i32.const 1052256
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
  (func $_ZN3std3sys2fs8read_dir17hc38638e55dc04626E (type 4) (param i32 i32 i32)
    (local i32 i32 i64 i32 i32)
    global.get $__stack_pointer
    i32.const 64
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    i32.const 0
    local.set 4
    local.get 3
    i32.const 47
    i32.add
    i32.const 0
    i32.store align=1
    local.get 3
    i64.const 1
    i64.store offset=40
    local.get 3
    i64.const 0
    i64.store offset=24
    local.get 3
    i64.const 0
    i64.store offset=8
    local.get 3
    i32.const 1
    i32.store8 offset=48
    local.get 3
    i32.const 2
    i32.store16 offset=46
    local.get 3
    i32.const 56
    i32.add
    local.get 1
    local.get 2
    local.get 3
    i32.const 8
    i32.add
    call $_ZN3std3sys2fs4wasi4File4open17h2ad5fb3abcd3d53dE
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 3
              i32.load8_u offset=56
              i32.const 4
              i32.eq
              br_if 0 (;@5;)
              local.get 0
              local.get 3
              i64.load offset=56
              local.tee 5
              i64.const 32
              i64.shr_u
              i64.store32 offset=12
              local.get 0
              local.get 5
              i64.store8 offset=8
              local.get 0
              i64.const 6
              i64.store
              local.get 0
              i32.const 11
              i32.add
              local.get 5
              i32.wrap_i64
              local.tee 2
              i32.const 24
              i32.shr_u
              i32.store8
              local.get 0
              local.get 2
              i32.const 8
              i32.shr_u
              i32.store16 offset=9 align=1
              br 1 (;@4;)
            end
            local.get 2
            i32.const 0
            i32.lt_s
            br_if 1 (;@3;)
            local.get 3
            i32.load offset=60
            local.set 6
            block  ;; label = @5
              block  ;; label = @6
                local.get 2
                br_if 0 (;@6;)
                i32.const 1
                local.set 7
                br 1 (;@5;)
              end
              i32.const 0
              i32.load8_u offset=1060573
              drop
              i32.const 1
              local.set 4
              local.get 2
              i32.const 1
              call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
              local.tee 7
              i32.eqz
              br_if 2 (;@3;)
            end
            block  ;; label = @5
              local.get 2
              i32.eqz
              br_if 0 (;@5;)
              local.get 7
              local.get 1
              local.get 2
              memory.copy
            end
            i32.const 0
            i32.load8_u offset=1060573
            drop
            i32.const 24
            i32.const 4
            call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
            local.tee 1
            i32.eqz
            br_if 2 (;@2;)
            local.get 1
            local.get 6
            i32.store offset=20
            local.get 1
            local.get 2
            i32.store offset=16
            local.get 1
            local.get 7
            i32.store offset=12
            local.get 1
            local.get 2
            i32.store offset=8
            local.get 1
            i64.const 4294967297
            i64.store align=4
            i32.const 0
            i32.load8_u offset=1060573
            drop
            i32.const 128
            i32.const 1
            call $_RNvCs691rhTbG0Ee_7___rustc19___rust_alloc_zeroed
            local.tee 2
            i32.eqz
            br_if 3 (;@1;)
            local.get 0
            local.get 1
            i32.store offset=32
            local.get 0
            i32.const 128
            i32.store offset=24
            local.get 0
            local.get 2
            i32.store offset=20
            local.get 0
            i32.const 128
            i32.store offset=16
            local.get 0
            i64.const 0
            i64.store offset=8
            local.get 0
            i64.const 2
            i64.store
          end
          local.get 3
          i32.const 64
          i32.add
          global.set $__stack_pointer
          return
        end
        local.get 4
        local.get 2
        i32.const 1049520
        call $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E
        unreachable
      end
      i32.const 4
      i32.const 24
      call $_ZN5alloc5alloc18handle_alloc_error17hcc35c2aed22157a6E
      unreachable
    end
    i32.const 1
    i32.const 128
    i32.const 1053344
    call $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E
    unreachable)
  (func $_ZN3std5alloc24default_alloc_error_hook17hfe3584b28bc072faE (type 3) (param i32 i32)
    (local i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 48
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      i32.const 0
      i32.load8_u offset=1060572
      br_if 0 (;@1;)
      local.get 2
      i32.const 2
      i32.store offset=12
      local.get 2
      i32.const 1051884
      i32.store offset=8
      local.get 2
      i64.const 1
      i64.store offset=20 align=4
      local.get 2
      i32.const 19
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
          call_indirect (type 0)
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
    i32.const 1051916
    i32.store offset=8
    local.get 2
    i64.const 1
    i64.store offset=20 align=4
    local.get 2
    local.get 1
    i32.store
    local.get 2
    i32.const 19
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
    i32.const 1051956
    call $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E
    unreachable)
  (func $_RNvCs691rhTbG0Ee_7___rustc11___rdl_alloc (type 1) (param i32 i32) (result i32)
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
  (func $_RNvCs691rhTbG0Ee_7___rustc13___rdl_realloc (type 8) (param i32 i32 i32 i32) (result i32)
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
  (func $_RNvCs691rhTbG0Ee_7___rustc18___rdl_alloc_zeroed (type 1) (param i32 i32) (result i32)
    (local i32 i32)
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
        i32.const 0
        local.set 3
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
        br_if 1 (;@1;)
        local.get 2
        i32.load offset=12
        local.tee 1
        i32.eqz
        br_if 1 (;@1;)
        block  ;; label = @3
          local.get 0
          i32.eqz
          br_if 0 (;@3;)
          local.get 1
          i32.const 0
          local.get 0
          memory.fill
        end
        local.get 1
        local.set 3
        br 1 (;@1;)
      end
      local.get 0
      i32.const 1
      call $calloc
      local.set 3
    end
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 3)
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
    call_indirect (type 3)
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
        call_indirect (type 3)
        i32.const 1052312
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
        i32.load offset=1060708
        local.tee 6
        i32.const 2
        i32.gt_u
        br_if 0 (;@2;)
        block  ;; label = @3
          block  ;; label = @4
            i32.const 0
            i64.load offset=1060688
            local.tee 5
            i64.eqz
            br_if 0 (;@4;)
            i32.const 0
            i64.load offset=1060672
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
        i32.const 1049684
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
        i64.load offset=1060688
        i64.ne
        br_if 0 (;@2;)
        local.get 3
        i32.const 8
        i32.add
        i32.const 1049684
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
      i32.load8_u offset=1060552
      local.set 0
      i32.const 0
      i32.const 0
      i32.store8 offset=1060552
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
      i32.const 1052132
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
    i32.const 1052140
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
    i32.const 1052192
    i32.store offset=544
    local.get 3
    i64.const 3
    i64.store offset=556 align=4
    local.get 3
    local.get 5
    i32.const 18
    i64.extend_i32_u
    i64.const 32
    i64.shl
    local.tee 6
    i64.or
    local.tee 5
    i64.store offset=584
    local.get 3
    local.get 4
    i32.const 24
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
          call_indirect (type 6)
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
            call_indirect (type 0)
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
            call_indirect (type 0)
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
        i32.const 1052192
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
          call_indirect (type 0)
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
    i32.const 1052152
    call $_ZN4core5slice5index24slice_end_index_len_fail17hc7943372990115c8E
    unreachable)
  (func $_ZN3std9panicking11panic_count8increase17h8f96eac579e666bcE (type 2) (param i32) (result i32)
    (local i32 i32)
    i32.const 0
    local.set 1
    i32.const 0
    i32.const 0
    i32.load offset=1060668
    local.tee 2
    i32.const 1
    i32.add
    i32.store offset=1060668
    block  ;; label = @1
      local.get 2
      i32.const 0
      i32.lt_s
      br_if 0 (;@1;)
      i32.const 1
      local.set 1
      i32.const 0
      i32.load8_u offset=1060700
      br_if 0 (;@1;)
      i32.const 0
      local.get 0
      i32.store8 offset=1060700
      i32.const 0
      i32.const 0
      i32.load offset=1060696
      i32.const 1
      i32.add
      i32.store offset=1060696
      i32.const 2
      local.set 1
    end
    local.get 1)
  (func $_RNvCs691rhTbG0Ee_7___rustc17rust_begin_unwind (type 0) (param i32)
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
  (func $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17h91eecedfd0f5623eE (type 3) (param i32 i32)
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
      i32.const 1049420
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
    i32.load8_u offset=1060573
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
    i32.const 1052224
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store
    local.get 2
    i32.const 64
    i32.add
    global.set $__stack_pointer)
  (func $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17h6cc4b8d5c4351f3cE (type 3) (param i32 i32)
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
      i32.const 1049420
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
    i32.const 1052224
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store
    local.get 2
    i32.const 48
    i32.add
    global.set $__stack_pointer)
  (func $_ZN95_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..fmt..Display$GT$3fmt17h698b05d4ac7f59faE (type 1) (param i32 i32) (result i32)
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
  (func $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17hda4884f51fc1d63cE (type 3) (param i32 i32)
    (local i32 i32)
    i32.const 0
    i32.load8_u offset=1060573
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
    i32.const 1052240
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store)
  (func $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17hc9ba6339c6f888eeE (type 3) (param i32 i32)
    local.get 0
    i32.const 1052240
    i32.store offset=4
    local.get 0
    local.get 1
    i32.store)
  (func $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$6as_str17hacc42b4685d93ce5E (type 3) (param i32 i32)
    local.get 0
    local.get 1
    i64.load align=4
    i64.store)
  (func $_ZN92_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..fmt..Display$GT$3fmt17ha2cf78d2946fbf30E (type 1) (param i32 i32) (result i32)
    local.get 1
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    call $_ZN4core3fmt9Formatter9write_str17hdf9d14a3fcabff76E)
  (func $_ZN3std9panicking20rust_panic_with_hook17hd6db915a7ab98bd5E (type 13) (param i32 i32 i32 i32 i32)
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
            call_indirect (type 3)
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
            i32.const 1052428
            i32.store offset=72
            local.get 5
            i64.const 2
            i64.store offset=84 align=4
            local.get 5
            i32.const 18
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
            i32.const 24
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
          i32.load offset=1060656
          local.tee 6
          i32.const -1
          i32.gt_s
          br_if 1 (;@2;)
          local.get 5
          i32.const 1
          i32.store offset=76
          local.get 5
          i32.const 1053660
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
        i32.const 1052352
        i32.store offset=72
        local.get 5
        i64.const 2
        i64.store offset=84 align=4
        local.get 5
        i32.const 25
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
        i32.const 24
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
      i32.store offset=1060656
      block  ;; label = @2
        block  ;; label = @3
          i32.const 0
          i32.load offset=1060660
          i32.eqz
          br_if 0 (;@3;)
          local.get 5
          i32.const 8
          i32.add
          local.get 0
          local.get 1
          i32.load offset=20
          call_indirect (type 3)
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
          i32.load offset=1060660
          local.get 5
          i32.const 72
          i32.add
          i32.const 0
          i32.load offset=1060664
          i32.load offset=20
          call_indirect (type 3)
          br 1 (;@2;)
        end
        local.get 5
        local.get 0
        local.get 1
        i32.load offset=20
        call_indirect (type 3)
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
      i32.load offset=1060656
      i32.const -1
      i32.add
      i32.store offset=1060656
      i32.const 0
      i32.const 0
      i32.store8 offset=1060700
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
        i32.const 1052500
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
  (func $_RNvCs691rhTbG0Ee_7___rustc10rust_panic (type 3) (param i32 i32)
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
    i32.const 1052572
    i32.store offset=24
    local.get 2
    i64.const 1
    i64.store offset=36 align=4
    local.get 2
    i32.const 19
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
  (func $_ZN62_$LT$std..io..error..ErrorKind$u20$as$u20$core..fmt..Debug$GT$3fmt17h2b1c6a02c8c0b007E (type 1) (param i32 i32) (result i32)
    local.get 1
    local.get 0
    i32.load8_u
    i32.const 2
    i32.shl
    local.tee 0
    i32.const 1054176
    i32.add
    i32.load
    local.get 0
    i32.const 1054008
    i32.add
    i32.load
    call $_ZN4core3fmt9Formatter9write_str17hdf9d14a3fcabff76E)
  (func $_ZN3std3sys2fs4wasi7open_at17he0bf6f9ea5d45c95E (type 13) (param i32 i32 i32 i32 i32)
    (local i32 i32 i32 i64 i32 i64)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    local.get 4
    i32.load offset=32
    local.set 6
    local.get 5
    i32.const 4
    i32.add
    local.get 2
    local.get 3
    call $_ZN4core3str8converts9from_utf817hb5c7d3e2ee61e867E
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          local.get 5
          i32.load offset=4
          i32.const 1
          i32.ne
          br_if 0 (;@3;)
          local.get 0
          i32.const 1051384
          i32.store offset=4
          local.get 0
          i32.const 2
          i32.store
          br 1 (;@2;)
        end
        local.get 5
        i32.load offset=12
        local.set 3
        local.get 5
        i32.load offset=8
        local.set 2
        local.get 4
        i32.load16_u offset=38
        local.set 7
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        local.get 4
                        i32.load
                        br_if 0 (;@10;)
                        i64.const 16386
                        i64.const 0
                        local.get 4
                        i32.load8_u offset=40
                        select
                        local.set 8
                        local.get 4
                        i32.load8_u offset=41
                        br_if 2 (;@8;)
                        local.get 4
                        i32.load offset=16
                        local.set 9
                        local.get 4
                        i32.load8_u offset=42
                        i32.eqz
                        br_if 1 (;@9;)
                        local.get 8
                        i64.const 266846205
                        i64.or
                        local.set 10
                        local.get 9
                        i32.const 1
                        i32.and
                        br_if 3 (;@7;)
                        br 4 (;@6;)
                      end
                      local.get 4
                      i64.load offset=8
                      local.tee 10
                      local.set 8
                      local.get 4
                      i32.load offset=16
                      br_if 2 (;@7;)
                      br 6 (;@3;)
                    end
                    local.get 8
                    i64.const 262651580
                    i64.or
                    local.set 10
                    local.get 9
                    i32.const 1
                    i32.and
                    i32.eqz
                    br_if 2 (;@6;)
                    br 1 (;@7;)
                  end
                  local.get 8
                  i64.const 266846205
                  i64.or
                  local.set 10
                  local.get 4
                  i32.load offset=16
                  i32.eqz
                  br_if 2 (;@5;)
                end
                local.get 4
                i64.load offset=24
                local.set 8
                br 3 (;@3;)
              end
              local.get 4
              i32.load8_u offset=42
              i32.const 1
              i32.ne
              br_if 1 (;@4;)
            end
            local.get 8
            i64.const 4194625
            i64.or
            local.set 8
          end
          local.get 8
          i64.const 262651580
          i64.or
          local.set 8
        end
        local.get 5
        i32.const 4
        i32.add
        local.get 1
        local.get 6
        local.get 2
        local.get 3
        local.get 7
        local.get 10
        local.get 8
        local.get 4
        i32.load16_u offset=36
        call $_ZN4wasi13lib_generated9path_open17h1f660a205120869aE
        block  ;; label = @3
          local.get 5
          i32.load16_u offset=4
          br_if 0 (;@3;)
          local.get 5
          i32.load offset=8
          local.tee 4
          i32.const -1
          i32.eq
          br_if 2 (;@1;)
          local.get 0
          i32.const 4
          i32.store8
          local.get 0
          local.get 4
          i32.store offset=4
          br 1 (;@2;)
        end
        local.get 5
        i32.load16_u offset=6
        local.set 4
        local.get 0
        i32.const 3
        i32.add
        i32.const 0
        i32.store8
        local.get 0
        i32.const 0
        i32.store16 offset=1 align=1
        local.get 0
        local.get 4
        i32.store offset=4
        local.get 0
        i32.const 0
        i32.store8
      end
      local.get 5
      i32.const 16
      i32.add
      global.set $__stack_pointer
      return
    end
    i32.const 1051396
    i32.const 8
    i32.const 1053296
    call $_ZN4core6option13expect_failed17hbb79b61f61810248E
    unreachable)
  (func $_ZN64_$LT$std..sys..stdio..wasi..Stderr$u20$as$u20$std..io..Write$GT$5write17h9130e91513ae60a2E (type 6) (param i32 i32 i32 i32)
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
  (func $_ZN64_$LT$std..sys..stdio..wasi..Stderr$u20$as$u20$std..io..Write$GT$14write_vectored17h8711081ec37d5f23E (type 6) (param i32 i32 i32 i32)
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
  (func $_ZN64_$LT$std..sys..stdio..wasi..Stderr$u20$as$u20$std..io..Write$GT$17is_write_vectored17h4a91ce14e3ddc646E (type 2) (param i32) (result i32)
    i32.const 1)
  (func $_ZN64_$LT$std..sys..stdio..wasi..Stderr$u20$as$u20$std..io..Write$GT$5flush17h7bd1b0dc5a2382a0E (type 3) (param i32 i32)
    local.get 0
    i32.const 4
    i32.store8)
  (func $_ZN3std5alloc8rust_oom17h293069cf3a87ceb7E (type 3) (param i32 i32)
    (local i32)
    local.get 0
    local.get 1
    i32.const 0
    i32.load offset=1060652
    local.tee 2
    i32.const 26
    local.get 2
    select
    call_indirect (type 3)
    call $_ZN3std7process5abort17hb229e5783e2ded8dE
    unreachable)
  (func $_RNvCs691rhTbG0Ee_7___rustc8___rg_oom (type 3) (param i32 i32)
    local.get 1
    local.get 0
    call $_ZN3std5alloc8rust_oom17h293069cf3a87ceb7E
    unreachable)
  (func $_RNvCs691rhTbG0Ee_7___rustc18___rust_start_panic (type 1) (param i32 i32) (result i32)
    unreachable)
  (func $_ZN4wasi13lib_generated10fd_readdir17hf832bfb1915260f1E (type 14) (param i32 i32 i32 i32 i64)
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
        local.get 5
        i32.const 12
        i32.add
        call $_ZN4wasi13lib_generated22wasi_snapshot_preview110fd_readdir17h9023b5be0357994cE
        local.tee 3
        br_if 0 (;@2;)
        local.get 0
        local.get 5
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
    local.get 5
    i32.const 16
    i32.add
    global.set $__stack_pointer)
  (func $_ZN4wasi13lib_generated8fd_write17h8e36e57726d845e0E (type 6) (param i32 i32 i32 i32)
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
  (func $_ZN4wasi13lib_generated17path_filestat_get17h52d9dede891736b6E (type 13) (param i32 i32 i32 i32 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 64
    i32.sub
    local.tee 5
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        local.get 2
        local.get 3
        local.get 4
        local.get 5
        call $_ZN4wasi13lib_generated22wasi_snapshot_preview117path_filestat_get17ha1e4dd55a19006b1E
        local.tee 4
        br_if 0 (;@2;)
        local.get 0
        local.get 5
        i64.load
        i64.store offset=8
        local.get 0
        i32.const 64
        i32.add
        local.get 5
        i32.const 56
        i32.add
        i64.load
        i64.store
        local.get 0
        i32.const 56
        i32.add
        local.get 5
        i32.const 48
        i32.add
        i64.load
        i64.store
        local.get 0
        i32.const 48
        i32.add
        local.get 5
        i32.const 40
        i32.add
        i64.load
        i64.store
        local.get 0
        i32.const 40
        i32.add
        local.get 5
        i32.const 32
        i32.add
        i64.load
        i64.store
        local.get 0
        i32.const 32
        i32.add
        local.get 5
        i32.const 24
        i32.add
        i64.load
        i64.store
        local.get 0
        i32.const 24
        i32.add
        local.get 5
        i32.const 16
        i32.add
        i64.load
        i64.store
        local.get 0
        i32.const 16
        i32.add
        local.get 5
        i32.const 8
        i32.add
        i64.load
        i64.store
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
    i32.const 64
    i32.add
    global.set $__stack_pointer)
  (func $_ZN4wasi13lib_generated9path_open17h1f660a205120869aE (type 15) (param i32 i32 i32 i32 i32 i32 i64 i64 i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 9
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        local.get 1
        local.get 2
        local.get 3
        local.get 4
        local.get 5
        i32.const 65535
        i32.and
        local.get 6
        local.get 7
        local.get 8
        i32.const 65535
        i32.and
        local.get 9
        i32.const 12
        i32.add
        call $_ZN4wasi13lib_generated22wasi_snapshot_preview19path_open17h24152001420e8094E
        local.tee 8
        br_if 0 (;@2;)
        local.get 0
        local.get 9
        i32.load offset=12
        i32.store offset=4
        i32.const 0
        local.set 8
        br 1 (;@1;)
      end
      local.get 0
      local.get 8
      i32.store16 offset=2
      i32.const 1
      local.set 8
    end
    local.get 0
    local.get 8
    i32.store16
    local.get 9
    i32.const 16
    i32.add
    global.set $__stack_pointer)
  (func $malloc (type 2) (param i32) (result i32)
    local.get 0
    call $dlmalloc)
  (func $dlmalloc (type 2) (param i32) (result i32)
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
                              i32.load offset=1060736
                              local.tee 2
                              br_if 0 (;@13;)
                              block  ;; label = @14
                                i32.const 0
                                i32.load offset=1061184
                                local.tee 3
                                br_if 0 (;@14;)
                                i32.const 0
                                i64.const -1
                                i64.store offset=1061196 align=4
                                i32.const 0
                                i64.const 281474976776192
                                i64.store offset=1061188 align=4
                                i32.const 0
                                local.get 1
                                i32.const 8
                                i32.add
                                i32.const -16
                                i32.and
                                i32.const 1431655768
                                i32.xor
                                local.tee 3
                                i32.store offset=1061184
                                i32.const 0
                                i32.const 0
                                i32.store offset=1061204
                                i32.const 0
                                i32.const 0
                                i32.store offset=1061156
                              end
                              i32.const 1114112
                              i32.const 1061280
                              i32.lt_u
                              br_if 1 (;@12;)
                              i32.const 0
                              local.set 2
                              i32.const 1114112
                              i32.const 1061280
                              i32.sub
                              i32.const 89
                              i32.lt_u
                              br_if 0 (;@13;)
                              i32.const 0
                              local.set 4
                              i32.const 0
                              i32.const 1061280
                              i32.store offset=1061160
                              i32.const 0
                              i32.const 1061280
                              i32.store offset=1060728
                              i32.const 0
                              local.get 3
                              i32.store offset=1060748
                              i32.const 0
                              i32.const -1
                              i32.store offset=1060744
                              i32.const 0
                              i32.const 1114112
                              i32.const 1061280
                              i32.sub
                              local.tee 3
                              i32.store offset=1061164
                              i32.const 0
                              local.get 3
                              i32.store offset=1061148
                              i32.const 0
                              local.get 3
                              i32.store offset=1061144
                              loop  ;; label = @14
                                local.get 4
                                i32.const 1060772
                                i32.add
                                local.get 4
                                i32.const 1060760
                                i32.add
                                local.tee 3
                                i32.store
                                local.get 3
                                local.get 4
                                i32.const 1060752
                                i32.add
                                local.tee 5
                                i32.store
                                local.get 4
                                i32.const 1060764
                                i32.add
                                local.get 5
                                i32.store
                                local.get 4
                                i32.const 1060780
                                i32.add
                                local.get 4
                                i32.const 1060768
                                i32.add
                                local.tee 5
                                i32.store
                                local.get 5
                                local.get 3
                                i32.store
                                local.get 4
                                i32.const 1060788
                                i32.add
                                local.get 4
                                i32.const 1060776
                                i32.add
                                local.tee 3
                                i32.store
                                local.get 3
                                local.get 5
                                i32.store
                                local.get 4
                                i32.const 1060784
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
                              i32.load offset=1061200
                              i32.store offset=1060740
                              i32.const 0
                              i32.const 1061280
                              i32.const -8
                              i32.const 1061280
                              i32.sub
                              i32.const 15
                              i32.and
                              local.tee 4
                              i32.add
                              local.tee 2
                              i32.store offset=1060736
                              i32.const 0
                              i32.const 1114112
                              i32.const 1061280
                              i32.sub
                              local.get 4
                              i32.sub
                              i32.const -56
                              i32.add
                              local.tee 4
                              i32.store offset=1060724
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
                                  i32.load offset=1060712
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
                                      i32.const 1060752
                                      i32.add
                                      local.tee 4
                                      local.get 3
                                      i32.const 1060760
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
                                      i32.store offset=1060712
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
                                i32.load offset=1060720
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
                                      i32.const 1060752
                                      i32.add
                                      local.tee 0
                                      local.get 4
                                      i32.const 1060760
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
                                      i32.store offset=1060712
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
                                    i32.const 1060752
                                    i32.add
                                    local.set 5
                                    i32.const 0
                                    i32.load offset=1060732
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
                                        i32.store offset=1060712
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
                                  i32.store offset=1060732
                                  i32.const 0
                                  local.get 0
                                  i32.store offset=1060720
                                  br 14 (;@1;)
                                end
                                i32.const 0
                                i32.load offset=1060716
                                local.tee 10
                                i32.eqz
                                br_if 1 (;@13;)
                                local.get 10
                                i32.ctz
                                i32.const 2
                                i32.shl
                                i32.const 1061016
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
                              i32.load offset=1060716
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
                                      i32.const 1061016
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
                                    i32.const 1061016
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
                              i32.load offset=1060720
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
                              i32.load offset=1060720
                              local.tee 4
                              local.get 5
                              i32.lt_u
                              br_if 0 (;@13;)
                              i32.const 0
                              i32.load offset=1060732
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
                              i32.store offset=1060720
                              i32.const 0
                              local.get 8
                              i32.store offset=1060732
                              local.get 3
                              i32.const 8
                              i32.add
                              local.set 4
                              br 12 (;@1;)
                            end
                            block  ;; label = @13
                              i32.const 0
                              i32.load offset=1060724
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
                              i32.store offset=1060736
                              i32.const 0
                              local.get 3
                              i32.store offset=1060724
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
                                i32.load offset=1061184
                                i32.eqz
                                br_if 0 (;@14;)
                                i32.const 0
                                i32.load offset=1061192
                                local.set 3
                                br 1 (;@13;)
                              end
                              i32.const 0
                              i64.const -1
                              i64.store offset=1061196 align=4
                              i32.const 0
                              i64.const 281474976776192
                              i64.store offset=1061188 align=4
                              i32.const 0
                              local.get 1
                              i32.const 12
                              i32.add
                              i32.const -16
                              i32.and
                              i32.const 1431655768
                              i32.xor
                              i32.store offset=1061184
                              i32.const 0
                              i32.const 0
                              i32.store offset=1061204
                              i32.const 0
                              i32.const 0
                              i32.store offset=1061156
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
                              i32.store offset=1061208
                              br 12 (;@1;)
                            end
                            block  ;; label = @13
                              i32.const 0
                              i32.load offset=1061152
                              local.tee 4
                              i32.eqz
                              br_if 0 (;@13;)
                              block  ;; label = @14
                                i32.const 0
                                i32.load offset=1061144
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
                              i32.store offset=1061208
                              br 12 (;@1;)
                            end
                            i32.const 0
                            i32.load8_u offset=1061156
                            i32.const 4
                            i32.and
                            br_if 5 (;@7;)
                            block  ;; label = @13
                              block  ;; label = @14
                                block  ;; label = @15
                                  local.get 2
                                  i32.eqz
                                  br_if 0 (;@15;)
                                  i32.const 1061160
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
                                  i32.load offset=1061188
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
                                  i32.load offset=1061152
                                  local.tee 4
                                  i32.eqz
                                  br_if 0 (;@15;)
                                  i32.const 0
                                  i32.load offset=1061144
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
                                i32.load offset=1061192
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
                  i32.load offset=1061156
                  i32.const 4
                  i32.or
                  i32.store offset=1061156
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
              i32.load offset=1061144
              local.get 6
              i32.add
              local.tee 4
              i32.store offset=1061144
              block  ;; label = @6
                local.get 4
                i32.const 0
                i32.load offset=1061148
                i32.le_u
                br_if 0 (;@6;)
                i32.const 0
                local.get 4
                i32.store offset=1061148
              end
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      i32.const 0
                      i32.load offset=1060736
                      local.tee 3
                      i32.eqz
                      br_if 0 (;@9;)
                      i32.const 1061160
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
                        i32.load offset=1060728
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
                      i32.store offset=1060728
                    end
                    i32.const 0
                    local.set 4
                    i32.const 0
                    local.get 6
                    i32.store offset=1061164
                    i32.const 0
                    local.get 8
                    i32.store offset=1061160
                    i32.const 0
                    i32.const -1
                    i32.store offset=1060744
                    i32.const 0
                    i32.const 0
                    i32.load offset=1061184
                    i32.store offset=1060748
                    i32.const 0
                    i32.const 0
                    i32.store offset=1061172
                    loop  ;; label = @9
                      local.get 4
                      i32.const 1060772
                      i32.add
                      local.get 4
                      i32.const 1060760
                      i32.add
                      local.tee 3
                      i32.store
                      local.get 3
                      local.get 4
                      i32.const 1060752
                      i32.add
                      local.tee 0
                      i32.store
                      local.get 4
                      i32.const 1060764
                      i32.add
                      local.get 0
                      i32.store
                      local.get 4
                      i32.const 1060780
                      i32.add
                      local.get 4
                      i32.const 1060768
                      i32.add
                      local.tee 0
                      i32.store
                      local.get 0
                      local.get 3
                      i32.store
                      local.get 4
                      i32.const 1060788
                      i32.add
                      local.get 4
                      i32.const 1060776
                      i32.add
                      local.tee 3
                      i32.store
                      local.get 3
                      local.get 0
                      i32.store
                      local.get 4
                      i32.const 1060784
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
                    i32.load offset=1061200
                    i32.store offset=1060740
                    i32.const 0
                    local.get 4
                    i32.store offset=1060724
                    i32.const 0
                    local.get 3
                    i32.store offset=1060736
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
                  i32.load offset=1060724
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
                  i32.load offset=1061200
                  i32.store offset=1060740
                  i32.const 0
                  local.get 0
                  i32.store offset=1060724
                  i32.const 0
                  local.get 8
                  i32.store offset=1060736
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
                  i32.load offset=1060728
                  i32.ge_u
                  br_if 0 (;@7;)
                  i32.const 0
                  local.get 8
                  i32.store offset=1060728
                end
                local.get 8
                local.get 6
                i32.add
                local.set 0
                i32.const 1061160
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
                i32.const 1061160
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
                i32.load offset=1061200
                i32.store offset=1060740
                i32.const 0
                local.get 4
                i32.store offset=1060724
                i32.const 0
                local.get 11
                i32.store offset=1060736
                local.get 9
                i32.const 16
                i32.add
                i32.const 0
                i64.load offset=1061168 align=4
                i64.store align=4
                local.get 9
                i32.const 0
                i64.load offset=1061160 align=4
                i64.store offset=8 align=4
                i32.const 0
                local.get 9
                i32.const 8
                i32.add
                i32.store offset=1061168
                i32.const 0
                local.get 6
                i32.store offset=1061164
                i32.const 0
                local.get 8
                i32.store offset=1061160
                i32.const 0
                i32.const 0
                i32.store offset=1061172
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
                    i32.const 1060752
                    i32.add
                    local.set 4
                    block  ;; label = @9
                      block  ;; label = @10
                        i32.const 0
                        i32.load offset=1060712
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
                        i32.store offset=1060712
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
                  i32.const 1061016
                  i32.add
                  local.set 0
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        i32.const 0
                        i32.load offset=1060716
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
                        i32.store offset=1060716
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
              i32.load offset=1060724
              local.tee 4
              local.get 5
              i32.le_u
              br_if 0 (;@5;)
              i32.const 0
              i32.load offset=1060736
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
              i32.store offset=1060724
              i32.const 0
              local.get 0
              i32.store offset=1060736
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
            i32.store offset=1061208
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
              i32.const 1061016
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
              i32.store offset=1060716
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
            i32.const 1060752
            i32.add
            local.set 4
            block  ;; label = @5
              block  ;; label = @6
                i32.const 0
                i32.load offset=1060712
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
                i32.store offset=1060712
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
          i32.const 1061016
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
            i32.store offset=1060716
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
            i32.const 1061016
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
            i32.store offset=1060716
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
          i32.const 1060752
          i32.add
          local.set 5
          i32.const 0
          i32.load offset=1060732
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
              i32.store offset=1060712
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
        i32.store offset=1060732
        i32.const 0
        local.get 3
        i32.store offset=1060720
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
        i32.load offset=1060736
        i32.ne
        br_if 0 (;@2;)
        i32.const 0
        local.get 5
        i32.store offset=1060736
        i32.const 0
        i32.const 0
        i32.load offset=1060724
        local.get 0
        i32.add
        local.tee 2
        i32.store offset=1060724
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
        i32.load offset=1060732
        i32.ne
        br_if 0 (;@2;)
        i32.const 0
        local.get 5
        i32.store offset=1060732
        i32.const 0
        i32.const 0
        i32.load offset=1060720
        local.get 0
        i32.add
        local.tee 2
        i32.store offset=1060720
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
              i32.load offset=1060712
              i32.const -2
              local.get 1
              i32.const 3
              i32.shr_u
              i32.rotl
              i32.and
              i32.store offset=1060712
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
              i32.const 1061016
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
              i32.load offset=1060716
              i32.const -2
              local.get 7
              i32.rotl
              i32.and
              i32.store offset=1060716
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
        i32.const 1060752
        i32.add
        local.set 2
        block  ;; label = @3
          block  ;; label = @4
            i32.const 0
            i32.load offset=1060712
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
            i32.store offset=1060712
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
      i32.const 1061016
      i32.add
      local.set 1
      block  ;; label = @2
        i32.const 0
        i32.load offset=1060716
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
        i32.store offset=1060716
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
  (func $free (type 0) (param i32)
    local.get 0
    call $dlfree)
  (func $dlfree (type 0) (param i32)
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
        i32.load offset=1060728
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
                i32.load offset=1060732
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
                  i32.load offset=1060712
                  i32.const -2
                  local.get 4
                  i32.const 3
                  i32.shr_u
                  i32.rotl
                  i32.and
                  i32.store offset=1060712
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
              i32.store offset=1060720
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
            i32.const 1061016
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
            i32.load offset=1060716
            i32.const -2
            local.get 5
            i32.rotl
            i32.and
            i32.store offset=1060716
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
                  i32.load offset=1060736
                  i32.ne
                  br_if 0 (;@7;)
                  i32.const 0
                  local.get 1
                  i32.store offset=1060736
                  i32.const 0
                  i32.const 0
                  i32.load offset=1060724
                  local.get 0
                  i32.add
                  local.tee 0
                  i32.store offset=1060724
                  local.get 1
                  local.get 0
                  i32.const 1
                  i32.or
                  i32.store offset=4
                  local.get 1
                  i32.const 0
                  i32.load offset=1060732
                  i32.ne
                  br_if 6 (;@1;)
                  i32.const 0
                  i32.const 0
                  i32.store offset=1060720
                  i32.const 0
                  i32.const 0
                  i32.store offset=1060732
                  return
                end
                block  ;; label = @7
                  local.get 3
                  i32.const 0
                  i32.load offset=1060732
                  i32.ne
                  br_if 0 (;@7;)
                  i32.const 0
                  local.get 1
                  i32.store offset=1060732
                  i32.const 0
                  i32.const 0
                  i32.load offset=1060720
                  local.get 0
                  i32.add
                  local.tee 0
                  i32.store offset=1060720
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
                    i32.load offset=1060712
                    i32.const -2
                    local.get 4
                    i32.const 3
                    i32.shr_u
                    i32.rotl
                    i32.and
                    i32.store offset=1060712
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
              i32.const 1061016
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
              i32.load offset=1060716
              i32.const -2
              local.get 5
              i32.rotl
              i32.and
              i32.store offset=1060716
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
        i32.load offset=1060732
        i32.ne
        br_if 0 (;@2;)
        i32.const 0
        local.get 0
        i32.store offset=1060720
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
        i32.const 1060752
        i32.add
        local.set 2
        block  ;; label = @3
          block  ;; label = @4
            i32.const 0
            i32.load offset=1060712
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
            i32.store offset=1060712
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
      i32.const 1061016
      i32.add
      local.set 3
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              i32.const 0
              i32.load offset=1060716
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
              i32.store offset=1060716
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
      i32.load offset=1060744
      i32.const -1
      i32.add
      local.tee 1
      i32.const -1
      local.get 1
      select
      i32.store offset=1060744
    end)
  (func $calloc (type 1) (param i32 i32) (result i32)
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
  (func $realloc (type 1) (param i32 i32) (result i32)
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
      i32.store offset=1061208
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
          i32.load offset=1061192
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
          i32.load offset=1060736
          i32.ne
          br_if 0 (;@3;)
          i32.const 0
          i32.load offset=1060724
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
          i32.store offset=1060736
          i32.const 0
          local.get 5
          local.get 2
          i32.sub
          local.tee 2
          i32.store offset=1060724
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
          i32.load offset=1060732
          i32.ne
          br_if 0 (;@3;)
          i32.const 0
          i32.load offset=1060720
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
          i32.store offset=1060732
          i32.const 0
          local.get 1
          i32.store offset=1060720
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
              i32.load offset=1060712
              i32.const -2
              local.get 8
              i32.const 3
              i32.shr_u
              i32.rotl
              i32.and
              i32.store offset=1060712
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
              i32.const 1061016
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
              i32.load offset=1060716
              i32.const -2
              local.get 8
              i32.rotl
              i32.and
              i32.store offset=1060716
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
  (func $dispose_chunk (type 3) (param i32 i32)
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
                i32.load offset=1060732
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
                  i32.load offset=1060712
                  i32.const -2
                  local.get 4
                  i32.const 3
                  i32.shr_u
                  i32.rotl
                  i32.and
                  i32.store offset=1060712
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
              i32.store offset=1060720
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
            i32.const 1061016
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
            i32.load offset=1060716
            i32.const -2
            local.get 5
            i32.rotl
            i32.and
            i32.store offset=1060716
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
                  i32.load offset=1060736
                  i32.ne
                  br_if 0 (;@7;)
                  i32.const 0
                  local.get 0
                  i32.store offset=1060736
                  i32.const 0
                  i32.const 0
                  i32.load offset=1060724
                  local.get 1
                  i32.add
                  local.tee 1
                  i32.store offset=1060724
                  local.get 0
                  local.get 1
                  i32.const 1
                  i32.or
                  i32.store offset=4
                  local.get 0
                  i32.const 0
                  i32.load offset=1060732
                  i32.ne
                  br_if 6 (;@1;)
                  i32.const 0
                  i32.const 0
                  i32.store offset=1060720
                  i32.const 0
                  i32.const 0
                  i32.store offset=1060732
                  return
                end
                block  ;; label = @7
                  local.get 2
                  i32.const 0
                  i32.load offset=1060732
                  i32.ne
                  br_if 0 (;@7;)
                  i32.const 0
                  local.get 0
                  i32.store offset=1060732
                  i32.const 0
                  i32.const 0
                  i32.load offset=1060720
                  local.get 1
                  i32.add
                  local.tee 1
                  i32.store offset=1060720
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
                    i32.load offset=1060712
                    i32.const -2
                    local.get 4
                    i32.const 3
                    i32.shr_u
                    i32.rotl
                    i32.and
                    i32.store offset=1060712
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
              i32.const 1061016
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
              i32.load offset=1060716
              i32.const -2
              local.get 5
              i32.rotl
              i32.and
              i32.store offset=1060716
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
        i32.load offset=1060732
        i32.ne
        br_if 0 (;@2;)
        i32.const 0
        local.get 1
        i32.store offset=1060720
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
        i32.const 1060752
        i32.add
        local.set 3
        block  ;; label = @3
          block  ;; label = @4
            i32.const 0
            i32.load offset=1060712
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
            i32.store offset=1060712
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
      i32.const 1061016
      i32.add
      local.set 4
      block  ;; label = @2
        i32.const 0
        i32.load offset=1060716
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
        i32.store offset=1060716
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
  (func $internal_memalign (type 1) (param i32 i32) (result i32)
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
      i32.store offset=1061208
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
  (func $close (type 2) (param i32) (result i32)
    call $__wasilibc_populate_preopens
    block  ;; label = @1
      local.get 0
      call $__wasi_fd_close
      local.tee 0
      br_if 0 (;@1;)
      i32.const 0
      return
    end
    i32.const 0
    local.get 0
    i32.store offset=1061208
    i32.const -1)
  (func $_Exit (type 0) (param i32)
    local.get 0
    call $__wasi_proc_exit
    unreachable)
  (func $__wasilibc_ensure_environ (type 11)
    block  ;; label = @1
      i32.const 0
      i32.load offset=1060556
      i32.const -1
      i32.ne
      br_if 0 (;@1;)
      call $__wasilibc_initialize_environ
    end)
  (func $__wasilibc_initialize_environ (type 11)
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
          i32.const 1061212
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
    i32.store offset=1060556
    local.get 0
    i32.const 16
    i32.add
    global.set $__stack_pointer)
  (func $__wasi_environ_get (type 1) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    call $__imported_wasi_snapshot_preview1_environ_get
    i32.const 65535
    i32.and)
  (func $__wasi_environ_sizes_get (type 1) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    call $__imported_wasi_snapshot_preview1_environ_sizes_get
    i32.const 65535
    i32.and)
  (func $__wasi_fd_close (type 2) (param i32) (result i32)
    local.get 0
    call $__imported_wasi_snapshot_preview1_fd_close
    i32.const 65535
    i32.and)
  (func $__wasi_fd_prestat_get (type 1) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    call $__imported_wasi_snapshot_preview1_fd_prestat_get
    i32.const 65535
    i32.and)
  (func $__wasi_fd_prestat_dir_name (type 5) (param i32 i32 i32) (result i32)
    local.get 0
    local.get 1
    local.get 2
    call $__imported_wasi_snapshot_preview1_fd_prestat_dir_name
    i32.const 65535
    i32.and)
  (func $__wasi_proc_exit (type 0) (param i32)
    local.get 0
    call $__imported_wasi_snapshot_preview1_proc_exit
    unreachable)
  (func $abort (type 11)
    unreachable)
  (func $__wasilibc_find_relpath_alloc (type 9) (param i32 i32 i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 5
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
                    i32.load8_u
                    local.tee 6
                    i32.const -46
                    i32.add
                    br_table 0 (;@8;) 6 (;@2;) 1 (;@7;)
                  end
                  local.get 0
                  i32.load8_u offset=1
                  local.tee 6
                  i32.eqz
                  br_if 1 (;@6;)
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 6
                      i32.const 47
                      i32.eq
                      br_if 0 (;@9;)
                      i32.const 0
                      local.set 6
                      br 1 (;@8;)
                    end
                    local.get 0
                    i32.load8_u offset=2
                    i32.eqz
                    br_if 2 (;@6;)
                    i32.const 2
                    local.set 6
                  end
                  local.get 0
                  local.get 6
                  i32.add
                  local.set 0
                  br 2 (;@5;)
                end
                local.get 6
                br_if 1 (;@5;)
              end
              i32.const 0
              i32.load offset=1060560
              local.set 0
              br 1 (;@4;)
            end
            i32.const 0
            i32.load offset=1061216
            local.set 7
            block  ;; label = @5
              i32.const 0
              i32.load offset=1060560
              local.tee 8
              call $strlen
              local.tee 6
              local.get 0
              call $strlen
              i32.add
              local.get 8
              local.get 6
              i32.add
              i32.const -1
              i32.add
              i32.load8_u
              local.tee 9
              i32.const 47
              i32.ne
              local.tee 10
              i32.add
              i32.const 1
              i32.add
              local.tee 11
              i32.const 0
              i32.load offset=1061220
              i32.le_u
              br_if 0 (;@5;)
              local.get 7
              local.get 11
              call $realloc
              local.tee 7
              i32.eqz
              br_if 2 (;@3;)
              i32.const 0
              local.get 11
              i32.store offset=1061220
              i32.const 0
              local.get 7
              i32.store offset=1061216
              i32.const 0
              i32.load offset=1060560
              local.set 8
            end
            local.get 7
            local.get 8
            call $strcpy
            local.set 7
            block  ;; label = @5
              local.get 9
              i32.const 47
              i32.eq
              br_if 0 (;@5;)
              local.get 7
              local.get 6
              i32.add
              i32.const 47
              i32.store16 align=1
            end
            local.get 7
            local.get 6
            i32.add
            local.get 10
            i32.add
            local.get 0
            call $strcpy
            drop
            local.get 7
            local.set 0
          end
          local.get 0
          br_if 1 (;@2;)
        end
        i32.const 0
        i32.const 48
        i32.store offset=1061208
        i32.const -1
        local.set 0
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 0
        local.get 1
        local.get 5
        i32.const 12
        i32.add
        call $__wasilibc_find_abspath
        local.tee 0
        i32.const -1
        i32.ne
        br_if 0 (;@2;)
        i32.const -1
        local.set 0
        br 1 (;@1;)
      end
      block  ;; label = @2
        block  ;; label = @3
          local.get 3
          i32.load
          local.get 5
          i32.load offset=12
          local.tee 1
          call $strlen
          i32.const 1
          i32.add
          local.tee 7
          i32.lt_u
          br_if 0 (;@3;)
          local.get 2
          i32.load
          local.set 6
          br 1 (;@2;)
        end
        block  ;; label = @3
          local.get 4
          br_if 0 (;@3;)
          i32.const 0
          i32.const 68
          i32.store offset=1061208
          i32.const -1
          local.set 0
          br 2 (;@1;)
        end
        block  ;; label = @3
          local.get 2
          i32.load
          local.get 7
          call $realloc
          local.tee 6
          br_if 0 (;@3;)
          i32.const 0
          i32.const 48
          i32.store offset=1061208
          i32.const -1
          local.set 0
          br 2 (;@1;)
        end
        local.get 3
        local.get 7
        i32.store
        local.get 2
        local.get 6
        i32.store
        local.get 5
        i32.load offset=12
        local.set 1
      end
      local.get 6
      local.get 1
      call $strcpy
      drop
    end
    local.get 5
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $getcwd (type 1) (param i32 i32) (result i32)
    (local i32)
    i32.const 0
    i32.load offset=1060560
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
        i32.store offset=1061208
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
        i32.store offset=1061208
        i32.const 0
        return
      end
      local.get 0
      local.get 2
      call $strcpy
      local.set 0
    end
    local.get 0)
  (func $__wasilibc_populate_preopens (type 11)
    (local i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 0
    global.set $__stack_pointer
    block  ;; label = @1
      i32.const 0
      i32.load8_u offset=1061232
      i32.const 1
      i32.and
      br_if 0 (;@1;)
      i32.const 0
      i32.load8_u offset=1061232
      i32.const 1
      i32.and
      br_if 0 (;@1;)
      i32.const 3
      local.set 1
      block  ;; label = @2
        block  ;; label = @3
          loop  ;; label = @4
            block  ;; label = @5
              local.get 1
              local.get 0
              i32.const 8
              i32.add
              call $__wasi_fd_prestat_get
              local.tee 2
              i32.eqz
              br_if 0 (;@5;)
              local.get 2
              i32.const 8
              i32.ne
              br_if 2 (;@3;)
              i32.const 0
              i32.const 1
              i32.store8 offset=1061232
              br 4 (;@1;)
            end
            block  ;; label = @5
              local.get 0
              i32.load8_u offset=8
              br_if 0 (;@5;)
              local.get 0
              i32.load offset=12
              local.tee 3
              i32.const 1
              i32.add
              call $malloc
              local.tee 2
              i32.eqz
              br_if 3 (;@2;)
              local.get 1
              local.get 2
              local.get 3
              call $__wasi_fd_prestat_dir_name
              br_if 2 (;@3;)
              local.get 2
              local.get 0
              i32.load offset=12
              i32.add
              i32.const 0
              i32.store8
              local.get 1
              local.get 2
              call $internal_register_preopened_fd_unlocked
              br_if 3 (;@2;)
              local.get 2
              call $free
            end
            local.get 1
            i32.const 1
            i32.add
            local.set 1
            br 0 (;@4;)
          end
        end
        i32.const 71
        call $_Exit
        unreachable
      end
      i32.const 70
      call $_Exit
      unreachable
    end
    local.get 0
    i32.const 16
    i32.add
    global.set $__stack_pointer)
  (func $internal_register_preopened_fd_unlocked (type 1) (param i32 i32) (result i32)
    (local i32 i32 i32 i32)
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.const 2
        i32.add
        br_table 1 (;@1;) 1 (;@1;) 0 (;@2;)
      end
      local.get 1
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        i32.const 0
        i32.load offset=1061224
        local.tee 2
        i32.const 0
        i32.load offset=1061236
        i32.ne
        br_if 0 (;@2;)
        i32.const 0
        i32.load offset=1061228
        local.set 3
        block  ;; label = @3
          i32.const 8
          local.get 2
          i32.const 1
          i32.shl
          i32.const 4
          local.get 2
          select
          local.tee 4
          call $calloc
          local.tee 5
          br_if 0 (;@3;)
          i32.const -1
          return
        end
        local.get 5
        local.get 3
        local.get 2
        i32.const 3
        i32.shl
        call $memcpy
        local.set 5
        i32.const 0
        local.get 4
        i32.store offset=1061236
        i32.const 0
        local.get 5
        i32.store offset=1061228
        local.get 3
        call $free
      end
      block  ;; label = @2
        loop  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 1
              local.tee 3
              i32.load8_u
              i32.const -46
              i32.add
              br_table 1 (;@4;) 0 (;@5;) 3 (;@2;)
            end
            local.get 3
            i32.const 1
            i32.add
            local.set 1
            br 1 (;@3;)
          end
          local.get 3
          i32.const 1
          i32.add
          local.set 1
          local.get 3
          i32.load8_u offset=1
          local.tee 4
          i32.eqz
          br_if 0 (;@3;)
          local.get 4
          i32.const 47
          i32.ne
          br_if 1 (;@2;)
          local.get 3
          i32.const 2
          i32.add
          local.set 1
          br 0 (;@3;)
        end
      end
      block  ;; label = @2
        local.get 3
        call $strdup
        local.tee 3
        br_if 0 (;@2;)
        i32.const -1
        return
      end
      i32.const 0
      local.get 2
      i32.const 1
      i32.add
      i32.store offset=1061224
      i32.const 0
      i32.load offset=1061228
      local.get 2
      i32.const 3
      i32.shl
      i32.add
      local.tee 1
      local.get 0
      i32.store offset=4
      local.get 1
      local.get 3
      i32.store
      i32.const 0
      return
    end
    call $abort
    unreachable)
  (func $__wasilibc_find_relpath (type 8) (param i32 i32 i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 4
    global.set $__stack_pointer
    local.get 4
    local.get 3
    i32.store offset=12
    block  ;; label = @1
      block  ;; label = @2
        i32.const 90
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        local.get 1
        local.get 2
        local.get 4
        i32.const 12
        i32.add
        i32.const 0
        call $__wasilibc_find_relpath_alloc
        local.set 3
        br 1 (;@1;)
      end
      local.get 0
      local.get 1
      local.get 2
      call $__wasilibc_find_abspath
      local.set 3
    end
    local.get 4
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 3)
  (func $__wasilibc_find_abspath (type 5) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32)
    local.get 0
    i32.const -1
    i32.add
    local.set 0
    call $__wasilibc_populate_preopens
    loop  ;; label = @1
      local.get 0
      i32.const 1
      i32.add
      local.tee 0
      i32.load8_u
      i32.const 47
      i32.eq
      br_if 0 (;@1;)
    end
    i32.const 0
    local.set 3
    block  ;; label = @1
      block  ;; label = @2
        i32.const 0
        i32.load offset=1061224
        local.tee 4
        i32.eqz
        br_if 0 (;@2;)
        i32.const 0
        i32.load offset=1061228
        local.set 5
        i32.const -1
        local.set 6
        loop  ;; label = @3
          local.get 5
          local.get 4
          i32.const 3
          i32.shl
          i32.add
          local.tee 7
          i32.const -8
          i32.add
          i32.load
          local.tee 8
          call $strlen
          local.set 9
          block  ;; label = @4
            block  ;; label = @5
              local.get 6
              i32.const -1
              i32.eq
              br_if 0 (;@5;)
              local.get 9
              local.get 3
              i32.le_u
              br_if 1 (;@4;)
            end
            local.get 0
            i32.load8_u
            local.set 10
            block  ;; label = @5
              block  ;; label = @6
                local.get 9
                br_if 0 (;@6;)
                local.get 10
                i32.const 255
                i32.and
                i32.const 47
                i32.ne
                br_if 1 (;@5;)
              end
              local.get 0
              local.get 8
              local.get 9
              call $memcmp
              br_if 1 (;@4;)
              block  ;; label = @6
                local.get 9
                i32.eqz
                br_if 0 (;@6;)
                local.get 8
                i32.const -1
                i32.add
                local.set 11
                local.get 9
                local.set 10
                block  ;; label = @7
                  loop  ;; label = @8
                    local.get 11
                    local.get 10
                    i32.add
                    i32.load8_u
                    i32.const 47
                    i32.ne
                    br_if 1 (;@7;)
                    local.get 10
                    i32.const -1
                    i32.add
                    local.tee 10
                    br_if 0 (;@8;)
                  end
                  i32.const 0
                  local.set 10
                end
                local.get 0
                local.get 10
                i32.add
                i32.load8_u
                local.set 10
              end
              local.get 10
              i32.const 255
              i32.and
              local.tee 10
              i32.const 47
              i32.eq
              br_if 0 (;@5;)
              local.get 10
              br_if 1 (;@4;)
            end
            local.get 1
            local.get 8
            i32.store
            local.get 7
            i32.const -4
            i32.add
            i32.load
            local.set 6
            local.get 9
            local.set 3
          end
          local.get 4
          i32.const -1
          i32.add
          local.tee 4
          br_if 0 (;@3;)
        end
        local.get 6
        i32.const -1
        i32.ne
        br_if 1 (;@1;)
      end
      i32.const 0
      i32.const 44
      i32.store offset=1061208
      i32.const -1
      return
    end
    local.get 0
    local.get 3
    i32.add
    i32.const -1
    i32.add
    local.set 0
    loop  ;; label = @1
      local.get 0
      i32.const 1
      i32.add
      local.tee 0
      i32.load8_u
      local.tee 4
      i32.const 47
      i32.eq
      br_if 0 (;@1;)
    end
    local.get 2
    local.get 0
    i32.const 1054422
    local.get 4
    select
    i32.store
    local.get 6)
  (func $sbrk (type 2) (param i32) (result i32)
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
        i32.store offset=1061208
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
  (func $getenv (type 2) (param i32) (result i32)
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
      i32.load offset=1060556
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
  (func $dummy (type 11))
  (func $__wasm_call_dtors (type 11)
    call $dummy
    call $dummy)
  (func $memcmp (type 5) (param i32 i32 i32) (result i32)
    (local i32 i32 i32)
    i32.const 0
    local.set 3
    block  ;; label = @1
      local.get 2
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        loop  ;; label = @3
          local.get 0
          i32.load8_u
          local.tee 4
          local.get 1
          i32.load8_u
          local.tee 5
          i32.ne
          br_if 1 (;@2;)
          local.get 1
          i32.const 1
          i32.add
          local.set 1
          local.get 0
          i32.const 1
          i32.add
          local.set 0
          local.get 2
          i32.const -1
          i32.add
          local.tee 2
          br_if 0 (;@3;)
          br 2 (;@1;)
        end
      end
      local.get 4
      local.get 5
      i32.sub
      local.set 3
    end
    local.get 3)
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
  (func $__strchrnul (type 1) (param i32 i32) (result i32)
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
  (func $__stpcpy (type 1) (param i32 i32) (result i32)
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
  (func $strcpy (type 1) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    call $__stpcpy
    drop
    local.get 0)
  (func $strdup (type 2) (param i32) (result i32)
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
  (func $dummy.1 (type 1) (param i32 i32) (result i32)
    local.get 0)
  (func $__lctrans (type 1) (param i32 i32) (result i32)
    local.get 0
    local.get 1
    call $dummy.1)
  (func $strerror (type 2) (param i32) (result i32)
    (local i32)
    block  ;; label = @1
      i32.const 0
      i32.load offset=1061264
      local.tee 1
      br_if 0 (;@1;)
      i32.const 1061240
      local.set 1
      i32.const 0
      i32.const 1061240
      i32.store offset=1061264
    end
    i32.const 0
    local.get 0
    local.get 0
    i32.const 76
    i32.gt_u
    select
    i32.const 1
    i32.shl
    i32.const 1055984
    i32.add
    i32.load16_u
    i32.const 1054424
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
  (func $strlen (type 2) (param i32) (result i32)
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
  (func $_ZN4core3fmt5Write9write_fmt17hf6935026b7772529E (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.const 1056144
    local.get 1
    call $_ZN4core3fmt5write17hb4e267bf92503392E)
  (func $_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h6ac393afd571ad54E (type 0) (param i32)
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
  (func $_ZN53_$LT$core..fmt..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17hffe343f4ed8e1477E (type 1) (param i32 i32) (result i32)
    local.get 1
    i32.const 1056138
    i32.const 5
    call $_ZN4core3fmt9Formatter9write_str17hdf9d14a3fcabff76E)
  (func $_ZN5alloc7raw_vec17capacity_overflow17h9658cfb2639ec95eE (type 0) (param i32)
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
    i32.const 1056188
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
  (func $_ZN5alloc7raw_vec11finish_grow17hfbb7e2842f19eb9bE (type 6) (param i32 i32 i32 i32)
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
              i32.load8_u offset=1060573
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
          i32.load8_u offset=1060573
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
  (func $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hf425d9260fa199c2E (type 4) (param i32 i32 i32)
    (local i32 i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 3
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
          local.set 4
          br 1 (;@2;)
        end
        i32.const 0
        local.set 4
        block  ;; label = @3
          local.get 2
          local.get 0
          i32.load
          local.tee 5
          i32.const 1
          i32.shl
          local.tee 1
          local.get 2
          local.get 1
          i32.gt_u
          select
          local.tee 1
          i32.const 8
          local.get 1
          i32.const 8
          i32.gt_u
          select
          local.tee 1
          i32.const 0
          i32.ge_s
          br_if 0 (;@3;)
          br 1 (;@2;)
        end
        i32.const 0
        local.set 2
        block  ;; label = @3
          local.get 5
          i32.eqz
          br_if 0 (;@3;)
          local.get 3
          local.get 5
          i32.store offset=28
          local.get 3
          local.get 0
          i32.load offset=4
          i32.store offset=20
          i32.const 1
          local.set 2
        end
        local.get 3
        local.get 2
        i32.store offset=24
        local.get 3
        i32.const 8
        i32.add
        i32.const 1
        local.get 1
        local.get 3
        i32.const 20
        i32.add
        call $_ZN5alloc7raw_vec11finish_grow17hfbb7e2842f19eb9bE
        local.get 3
        i32.load offset=8
        i32.const 1
        i32.ne
        br_if 1 (;@1;)
        local.get 3
        i32.load offset=16
        local.set 0
        local.get 3
        i32.load offset=12
        local.set 4
      end
      local.get 4
      local.get 0
      i32.const 1056228
      call $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E
      unreachable
    end
    local.get 3
    i32.load offset=12
    local.set 2
    local.get 0
    local.get 1
    i32.store
    local.get 0
    local.get 2
    i32.store offset=4
    local.get 3
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $_ZN5alloc5alloc18handle_alloc_error17hcc35c2aed22157a6E (type 3) (param i32 i32)
    local.get 1
    local.get 0
    call $_RNvCs691rhTbG0Ee_7___rustc26___rust_alloc_error_handler
    unreachable)
  (func $_ZN256_$LT$alloc..boxed..convert..$LT$impl$u20$core..convert..From$LT$alloc..string..String$GT$$u20$for$u20$alloc..boxed..Box$LT$dyn$u20$core..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$$GT$..from..StringError$u20$as$u20$core..error..Error$GT$11description17h483f5746e679cc2fE (type 3) (param i32 i32)
    local.get 0
    local.get 1
    i64.load offset=4 align=4
    i64.store)
  (func $_ZN256_$LT$alloc..boxed..convert..$LT$impl$u20$core..convert..From$LT$alloc..string..String$GT$$u20$for$u20$alloc..boxed..Box$LT$dyn$u20$core..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$$GT$..from..StringError$u20$as$u20$core..fmt..Display$GT$3fmt17h2cac5981db7cc6d2E (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.load offset=4
    local.get 0
    i32.load offset=8
    local.get 1
    call $_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17hf7f012776df7e14cE)
  (func $_ZN254_$LT$alloc..boxed..convert..$LT$impl$u20$core..convert..From$LT$alloc..string..String$GT$$u20$for$u20$alloc..boxed..Box$LT$dyn$u20$core..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$$GT$..from..StringError$u20$as$u20$core..fmt..Debug$GT$3fmt17h12b13d887e4fa65aE (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.load offset=4
    local.get 0
    i32.load offset=8
    local.get 1
    call $_ZN40_$LT$str$u20$as$u20$core..fmt..Debug$GT$3fmt17he4df7632dab5ca2aE)
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
            i32.load8_u offset=1060573
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
          i32.const 1056320
          call $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E
          unreachable
        end
        i32.const 1056336
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
  (func $_ZN5alloc3ffi5c_str7CString19_from_vec_unchecked17h444898f7bcaf2199E (type 3) (param i32 i32)
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
        i32.const 1056352
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
  (func $_ZN5alloc3fmt6format12format_inner17h79d363dc4fdc0dbbE (type 3) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 1
              i32.load offset=4
              local.tee 3
              i32.eqz
              br_if 0 (;@5;)
              local.get 1
              i32.load
              local.set 4
              local.get 3
              i32.const 3
              i32.and
              local.set 5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 3
                  i32.const 4
                  i32.ge_u
                  br_if 0 (;@7;)
                  i32.const 0
                  local.set 3
                  i32.const 0
                  local.set 6
                  br 1 (;@6;)
                end
                local.get 4
                i32.const 28
                i32.add
                local.set 7
                local.get 3
                i32.const -4
                i32.and
                local.set 8
                i32.const 0
                local.set 3
                i32.const 0
                local.set 6
                loop  ;; label = @7
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
                  local.get 3
                  i32.add
                  i32.add
                  i32.add
                  i32.add
                  local.set 3
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
                  br_if 0 (;@7;)
                end
              end
              block  ;; label = @6
                local.get 5
                i32.eqz
                br_if 0 (;@6;)
                local.get 6
                i32.const 3
                i32.shl
                local.get 4
                i32.add
                i32.const 4
                i32.add
                local.set 7
                loop  ;; label = @7
                  local.get 7
                  i32.load
                  local.get 3
                  i32.add
                  local.set 3
                  local.get 7
                  i32.const 8
                  i32.add
                  local.set 7
                  local.get 5
                  i32.const -1
                  i32.add
                  local.tee 5
                  br_if 0 (;@7;)
                end
              end
              local.get 1
              i32.load offset=12
              i32.eqz
              br_if 2 (;@3;)
              local.get 3
              i32.const 15
              i32.gt_u
              br_if 1 (;@4;)
              local.get 4
              i32.load offset=4
              br_if 1 (;@4;)
              br 3 (;@2;)
            end
            i32.const 0
            local.set 3
            local.get 1
            i32.load offset=12
            i32.eqz
            br_if 2 (;@2;)
          end
          local.get 3
          i32.const 0
          local.get 3
          i32.const 0
          i32.gt_s
          select
          i32.const 1
          i32.shl
          local.set 3
        end
        i32.const 0
        local.set 5
        block  ;; label = @3
          local.get 3
          i32.const 0
          i32.lt_s
          br_if 0 (;@3;)
          local.get 3
          i32.eqz
          br_if 1 (;@2;)
          i32.const 0
          i32.load8_u offset=1060573
          drop
          i32.const 1
          local.set 5
          local.get 3
          i32.const 1
          call $_RNvCs691rhTbG0Ee_7___rustc12___rust_alloc
          local.tee 7
          br_if 2 (;@1;)
        end
        local.get 5
        local.get 3
        i32.const 1056272
        call $_ZN5alloc7raw_vec12handle_error17hb73fb4043b5a38a7E
        unreachable
      end
      i32.const 1
      local.set 7
      i32.const 0
      local.set 3
    end
    local.get 2
    i32.const 0
    i32.store offset=8
    local.get 2
    local.get 7
    i32.store offset=4
    local.get 2
    local.get 3
    i32.store
    block  ;; label = @1
      local.get 2
      i32.const 1056144
      local.get 1
      call $_ZN4core3fmt5write17hb4e267bf92503392E
      br_if 0 (;@1;)
      local.get 0
      local.get 2
      i64.load align=4
      i64.store align=4
      local.get 0
      i32.const 8
      i32.add
      local.get 2
      i32.const 8
      i32.add
      i32.load
      i32.store
      local.get 2
      i32.const 16
      i32.add
      global.set $__stack_pointer
      return
    end
    i32.const 1056384
    i32.const 86
    local.get 2
    i32.const 15
    i32.add
    i32.const 1056368
    i32.const 1056496
    call $_ZN4core6result13unwrap_failed17h398ddd55d54bb216E
    unreachable)
  (func $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$9write_str17hb927a9f601e7c7bcE.1 (type 5) (param i32 i32 i32) (result i32)
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
      call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hf425d9260fa199c2E
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
  (func $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$10write_char17hc99d8b2b5ebe5dd6E.1 (type 1) (param i32 i32) (result i32)
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
      call $_ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17hf425d9260fa199c2E
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
  (func $_ZN4core9panicking9panic_fmt17h127b5c782bf342d9E (type 3) (param i32 i32)
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
  (func $_ZN71_$LT$core..ops..range..Range$LT$Idx$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hcaf36282d85189a7E (type 1) (param i32 i32) (result i32)
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
          i32.const 1057601
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
        i32.const 1057601
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
      i32.const 1057264
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
        i32.const 1057601
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
      i32.const 1057601
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
        i32.const 1057604
        i32.add
        i32.load8_u
        i32.store8
        local.get 7
        i32.const -4
        i32.add
        local.get 10
        i32.const 1057603
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
        i32.const 1057604
        i32.add
        i32.load8_u
        i32.store8
        local.get 7
        i32.const -2
        i32.add
        local.get 8
        i32.const 1057603
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
      i32.const 1057604
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
      i32.const 1057603
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
      i32.const 1057604
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
  (func $_ZN4core3fmt9Formatter12pad_integral17h57e359ed883e3df4E (type 16) (param i32 i32 i32 i32 i32 i32) (result i32)
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
  (func $_ZN70_$LT$core..slice..ascii..EscapeAscii$u20$as$u20$core..fmt..Display$GT$3fmt17h0f4effed075a9015E (type 1) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 0
    i32.const 17
    i32.add
    i32.load8_u
    local.set 3
    local.get 0
    i32.load8_u offset=19
    local.set 4
    local.get 0
    i32.load8_u offset=18
    local.set 5
    local.get 0
    i32.load offset=4
    local.set 6
    local.get 0
    i32.load
    local.set 7
    local.get 0
    i32.load8_u offset=13
    local.set 8
    local.get 0
    i32.load8_u offset=12
    local.set 9
    local.get 0
    i32.load8_u offset=14
    local.set 10
    local.get 0
    i32.load16_u offset=15 align=1
    local.set 11
    local.get 2
    i32.const 0
    local.get 0
    i32.const 11
    i32.add
    i32.load8_u
    i32.const 24
    i32.shl
    local.get 0
    i32.load16_u offset=9 align=1
    i32.const 8
    i32.shl
    i32.or
    local.get 0
    i32.load8_u offset=8
    local.tee 0
    i32.or
    local.get 0
    i32.const 128
    i32.eq
    local.tee 12
    select
    i32.store offset=8
    i32.const 0
    local.get 10
    local.get 3
    i32.const 24
    i32.shl
    local.get 11
    i32.const 8
    i32.shl
    i32.or
    i32.or
    local.get 10
    i32.const 128
    i32.eq
    local.tee 3
    select
    local.set 13
    i32.const 0
    i32.const 0
    local.get 9
    local.get 12
    select
    i32.const 255
    i32.and
    local.tee 0
    local.get 8
    local.get 0
    local.get 8
    i32.gt_u
    select
    local.get 12
    select
    local.set 9
    local.get 6
    i32.const 1
    local.get 7
    select
    local.get 7
    i32.const 1
    local.get 7
    select
    local.tee 8
    i32.sub
    local.set 12
    i32.const 0
    local.get 5
    local.get 3
    select
    local.set 14
    local.get 1
    i32.load offset=4
    local.set 3
    local.get 1
    i32.load
    local.set 1
    block  ;; label = @1
      block  ;; label = @2
        loop  ;; label = @3
          local.get 9
          local.get 0
          i32.eq
          br_if 1 (;@2;)
          local.get 2
          i32.const 8
          i32.add
          local.get 0
          i32.add
          local.set 7
          local.get 0
          i32.const 1
          i32.add
          local.set 0
          local.get 1
          local.get 7
          i32.load8_u
          local.get 3
          i32.load offset=16
          call_indirect (type 1)
          i32.eqz
          br_if 0 (;@3;)
        end
        i32.const 1
        local.set 6
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 12
        i32.eqz
        br_if 0 (;@2;)
        local.get 3
        i32.load offset=12
        local.set 9
        loop  ;; label = @3
          i32.const 0
          local.set 0
          block  ;; label = @4
            loop  ;; label = @5
              local.get 8
              local.get 0
              i32.add
              i32.load8_u
              local.tee 7
              i32.const -127
              i32.add
              i32.const 255
              i32.and
              i32.const 161
              i32.lt_u
              br_if 1 (;@4;)
              block  ;; label = @6
                block  ;; label = @7
                  local.get 7
                  i32.const -34
                  i32.add
                  br_table 3 (;@4;) 1 (;@6;) 1 (;@6;) 1 (;@6;) 1 (;@6;) 3 (;@4;) 0 (;@7;)
                end
                local.get 7
                i32.const 92
                i32.eq
                br_if 2 (;@4;)
              end
              local.get 12
              local.get 0
              i32.const 1
              i32.add
              local.tee 0
              i32.ne
              br_if 0 (;@5;)
            end
            local.get 12
            local.set 0
          end
          i32.const 1
          local.set 6
          local.get 1
          local.get 8
          local.get 0
          local.get 9
          call_indirect (type 5)
          br_if 2 (;@1;)
          local.get 12
          local.get 0
          i32.eq
          br_if 1 (;@2;)
          local.get 8
          local.get 0
          i32.add
          local.tee 5
          i32.load8_u
          local.tee 11
          i32.const 1059981
          i32.add
          i32.load8_s
          local.tee 7
          i32.const 127
          i32.and
          local.set 8
          block  ;; label = @4
            block  ;; label = @5
              local.get 7
              i32.const 0
              i32.lt_s
              br_if 0 (;@5;)
              i32.const 1
              local.set 7
              br 1 (;@4;)
            end
            block  ;; label = @5
              local.get 8
              br_if 0 (;@5;)
              i32.const 4
              local.set 7
              local.get 11
              i32.const 4
              i32.shr_u
              i32.const 1057266
              i32.add
              i32.load8_u
              i32.const 16
              i32.shl
              local.get 11
              i32.const 15
              i32.and
              i32.const 1057266
              i32.add
              i32.load8_u
              i32.const 24
              i32.shl
              i32.or
              i32.const 30812
              i32.or
              local.set 8
              br 1 (;@4;)
            end
            local.get 8
            i32.const 8
            i32.shl
            i32.const 92
            i32.or
            local.set 8
            i32.const 2
            local.set 7
          end
          local.get 2
          local.get 7
          i32.store8 offset=13
          local.get 2
          i32.const 0
          i32.store8 offset=12
          local.get 2
          local.get 8
          i32.store offset=8
          local.get 1
          local.get 2
          i32.const 8
          i32.add
          local.get 7
          local.get 9
          call_indirect (type 5)
          br_if 2 (;@1;)
          local.get 5
          i32.const 1
          i32.add
          local.set 8
          local.get 12
          local.get 0
          i32.const -1
          i32.xor
          i32.add
          local.tee 12
          br_if 0 (;@3;)
        end
      end
      local.get 2
      local.get 13
      i32.store offset=8
      i32.const 0
      local.get 14
      i32.const 255
      i32.and
      local.tee 0
      local.get 4
      i32.const 255
      i32.and
      local.tee 7
      local.get 0
      local.get 7
      i32.gt_u
      select
      local.get 10
      i32.const 128
      i32.eq
      select
      local.set 8
      block  ;; label = @2
        loop  ;; label = @3
          local.get 8
          local.get 0
          i32.eq
          br_if 1 (;@2;)
          local.get 2
          i32.const 8
          i32.add
          local.get 0
          i32.add
          local.set 7
          local.get 0
          i32.const 1
          i32.add
          local.set 0
          local.get 1
          local.get 7
          i32.load8_u
          local.get 3
          i32.load offset=16
          call_indirect (type 1)
          i32.eqz
          br_if 0 (;@3;)
        end
        i32.const 1
        local.set 6
        br 1 (;@1;)
      end
      i32.const 0
      local.set 6
    end
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 6)
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
                        i32.const 1057266
                        i32.add
                        i32.load8_u
                        i32.store8 offset=11
                        local.get 3
                        local.get 1
                        i32.const 4
                        i32.shr_u
                        i32.const 15
                        i32.and
                        i32.const 1057266
                        i32.add
                        i32.load8_u
                        i32.store8 offset=15
                        local.get 3
                        local.get 1
                        i32.const 8
                        i32.shr_u
                        i32.const 15
                        i32.and
                        i32.const 1057266
                        i32.add
                        i32.load8_u
                        i32.store8 offset=14
                        local.get 3
                        local.get 1
                        i32.const 12
                        i32.shr_u
                        i32.const 15
                        i32.and
                        i32.const 1057266
                        i32.add
                        i32.load8_u
                        i32.store8 offset=13
                        local.get 3
                        local.get 1
                        i32.const 16
                        i32.shr_u
                        i32.const 15
                        i32.and
                        i32.const 1057266
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
                        i32.const 1057266
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
          i32.const 1057266
          i32.add
          i32.load8_u
          i32.store8 offset=23
          local.get 3
          local.get 1
          i32.const 4
          i32.shr_u
          i32.const 15
          i32.and
          i32.const 1057266
          i32.add
          i32.load8_u
          i32.store8 offset=27
          local.get 3
          local.get 1
          i32.const 8
          i32.shr_u
          i32.const 15
          i32.and
          i32.const 1057266
          i32.add
          i32.load8_u
          i32.store8 offset=26
          local.get 3
          local.get 1
          i32.const 12
          i32.shr_u
          i32.const 15
          i32.and
          i32.const 1057266
          i32.add
          i32.load8_u
          i32.store8 offset=25
          local.get 3
          local.get 1
          i32.const 16
          i32.shr_u
          i32.const 15
          i32.and
          i32.const 1057266
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
          i32.const 1057266
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
  (func $_ZN4core3str5count14do_count_chars17h3f21c085b7864607E (type 1) (param i32 i32) (result i32)
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
  (func $_ZN63_$LT$core..cell..BorrowMutError$u20$as$u20$core..fmt..Debug$GT$3fmt17h222c0dff95342636E (type 1) (param i32 i32) (result i32)
    local.get 1
    i32.load
    i32.const 1057292
    i32.const 14
    local.get 1
    i32.load offset=4
    i32.load offset=12
    call_indirect (type 5))
  (func $_ZN4core4cell22panic_already_borrowed17h95614011b014b567E (type 0) (param i32)
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
    i32.const 1057324
    i32.store offset=8
    local.get 1
    i64.const 1
    i64.store offset=20 align=4
    local.get 1
    i32.const 96
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
  (func $_ZN4core7unicode12unicode_data15grapheme_extend11lookup_slow17h8ec48f5652b05045E (type 2) (param i32) (result i32)
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
    i32.const 1060392
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
    i32.const 1060392
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
    i32.const 1060392
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
    i32.const 1060392
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
    i32.const 1060392
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
    i32.const 1060392
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
    i32.const 1060392
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
        i32.const 1056512
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
  (func $_ZN4core7unicode9printable12is_printable17h341793aa4c76ac40E (type 2) (param i32) (result i32)
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
      i32.const 1058532
      i32.const 44
      i32.const 1058620
      i32.const 208
      i32.const 1058828
      i32.const 486
      call $_ZN4core7unicode9printable5check17h8bb7cfb0a6a631caE
      return
    end
    local.get 0
    i32.const 1059314
    i32.const 40
    i32.const 1059394
    i32.const 290
    i32.const 1059684
    i32.const 297
    call $_ZN4core7unicode9printable5check17h8bb7cfb0a6a631caE)
  (func $_ZN59_$LT$core..ffi..c_str..CStr$u20$as$u20$core..fmt..Debug$GT$3fmt17h7fd1a31f0b134679E (type 5) (param i32 i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 64
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 3
    i32.const 2
    i32.store offset=12
    local.get 3
    i32.const 1057332
    i32.store offset=8
    local.get 3
    i64.const 1
    i64.store offset=20 align=4
    local.get 3
    i32.const 128
    i32.store8 offset=58
    local.get 3
    i32.const 128
    i32.store8 offset=52
    local.get 3
    i32.const 97
    i64.extend_i32_u
    i64.const 32
    i64.shl
    local.get 3
    i32.const 44
    i32.add
    i64.extend_i32_u
    i64.or
    i64.store offset=32
    local.get 3
    local.get 0
    i32.store offset=44
    local.get 3
    local.get 0
    local.get 1
    i32.add
    i32.const -1
    i32.add
    i32.store offset=48
    local.get 3
    local.get 3
    i32.const 32
    i32.add
    i32.store offset=16
    local.get 2
    i32.load
    local.get 2
    i32.load offset=4
    local.get 3
    i32.const 8
    i32.add
    call $_ZN4core3fmt5write17hb4e267bf92503392E
    local.set 0
    local.get 3
    i32.const 64
    i32.add
    global.set $__stack_pointer
    local.get 0)
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
                                      i32.const 1057963
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
        i32.const 1057587
        i32.const 1057584
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
        i32.const 1057536
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
        call_indirect (type 1)
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
        i32.const 1057589
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
      i32.const 1057556
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
      i32.const 1057536
      i32.const 2
      call $_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h21cf2d4c44ad3142E
      br_if 0 (;@1;)
      local.get 3
      local.get 5
      i32.const 16
      i32.add
      local.get 4
      i32.load offset=12
      call_indirect (type 1)
      br_if 0 (;@1;)
      local.get 5
      i32.load offset=16
      i32.const 1057592
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
  (func $_ZN4core3fmt3num3imp51_$LT$impl$u20$core..fmt..Display$u20$for$u20$u8$GT$3fmt17h3aee1a4af9b1cd21E (type 1) (param i32 i32) (result i32)
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
      i32.const 1057604
      i32.add
      i32.load8_u
      i32.store8 offset=15
      local.get 2
      local.get 5
      i32.const 1057603
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
      i32.const 1057604
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
  (func $_ZN4core6result13unwrap_failed17h398ddd55d54bb216E (type 13) (param i32 i32 i32 i32 i32)
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
    i32.const 1057540
    i32.store offset=24
    local.get 5
    i64.const 2
    i64.store offset=36 align=4
    local.get 5
    i32.const 98
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
    i32.const 99
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
  (func $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h5cd5bf496cf18c08E (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.load
    i32.const 1
    local.get 1
    call $_ZN4core3fmt3num3imp21_$LT$impl$u20$u32$GT$4_fmt17hc1581077febdde3aE)
  (func $_ZN4core6option13unwrap_failed17habb842812e602dc6E (type 0) (param i32)
    i32.const 1057348
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
    i32.const 1057284
    i32.store offset=16
    local.get 3
    i64.const 1
    i64.store offset=28 align=4
    local.get 3
    i32.const 99
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
  (func $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h2efaf87080996a5eE (type 1) (param i32 i32) (result i32)
    local.get 1
    local.get 0
    i32.load
    local.get 0
    i32.load offset=4
    call $_ZN4core3fmt9Formatter3pad17hcc32532bfecc9527E)
  (func $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i32$GT$3fmt17h33f159b23376b92cE (type 1) (param i32 i32) (result i32)
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
    i32.const 1057601
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
  (func $_ZN4core9panicking19assert_failed_inner17ha727a1f35658cb19E (type 17) (param i32 i32 i32 i32 i32 i32 i32)
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
    i32.const 1060540
    i32.add
    i32.load
    i32.store offset=28
    local.get 7
    local.get 2
    i32.const 1060528
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
      i32.const 1057504
      i32.store offset=88
      local.get 7
      i64.const 4
      i64.store offset=100 align=4
      local.get 7
      i32.const 98
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
      i32.const 100
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
      i32.const 99
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
    i32.const 1057452
    i32.store offset=88
    local.get 7
    i64.const 3
    i64.store offset=100 align=4
    local.get 7
    i32.const 98
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
    i32.const 99
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
  (func $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h7b5d3569f767cb83E (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.load
    local.get 1
    local.get 0
    i32.load offset=4
    i32.load offset=12
    call_indirect (type 1))
  (func $_ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17h511711e1bbf1c9f9E (type 1) (param i32 i32) (result i32)
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
            i32.const 1057580
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
  (func $_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$10write_char17he1f0cb056f10b73fE (type 1) (param i32 i32) (result i32)
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
      i32.const 1057580
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
    call_indirect (type 1))
  (func $_ZN4core3fmt8builders11DebugStruct6finish17h9c0eaac50360f7e7E (type 2) (param i32) (result i32)
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
          i32.const 1057595
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
        i32.const 1057594
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
  (func $_ZN4core3fmt8builders10DebugTuple5field17h637fae3119e1c9c0E (type 5) (param i32 i32 i32) (result i32)
    (local i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    local.get 0
    i32.load
    local.set 4
    i32.const 1
    local.set 5
    block  ;; label = @1
      local.get 0
      i32.load8_u offset=8
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 0
        i32.load offset=4
        local.tee 6
        i32.load8_u offset=10
        i32.const 128
        i32.and
        br_if 0 (;@2;)
        i32.const 1
        local.set 5
        local.get 6
        i32.load
        i32.const 1057587
        i32.const 1057597
        local.get 4
        select
        i32.const 2
        i32.const 1
        local.get 4
        select
        local.get 6
        i32.load offset=4
        i32.load offset=12
        call_indirect (type 5)
        br_if 1 (;@1;)
        local.get 1
        local.get 6
        local.get 2
        i32.load offset=12
        call_indirect (type 1)
        local.set 5
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 4
        br_if 0 (;@2;)
        i32.const 1
        local.set 5
        local.get 6
        i32.load
        i32.const 1057598
        i32.const 2
        local.get 6
        i32.load offset=4
        i32.load offset=12
        call_indirect (type 5)
        br_if 1 (;@1;)
      end
      i32.const 1
      local.set 5
      local.get 3
      i32.const 1
      i32.store8 offset=15
      local.get 3
      i32.const 1057556
      i32.store offset=20
      local.get 3
      local.get 6
      i64.load align=4
      i64.store align=4
      local.get 3
      local.get 6
      i64.load offset=8 align=4
      i64.store offset=24 align=4
      local.get 3
      local.get 3
      i32.const 15
      i32.add
      i32.store offset=8
      local.get 3
      local.get 3
      i32.store offset=16
      local.get 1
      local.get 3
      i32.const 16
      i32.add
      local.get 2
      i32.load offset=12
      call_indirect (type 1)
      br_if 0 (;@1;)
      local.get 3
      i32.load offset=16
      i32.const 1057592
      i32.const 2
      local.get 3
      i32.load offset=20
      i32.load offset=12
      call_indirect (type 5)
      local.set 5
    end
    local.get 0
    local.get 5
    i32.store8 offset=8
    local.get 0
    local.get 4
    i32.const 1
    i32.add
    i32.store
    local.get 3
    i32.const 32
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $_ZN4core3fmt8builders10DebugTuple6finish17hd2824a8dc5a513d2E (type 2) (param i32) (result i32)
    (local i32 i32 i32)
    local.get 0
    i32.load8_u offset=8
    local.set 1
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.load
        local.tee 2
        br_if 0 (;@2;)
        local.get 1
        local.set 3
        br 1 (;@1;)
      end
      i32.const 1
      local.set 3
      block  ;; label = @2
        block  ;; label = @3
          local.get 1
          i32.const 1
          i32.and
          br_if 0 (;@3;)
          local.get 2
          i32.const 1
          i32.ne
          br_if 1 (;@2;)
          local.get 0
          i32.load8_u offset=9
          i32.eqz
          br_if 1 (;@2;)
          local.get 0
          i32.load offset=4
          local.tee 1
          i32.load8_u offset=10
          i32.const 128
          i32.and
          br_if 1 (;@2;)
          i32.const 1
          local.set 3
          local.get 1
          i32.load
          i32.const 1057600
          i32.const 1
          local.get 1
          i32.load offset=4
          i32.load offset=12
          call_indirect (type 5)
          i32.eqz
          br_if 1 (;@2;)
        end
        local.get 0
        local.get 3
        i32.store8 offset=8
        br 1 (;@1;)
      end
      local.get 0
      local.get 0
      i32.load offset=4
      local.tee 3
      i32.load
      i32.const 1057263
      i32.const 1
      local.get 3
      i32.load offset=4
      i32.load offset=12
      call_indirect (type 5)
      local.tee 3
      i32.store8 offset=8
    end
    local.get 3
    i32.const 1
    i32.and)
  (func $_ZN4core3fmt5Write9write_fmt17h1155b5ded69ce2afE (type 1) (param i32 i32) (result i32)
    local.get 0
    i32.const 1057556
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
  (func $_ZN4core3fmt9Formatter12debug_struct17h8b04cc0c27469750E (type 6) (param i32 i32 i32 i32)
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
  (func $_ZN4core3fmt9Formatter26debug_struct_field1_finish17h34904a7ebe8413d1E (type 18) (param i32 i32 i32 i32 i32 i32 i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 7
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
    local.get 7
    i32.const 0
    i32.store8 offset=13
    local.get 7
    local.get 2
    i32.store8 offset=12
    local.get 7
    local.get 0
    i32.store offset=8
    local.get 7
    i32.const 8
    i32.add
    local.get 3
    local.get 4
    local.get 5
    local.get 6
    call $_ZN4core3fmt8builders11DebugStruct5field17h13f66060f544090dE
    local.set 6
    local.get 7
    i32.load8_u offset=13
    local.tee 2
    local.get 7
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
        local.get 6
        i32.load
        local.tee 0
        i32.load8_u offset=10
        i32.const 128
        i32.and
        br_if 0 (;@2;)
        local.get 0
        i32.load
        i32.const 1057595
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
      i32.const 1057594
      i32.const 1
      local.get 0
      i32.load offset=4
      i32.load offset=12
      call_indirect (type 5)
      local.set 0
    end
    local.get 7
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 0
    i32.const 1
    i32.and)
  (func $_ZN4core3fmt9Formatter26debug_struct_field2_finish17h05c90c1de6f82831E (type 19) (param i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32) (result i32)
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
        i32.const 1057595
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
      i32.const 1057594
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
  (func $_ZN4core3fmt9Formatter11debug_tuple17h3f925525b32910b2E (type 6) (param i32 i32 i32 i32)
    local.get 0
    local.get 1
    i32.load
    local.get 2
    local.get 3
    local.get 1
    i32.load offset=4
    i32.load offset=12
    call_indirect (type 5)
    i32.store8 offset=8
    local.get 0
    local.get 1
    i32.store offset=4
    local.get 0
    local.get 3
    i32.eqz
    i32.store8 offset=9
    local.get 0
    i32.const 0
    i32.store)
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
          i32.const 1057597
          i32.const 1
          local.get 9
          call_indirect (type 5)
          br_if 2 (;@1;)
          local.get 3
          local.get 0
          local.get 4
          i32.load offset=12
          call_indirect (type 1)
          i32.eqz
          br_if 1 (;@2;)
          br 2 (;@1;)
        end
        local.get 7
        i32.const 1057598
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
        i32.const 1057556
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
        call_indirect (type 1)
        br_if 1 (;@1;)
        local.get 5
        i32.load offset=16
        i32.const 1057592
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
        i32.const 1057600
        i32.const 1
        local.get 0
        i32.load offset=4
        i32.load offset=12
        call_indirect (type 5)
        br_if 1 (;@1;)
      end
      local.get 0
      i32.load
      i32.const 1057263
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
  (func $_ZN43_$LT$bool$u20$as$u20$core..fmt..Display$GT$3fmt17he3b1fcab12cb0898E (type 1) (param i32 i32) (result i32)
    block  ;; label = @1
      local.get 0
      i32.load8_u
      br_if 0 (;@1;)
      local.get 1
      i32.const 1057830
      i32.const 5
      call $_ZN4core3fmt9Formatter3pad17hcc32532bfecc9527E
      return
    end
    local.get 1
    i32.const 1057835
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
      call_indirect (type 1)
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
                    i32.const 1057840
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
                      call_indirect (type 1)
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
        i32.const 1057856
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
      call_indirect (type 1)
      local.set 4
    end
    local.get 3
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 4)
  (func $_ZN4core3str16slice_error_fail17hdf53459d42311535E (type 13) (param i32 i32 i32 i32 i32)
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
  (func $_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h67599d50c3692507E (type 1) (param i32 i32) (result i32)
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
      call_indirect (type 1)
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
          call_indirect (type 1)
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
      call_indirect (type 1)
      local.set 3
    end
    local.get 2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 3)
  (func $_ZN4core5slice6memchr14memchr_aligned17hc1073447135eebe4E (type 6) (param i32 i32 i32 i32)
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
  (func $_ZN4core5slice6memchr7memrchr17h3f286f71ea91eee5E (type 6) (param i32 i32 i32 i32)
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
          i32.const 1057904
          call $_ZN4core5slice5index26slice_start_index_len_fail17hcb91b9a11352b54bE
          unreachable
        end
        local.get 5
        local.get 3
        i32.const 1057920
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
    i32.const 1060292
    i32.store offset=8
    local.get 3
    i64.const 2
    i64.store offset=20 align=4
    local.get 3
    i32.const 19
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
    i32.const 1060324
    i32.store offset=8
    local.get 3
    i64.const 2
    i64.store offset=20 align=4
    local.get 3
    i32.const 19
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
    i32.const 1060376
    i32.store offset=8
    local.get 3
    i64.const 2
    i64.store offset=20 align=4
    local.get 3
    i32.const 19
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
  (func $_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i8$GT$3fmt17h41ed9124bb676b3fE (type 1) (param i32 i32) (result i32)
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
    i32.const 1057601
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
  (func $_ZN4core3str19slice_error_fail_rt17ha139c978b4ba67a8E (type 13) (param i32 i32 i32 i32 i32)
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
          i32.const 1058219
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
            i32.const 1058356
            i32.store offset=48
            local.get 5
            i64.const 5
            i64.store offset=60 align=4
            local.get 5
            i32.const 99
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
            i32.const 101
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
            i32.const 102
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
            i32.const 19
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
          i32.const 1058420
          i32.store offset=48
          local.get 5
          i64.const 3
          i64.store offset=60 align=4
          local.get 5
          i32.const 99
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
          i32.const 19
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
        i32.const 1058260
        i32.store offset=48
        local.get 5
        i64.const 4
        i64.store offset=60 align=4
        local.get 5
        i32.const 99
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
        i32.const 19
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
      i32.const 1058444
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
  (func $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u64$GT$3fmt17hfbc1ed21c1423f7fE (type 1) (param i32 i32) (result i32)
    local.get 0
    i64.load
    i32.const 1
    local.get 1
    call $_ZN4core3fmt3num3imp21_$LT$impl$u20$u64$GT$4_fmt17h81ef77b90521efd4E)
  (func $_ZN4core7unicode9printable5check17h8bb7cfb0a6a631caE (type 18) (param i32 i32 i32 i32 i32 i32 i32) (result i32)
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
          i32.const 1058516
          call $_ZN4core5slice5index22slice_index_order_fail17hacfaea8d0e6739e4E
          unreachable
        end
        local.get 12
        local.get 4
        i32.const 1058516
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
          i32.const 1058500
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
  (func $_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i8$GT$3fmt17he7063fd2fe3493f9E (type 1) (param i32 i32) (result i32)
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
    i32.const 1057601
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
  (func $_ZN4core3fmt3num3imp21_$LT$impl$u20$u64$GT$4_fmt17h81ef77b90521efd4E (type 20) (param i64 i32 i32) (result i32)
    (local i32 i32 i64 i64 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 3
    global.set $__stack_pointer
    i32.const 20
    local.set 4
    local.get 0
    local.set 5
    block  ;; label = @1
      local.get 0
      i64.const 1000
      i64.lt_u
      br_if 0 (;@1;)
      i32.const 20
      local.set 4
      local.get 0
      local.set 6
      loop  ;; label = @2
        local.get 3
        i32.const 12
        i32.add
        local.get 4
        i32.add
        local.tee 7
        i32.const -3
        i32.add
        local.get 6
        local.get 6
        i64.const 10000
        i64.div_u
        local.tee 5
        i64.const 10000
        i64.mul
        i64.sub
        i32.wrap_i64
        local.tee 8
        i32.const 65535
        i32.and
        i32.const 100
        i32.div_u
        local.tee 9
        i32.const 1
        i32.shl
        local.tee 10
        i32.const 1057604
        i32.add
        i32.load8_u
        i32.store8
        local.get 7
        i32.const -4
        i32.add
        local.get 10
        i32.const 1057603
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
        i32.const 1057604
        i32.add
        i32.load8_u
        i32.store8
        local.get 7
        i32.const -2
        i32.add
        local.get 8
        i32.const 1057603
        i32.add
        i32.load8_u
        i32.store8
        local.get 4
        i32.const -4
        i32.add
        local.set 4
        local.get 6
        i64.const 9999999
        i64.gt_u
        local.set 7
        local.get 5
        local.set 6
        local.get 7
        br_if 0 (;@2;)
      end
    end
    block  ;; label = @1
      local.get 5
      i64.const 9
      i64.le_u
      br_if 0 (;@1;)
      local.get 3
      i32.const 12
      i32.add
      local.get 4
      i32.add
      i32.const -1
      i32.add
      local.get 5
      i32.wrap_i64
      local.tee 7
      local.get 7
      i32.const 65535
      i32.and
      i32.const 100
      i32.div_u
      local.tee 7
      i32.const 100
      i32.mul
      i32.sub
      i32.const 65535
      i32.and
      i32.const 1
      i32.shl
      local.tee 8
      i32.const 1057604
      i32.add
      i32.load8_u
      i32.store8
      local.get 3
      i32.const 12
      i32.add
      local.get 4
      i32.const -2
      i32.add
      local.tee 4
      i32.add
      local.get 8
      i32.const 1057603
      i32.add
      i32.load8_u
      i32.store8
      local.get 7
      i64.extend_i32_u
      local.set 5
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i64.eqz
        br_if 0 (;@2;)
        local.get 5
        i64.eqz
        br_if 1 (;@1;)
      end
      local.get 3
      i32.const 12
      i32.add
      local.get 4
      i32.const -1
      i32.add
      local.tee 4
      i32.add
      local.get 5
      i32.wrap_i64
      i32.const 1
      i32.shl
      i32.const 30
      i32.and
      i32.const 1057604
      i32.add
      i32.load8_u
      i32.store8
    end
    local.get 2
    local.get 1
    i32.const 1
    i32.const 0
    local.get 3
    i32.const 12
    i32.add
    local.get 4
    i32.add
    i32.const 20
    local.get 4
    i32.sub
    call $_ZN4core3fmt9Formatter12pad_integral17h57e359ed883e3df4E
    local.set 7
    local.get 3
    i32.const 32
    i32.add
    global.set $__stack_pointer
    local.get 7)
  (func $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17h2e5d1c92a54fe8a1E (type 1) (param i32 i32) (result i32)
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
    i32.const 1057601
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
  (func $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i64$GT$3fmt17h475f7bc048321a9aE (type 1) (param i32 i32) (result i32)
    (local i32 i64 i32)
    global.get $__stack_pointer
    i32.const 128
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 0
    i64.load
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
      i32.wrap_i64
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
      i64.const 15
      i64.gt_u
      local.set 4
      local.get 3
      i64.const 4
      i64.shr_u
      local.set 3
      local.get 4
      br_if 0 (;@1;)
    end
    local.get 1
    i32.const 1
    i32.const 1057601
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
  (func $_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i64$GT$3fmt17h2bf7fe3e6a3e1f66E (type 1) (param i32 i32) (result i32)
    (local i32 i64 i32)
    global.get $__stack_pointer
    i32.const 128
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 0
    i64.load
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
      i32.wrap_i64
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
      i64.const 15
      i64.gt_u
      local.set 4
      local.get 3
      i64.const 4
      i64.shr_u
      local.set 3
      local.get 4
      br_if 0 (;@1;)
    end
    local.get 1
    i32.const 1
    i32.const 1057601
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
  (func $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$i32$GT$3fmt17h7840b0de03a5fc94E (type 1) (param i32 i32) (result i32)
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
  (table (;0;) 106 106 funcref)
  (memory (;0;) 17)
  (global $__stack_pointer (mut i32) (i32.const 1048576))
  (global $GOT.data.internal.__memory_base i32 (i32.const 0))
  (export "memory" (memory 0))
  (export "_start" (func $_start))
  (export "__main_void" (func $__main_void))
  (elem (;0;) (i32.const 1) func $_ZN67_$LT$alloc..boxed..Box$LT$T$C$A$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hf66529acfb7daac0E $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h52e2d67e7b195f58E $_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17h8b348b62ae96333eE $_ZN57_$LT$std..fs..Permissions$u20$as$u20$core..fmt..Debug$GT$3fmt17h31c41953cf56dc3dE $_ZN7wasi_ll4main17h5aa279313bf56a05E $_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17ha904373cb3145bcaE $_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h81cf2e14820d3a06E $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h57ea09d893436990E $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h150c8b3cbd4e8b2cE $_ZN4core3ptr42drop_in_place$LT$std..io..error..Error$GT$17h78a910d02a170d17E $_ZN60_$LT$std..io..error..Error$u20$as$u20$core..fmt..Display$GT$3fmt17h2ced7ae1889d6455E $_ZN58_$LT$std..io..error..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h1f889c652801a153E $_ZN60_$LT$std..io..error..Error$u20$as$u20$core..error..Error$GT$6source17h06ddb842e9dc45b6E $_ZN4core5error5Error7type_id17h61d20a70f528c150E $_ZN60_$LT$std..io..error..Error$u20$as$u20$core..error..Error$GT$11description17hc67db8b1160eacdcE $_ZN60_$LT$std..io..error..Error$u20$as$u20$core..error..Error$GT$5cause17h3d04d7f6a477ff66E $_ZN4core5error5Error7provide17h3cf740c510eafb34E $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hd0fd140cfc9a36efE $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h5cd5bf496cf18c08E $_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$i32$GT$3fmt17h7840b0de03a5fc94E $_ZN60_$LT$alloc..string..String$u20$as$u20$core..fmt..Display$GT$3fmt17h22c8aa5f6d5a984cE $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h7999eed731dd903bE $_ZN98_$LT$std..sys..backtrace..BacktraceLock..print..DisplayBacktrace$u20$as$u20$core..fmt..Display$GT$3fmt17h2855f445b96d4beeE $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h98109e2d277772fbE $_ZN52_$LT$$RF$mut$u20$T$u20$as$u20$core..fmt..Display$GT$3fmt17h0531e392a94f6dbeE $_ZN3std5alloc24default_alloc_error_hook17hfe3584b28bc072faE $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h3150aa17e091748dE $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hb66487f36964aa60E $_ZN4core3ptr238drop_in_place$LT$alloc..boxed..convert..$LT$impl$u20$core..convert..From$LT$alloc..string..String$GT$$u20$for$u20$alloc..boxed..Box$LT$dyn$u20$core..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$$GT$..from..StringError$GT$17h94e06a9b9c0bb73bE $_ZN256_$LT$alloc..boxed..convert..$LT$impl$u20$core..convert..From$LT$alloc..string..String$GT$$u20$for$u20$alloc..boxed..Box$LT$dyn$u20$core..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$$GT$..from..StringError$u20$as$u20$core..fmt..Display$GT$3fmt17h2cac5981db7cc6d2E $_ZN254_$LT$alloc..boxed..convert..$LT$impl$u20$core..convert..From$LT$alloc..string..String$GT$$u20$for$u20$alloc..boxed..Box$LT$dyn$u20$core..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$$GT$..from..StringError$u20$as$u20$core..fmt..Debug$GT$3fmt17h12b13d887e4fa65aE $_ZN4core5error5Error5cause17h26c4b13c0a591580E $_ZN4core5error5Error7type_id17h66f6cc4dd903555dE $_ZN256_$LT$alloc..boxed..convert..$LT$impl$u20$core..convert..From$LT$alloc..string..String$GT$$u20$for$u20$alloc..boxed..Box$LT$dyn$u20$core..error..Error$u2b$core..marker..Sync$u2b$core..marker..Send$GT$$GT$..from..StringError$u20$as$u20$core..error..Error$GT$11description17h483f5746e679cc2fE $_ZN4core5error5Error7provide17hdabe7bd7484a2ac5E $_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hf3306bbd8b6bdd55E $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hf130eefae1d3725aE $_ZN4core3ptr119drop_in_place$LT$std..io..default_write_fmt..Adapter$LT$std..io..cursor..Cursor$LT$$RF$mut$u20$$u5b$u8$u5d$$GT$$GT$$GT$17haa00b3b07a295c2eE $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17hc4a5943773967867E $_ZN4core3fmt5Write10write_char17hebf230d22cf70b0aE $_ZN4core3fmt5Write9write_fmt17h990aa971c551724cE $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17hffca5ab1aa2ac1e7E $_ZN4core3fmt5Write10write_char17h52852870b95da1a0E $_ZN4core3fmt5Write9write_fmt17h345d79298f1724e6E $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17hef3d614a18d92fc0E $_ZN4core3fmt5Write10write_char17ha2bc79364991ee1dE $_ZN4core3fmt5Write9write_fmt17ha99898242d13ca1cE $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17h6c912057206b6ef0E $_ZN4core3fmt5Write10write_char17h8fdb4a4ad22d286fE $_ZN4core3fmt5Write9write_fmt17h9c16d329b6a554acE $_ZN81_$LT$std..io..default_write_fmt..Adapter$LT$T$GT$$u20$as$u20$core..fmt..Write$GT$9write_str17h4153cc3db7e9152aE $_ZN4core3fmt5Write10write_char17hd8cddfdb4fcc7641E $_ZN4core3fmt5Write9write_fmt17ha942ff10abf664dcE $_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17he0b805fdcd295968E $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$9write_str17hb927a9f601e7c7bcE $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$10write_char17hc99d8b2b5ebe5dd6E $_ZN4core3fmt5Write9write_fmt17hd822b868a48f344bE $_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$i32$GT$3fmt17hfbe88f27a048c86dE $_ZN62_$LT$std..io..error..ErrorKind$u20$as$u20$core..fmt..Debug$GT$3fmt17h2b1c6a02c8c0b007E $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Debug$GT$3fmt17ha9bb96ed4384267eE $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h8a99d8c9aca26bbbE $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h2168c0e0eebccb9dE $_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17hd9b88af97f3c2071E $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$5write17hb9727852f7c84a6aE $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$14write_vectored17h0846ae4dacdce16fE $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$17is_write_vectored17h85ccc55a9e1850d4E $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$5flush17h1f2dc7de04349823E $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$9write_all17h6bed96dfd3f6d961E $_ZN3std2io5impls74_$LT$impl$u20$std..io..Write$u20$for$u20$alloc..vec..Vec$LT$u8$C$A$GT$$GT$18write_all_vectored17ha48943a12795c360E $_ZN3std2io5Write9write_fmt17h35f31b561ea91fb1E $_ZN64_$LT$std..sys..stdio..wasi..Stderr$u20$as$u20$std..io..Write$GT$5write17h9130e91513ae60a2E $_ZN64_$LT$std..sys..stdio..wasi..Stderr$u20$as$u20$std..io..Write$GT$14write_vectored17h8711081ec37d5f23E $_ZN64_$LT$std..sys..stdio..wasi..Stderr$u20$as$u20$std..io..Write$GT$17is_write_vectored17h4a91ce14e3ddc646E $_ZN64_$LT$std..sys..stdio..wasi..Stderr$u20$as$u20$std..io..Write$GT$5flush17h7bd1b0dc5a2382a0E $_ZN3std2io5Write9write_all17h55293c4c3ff1edf7E $_ZN3std2io5Write18write_all_vectored17h0a60c130116d5293E $_ZN3std2io5Write9write_fmt17he070a5b119ee3d3cE $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h91f73deee89ea2feE $_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h4efe53c54189bac6E $_ZN92_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..fmt..Display$GT$3fmt17ha2cf78d2946fbf30E $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17hda4884f51fc1d63cE $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17hc9ba6339c6f888eeE $_ZN99_$LT$std..panicking..begin_panic_handler..StaticStrPayload$u20$as$u20$core..panic..PanicPayload$GT$6as_str17hacc42b4685d93ce5E $_ZN4core3ptr77drop_in_place$LT$std..panicking..begin_panic_handler..FormatStringPayload$GT$17ha0e54a94adfb7416E $_ZN95_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..fmt..Display$GT$3fmt17h698b05d4ac7f59faE $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$8take_box17h91eecedfd0f5623eE $_ZN102_$LT$std..panicking..begin_panic_handler..FormatStringPayload$u20$as$u20$core..panic..PanicPayload$GT$3get17h6cc4b8d5c4351f3cE $_ZN4core5panic12PanicPayload6as_str17h72bb6430629ae496E $_ZN64_$LT$core..str..error..Utf8Error$u20$as$u20$core..fmt..Debug$GT$3fmt17he058c9f858a9d8f5E $__wasilibc_find_relpath_alloc $_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h6ac393afd571ad54E $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$9write_str17hb927a9f601e7c7bcE.1 $_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Write$GT$10write_char17hc99d8b2b5ebe5dd6E.1 $_ZN4core3fmt5Write9write_fmt17hf6935026b7772529E $_ZN53_$LT$core..fmt..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17hffe343f4ed8e1477E $_ZN63_$LT$core..cell..BorrowMutError$u20$as$u20$core..fmt..Debug$GT$3fmt17h222c0dff95342636E $_ZN70_$LT$core..slice..ascii..EscapeAscii$u20$as$u20$core..fmt..Display$GT$3fmt17h0f4effed075a9015E $_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h7b5d3569f767cb83E $_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h2efaf87080996a5eE $_ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17h511711e1bbf1c9f9E $_ZN71_$LT$core..ops..range..Range$LT$Idx$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17hcaf36282d85189a7E $_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h67599d50c3692507E $_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17h21cf2d4c44ad3142E $_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$10write_char17he1f0cb056f10b73fE $_ZN4core3fmt5Write9write_fmt17h1155b5ded69ce2afE)
  (data $.rodata (i32.const 1048576) "\00\00\00\00\04\00\00\00\04\00\00\00\06\00\00\00\07\00\00\00\07\00\00\00\00\00\00\00\04\00\00\00\04\00\00\00\08\00\00\00Permissions\00\00\00\00\00\04\00\00\00\04\00\00\00\09\00\00\00FilePermissionsreadonlyError: \0a\00[\00\10\00\07\00\00\00b\00\10\00\01\00\00\00pywasm \00\01\00\00\00\00\00\00\00z\00\10\00\01\00\00\00z\00\10\00\01\00\00\00b\00\10\00\01\00\00\00src/main.rs\00\9c\00\10\00\0b\00\00\00\05\00\00\00O\00\00\00\02\00\00\00\00\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00 \00\00\e0\02\00\00\00\00\00\00\00\00\00\06\00\00\00\00\00\01\00\00\00 \00\00\e8\02\00\00\00\00\00\00\00\02\00\00\00\00\00\00\00\02\00\00\00 \00\00\e0\0a\00\00\00\08\00\00\00\04\00\00\00\0b\00\00\00\0a\00\00\00\08\00\00\00\04\00\00\00\0c\00\00\00\0b\00\00\00\00\01\10\00\0d\00\00\00\0e\00\00\00\0f\00\00\00\10\00\00\00\11\00\00\00library/std/src/panicking.rs: \00\00\00\00\00\00\04\00\00\00\04\00\00\00\1b\00\00\00\00\00\00\00\04\00\00\00\04\00\00\00\1c\00\00\00/rustc/6b00bc3880198600130e1cf62b8f8a93494488cc/library/alloc/src/vec/mod.rs|\01\10\00L\00\00\00V\0a\00\00$\00\00\00\1d\00\00\00\0c\00\00\00\04\00\00\00\1e\00\00\00\1d\00\00\00\0c\00\00\00\04\00\00\00\1f\00\00\00\1e\00\00\00\d8\01\10\00 \00\00\00!\00\00\00\22\00\00\00 \00\00\00#\00\00\00/rustc/6b00bc3880198600130e1cf62b8f8a93494488cc/library/alloc/src/raw_vec/mod.rs\14\02\10\00P\00\00\00.\02\00\00\11\00\00\00\00\00\00\00\04\00\00\00\04\00\00\00$\00\00\00\00\00\00\00\04\00\00\00\04\00\00\00%\00\00\00Utf8Errorvalid_up_toerror_lenNoneSome:\00\00\01\00\00\00\00\00\00\00\b9\02\10\00\01\00\00\00\b9\02\10\00\01\00\00\00&\00\00\00\0c\00\00\00\04\00\00\00'\00\00\00(\00\00\00)\00\00\00&\00\00\00\0c\00\00\00\04\00\00\00*\00\00\00+\00\00\00,\00\00\00&\00\00\00\0c\00\00\00\04\00\00\00-\00\00\00.\00\00\00/\00\00\00&\00\00\00\0c\00\00\00\04\00\00\000\00\00\001\00\00\002\00\00\00&\00\00\00\0c\00\00\00\04\00\00\003\00\00\004\00\00\005\00\00\006\00\00\00\0c\00\00\00\04\00\00\007\00\00\008\00\00\009\00\00\00/rustc/6b00bc3880198600130e1cf62b8f8a93494488cc/library/alloc/src/slice.rs\00\00d\03\10\00J\00\00\00\be\01\00\00\1d\00\00\00library/std/src/rt.rs\00\00\00\c0\03\10\00\15\00\00\00\86\00\00\00\0d\00\00\00library/std/src/thread/mod.rsfailed to generate unique thread ID: bitspace exhausted\05\04\10\007\00\00\00\e8\03\10\00\1d\00\00\00\a9\04\00\00\0d\00\00\00mainRUST_BACKTRACEcalled `Result::unwrap()` on an `Err` valueWouldBlockfailed to write the buffered data\9b\04\10\00!\00\00\00\17\00\00\00library/std/src/io/buffered/bufwriter.rs\01\00\00\00\00\00\00\00library/std/src/io/buffered/linewritershim.rsmid > len\00\00%\05\10\00\09\00\00\00\f8\04\10\00-\00\00\00\16\01\00\00)\00\00\00failed to write whole bufferH\05\10\00\1c\00\00\00\17\00\00\00\02\00\00\00d\05\10\00entity not foundpermission deniedconnection refusedconnection resethost unreachablenetwork unreachableconnection abortednot connectedaddress in useaddress not availablenetwork downbroken pipeentity already existsoperation would blocknot a directoryis a directorydirectory not emptyread-only filesystem or storage mediumfilesystem loop or indirection limit (e.g. symlink loop)stale network file handleinvalid input parameterinvalid datatimed outwrite zerono storage spaceseek on unseekable filequota exceededfile too largeresource busyexecutable file busydeadlockcross-device link or renametoo many linksinvalid filenameargument list too longoperation interruptedunsupportedunexpected end of fileout of memoryin progressother erroruncategorized errorOs\00\00\00\00\00\04\00\00\00\04\00\00\00:\00\00\00code\00\00\00\00\01\00\00\00\01\00\00\00;\00\00\00kind6\00\00\00\0c\00\00\00\04\00\00\00<\00\00\00messageKindError\00\00\00\00\08\00\00\00\04\00\00\00=\00\00\00\00\00\00\00\04\00\00\00\04\00\00\00>\00\00\00Customerror (os error )\00\01\00\00\00\00\00\00\00\db\08\10\00\0b\00\00\00\e6\08\10\00\01\00\00\00\c8\04\10\00(\00\00\00z\00\00\00!\00\00\00library/std/src/io/stdio.rs\00\10\09\10\00\1b\00\00\00\e3\02\00\00\13\00\00\00\10\09\10\00\1b\00\00\00\5c\03\00\00\14\00\00\00\10\09\10\00\1b\00\00\00D\04\00\00\14\00\00\00failed printing to \00\5c\09\10\00\13\00\00\00X\01\10\00\02\00\00\00\10\09\10\00\1b\00\00\00\8d\04\00\00\09\00\00\00stdoutlibrary/std/src/io/mod.rsa formatting trait implementation returned an error when the underlying stream did not\00\00\00\af\09\10\00V\00\00\00\96\09\10\00\19\00\00\00\88\02\00\00\11\00\00\00\96\09\10\00\19\00\00\00\08\06\00\00 \00\00\00advancing io slices beyond their length\000\0a\10\00'\00\00\00\96\09\10\00\19\00\00\00\0a\06\00\00\0d\00\00\00advancing IoSlice beyond its length\00p\0a\10\00#\00\00\00library/std/src/sys/io/io_slice/wasi.rs\00\9c\0a\10\00'\00\00\00\14\00\00\00\0d\00\00\00\96\09\10\00\19\00\00\00\09\07\00\00$\00\00\00input must be utf-8\00\e4\0a\10\00\13\00\00\00)\00\00\00fd != -1panicked at :\0acannot recursively acquire mutex\00\00\1a\0b\10\00 \00\00\00library/std/src/sys/sync/mutex/no_threads.rsD\0b\10\00,\00\00\00\13\00\00\00\09\00\00\00library/std/src/sync/poison/once.rs\00\80\0b\10\00#\00\00\00\9b\00\00\002\00\00\00\80\0b\10\00#\00\00\00\d6\00\00\00\14\00\00\00lock count overflow in reentrant mutexlibrary/std/src/sync/reentrant_lock.rs\ea\0b\10\00&\00\00\00 \01\00\00-\00\00\00file name contained an unexpected NUL byte\00\00 \0c\10\00*\00\00\00\14\00\00\00\02\00\00\00L\0c\10\00stack backtrace:\0anote: Some details are omitted, run with `RUST_BACKTRACE=full` for a verbose backtrace.\0amemory allocation of  bytes failed\0a\c9\0c\10\00\15\00\00\00\de\0c\10\00\0e\00\00\00 bytes failed\00\00\00\c9\0c\10\00\15\00\00\00\fc\0c\10\00\0d\00\00\00library/std/src/alloc.rs\1c\0d\10\00\18\00\00\00d\01\00\00\09\00\00\00?\00\00\00\0c\00\00\00\04\00\00\00@\00\00\00A\00\00\00B\00\00\00C\00\00\00D\00\00\00E\00\00\00F\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00G\00\00\00H\00\00\00I\00\00\00J\00\00\00K\00\00\00L\00\00\00M\00\00\00note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace\0a\00\00\94\0d\10\00N\00\00\00<unnamed>\00\00\00<\01\10\00\1c\00\00\00\1d\01\00\00.\00\00\00\0athread '' panicked at \0a\08\0e\10\00\09\00\00\00\11\0e\10\00\0e\00\00\00\18\0b\10\00\02\00\00\00\1f\0e\10\00\01\00\00\006\00\00\00\0c\00\00\00\04\00\00\00N\00\00\00\00\00\00\00\08\00\00\00\04\00\00\00O\00\00\00\00\00\00\00\08\00\00\00\04\00\00\00P\00\00\00Q\00\00\00R\00\00\00S\00\00\00T\00\00\00\10\00\00\00\04\00\00\00U\00\00\00V\00\00\00W\00\00\00X\00\00\00Box<dyn Any>aborting due to panic at \00\00\00\a4\0e\10\00\19\00\00\00\18\0b\10\00\02\00\00\00\1f\0e\10\00\01\00\00\00\0athread panicked while processing panic. aborting.\0a\00\0c\0b\10\00\0c\00\00\00\18\0b\10\00\02\00\00\00\d8\0e\10\003\00\00\00thread caused non-unwinding panic. aborting.\0a\00\00\00$\0f\10\00-\00\00\00fatal runtime error: failed to initiate panic, error , aborting\0a\5c\0f\10\005\00\00\00\91\0f\10\00\0b\00\00\00NotFoundPermissionDeniedConnectionRefusedConnectionResetHostUnreachableNetworkUnreachableConnectionAbortedNotConnectedAddrInUseAddrNotAvailableNetworkDownBrokenPipeAlreadyExistsNotADirectoryIsADirectoryDirectoryNotEmptyReadOnlyFilesystemFilesystemLoopStaleNetworkFileHandleInvalidInputInvalidDataTimedOutWriteZeroStorageFullNotSeekableQuotaExceededFileTooLargeResourceBusyExecutableFileBusyDeadlockCrossesDevicesTooManyLinksInvalidFilenameArgumentListTooLongInterruptedUnsupportedUnexpectedEofOutOfMemoryInProgressOtherUncategorized\00\00\00\00\08\00\00\00\04\00\00\00Y\00\00\00library/std/src/sys/pal/wasi/os.rs\00\00\d0\11\10\00\22\00\00\00(\00\00\006\00\00\00strerror_r failure\00\00\04\12\10\00\12\00\00\00\d0\11\10\00\22\00\00\00&\00\00\00\0d\00\00\00\d0\11\10\00\22\00\00\00-\00\00\00\13\00\00\00\d0\11\10\00\22\00\00\004\00\00\00\15\00\00\00library/std/src/sys/fd/wasi.rs\00\00P\12\10\00\1e\00\00\00I\01\00\00\1d\00\00\00library/std/src/sys/fs/wasi.rs\00\00\80\12\10\00\1e\00\00\00\a7\00\00\00I\00\00\00\80\12\10\00\1e\00\00\00\d2\00\00\00$\00\00\00\80\12\10\00\1e\00\00\00\f5\02\00\00\17\00\00\00failed to find a pre-opened file descriptor through which  could be opened\00\00\d0\12\10\00:\00\00\00\0a\13\10\00\10\00\00\00Once instance has previously been poisoned\00\00,\13\10\00*\00\00\00one-time initialization may not be performed recursively`\13\10\008\00\00\00fatal runtime error: rwlock locked for writing, aborting\0a\00\00\00\a0\13\10\009\00\00\00\00\00\00\00\10\00\00\00\11\00\00\00\12\00\00\00\10\00\00\00\10\00\00\00\13\00\00\00\12\00\00\00\0d\00\00\00\0e\00\00\00\15\00\00\00\0c\00\00\00\0b\00\00\00\15\00\00\00\15\00\00\00\0f\00\00\00\0e\00\00\00\13\00\00\00&\00\00\008\00\00\00\19\00\00\00\17\00\00\00\0c\00\00\00\09\00\00\00\0a\00\00\00\10\00\00\00\17\00\00\00\0e\00\00\00\0e\00\00\00\0d\00\00\00\14\00\00\00\08\00\00\00\1b\00\00\00\0e\00\00\00\10\00\00\00\16\00\00\00\15\00\00\00\0b\00\00\00\16\00\00\00\0d\00\00\00\0b\00\00\00\0b\00\00\00\13\00\00\00x\05\10\00\88\05\10\00\99\05\10\00\ab\05\10\00\bb\05\10\00\cb\05\10\00\de\05\10\00\f0\05\10\00\fd\05\10\00\0b\06\10\00 \06\10\00,\06\10\007\06\10\00L\06\10\00a\06\10\00p\06\10\00~\06\10\00\91\06\10\00\b7\06\10\00\ef\06\10\00\08\07\10\00\1f\07\10\00+\07\10\004\07\10\00>\07\10\00N\07\10\00e\07\10\00s\07\10\00\81\07\10\00\8e\07\10\00\a2\07\10\00\aa\07\10\00\c5\07\10\00\d3\07\10\00\e3\07\10\00\f9\07\10\00\0e\08\10\00\19\08\10\00/\08\10\00<\08\10\00G\08\10\00R\08\10\00\08\00\00\00\10\00\00\00\11\00\00\00\0f\00\00\00\0f\00\00\00\12\00\00\00\11\00\00\00\0c\00\00\00\09\00\00\00\10\00\00\00\0b\00\00\00\0a\00\00\00\0d\00\00\00\0a\00\00\00\0d\00\00\00\0c\00\00\00\11\00\00\00\12\00\00\00\0e\00\00\00\16\00\00\00\0c\00\00\00\0b\00\00\00\08\00\00\00\09\00\00\00\0b\00\00\00\0b\00\00\00\0d\00\00\00\0c\00\00\00\0c\00\00\00\12\00\00\00\08\00\00\00\0e\00\00\00\0c\00\00\00\0f\00\00\00\13\00\00\00\0b\00\00\00\0b\00\00\00\0d\00\00\00\0b\00\00\00\0a\00\00\00\05\00\00\00\0d\00\00\00\ac\0f\10\00\b4\0f\10\00\c4\0f\10\00\d5\0f\10\00\e4\0f\10\00\f3\0f\10\00\05\10\10\00\16\10\10\00\22\10\10\00+\10\10\00;\10\10\00F\10\10\00P\10\10\00\91\04\10\00]\10\10\00j\10\10\00v\10\10\00\87\10\10\00\99\10\10\00\a7\10\10\00\bd\10\10\00\c9\10\10\00\d4\10\10\00\dc\10\10\00\e5\10\10\00\f0\10\10\00\fb\10\10\00\08\11\10\00\14\11\10\00 \11\10\002\11\10\00:\11\10\00H\11\10\00T\11\10\00c\11\10\00v\11\10\00\81\11\10\00\8c\11\10\00\99\11\10\00\a4\11\10\00\ae\11\10\00\b3\11\10\00\22\01\08\09$\0d)))\1c))\06\02\03\1e)\14)\0c)\1b\04)))#\14))\0f\12) ))!\0a)\05))\00\00)))&))\18$\07\0e\10))$)\00))\01\0b)$))\11\19\00)\16\1c\1f\01/\00.\00Success\00Illegal byte sequence\00Domain error\00Result not representable\00Not a tty\00Permission denied\00Operation not permitted\00No such file or directory\00No such process\00File exists\00Value too large for data type\00No space left on device\00Out of memory\00Resource busy\00Interrupted system call\00Resource temporarily unavailable\00Invalid seek\00Cross-device link\00Read-only file system\00Directory not empty\00Connection reset by peer\00Operation timed out\00Connection refused\00Host is unreachable\00Address in use\00Broken pipe\00I/O error\00No such device or address\00No such device\00Not a directory\00Is a directory\00Text file busy\00Exec format error\00Invalid argument\00Argument list too long\00Symbolic link loop\00Filename too long\00Too many open files in system\00No file descriptors available\00Bad file descriptor\00No child process\00Bad address\00File too large\00Too many links\00No locks available\00Resource deadlock would occur\00State not recoverable\00Previous owner died\00Operation canceled\00Function not implemented\00No message of desired type\00Identifier removed\00Link has been severed\00Protocol error\00Bad message\00Not a socket\00Destination address required\00Message too large\00Protocol wrong type for socket\00Protocol not available\00Protocol not supported\00Not supported\00Address family not supported by protocol\00Address not available\00Network is down\00Network unreachable\00Connection reset by network\00Connection aborted\00No buffer space available\00Socket is connected\00Socket not connected\00Operation already in progress\00Operation in progress\00Stale file handle\00Quota exceeded\00Multihop attempted\00Capabilities insufficient\00\00\00\00\00\00\00\00\00\00\00u\02N\00\d6\01\e2\04\b9\04\18\01\8e\05\ed\02\16\04\f2\00\97\03\01\038\05\af\01\82\01O\03/\04\1e\00\d4\05\a2\00\12\03\1e\03\c2\01\de\03\08\00\ac\05\00\01d\02\f1\01e\054\02\8c\02\cf\02-\03L\04\e3\05\9f\02\f8\04\1c\05\08\05\b1\02K\05\15\02x\00R\02<\03\f1\03\e4\00\c3\03}\04\cc\00\aa\03y\05$\02n\01m\03\22\04\ab\04D\00\fb\01\ae\00\83\03`\00\e5\01\07\04\94\04^\04+\00X\019\01\92\00\c2\05\9b\01C\02F\01\f6\05Error\00[\00\00\00\0c\00\00\00\04\00\00\00\5c\00\00\00]\00\00\00^\00\00\00capacity overflow\00\00\00\a8\1d\10\00\11\00\00\00library/alloc/src/raw_vec/mod.rs\c4\1d\10\00 \00\00\00.\02\00\00\11\00\00\00library/alloc/src/string.rs\00\f4\1d\10\00\1b\00\00\00\e8\01\00\00\17\00\00\00library/alloc/src/ffi/c_str.rs\00\00 \1e\10\00\1e\00\00\00\1a\01\00\00\1e\00\00\00 \1e\10\00\1e\00\00\00\16\01\00\007\00\00\00 \1e\10\00\1e\00\00\00U\01\00\00\0b\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00_\00\00\00a formatting trait implementation returned an error when the underlying stream did notlibrary/alloc/src/fmt.rs\00\00\d6\1e\10\00\18\00\00\00\8a\02\00\00\0e\00\00\00\00p\00\07\00-\01\01\01\02\01\02\01\01H\0b0\15\10\01e\07\02\06\02\02\01\04#\01\1e\1b[\0b:\09\09\01\18\04\01\09\01\03\01\05+\03;\09*\18\01 7\01\01\01\04\08\04\01\03\07\0a\02\1d\01:\01\01\01\02\04\08\01\09\01\0a\02\1a\01\02\029\01\04\02\04\02\02\03\03\01\1e\02\03\01\0b\029\01\04\05\01\02\04\01\14\02\16\06\01\01:\01\01\02\01\04\08\01\07\03\0a\02\1e\01;\01\01\01\0c\01\09\01(\01\03\017\01\01\03\05\03\01\04\07\02\0b\02\1d\01:\01\02\02\01\01\03\03\01\04\07\02\0b\02\1c\029\02\01\01\02\04\08\01\09\01\0a\02\1d\01H\01\04\01\02\03\01\01\08\01Q\01\02\07\0c\08b\01\02\09\0b\07I\02\1b\01\01\01\01\017\0e\01\05\01\02\05\0b\01$\09\01f\04\01\06\01\02\02\02\19\02\04\03\10\04\0d\01\02\02\06\01\0f\01\00\03\00\04\1c\03\1d\02\1e\02@\02\01\07\08\01\02\0b\09\01-\03\01\01u\02\22\01v\03\04\02\09\01\06\03\db\02\02\01:\01\01\07\01\01\01\01\02\08\06\0a\02\010\1f1\040\0a\04\03&\09\0c\02 \04\02\068\01\01\02\03\01\01\058\08\02\02\98\03\01\0d\01\07\04\01\06\01\03\02\c6@\00\01\c3!\00\03\8d\01` \00\06i\02\00\04\01\0a \02P\02\00\01\03\01\04\01\19\02\05\01\97\02\1a\12\0d\01&\08\19\0b\01\01,\030\01\02\04\02\02\02\01$\01C\06\02\02\02\02\0c\01\08\01/\013\01\01\03\02\02\05\02\01\01*\02\08\01\ee\01\02\01\04\01\00\01\00\10\10\10\00\02\00\01\e2\01\95\05\00\03\01\02\05\04(\03\04\01\a5\02\00\04A\05\00\02O\04F\0b1\04{\016\0f)\01\02\02\0a\031\04\02\02\07\01=\03$\05\01\08>\01\0c\024\09\01\01\08\04\02\01_\03\02\04\06\01\02\01\9d\01\03\08\15\029\02\01\01\01\01\0c\01\09\01\0e\07\03\05C\01\02\06\01\01\02\01\01\03\04\03\01\01\0e\02U\08\02\03\01\01\17\01Q\01\02\06\01\01\02\01\01\02\01\02\eb\01\02\04\06\02\01\02\1b\02U\08\02\01\01\02j\01\01\01\02\08e\01\01\01\02\04\01\05\00\09\01\02\f5\01\0a\04\04\01\90\04\02\02\04\01 \0a(\06\02\04\08\01\09\06\02\03.\0d\01\02\00\07\01\06\01\01R\16\02\07\01\02\01\02z\06\03\01\01\02\01\07\01\01H\02\03\01\01\01\00\02\0b\024\05\05\03\17\01\00\01\06\0f\00\0c\03\03\00\05;\07\00\01?\04Q\01\0b\02\00\02\00.\02\17\00\05\03\06\08\08\02\07\1e\04\94\03\007\042\08\01\0e\01\16\05\01\0f\00\07\01\11\02\07\01\02\01\05d\01\a0\07\00\01=\04\00\04\fe\02\00\07m\07\00`\80\f0\00)..0123456789abcdef\22\00\01\00\00\00\00\00\00\00BorrowMutErroralready borrowed: \1a\22\10\00\12\00\00\00\02\22\10\00\01\00\00\00\02\22\10\00\01\00\00\00called `Option::unwrap()` on a `None` value==!=matchesassertion `left  right` failed\0a  left: \0a right: \00\00z\22\10\00\10\00\00\00\8a\22\10\00\17\00\00\00\a1\22\10\00\09\00\00\00 right` failed: \0a  left: \00\00\00z\22\10\00\10\00\00\00\c4\22\10\00\10\00\00\00\d4\22\10\00\09\00\00\00\a1\22\10\00\09\00\00\00: \00\00\01\00\00\00\00\00\00\00\00#\10\00\02\00\00\00\00\00\00\00\0c\00\00\00\04\00\00\00g\00\00\00h\00\00\00i\00\00\00     { ,  {\0a,\0a} }((\0a,0x00010203040506070809101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899library/core/src/fmt/mod.rsfalsetrue\00\0b$\10\00\1b\00\00\00\99\0a\00\00&\00\00\00\0b$\10\00\1b\00\00\00\a2\0a\00\00\1a\00\00\00library/core/src/slice/memchr.rsP$\10\00 \00\00\00\84\00\00\00\1e\00\00\00P$\10\00 \00\00\00\a0\00\00\00\09\00\00\00library/core/src/str/mod.rs\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\04\04\04\04\04\00\00\00\00\00\00\00\00\00\00\00[...]begin <= end ( <= ) when slicing ``\00\b0%\10\00\0e\00\00\00\be%\10\00\04\00\00\00\c2%\10\00\10\00\00\00\d2%\10\00\01\00\00\00byte index  is not a char boundary; it is inside  (bytes ) of `\00\f4%\10\00\0b\00\00\00\ff%\10\00&\00\00\00%&\10\00\08\00\00\00-&\10\00\06\00\00\00\d2%\10\00\01\00\00\00 is out of bounds of `\00\00\f4%\10\00\0b\00\00\00\5c&\10\00\16\00\00\00\d2%\10\00\01\00\00\00\90$\10\00\1b\00\00\00\9e\01\00\00,\00\00\00library/core/src/unicode/printable.rs\00\00\00\9c&\10\00%\00\00\00\1a\00\00\006\00\00\00\9c&\10\00%\00\00\00\0a\00\00\00+\00\00\00\00\06\01\01\03\01\04\02\05\07\07\02\08\08\09\02\0a\05\0b\02\0e\04\10\01\11\02\12\05\13\1c\14\01\15\02\17\02\19\0d\1c\05\1d\08\1f\01$\01j\04k\02\af\03\b1\02\bc\02\cf\02\d1\02\d4\0c\d5\09\d6\02\d7\02\da\01\e0\05\e1\02\e7\04\e8\02\ee \f0\04\f8\02\fa\04\fb\01\0c';>NO\8f\9e\9e\9f{\8b\93\96\a2\b2\ba\86\b1\06\07\096=>V\f3\d0\d1\04\14\1867VW\7f\aa\ae\af\bd5\e0\12\87\89\8e\9e\04\0d\0e\11\12)14:EFIJNOde\8a\8c\8d\8f\b6\c1\c3\c4\c6\cb\d6\5c\b6\b7\1b\1c\07\08\0a\0b\14\1769:\a8\a9\d8\d9\097\90\91\a8\07\0a;>fi\8f\92\11o_\bf\ee\efZb\f4\fc\ffST\9a\9b./'(U\9d\a0\a1\a3\a4\a7\a8\ad\ba\bc\c4\06\0b\0c\15\1d:?EQ\a6\a7\cc\cd\a0\07\19\1a\22%>?\e7\ec\ef\ff\c5\c6\04 #%&(38:HJLPSUVXZ\5c^`cefksx}\7f\8a\a4\aa\af\b0\c0\d0\ae\afno\dd\de\93^\22{\05\03\04-\03f\03\01/.\80\82\1d\031\0f\1c\04$\09\1e\05+\05D\04\0e*\80\aa\06$\04$\04(\084\0bN\034\0c\817\09\16\0a\08\18;E9\03c\08\090\16\05!\03\1b\05\01@8\04K\05/\04\0a\07\09\07@ '\04\0c\096\03:\05\1a\07\04\0c\07PI73\0d3\07.\08\0a\06&\03\1d\08\02\80\d0R\10\037,\08*\16\1a&\1c\14\17\09N\04$\09D\0d\19\07\0a\06H\08'\09u\0bB>*\06;\05\0a\06Q\06\01\05\10\03\05\0bY\08\02\1db\1eH\08\0a\80\a6^\22E\0b\0a\06\0d\13:\06\0a\06\14\1c,\04\17\80\b9<dS\0cH\09\0aFE\1bH\08S\0dI\07\0a\80\b6\22\0e\0a\06F\0a\1d\03GI7\03\0e\08\0a\069\07\0a\816\19\07;\03\1dU\01\0f2\0d\83\9bfu\0b\80\c4\8aLc\0d\840\10\16\0a\8f\9b\05\82G\9a\b9:\86\c6\829\07*\04\5c\06&\0aF\0a(\05\13\81\b0:\80\c6[eK\049\07\11@\05\0b\02\0e\97\f8\08\84\d6)\0a\a2\e7\813\0f\01\1d\06\0e\04\08\81\8c\89\04k\05\0d\03\09\07\10\8f`\80\fa\06\81\b4LG\09t<\80\f6\0as\08p\15Fz\14\0c\14\0cW\09\19\80\87\81G\03\85B\0f\15\84P\1f\06\06\80\d5+\05>!\01p-\03\1a\04\02\81@\1f\11:\05\01\81\d0*\80\d6+\04\01\81\e0\80\f7)L\04\0a\04\02\83\11DL=\80\c2<\06\01\04U\05\1b4\02\81\0e,\04d\0cV\0a\80\ae8\1d\0d,\04\09\07\02\0e\06\80\9a\83\d8\04\11\03\0d\03w\04_\06\0c\04\01\0f\0c\048\08\0a\06(\08,\04\02>\81T\0c\1d\03\0a\058\07\1c\06\09\07\80\fa\84\06\00\01\03\05\05\06\06\02\07\06\08\07\09\11\0a\1c\0b\19\0c\1a\0d\10\0e\0c\0f\04\10\03\12\12\13\09\16\01\17\04\18\01\19\03\1a\07\1b\01\1c\02\1f\16 \03+\03-\0b.\010\041\022\01\a7\04\a9\02\aa\04\ab\08\fa\02\fb\05\fd\02\fe\03\ff\09\adxy\8b\8d\a20WX\8b\8c\90\1c\dd\0e\0fKL\fb\fc./?\5c]_\e2\84\8d\8e\91\92\a9\b1\ba\bb\c5\c6\c9\ca\de\e4\e5\ff\00\04\11\12)147:;=IJ]\84\8e\92\a9\b1\b4\ba\bb\c6\ca\ce\cf\e4\e5\00\04\0d\0e\11\12)14:;EFIJ^de\84\91\9b\9d\c9\ce\cf\0d\11):;EIW[\5c^_de\8d\91\a9\b4\ba\bb\c5\c9\df\e4\e5\f0\0d\11EIde\80\84\b2\bc\be\bf\d5\d7\f0\f1\83\85\8b\a4\a6\be\bf\c5\c7\cf\da\dbH\98\bd\cd\c6\ce\cfINOWY^_\89\8e\8f\b1\b6\b7\bf\c1\c6\c7\d7\11\16\17[\5c\f6\f7\fe\ff\80mq\de\df\0e\1fno\1c\1d_}~\ae\afM\bb\bc\16\17\1e\1fFGNOXZ\5c^~\7f\b5\c5\d4\d5\dc\f0\f1\f5rs\8ftu\96&./\a7\af\b7\bf\c7\cf\d7\df\9a\00@\97\980\8f\1f\ce\cf\d2\d4\ce\ffNOZ[\07\08\0f\10'/\ee\efno7=?BE\90\91Sgu\c8\c9\d0\d1\d8\d9\e7\fe\ff\00 _\22\82\df\04\82D\08\1b\04\06\11\81\ac\0e\80\ab\05\1f\08\81\1c\03\19\08\01\04/\044\04\07\03\01\07\06\07\11\0aP\0f\12\07U\07\03\04\1c\0a\09\03\08\03\07\03\02\03\03\03\0c\04\05\03\0b\06\01\0e\15\05N\07\1b\07W\07\02\06\17\0cP\04C\03-\03\01\04\11\06\0f\0c:\04\1d%_ m\04j%\80\c8\05\82\b0\03\1a\06\82\fd\03Y\07\16\09\18\09\14\0c\14\0cj\06\0a\06\1a\06Y\07+\05F\0a,\04\0c\04\01\031\0b,\04\1a\06\0b\03\80\ac\06\0a\06/1\80\f4\08<\03\0f\03>\058\08+\05\82\ff\11\18\08/\11-\03!\0f!\0f\80\8c\04\82\9a\16\0b\15\88\94\05/\05;\07\02\0e\18\09\80\be\22t\0c\80\d6\1a\81\10\05\80\e1\09\f2\9e\037\09\81\5c\14\80\b8\08\80\dd\15;\03\0a\068\08F\08\0c\06t\0b\1e\03Z\04Y\09\80\83\18\1c\0a\16\09L\04\80\8a\06\ab\a4\0c\17\041\a1\04\81\da&\07\0c\05\05\80\a6\10\81\f5\07\01 *\06L\04\80\8d\04\80\be\03\1b\03\0f\0d\80\80\80\80\80\80\80\80\80\f4\ee\80\80\f2\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80 !\a2#$%&\a7()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\dc]^_`abcdefghijklmnopqrstuvwxyz{|}~\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80\80range start index  out of range for slice of length \00\00\00\8d-\10\00\12\00\00\00\9f-\10\00\22\00\00\00range end index \d4-\10\00\10\00\00\00\9f-\10\00\22\00\00\00slice index starts at  but ends at \00\f4-\10\00\16\00\00\00\0a.\10\00\0d\00\00\00\00\03\00\00\83\04 \00\91\05`\00]\13\a0\00\12\17 \1f\0c `\1f\ef, +*0\a0+o\a6`,\02\a8\e0,\1e\fb\e0-\00\fe 6\9e\ff`6\fd\01\e16\01\0a!7$\0d\e17\ab\0ea9/\18\e190\1c\e1J\f3\1e\e1N@4\a1R\1ea\e1S\f0jaTOo\e1T\9d\bcaU\00\cfaVe\d1\a1V\00\da!W\00\e0\a1X\ae\e2!Z\ec\e4\e1[\d0\e8a\5c \00\ee\5c\f0\01\7f]o\22\10\00q\22\10\00s\22\10\00\02\00\00\00\02\00\00\00\07\00\00\00")
  (data $.data (i32.const 1060552) "\01\00\00\00\ff\ff\ff\ff\d4\16\10\00"))
