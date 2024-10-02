const std = @import("std");

pub export fn _start() noreturn {
    const str = "Hello world!\n";
    _ = std.os.linux.write(1, str.ptr, str.len);
    std.process.exit(42);
}
