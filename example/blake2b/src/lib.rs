#[unsafe(no_mangle)]
pub extern "C" fn alloc(size: usize) -> *mut u8 {
    let layout = std::alloc::Layout::array::<u8>(size).unwrap();
    unsafe { std::alloc::alloc(layout) }
}

#[unsafe(no_mangle)]
pub extern "C" fn alloc_zeroed(size: usize) -> *mut u8 {
    let layout = std::alloc::Layout::array::<u8>(size).unwrap();
    unsafe { std::alloc::alloc_zeroed(layout) }
}

#[unsafe(no_mangle)]
pub extern "C" fn blake2b(
    data_ptr: *mut u8,
    data_size: usize,
    hash_ptr: *mut u8,
    hash_size: usize,
) {
    let data_buf = unsafe { std::slice::from_raw_parts(data_ptr, data_size) };
    let hash_buf = unsafe { std::slice::from_raw_parts_mut(hash_ptr, hash_size) };
    let mut p = blake2ya::blake2b_params();
    p.digest(64);
    let mut h = blake2ya::blake2b(p);
    h.update(data_buf);
    h.digest(hash_buf);
}

#[unsafe(no_mangle)]
pub extern "C" fn dealloc(ptr: *mut u8, size: usize) {
    let layout = std::alloc::Layout::array::<u8>(size).unwrap();
    unsafe { std::alloc::dealloc(ptr, layout) }
}
