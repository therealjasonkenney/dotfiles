local M = {}

M.icons = require("config.icons").config

if vim.g.neovide then
  require("config.neovide")
end

require("config.diagnostics")
require("config.keymaps")
require("config.lsp")
require("config.options")

return M
