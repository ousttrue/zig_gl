const std = @import("std");
// const glfw = @import("glfw");
const glfw = @import(".gyro/mach-glfw-hexops-github.com-dae779de/pkg/src/main.zig");
const zgl = @import(".gyro/zgl-ziglibs-github.com-ebc646aa/pkg/zgl.zig");

pub fn main() anyerror!void {
    try glfw.init(.{});
    defer glfw.terminate();

    const window = try glfw.Window.create(640, 480, "zig glfw sample", null, null, .{});
    defer window.destroy();

    try glfw.makeContextCurrent(window);
    while (!window.shouldClose()) {
        zgl.clear(.{ .color = true });
        try window.swapBuffers();
        try glfw.pollEvents();
    }
}

test "basic test" {
    try std.testing.expectEqual(10, 3 + 7);
}
