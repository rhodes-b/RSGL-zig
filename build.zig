const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const rsgl_gl = b.createModule(.{
        .target = target,
        .optimize = optimize,
        .link_libc = true,
        .root_source_file = null,
    });

    const rsgl_gl1 = b.createModule(.{
        .target = target,
        .optimize = optimize,
        .link_libc = true,
        .root_source_file = null,
    });

    rsgl_gl.addCSourceFiles(.{
        .files = &.{
            "RSGL.h",
            "renderers/RSGL_gl.h",
        },
        .flags = &.{"-DRSGL_IMPLEMENTATION"},
        .language = .c,
    });

    rsgl_gl1.addCSourceFiles(.{
        .files = &.{
            "RSGL.h",
            "renderers/RSGL_gl1.h",
        },
        .flags = &.{"-DRSGL_IMPLEMENTATION"},
        .language = .c,
    });

    const mod = b.addModule("RSGL", .{
        .target = target,
        .optimize = optimize,
        .link_libc = true,
        .root_source_file = b.path("root.zig")
    });

    mod.addImport("rsgl_gl", rsgl_gl);
    mod.addImport("rsgl_gl1", rsgl_gl1);

    mod.addIncludePath(b.path("."));
    
    switch (target.result.os.tag) {
        .linux, .freebsd, .openbsd, .dragonfly => {
            mod.linkSystemLibrary("GL", .{.needed = true});
        },
        .macos => {
            mod.linkFramework("OpenGL", .{.needed = true});
        },
        .windows => {
            mod.linkSystemLibrary("opengl32", .{.needed = true});
        },
        else => {}
    }
}
