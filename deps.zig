const std = @import("std");
const Pkg = std.build.Pkg;
const FileSource = std.build.FileSource;

pub const pkgs = struct {
    pub const glfw = Pkg{
        .name = "glfw",
        .path = FileSource{
            .path = ".gyro\\mach-glfw-hexops-github.com-dae779de\\pkg\\src\\main.zig",
        },
    };

    pub fn addAllTo(artifact: *std.build.LibExeObjStep) void {
        artifact.addPackage(pkgs.glfw);
    }
};