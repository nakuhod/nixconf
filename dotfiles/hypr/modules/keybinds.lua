-- Essentials
--- columns
hl.bind(main_mod .. " + F", hl.dsp.layout("colresize 1"))
hl.bind(main_mod .. " + SHIFT + V", hl.dsp.layout("colresize 0.5"))

hl.bind(main_mod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(main_mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + SHIFT + Q", hl.dsp.exit())
hl.bind(main_mod .. " + C", hl.dsp.window.close())

-- exec_cmd keybindings
hl.bind(main_mod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(main_mod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(main_mod .. " + D", hl.dsp.exec_cmd(file_manager))
hl.bind(main_mod .. " + E", hl.dsp.exec_cmd(emacs))
hl.bind(main_mod .. " + slash", hl.dsp.exec_cmd(clipboard_panel))
hl.bind(main_mod .. " + SPACE", hl.dsp.exec_cmd(app_launcher))

-- Layout
--- Focus window
hl.bind(main_mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(main_mod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(main_mod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(main_mod .. " + L", hl.dsp.focus({ direction = "right" }))

--- Move window
hl.bind(main_mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(main_mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(main_mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(main_mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

--- Swap columns and notify
hl.bind(main_mod .. " + comma", function()
    hl.dispatch(hl.dsp.layout("swapcol l"))
    local active_window = hl.get_active_window()
    if active_window ~= nil then
        hl.notification.create({
            text = active_window.class .. " ⬅️",
            timeout = 2000,
            icon = "info"
        })
    end
end)
hl.bind(main_mod .. " + period", function()
    hl.dispatch(hl.dsp.layout("swapcol r"))
    local active_window = hl.get_active_window()
    if active_window ~= nil then
        hl.notification.create({
            text = active_window.class .. " ➡️",
            timeout = 2000,
            icon = "info"
        })
    end
end)


-- Default workspace keybindings
for i = 1, 9 do
    local key = i
    hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special Workspaces
hl.workspace_rule({ workspace = "special:terminalScratchpad", on_created_empty = created_on_empty_terminal })
hl.bind(main_mod .. " + S", hl.dsp.workspace.toggle_special("terminalScratchpad"))
hl.bind(main_mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:terminalScratchpad" }))

hl.on("window.open", function(w)
    if w.class == "footclient_created_on_empty" then
        hl.dsp.focus({ window = w })
    end
end)

-- Move/resize windows with main_mod + LMB/RMB and dragging
hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Other

--- Multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

--- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind(main_mod .. " + Up", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind(main_mod .. " + Down", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind(main_mod .. " + P", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

--- Zoom
local MAX_ZOOM = 3
local MIN_ZOOM = 1
local ZOOM_TOGGLE_FACTOR = 1.5

local function zoom(offset)
    local current = hl.get_config("cursor.zoom_factor")
    if offset ~= nil then
        current = current + offset
    elseif current ~= MIN_ZOOM then
        current = MIN_ZOOM
    else
        current = ZOOM_TOGGLE_FACTOR
    end
    current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
    hl.config({ cursor = { zoom_factor = current } })
end

hl.bind(main_mod .. " + Z", zoom)
hl.bind(main_mod .. " + KP_ADD", function()
    zoom(0.5)
end)
hl.bind(main_mod .. " + KP_SUBTRACT", function()
    zoom(-0.5)
end)
