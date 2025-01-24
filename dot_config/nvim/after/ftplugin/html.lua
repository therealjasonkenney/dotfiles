-- For HTML we only need formatting and syntax highlighting.

local util = require("util")

local bufnr = vim.api.nvim_get_current_buf()

util.ensure_installed("prettierd", function()
  util.enable_formatting(bufnr, false)
end)
