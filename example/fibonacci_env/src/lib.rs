unsafe extern "C" {
    fn fibonacci_host(n: u32) -> u32;
}

#[unsafe(no_mangle)]
pub fn fibonacci(n: u32) -> u32 {
    unsafe { fibonacci_host(n) }
}
