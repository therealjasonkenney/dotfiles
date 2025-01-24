-- Utilities for my neovim config.

local M = {}

local util_icons = require("util.icon")
local util_mason = require("util.mason")

M.add_cmp_capabilities = require("util.cmp").add_capabilities
M.enable_dap = require("util.dap").enable_dap
M.enable_formatting = require("util.conform").enable_formatting
M.ensure_installed = util_mason.ensure_installed
M.load_dictionary = require("util.dictionary").load_dictionary
M.mason_path = util_mason.mason_path
M.supports_glyph = util_icons.supports_glyph

---Finds a git project root, which can be a default for some
---lsps.
---@return string?
M.git_project_dir = function()
  local bufnr = vim.api.nvim_get_current_buf()

  return vim.fs.root(bufnr, { ".git" })
end

return M
