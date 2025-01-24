local config = require("config")
local util = require("util")

local set = vim.api.nvim_set_option_value

local bufnr = vim.api.nvim_get_current_buf()

-- clear out the spacing augroup.
vim.api.nvim_create_augroup("default_spacing", { clear = true })

vim.bo.shiftwidth = 2

util.ensure_installed("prettierd", function()
  util.enable_formatting(bufnr, false)
end)

util.ensure_installed("typescript-language-server", function()
  vim.lsp.start(config.typescript_ls(bufnr))
end)
