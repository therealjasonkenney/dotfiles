-- ---------------------------------------------------------------------------
-- LSP client for JSON and JSONC
-- ---------------------------------------------------------------------------
local util = require("util")

---@type vim.lsp.ClientConfig
return {
  name = "jsonls",
  cmd = util.mason_cmd("vscode-json-language-server", { "--stdio" }),
  filetypes = { "json", "jsonc" },
  init_options = {
    provideFormatter = false,
  },
  root_markers = { ".git" },
}
