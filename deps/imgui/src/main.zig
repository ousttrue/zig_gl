// rawtypes generated
const std = @import("std");
const testing = std.testing;
export fn add(a: i32, b: i32) i32 {
    return a + b;
}
test "basic add functionality" {
    try testing.expect(add(3, 7) == 10);
}

extern "c" fn _ZN5ImGui13CreateContextEP11ImFontAtlas(shared_font_atlas: ?*anyopaque) ?*anyopaque;
const CreateContext = _ZN5ImGui13CreateContextEP11ImFontAtlas;
