-- Utilities for my neovim config.

local M = vim.tbl_extend(
  "error",
  require("util.conform"),
  require("util.dap"),
  require("util.dictionary"),
  require("util.icon"),
  require("util.lsp"),
  require("util.mason")
)

M.add_cmp_capabilities = require("util.cmp").add_capabilities

---Finds a git project root, which can be a default for some
---lsps.
---@return string?
M.git_project_dir = function()
  local bufnr = vim.api.nvim_get_current_buf()

  return vim.fs.root(bufnr, { ".git" })
end

return M
