local util = require("util")

local bufnr = vim.api.nvim_get_current_buf()

vim.bo.shiftwidth = 2

util.ensure_installed("prettierd", function()
  util.enable_formatting(bufnr, false)
end)

util.ensure_installed("typescript-language-server", function()
  local config = vim.lsp.config.ts_ls

  vim.lsp.start(config, {
    bufnr = bufnr,
    reuse_client = config.reuse_client,
    _root_markers = config.root_markers,
  })
end)
