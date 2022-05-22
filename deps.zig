const std = @import("std");
const Pkg = std.build.Pkg;
const FileSource = std.build.FileSource;

pub const build_pkgs = struct {
    pub const @"build-glfw" = @import(".gyro/mach-glfw-hexops-github.com-dae779de/pkg/build.zig");
};

pub const pkgs = struct {
    pub const glfw = Pkg{
        .name = "glfw",
        .path = FileSource{
            .path = ".gyro/mach-glfw-hexops-github.com-dae779de/pkg/src/main.zig",
        },
    };

    pub const gl = Pkg{
        .name = "gl",
        .path = FileSource{
            .path = ".gyro/zgl-ziglibs-github.com-ebc646aa/pkg/zgl.zig",
        },
    };

    pub fn addAllTo(artifact: *std.build.LibExeObjStep) void {
        artifact.addPackage(pkgs.glfw);
        artifact.addPackage(pkgs.gl);
    }
};
