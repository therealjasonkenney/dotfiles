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

-- Use lua-language-server as an LSP (except for formatting)]
-- Use nvim-cmp for completions.
util.ensure_installed("lua-language-server", function()
  local cmd = util.mason_path() .. "/lua-language-server"

  -- Set LSP
  vim.lsp.start({
    name = "luals",
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    cmd = { cmd },
    filetypes = { "lua" },
    on_init = util.add_cmp_capabilities,
    root_dir = vim.fs.root(bufnr, { ".luarc.json" }),
  })

  vim.keymap.set("n", "<leader>h", function()
    util.add_header("--")
  end, { desc = "Add comment header to lua file" })
end)

-- Enable formatting via conform, do not use the lsp.
util.ensure_installed("stylua", function()
  util.enable_formatting(bufnr, false)
end)
