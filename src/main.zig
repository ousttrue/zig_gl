const std = @import("std");
const glfw = @import("glfw");

pub fn main() anyerror!void {
    try glfw.init(.{});
    defer glfw.terminate();  
}

test "basic test" {
    try std.testing.expectEqual(10, 3 + 7);
}
