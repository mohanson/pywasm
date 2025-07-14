fn main() {
    let mut buffer = [0u8; 1024];
    buffer[..59]
        .copy_from_slice(b"GET /get HTTP/1.1\r\nHost: httpbin.org\r\nConnection: close\r\n\r\n");
    let iovs = [wasi::Ciovec {
        buf: buffer.as_ptr(),
        buf_len: 59,
    }];
    unsafe { wasi::sock_send(3, &iovs, 0).unwrap() };

    let iovs = [wasi::Iovec {
        buf: buffer.as_mut_ptr(),
        buf_len: buffer.len(),
    }];
    let recv = unsafe { wasi::sock_recv(3, &iovs, wasi::RIFLAGS_RECV_WAITALL).unwrap() };
    let recv = str::from_utf8(&buffer[..recv.0]).unwrap();
    println!("{}", recv);
}
