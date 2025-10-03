pub const RSGL_gl = @cImport({
    @cDefine("RSGL_IMPLEMENTATION", "");
    @cInclude("RSGL.h");
    @cInclude("renderers/RSGL_gl.h");
});

pub const RSGL_gl1 = @cImport({
    @cDefine("RSGL_IMPLEMENTATION", "");
    @cInclude("RSGL.h");
    @cInclude("renderers/RSGL_gl1.h");
});
