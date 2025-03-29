---Disable formatting (we use prettier) and enable completion via nvim-cmp.
---@param client vim.lsp.Client
local function on_init(client)
  local cmp = require("cmp_nvim_lsp")

  -- Disable tsserver's formatting.
  client.capabilities.textDocument.formatting = {}
  client.capabilities.textDocument.rangeFormatting = {}

  -- Add completion
  client.capabilities.textDocument.completion =
    cmp.default_capabilities().textDocument.completion
end

local util = require("util")

local cmd = util.mason_path() .. "/typescript-language-server"

---@type vim.lsp.ClientConfig
return {
  name = "ts_ls",
  init_options = { hostInfo = "neovim" },
  cmd = { cmd, "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  on_init = on_init,
  root_markers = { "tsconfig.json", "package.json", ".git" },
}
