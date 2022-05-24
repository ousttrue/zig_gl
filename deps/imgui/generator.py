import pathlib
HERE = pathlib.Path(__file__).absolute().parent

IMGUI_DIR = HERE / 'deps/imgui'
IMGUI_HEADER = IMGUI_DIR / 'imgui.h'
DST = HERE / 'src/main.zig'
IMGUI_IMPL_GLFW = IMGUI_DIR / 'backends/imgui_impl_glfw.h'
IMGUI_IMPL_OPENGL3 = IMGUI_DIR / 'backends/imgui_impl_opengl3.h'


def main():
    from rawtypes.parser.header import Header
    headers = [
        Header(IMGUI_HEADER, include_dirs=[IMGUI_DIR], begin='''
pub const ImVector = extern struct {
    Size: c_int,
    Capacity: c_int,
    Data: *anyopaque,
};

'''),
        Header(IMGUI_IMPL_GLFW),
        Header(IMGUI_IMPL_OPENGL3),
    ]

    from rawtypes.generator.zig_generator import ZigGenerator
    generator = ZigGenerator(*headers)

    generator.generate(DST)


if __name__ == '__main__':
    main()
