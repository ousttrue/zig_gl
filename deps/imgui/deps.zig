const std = @import("std");
const Pkg = std.build.Pkg;
const FileSource = std.build.FileSource;


pub const pkgs = struct {
    pub const imgui = Pkg{
        .name = "imgui",
        .path = FileSource{
            .path = "src/main.zig",
        },
    };

    pub fn addAllTo(artifact: *std.build.LibExeObjStep) void {
        artifact.addPackage(pkgs.imgui);
    }
};
