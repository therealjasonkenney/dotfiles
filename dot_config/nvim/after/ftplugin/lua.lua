-- ----------------------------------------------------------------------------
-- # 󰢱 Lua Configuration
--
-- ## Settings
-- |              |                       |                     |
-- | ------------ | --------------------- | ------------------- |
-- | Indent width | 2                     | Tabs are spaces     |
-- | Formatter    | `stylua`              | Installed via mason |
-- | LSP          | `lua-language-server` | Installed via mason |
-- | Root         | `.luarc.json`         |                     |
--
-- ## Autocompletion
-- * Signature Help
-- * Treesitter
-- * LSP
-- * LuaSnips Snippets
-- * Friendly Snippets
--
-- ## Configuration Files
-- |                     |               |
-- | ------------------- | ------------- |
-- | lua-language-server | `.luarc.json` |
-- | stylua              | `stylua.toml` |
--
-- ----------------------------------------------------------------------------

local util = require("util")

local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<leader>h", function()
  util.add_header("--")
end, { buffer = bufnr, desc = "Add comment header to lua file" })

-- Use lua-language-server as an LSP (except for formatting)]
-- Use nvim-cmp for completions.
util.ensure_installed("lua-language-server", function()
  local cfg = vim.lsp.config["luals"]

  vim.lsp.start(cfg, {
    bufnr = bufnr,
    reuse_client = cfg.reuse_client,
    _root_markers = cfg.root_markers,
  })
end)

-- Enable formatting via conform, do not use the lsp.
util.ensure_installed("stylua", function()
  util.enable_formatting(bufnr, false)
end)
