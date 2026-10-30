hl.layer_rule({
    name = "noctalia",
    match = {
        namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
    },
    no_anim = true,
    ignore_alpha = 0.5,
    blur = true,
    blur_popups = true,
})

hl.window_rule({
    name = "TerminalScratchpad",
    match = {
        workspace = "special:terminalScratchpad"
    },
    opacity = "0.6 override 0.5 override 0.4 override",
    focus_on_activate = true
})


hl.window_rule({
    name = "Handle on_created_empty behavior",
    match = {
        initial_class = "footclient_created_on_empty"
    },
    workspace = "special:terminalScratchpad",
    no_initial_focus = false,
})

hl.window_rule({
    name = "FullscreenBorders",
    match = {
        fullscreen = true
    },
    border_color = "rgba(ff0000ff)",
    border_size = 5,
})

local whole_column_classes = table.concat({
    "firefox",
    "chromium-browser",
}, "|")
hl.window_rule({
    name = "WholeColumnApps",
    match = {
        class = whole_column_classes
    },
    scrolling_width = 1
})


local float_classes = table.concat({
    "org\\.pulseaudio\\.pavucontrol",
    "org\\.gnome\\.Calculator",
    "org\\.kde\\.kclock",
    "blueman-manager",
}, "|")
hl.window_rule({
    name = "FloatingApps",
    match = {
        class = float_classes
    },
    float = true,
    center = true,
    size = { "monitor_w * 0.5", "monitor_h * 0.6" }
})

local bigger_float_classes = table.concat({
    "anki",
    "thunar",
    "Thunar",
    "Nsxiv",
    "nm-connection-editor",
    "hyprland-share-picker",
}, "|")
hl.window_rule({
    name = "BiggerFloatingApps",
    match = {
        class = bigger_float_classes
    },
    float = true,
    center = true,
    size = { "monitor_w * 0.6", "monitor_h * 0.8" }
})
