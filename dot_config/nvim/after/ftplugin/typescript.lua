local config = require("config")
local util = require("util")

local bufnr = vim.api.nvim_get_current_buf()

vim.bo.shiftwidth = 2

util.ensure_installed("prettierd", function()
  util.enable_formatting(bufnr, false)
end)

util.ensure_installed("typescript-language-server", function()
  vim.lsp.start(config.typescript_ls(bufnr))
end)
