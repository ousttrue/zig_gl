import pathlib
HERE = pathlib.Path(__file__).absolute().parent

IMGUI_DIR = HERE / 'deps/imgui'
IMGUI_HEADER = IMGUI_DIR / 'imgui.h'
DST = HERE / 'src/main.zig'


def main():
    from rawtypes.parser.header import Header
    header = Header(IMGUI_HEADER, include_dirs=[IMGUI_DIR])

    from rawtypes.generator.zig_generator import ZigGenerator
    generator = ZigGenerator(header)

    generator.generate(DST)


if __name__ == '__main__':
    main()
