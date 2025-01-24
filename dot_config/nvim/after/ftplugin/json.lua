-- JSON settings
-- LSP: vscode-json-language-server as an LSP
-- Formatter: vscode-json-language-server
-- Code Completion: Yes
-- This should also utilize schemas specified in the json file.

local util = require("util")

local bufnr = vim.api.nvim_get_current_buf()
local jsonls = util.mason_path() .. "/vscode-json-language-server"

util.ensure_installed("prettierd", function()
  util.enable_formatting(bufnr, false)
end)

util.ensure_installed("json-lsp", function()
  local cmp = require("cmp")

  cmp.setup.buffer({ enabled = true })

  vim.lsp.start({
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    cmd = { jsonls, "--stdio" },
    filetypes = { "json", "jsonc" },
    init_options = {
      provideFormatter = false,
    },
    name = "jsonls",
    on_init = util.add_cmp_capabilities,
    root_dir = util.git_project_dir(),
  })
end)
