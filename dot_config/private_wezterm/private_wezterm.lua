-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "PaperColor Light (base16)"

config.default_prog = { "/usr/local/bin/fish", "-l" }

config.font = wezterm.font("Hack")
config.font_size = 24.0

return config
