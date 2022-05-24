const std = @import("std");
// const glfw = @import("glfw");
const glfw = @import(".gyro/mach-glfw-hexops-github.com-dae779de/pkg/src/main.zig");
const zgl = @import(".gyro/zgl-ziglibs-github.com-ebc646aa/pkg/zgl.zig");
const imgui = @import("deps/imgui/src/main.zig");

fn glfw_error_callback(_: glfw.Error, description: [:0]const u8) void {
    std.debug.print("Glfw Error: {s}\n", .{description});
}

pub fn main() anyerror!void {
    // Setup window
    glfw.setErrorCallback(glfw_error_callback);

    try glfw.init(.{});
    defer glfw.terminate();

    // GL 3.0 + GLSL 130
    const glsl_version = "#version 130";
    // glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    // glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 0);
    // glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);  // 3.2+ only
    // glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);            // 3.0+ only

    // Create window with graphics context
    const window = try glfw.Window.create(1280, 720, "zig Dear ImGui GLFW+OpenGL3 example", null, null, .{});
    defer window.destroy();
    try glfw.makeContextCurrent(window);
    try glfw.swapInterval(1); // Enable vsync

    // Setup Dear ImGui context
    // IMGUI_CHECKVERSION();
    _ = imgui.CreateContext(null);
    defer imgui.DestroyContext(null);

    const io = imgui.GetIO() orelse return;
    io.ConfigFlags |= @enumToInt(imgui.ImGuiConfigFlags._NavEnableKeyboard); // Enable Keyboard Controls
    //io.ConfigFlags |= ImGuiConfigFlags_NavEnableGamepad;      // Enable Gamepad Controls
    io.ConfigFlags |= @enumToInt(imgui.ImGuiConfigFlags._DockingEnable); // Enable Docking
    io.ConfigFlags |= @enumToInt(imgui.ImGuiConfigFlags._ViewportsEnable); // Enable Multi-Viewport / Platform Windows
    //io.ConfigViewportsNoAutoMerge = true;
    //io.ConfigViewportsNoTaskBarIcon = true;

    // Setup Dear ImGui style
    imgui.StyleColorsDark(null);
    //ImGui::StyleColorsClassic();

    // When viewports are enabled we tweak WindowRounding/WindowBg so platform windows can look identical to regular ones.
    if (imgui.GetStyle()) |style| {
        if ((io.ConfigFlags & @enumToInt(imgui.ImGuiConfigFlags._ViewportsEnable)) != 0) {
            style.WindowRounding = 0.0;
            style.Colors[@enumToInt(imgui.ImGuiCol._WindowBg)].w = 1.0;
        }
    }

    // Setup Platform/Renderer backends
    _ = imgui.ImGui_ImplGlfw_InitForOpenGL(window.handle, true);
    defer imgui.ImGui_ImplGlfw_Shutdown();
    _ = imgui.ImGui_ImplOpenGL3_Init(glsl_version);
    defer imgui.ImGui_ImplOpenGL3_Shutdown();

    //     // Load Fonts
    //     // - If no fonts are loaded, dear imgui will use the default font. You can also load multiple fonts and use ImGui::PushFont()/PopFont() to select them.
    //     // - AddFontFromFileTTF() will return the ImFont* so you can store it if you need to select the font among multiple.
    //     // - If the file cannot be loaded, the function will return NULL. Please handle those errors in your application (e.g. use an assertion, or display an error and quit).
    //     // - The fonts will be rasterized at a given size (w/ oversampling) and stored into a texture when calling ImFontAtlas::Build()/GetTexDataAsXXXX(), which ImGui_ImplXXXX_NewFrame below will call.
    //     // - Read 'docs/FONTS.md' for more instructions and details.
    //     // - Remember that in C/C++ if you want to include a backslash \ in a string literal you need to write a double backslash \\ !
    //     //io.Fonts->AddFontDefault();
    //     //io.Fonts->AddFontFromFileTTF("../../misc/fonts/Roboto-Medium.ttf", 16.0f);
    //     //io.Fonts->AddFontFromFileTTF("../../misc/fonts/Cousine-Regular.ttf", 15.0f);
    //     //io.Fonts->AddFontFromFileTTF("../../misc/fonts/DroidSans.ttf", 16.0f);
    //     //io.Fonts->AddFontFromFileTTF("../../misc/fonts/ProggyTiny.ttf", 10.0f);
    //     //ImFont* font = io.Fonts->AddFontFromFileTTF("c:\\Windows\\Fonts\\ArialUni.ttf", 18.0f, NULL, io.Fonts->GetGlyphRangesJapanese());
    //     //IM_ASSERT(font != NULL);

    //     // Our state
    var show_demo_window: c_int = 1;
    //     bool show_another_window = false;
    const clear_color: imgui.ImVec4 = .{ .x = 0.45, .y = 0.55, .z = 0.60, .w = 1.00 };

    while (!window.shouldClose()) {
        try glfw.pollEvents();

        // Start the Dear ImGui frame
        imgui.ImGui_ImplOpenGL3_NewFrame();
        imgui.ImGui_ImplGlfw_NewFrame();
        imgui.NewFrame();

        // 1. Show the big demo window (Most of the sample code is in ImGui::ShowDemoWindow()! You can browse its code to learn more about Dear ImGui!).
        if (show_demo_window != 0)
            imgui.ShowDemoWindow(&show_demo_window);

        //         // 2. Show a simple window that we create ourselves. We use a Begin/End pair to created a named window.
        //         {
        //             static float f = 0.0f;
        //             static int counter = 0;

        //             ImGui::Begin("Hello, world!");                          // Create a window called "Hello, world!" and append into it.

        //             ImGui::Text("This is some useful text.");               // Display some text (you can use a format strings too)
        //             ImGui::Checkbox("Demo Window", &show_demo_window);      // Edit bools storing our window open/close state
        //             ImGui::Checkbox("Another Window", &show_another_window);

        //             ImGui::SliderFloat("float", &f, 0.0f, 1.0f);            // Edit 1 float using a slider from 0.0f to 1.0f
        //             ImGui::ColorEdit3("clear color", (float*)&clear_color); // Edit 3 floats representing a color

        //             if (ImGui::Button("Button"))                            // Buttons return true when clicked (most widgets return true when edited/activated)
        //                 counter++;
        //             ImGui::SameLine();
        //             ImGui::Text("counter = %d", counter);

        //             ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", 1000.0f / ImGui::GetIO().Framerate, ImGui::GetIO().Framerate);
        //             ImGui::End();
        //         }

        //         // 3. Show another simple window.
        //         if (show_another_window)
        //         {
        //             ImGui::Begin("Another Window", &show_another_window);   // Pass a pointer to our bool variable (the window will have a closing button that will clear the bool when clicked)
        //             ImGui::Text("Hello from another window!");
        //             if (ImGui::Button("Close Me"))
        //                 show_another_window = false;
        //             ImGui::End();
        //         }

        // Rendering
        imgui.Render();
        const size = try window.getFramebufferSize();
        // int ;
        zgl.viewport(0, 0, size.width, size.height);
        zgl.clearColor(clear_color.x * clear_color.w, clear_color.y * clear_color.w, clear_color.z * clear_color.w, clear_color.w);
        zgl.clear(.{ .color = true });
        imgui.ImGui_ImplOpenGL3_RenderDrawData(imgui.GetDrawData());

        // Update and Render additional Platform Windows
        // (Platform functions may change the current OpenGL context, so we save/restore it to make it easier to paste this code elsewhere.
        //  For this specific demo app we could also call glfwMakeContextCurrent(window) directly)
        if ((io.ConfigFlags & @enumToInt(imgui.ImGuiConfigFlags._ViewportsEnable)) != 0) {
            const backup_current_context = glfw.getCurrentContext();
            imgui.UpdatePlatformWindows();
            imgui.RenderPlatformWindowsDefault(null, null);
            try glfw.makeContextCurrent(backup_current_context);
        }

        try window.swapBuffers();
    }
}
