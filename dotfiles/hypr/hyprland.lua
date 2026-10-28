main_mod = "SUPER"
noctalia_ipc = "noctalia msg "

browser = "firefox"
terminal = "footclient"
created_on_empty_terminal = "footclient --app-id=footclient_created_on_empty"
app_launcher = noctalia_ipc .. "panel-toggle launcher"
clipboard_panel = noctalia_ipc .. "panel-toggle clipboard"
file_manager = "thunar"
emacs = "emacsclient -c -a ''"

require("modules.autostart")
require("modules.general")
require("modules.monitors")
require("modules.rules")
require("modules.keybinds")

-- For Noctalia Color templates
require("noctalia").apply_theme()
