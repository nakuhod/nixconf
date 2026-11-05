return {
    cmd = {
        "clangd"
    },
    root_markers = {
        '.clangd',
        'meson.build',
        'Makefile',
        'compile_commands.json',
    },
    filetypes = {
        "c",
        "cpp",
    },
}
