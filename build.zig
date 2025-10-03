const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mod = b.addModule("RSGL", .{
        .target = target,
        .optimize = optimize,
        .link_libc = true,
        .root_source_file = b.path("root.zig")
    });
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
