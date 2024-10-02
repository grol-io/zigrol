const std = @import("std");

pub fn main() u8 {
    std.io.getStdOut().writeAll("Hello world!\n") catch {};
    return 42;
}
