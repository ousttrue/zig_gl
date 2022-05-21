const std = @import("std");
// const glfw = @import("glfw");
const glfw = @import(".gyro/mach-glfw-hexops-github.com-dae779de/pkg/src/main.zig");

pub fn main() anyerror!void {
    try glfw.init(.{});
    defer glfw.terminate();

    const window = try glfw.Window.create(640, 480, "zig glfw sample", null, null, .{
        .client_api = .no_api,
    });
    defer window.destroy();

    while (!window.shouldClose()) {

        

        try glfw.pollEvents();
    }
}

test "basic test" {
    try std.testing.expectEqual(10, 3 + 7);
}
