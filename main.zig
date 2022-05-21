const std = @import("std");
// const glfw = @import("glfw");
const glfw = @import(".gyro/mach-glfw-hexops-github.com-dae779de/pkg/src/main.zig");

pub fn main() anyerror!void {
    try glfw.init(.{});
    defer glfw.terminate();
}

test "basic test" {
    try std.testing.expectEqual(10, 3 + 7);
}
