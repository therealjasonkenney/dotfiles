-- ----------------------------------------------------------------------------
-- # 󰍔 Makrdown Configuration
--
-- ## Settings
--
-- |              |          |                                |
-- | ------------ | -------- | ------------------------------ |
-- | Indent width | 2        | Tabs are spaces.               |
-- | LSP          | `ltex`   | Used for spelling and grammar. |
--
-- ## Completions
-- * Spelling & Grammar
-- * Snippets from render-markdown.
--
-- ## Keyamps
--
-- |             |                                       |
-- | ----------- | ------------------------------------- |
-- | `<space>mp` | Paste an image from system clipboard. |
--
-- ----------------------------------------------------------------------------
local cmp = require("cmp")
local util = require("util")

require("render-markdown").setup({})
require("render-markdown").enable()

require("img-clip").setup({})

cmp.setup.buffer({
  enabled = true,
  sources = cmp.config.sources({
    { name = "render-markdown" },
  }),
})

local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set(
  "n",
  "<leader>mp",
  vim.cmd.PasteImage,
  { buffer = bufnr, desc = "Paste image system from clipboard" }
)

-- Spelling and grammar support.
-- TODO: Update to ltex-ls-plus when it gets
-- added to mason-registry.
util.ensure_installed("ltex-ls", function()
  local cmd = util.mason_path() .. "/ltex-ls"
  vim.lsp.start({
    name = "ltex",
    cmd = { cmd },
    filetypes = { "markdown" },
    on_init = function(client)
      local dictionary = util.load_dictionary()

      client.settings.ltex.dictionary = {
        ["en-US"] = dictionary,
      }

      --      util.add_cmp_capabilities(client)
    end,
    settings = {
      ltex = {
        language = "en-US",
        enabled = true,
        dictionary = {},
      },
    },
  })
end)
