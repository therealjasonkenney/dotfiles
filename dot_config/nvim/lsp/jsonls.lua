-- ---------------------------------------------------------------------------
-- LSP client for JSON and JSONC
-- ---------------------------------------------------------------------------

---@type vim.lsp.ClientConfig
return {
  name = "jsonls",
  cmd = function(dispatchers)
    local util = require("util")

    local jsonls = util.mason_path() .. "/vscode-json-language-server"

    local client = vim.lsp.rpc.start({ jsonls, "--stdio" }, dispatchers)

    return client
  end,
  filetypes = { "json", "jsonc" },
  init_options = {
    provideFormatter = false,
  },
  root_markers = { ".git" },
}
