-- JSON settings
-- LSP: vscode-json-language-server as an LSP
-- Formatter: vscode-json-language-server
-- Code Completion: Yes
-- This should also utilize schemas specified in the json file.

local util = require("util")

-- load completion plugin
require("cmp_nvim_lsp")

-- We can't use the normal nvim_cmp_lsp way because
-- it causes unhandled mehtod textDocument/diagnostic
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local jsonls = util.mason_path() .. "/vscode-json-language-server"

util.ensure_installed("json-lsp")
util.ensure_installed("prettierd")

vim.lsp.start({
  capabilities = capabilities,
  cmd = { jsonls, "--stdio" },
  filetypes = { "json", "jsonc" },
  init_options = {
    provideFormatter = false,
  },
  name = "jsonls",
  root_dir = util.git_project_dir(),
})
