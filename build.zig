const std = @import("std");
const pkgs = @import("deps.zig").pkgs;
const glfw = @import("build-glfw");
const imgui_pkg = @import("deps/imgui/deps.zig").pkgs;

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
    exe.addIncludePath("libepoxy/include");
    exe.addIncludePath("libepoxy/src");
    exe.addCSourceFile("libepoxy/src/dispatch_common.c", &.{});
    // require
    // mkdir libepoxy_build
    // cd libepoxy_build
    // meson
    // ninja
    exe.addIncludePath("libepoxy_build/include");
    exe.addIncludePath("libepoxy_build/src");
    exe.addCSourceFile("libepoxy_build/src/gl_generated_dispatch.c", &.{});
    if (exe.target_info.target.os.tag == std.Target.Os.Tag.windows) {
        exe.addCSourceFile("libepoxy/src/dispatch_wgl.c", &.{});
        exe.addCSourceFile("libepoxy_build/src/wgl_generated_dispatch.c", &.{});
    } else {
        exe.addCSourceFile("libepoxy/src/dispatch_glx.c", &.{});
        exe.addCSourceFile("libepoxy_build/src/glx_generated_dispatch.c", &.{});
        exe.addCSourceFile("libepoxy/src/dispatch_egl.c", &.{});
        exe.addCSourceFile("libepoxy_build/src/egl_generated_dispatch.c", &.{});
    }

    // imgui
    exe.linkSystemLibrary("c");
    exe.linkSystemLibrary("c++");
    const imguiFlags = [_][]const u8{ "-std=c++11", "-Ideps/imgui/deps/imgui" };
    exe.addCSourceFile("deps/imgui/deps/imgui/imgui.cpp", &imguiFlags);
    exe.addCSourceFile("deps/imgui/deps/imgui/imgui_draw.cpp", &imguiFlags);
    exe.addCSourceFile("deps/imgui/deps/imgui/imgui_widgets.cpp", &imguiFlags);
    exe.addCSourceFile("deps/imgui/deps/imgui/imgui_tables.cpp", &imguiFlags);
    exe.addCSourceFile("deps/imgui/deps/imgui/imgui_demo.cpp", &imguiFlags);
    exe.addCSourceFile("deps/imgui/deps/imgui/backends/imgui_impl_glfw.cpp", &imguiFlags);
    exe.addCSourceFile("deps/imgui/deps/imgui/backends/imgui_impl_opengl3.cpp", &imguiFlags);

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
