// This function runs the blake2b hash algorithm n times in a loop.
#[unsafe(no_mangle)]
pub extern "C" fn blake2b_iter(n: u32) -> u8 {
    let mut data = vec![0x00; 64];
    let mut s = 0u8;
    for _ in 0..n {
        let mut p = blake2ya::blake2b_params();
        p.digest(64);
        let mut h = blake2ya::blake2b(p);
        h.update(&data);
        h.digest(&mut data);
        for u in data.iter() {
            s = s.wrapping_add(*u);
        }
    }
    s
}
