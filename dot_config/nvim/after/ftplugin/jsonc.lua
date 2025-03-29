-- JSON settings
-- LSP: vscode-json-language-server as an LSP
-- Formatter: vscode-json-language-server
-- Code Completion: Yes
-- This should also utilize schemas specified in the json file.

local util = require("util")

local bufnr = vim.api.nvim_get_current_buf()

util.ensure_installed("json-lsp", function()
  local cmp = require("cmp")

  cmp.setup.buffer({ enabled = true })

  local config = vim.lsp.config.jsonls

  vim.lsp.start(config, {
    bufnr = bufnr,
    reuse_client = config.reuse_client,
    _root_markers = config.root_markers,
  })
end)

util.ensure_installed("prettierd", function()
  util.enable_formatting(bufnr, false)
end)
