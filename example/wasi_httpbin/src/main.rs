fn main() {
    let fd = 3;
    let send_data = b"GET /get HTTP/1.1\r\nHost: httpbin.org\r\nConnection: close\r\n\r\n";
    let mut buffer = [0u8; 1024];
    buffer[..send_data.len()].copy_from_slice(send_data);
    let iovs = [wasi::Ciovec {
        buf: buffer.as_ptr(),
        buf_len: send_data.len(),
    }];
    let size = unsafe { wasi::sock_send(fd, &iovs, 0).unwrap() };
    assert_eq!(size, send_data.len());

    let iovs = [wasi::Iovec {
        buf: buffer.as_mut_ptr(),
        buf_len: buffer.len(),
    }];
    let recv = unsafe { wasi::sock_recv(fd, &iovs, wasi::RIFLAGS_RECV_WAITALL).unwrap() };
    let recv = str::from_utf8(&buffer[..recv.0]).unwrap();
    println!("{}", recv);

    let _ = unsafe { wasi::sock_shutdown(fd, wasi::SDFLAGS_RD | wasi::SDFLAGS_WR) };
}
