const std = @import("std");
const pkgs = @import("deps.zig").pkgs;
const glfw = @import("build-glfw");

pub fn build(b: *std.build.Builder) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("zig_gl", "main.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.addPackage(pkgs.glfw);
    glfw.link(b, exe, .{});    
    exe.addIncludePath("libepoxy-1.5.10/include");
    exe.addIncludePath("libepoxy-1.5.10/src");
    exe.addIncludePath("libepoxy-1.5.10/_build/include");
    exe.addIncludePath("libepoxy-1.5.10/_build/src");
    exe.addCSourceFile("libepoxy-1.5.10/src/dispatch_common.c", &.{});
    exe.addCSourceFile("libepoxy-1.5.10/src/dispatch_wgl.c", &.{});
    exe.addCSourceFile("libepoxy-1.5.10/_build/src/gl_generated_dispatch.c", &.{});
    exe.addCSourceFile("libepoxy-1.5.10/_build/src/wgl_generated_dispatch.c", &.{});
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const exe_tests = b.addTest("main.zig");
    exe_tests.setTarget(target);
    exe_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&exe_tests.step);
}
