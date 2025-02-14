-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():toggle_fullscreen()
end)

local config = wezterm.config_builder()

config.color_scheme = "PaperColor Light (base16)"

config.font = wezterm.font("Hack")
config.font_size = 24.0

config.native_macos_fullscreen_mode = true

return config
