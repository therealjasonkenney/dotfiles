local M = {}

M.lazy = require("setup.bootstrap_lazy").setup
M.lsp = require("setup.lsp").setup
M.mini = require("setup.mini").setup
M.neovide = require("setup.neovide").setup
M.ui = require("setup.ui").setup

return M
