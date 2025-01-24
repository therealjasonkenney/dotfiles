local M = {}

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

---Default configuration for typescript language server.
--- * Set the name to 'ts_ls' and set the file types to js, ts, and react types.
---   this allows neovim to reuse an existing lsp if the same name and type are
---   used.
--- * Let the server know neovim is the host.
--- * Use the mason installed binary.
--- * Look for the nearest directory with package.json, tsconfig.json or default to .git
---@return vim.lsp.ClientConfig
M.config = function(bufnr)
  local util = require("util")

  local cmd = util.mason_path() .. "/typescript-language-server"

  local root_dir =
    vim.fs.root(bufnr, { "tsconfig.json", "package.json", ".git" })

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
    root_dir = root_dir,
  }
end

return M
