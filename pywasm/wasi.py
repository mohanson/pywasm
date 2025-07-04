import pywasm.core
import random
import sys
import typing


class Preview1:

    # Wasi started with launching what is now called preview 1. This specification is now widely supported. Preview1
    # corresponds to the import module name "wasi_snapshot_preview1".
    #
    # Pywasm's wasi preview 1 refers to the following rust code.
    # See https://docs.rs/crate/wasi/0.11.1+wasi-snapshot-preview1/source/src/lib_generated.rs
    # See https://docs.rs/wasi/0.11.1+wasi-snapshot-preview1/wasi/wasi_snapshot_preview1/index.html
    # See https://github.com/bytecodealliance/wasmtime/blob/main/crates/wasi-preview1-component-adapter/src/lib.rs

    # No error occurred. System call completed successfully.
    ERRNO_SUCCESS = 0
    # Argument list too long.
    ERRNO_2BIG = 1
    # Permission denied.
    ERRNO_ACCES = 2
    # Address in use.
    ERRNO_ADDRINUSE = 3
    # Address not available.
    ERRNO_ADDRNOTAVAIL = 4
    # Address family not supported.
    ERRNO_AFNOSUPPORT = 5
    # Resource unavailable, or operation would block.
    ERRNO_AGAIN = 6
    # Connection already in progress.
    ERRNO_ALREADY = 7
    # Bad file descriptor.
    ERRNO_BADF = 8
    # Bad message.
    ERRNO_BADMSG = 9
    # Device or resource busy.
    ERRNO_BUSY = 10
    # Operation canceled.
    ERRNO_CANCELED = 11
    # No child processes.
    ERRNO_CHILD = 12
    # Connection aborted.
    ERRNO_CONNABORTED = 13
    # Connection refused.
    ERRNO_CONNREFUSED = 14
    # Connection reset.
    ERRNO_CONNRESET = 15
    # Resource deadlock would occur.
    ERRNO_DEADLK = 16
    # Destination address required.
    ERRNO_DESTADDRREQ = 17
    # Mathematics argument out of domain of function.
    ERRNO_DOM = 18
    # Reserved.
    ERRNO_DQUOT = 19
    # File exists.
    ERRNO_EXIST = 20
    # Bad address.
    ERRNO_FAULT = 21
    # File too large.
    ERRNO_FBIG = 22
    # Host is unreachable.
    ERRNO_HOSTUNREACH = 23
    # Identifier removed.
    ERRNO_IDRM = 24
    # Illegal byte sequence.
    ERRNO_ILSEQ = 25
    # Operation in progress.
    ERRNO_INPROGRESS = 26
    # Interrupted function.
    ERRNO_INTR = 27
    # Invalid argument.
    ERRNO_INVAL = 28
    # I/O error.
    ERRNO_IO = 29
    # Socket is connected.
    ERRNO_ISCONN = 30
    # Is a directory.
    ERRNO_ISDIR = 31
    # Too many levels of symbolic links.
    ERRNO_LOOP = 32
    # File descriptor value too large.
    ERRNO_MFILE = 33
    # Too many links.
    ERRNO_MLINK = 34
    # Message too large.
    ERRNO_MSGSIZE = 35
    # Reserved.
    ERRNO_MULTIHOP = 36
    # Filename too long.
    ERRNO_NAMETOOLONG = 37
    # Network is down.
    ERRNO_NETDOWN = 38
    # Connection aborted by network.
    ERRNO_NETRESET = 39
    # Network unreachable.
    ERRNO_NETUNREACH = 40
    # Too many files open in system.
    ERRNO_NFILE = 41
    # No buffer space available.
    ERRNO_NOBUFS = 42
    # No such device.
    ERRNO_NODEV = 43
    # No such file or directory.
    ERRNO_NOENT = 44
    # Executable file format error.
    ERRNO_NOEXEC = 45
    # No locks available.
    ERRNO_NOLCK = 46
    # Reserved.
    ERRNO_NOLINK = 47
    # Not enough space.
    ERRNO_NOMEM = 48
    # No message of the desired type.
    ERRNO_NOMSG = 49
    # Protocol not available.
    ERRNO_NOPROTOOPT = 50
    # No space left on device.
    ERRNO_NOSPC = 51
    # Function not supported.
    ERRNO_NOSYS = 52
    # The socket is not connected.
    ERRNO_NOTCONN = 53
    # Not a directory or a symbolic link to a directory.
    ERRNO_NOTDIR = 54
    # Directory not empty.
    ERRNO_NOTEMPTY = 55
    # State not recoverable.
    ERRNO_NOTRECOVERABLE = 56
    # Not a socket.
    ERRNO_NOTSOCK = 57
    # Not supported, or operation not supported on socket.
    ERRNO_NOTSUP = 58
    # Inappropriate I/O control operation.
    ERRNO_NOTTY = 59
    # No such device or address.
    ERRNO_NXIO = 60
    # Value too large to be stored in data type.
    ERRNO_OVERFLOW = 61
    # Previous owner died.
    ERRNO_OWNERDEAD = 62
    # Operation not permitted.
    ERRNO_PERM = 63
    # Broken pipe.
    ERRNO_PIPE = 64
    # Protocol error.
    ERRNO_PROTO = 65
    # Protocol not supported.
    ERRNO_PROTONOSUPPORT = 66
    # Protocol wrong type for socket.
    ERRNO_PROTOTYPE = 67
    # Result too large.
    ERRNO_RANGE = 68
    # Read-only file system.
    ERRNO_ROFS = 69
    # Invalid seek.
    ERRNO_SPIPE = 70
    # No such process.
    ERRNO_SRCH = 71
    # Reserved.
    ERRNO_STALE = 72
    # Connection timed out.
    ERRNO_TIMEDOUT = 73
    # Text file busy.
    ERRNO_TXTBSY = 74
    # Cross-device link.
    ERRNO_XDEV = 75
    # Extension: Capabilities insufficient.
    ERRNO_NOTCAPABLE = 76

    def __init__(self, args: typing.List[str], envs: typing.Dict[str, str]):
        self.args = args
        self.envs = ['='.join(e) for e in sorted(envs.items())]
        # By setting the value to io.BytesIO(bytearray()) to capture output or provide input.
        self.fd = {
            0: sys.stdin.buffer,
            1: sys.stdout.buffer,
            2: sys.stderr.buffer,
        }
        # By default, when wasi applications call proc_exit(), wasi.main() will return with the exit code specified
        # rather than terminating the process. Setting this option to 0 will cause the python process to exit with the
        # specified exit code instead.
        self.return_on_exit = 1

    def args_get(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Read command-line argument data. The size of the array should match that returned by args_sizes_get. Each
        # argument is expected to be `\0` terminated.
        mems = m.store.mems[m.stack.frame[-1].module.mems[0]]
        argv = args[0]
        argv_buf = args[1]
        for e in self.args:
            mems.put_u32(argv, argv_buf)
            argv += 4
            mems.put(argv_buf, bytearray(e.encode()))
            argv_buf += len(e)
            mems.put(argv_buf, bytearray([0]))
            argv_buf += 1
        return [self.ERRNO_SUCCESS]

    def args_sizes_get(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Return command-line argument data sizes.
        mems = m.store.mems[m.stack.frame[-1].module.mems[0]]
        mems.put_u32(args[0], len(self.args))
        mems.put_u32(args[1], sum([len(e) + 1 for e in self.args]))
        return [self.ERRNO_SUCCESS]

    def bind(self, runtime: pywasm.core.Runtime) -> None:
        i32 = pywasm.core.ValType.i32()
        i64 = pywasm.core.ValType.i64()
        vec = [
            ['args_get', [i32, i32], [i32], self.args_get],
            ['args_sizes_get', [i32, i32], [i32], self.args_sizes_get],
            ['clock_res_get', [i32, i32], [i32], self.clock_res_get],
            ['clock_time_get', [i32, i64, i32], [i32], self.clock_time_get],
            ['environ_get', [i32, i32], [i32], self.environ_get],
            ['environ_sizes_get', [i32, i32], [i32], self.environ_sizes_get],
            ['fd_advise', [i32, i64, i64, i32], [i32], self.fd_advise],
            ['fd_allocate', [i32, i64, i64], [i32], self.fd_allocate],
            ['fd_close', [i32], [i32], self.fd_close],
            ['fd_datasync', [i32], [i32], self.fd_datasync],
            ['fd_fdstat_get', [i32, i32], [i32], self.fd_fdstat_get],
            ['fd_fdstat_set_flags', [i32, i32], [i32], self.fd_fdstat_set_flags],
            ['fd_fdstat_set_rights', [i32, i64, i64], [i32], self.fd_fdstat_set_rights],
            ['fd_filestat_get', [i32, i32], [i32], self.fd_filestat_get],
            ['fd_filestat_set_size', [i32, i64], [i32], self.fd_filestat_set_size],
            ['fd_filestat_set_times', [i32, i64, i64, i32], [i32], self.fd_filestat_set_times],
            ['fd_pread', [i32, i32, i32, i64, i32], [i32], self.fd_pread],
            ['fd_prestat_dir_name', [i32, i32, i32], [i32], self.fd_prestat_dir_name],
            ['fd_prestat_get', [i32, i32], [i32], self.fd_prestat_get],
            ['fd_pwrite', [i32, i32, i32, i64, i32], [i32], self.fd_pwrite],
            ['fd_read', [i32, i32, i32, i32], [i32], self.fd_read],
            ['fd_readdir', [i32, i32, i32, i64, i32], [i32], self.fd_readdir],
            ['fd_renumber', [i32, i32], [i32], self.fd_renumber],
            ['fd_seek', [i32, i64, i32, i32], [i32], self.fd_seek],
            ['fd_sync', [i32], [i32], self.fd_sync],
            ['fd_tell', [i32, i32], [i32], self.fd_tell],
            ['fd_write', [i32, i32, i32, i32], [i32], self.fd_write],
            ['path_create_directory', [i32, i32, i32], [i32], self.path_create_directory],
            ['path_filestat_get', [i32, i32, i32, i32, i32], [i32], self.path_filestat_get],
            ['path_filestat_set_times', [i32, i32, i32, i32, i64, i64, i32], [i32], self.path_filestat_set_times],
            ['path_link', [i32, i32, i32, i32, i32, i32, i32], [i32], self.path_link],
            ['path_open', [i32, i32, i32, i32, i32, i64, i64, i32, i32], [i32], self.path_open],
            ['path_readlink', [i32, i32, i32, i32, i32, i32], [i32], self.path_readlink],
            ['path_remove_directory', [i32, i32, i32], [i32], self.path_remove_directory],
            ['path_rename', [i32, i32, i32, i32, i32, i32], [i32], self.path_rename],
            ['path_symlink', [i32, i32, i32, i32, i32], [i32], self.path_symlink],
            ['path_unlink_file', [i32, i32, i32], [i32], self.path_unlink_file],
            ['poll_oneoff', [i32, i32, i32, i32], [i32], self.poll_oneoff],
            ['proc_exit', [i32], [], self.proc_exit],
            ['proc_raise', [i32], [i32], self.proc_raise],
            ['random_get', [i32, i32], [i32], self.random_get],
            ['sched_yield', [], [i32], self.sched_yield],
            ['sock_accept', [i32, i32, i32], [i32], self.sock_accept],
            ['sock_recv', [i32, i32, i32, i32, i32, i32], [i32], self.sock_recv],
            ['sock_send', [i32, i32, i32, i32, i32], [i32], self.sock_send],
            ['sock_shutdown', [i32, i32], [i32], self.sock_shutdown],
        ]
        runtime.imports['wasi_snapshot_preview1'] = {}
        for e in vec:
            funkype = pywasm.core.FuncType(e[1], e[2])
            runtime.imports['wasi_snapshot_preview1'][e[0]] = runtime.allocate_func_host(funkype, e[3])

    def clock_res_get(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Return the resolution of a clock.
        raise Exception('todo')

    def clock_time_get(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Return the time value of a clock.
        raise Exception('todo')

    def environ_get(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Read environment variable data. The sizes of the buffers should match that returned by environ_sizes_get.
        # Key/value pairs are expected to be joined with =, and terminated with 0.
        mems = m.store.mems[m.stack.frame[-1].module.mems[0]]
        environ = args[0]
        environ_buf = args[1]
        for e in self.envs:
            mems.put_u32(environ, environ_buf)
            environ += 4
            mems.put(environ_buf, bytearray(e.encode()))
            environ_buf += len(e)
            mems.put(environ_buf, bytearray([0]))
            environ_buf += 1
        return [self.ERRNO_SUCCESS]

    def environ_sizes_get(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Return environment variable data sizes.
        mems = m.store.mems[m.stack.frame[-1].module.mems[0]]
        mems.put_u32(args[0], len(self.envs))
        mems.put_u32(args[1], sum([len(e) + 1 for e in self.envs]))
        return [self.ERRNO_SUCCESS]

    def fd_advise(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Provide file advisory information on a file descriptor.
        raise Exception('todo')

    def fd_allocate(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Force the allocation of space in a file.
        raise Exception('todo')

    def fd_close(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Close a file descriptor.
        raise Exception('todo')

    def fd_datasync(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Synchronize the data of a file to disk.
        raise Exception('todo')

    def fd_fdstat_get(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Get the attributes of a file descriptor.
        raise Exception('todo')

    def fd_fdstat_set_flags(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Adjust the flags associated with a file descriptor.
        raise Exception('todo')

    def fd_fdstat_set_rights(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Adjust the rights associated with a file descriptor.
        raise Exception('todo')

    def fd_filestat_get(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Return the attributes of an open file.
        raise Exception('todo')

    def fd_filestat_set_size(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Adjust the size of an open file. If this increases the file's size, the extra bytes are filled with zeros.
        raise Exception('todo')

    def fd_filestat_set_times(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Adjust the timestamps of an open file or directory.
        raise Exception('todo')

    def fd_pread(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Read from a file descriptor, without using and updating the file descriptor's offset.
        raise Exception('todo')

    def fd_prestat_dir_name(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Return a description of the given preopened file descriptor.
        raise Exception('todo')

    def fd_prestat_get(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Return a description of the given preopened file descriptor.
        raise Exception('todo')

    def fd_pwrite(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Write to a file descriptor, without using and updating the file descriptor's offset.
        raise Exception('todo')

    def fd_read(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Read from a file descriptor.
        raise Exception('todo')

    def fd_readdir(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Read directory entries from a directory.
        raise Exception('todo')

    def fd_renumber(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        raise Exception('todo')

    def fd_seek(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Move the offset of a file descriptor.
        raise Exception('todo')

    def fd_sync(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Synchronize the data and metadata of a file to disk.
        raise Exception('todo')

    def fd_tell(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Return the current offset of a file descriptor.
        raise Exception('todo')

    def fd_write(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Write to a file descriptor.
        mems = m.store.mems[m.stack.frame[-1].module.mems[0]]
        fd = args[0]
        iovs_ptr = args[1]
        iovs_len = args[2]
        nwritten = args[3]
        if fd not in self.fd:
            return [self.ERRNO_BADF]
        data = bytearray()
        for _ in range(iovs_len):
            elem_ptr = mems.get_u32(iovs_ptr)
            elem_len = mems.get_u32(iovs_ptr + 4)
            elem = mems.get(elem_ptr, elem_len)
            iovs_ptr += 1
            data.extend(elem)
        mems.put_u32(nwritten, self.fd[fd].write(data))
        return [self.ERRNO_SUCCESS]

    def main(self, runtime: pywasm.core.Runtime, module: pywasm.core.ModuleInst) -> int:
        # Attempt to begin execution of instance as a wasi command by invoking its _start() export. If instance does
        # not contain a _start() export, then an exception is thrown.
        try:
            runtime.invocate(module, '_start', [])
        except Exception as e:
            runtime.machine.stack.frame.clear()
            runtime.machine.stack.label.clear()
            runtime.machine.stack.value.clear()
            if e.args[0] == SystemExit:
                return e.args[1]
            raise e
        else:
            return 0

    def path_create_directory(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Create a directory.
        raise Exception('todo')

    def path_filestat_get(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Return the attributes of a file or directory.
        raise Exception('todo')

    def path_filestat_set_times(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Adjust the timestamps of a file or directory.
        raise Exception('todo')

    def path_link(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Create a hard link.
        raise Exception('todo')

    def path_open(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Open a file or directory.
        raise Exception('todo')

    def path_readlink(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Read the contents of a symbolic link.
        raise Exception('todo')

    def path_remove_directory(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Remove a directory.
        raise Exception('todo')

    def path_rename(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Rename a file or directory.
        raise Exception('todo')

    def path_symlink(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Create a symbolic link.
        raise Exception('todo')

    def path_unlink_file(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Unlink a file.
        raise Exception('todo')

    def poll_oneoff(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Concurrently poll for the occurrence of a set of events.
        raise Exception('todo')

    def proc_exit(self, _: pywasm.core.Machine, args: typing.List[int]) -> None:
        # Terminate the process normally. An exit code of 0 indicates successful termination of the program. The
        # meanings of other values is dependent on the environment.
        if self.return_on_exit:
            raise Exception(SystemExit, args[0])
        sys.exit(args[0])

    def proc_raise(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Send a signal to the process of the calling thread.
        raise Exception('todo')

    def random_get(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Write high-quality random data into a buffer.
        mems = m.store.mems[m.stack.frame[-1].module.mems[0]]
        mems.put(args[0], bytearray(random.randbytes(args[1])))
        return [self.ERRNO_SUCCESS]

    def sched_yield(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Temporarily yield execution of the calling thread.
        raise Exception('todo')

    def sock_accept(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Accept a new incoming connection.
        raise Exception('todo')

    def sock_recv(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Receive a message from a socket.
        raise Exception('todo')

    def sock_send(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Send a message on a socket.
        raise Exception('todo')

    def sock_shutdown(self, m: pywasm.core.Machine, args: typing.List[int]) -> typing.List[int]:
        # Shut down socket send and receive channels.
        raise Exception('todo')
