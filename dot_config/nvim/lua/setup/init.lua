local M = {}

local actions = require("setup.actions")

M.neovide = require("setup.neovide").setup
M.mini = require("setup.mini").setup
M.install_plugins = require("setup.plugins").install_plugins
M.setup_colorscheme = actions.setup_colorscheme
M.set_defaults = actions.set_defaults

return M
