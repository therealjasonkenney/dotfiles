-- ----------------------------------------------------------------------------
-- My Neovim Config
-- * Optmized for a polyglot whom bounces from language to language to avoid
--   setup conflicts between projects.
-- * I use mini.deps because it has the basics of what I need and I have
--   a better idea of when things get installed and loaded.
-- * I do not use lspconfig, I use the builtin vim.lsp client because I do
--   not use LSP for most filetypes, and when I do it must be configured, often
--   with specific needs. And because as a polyglot programmer I do not want all
--   the lsp clients setup all at once (or specifically loading all the other
--   plugins specific for those lsp's)
-- * That also means I ensure installation for mason tools in the ftplugin file
--   again, its so my poor laptop does not need to load prettier and node and all
--   its things when editing a shell file.
-- * I rely on treesitter with basic completion for most languages.
--
-- ## Directory Structure
--
-- * `lua/config` - Common configuration tables for reuse across files in
--                  `after/ftplugin`.
-- * `lua/setup` - Configuration that must run in a specific order,
--                 like installing mini, and then the other plugins.
-- * `after/plugin` - Configuration that can run in any order and is loaded
--   after everything else.
-- * `after/ftplugin` - Language specific configuration, this is where formatting
--   debuggers, and language servers are enabled if they are. I only place
--   configuration for common languages I use which require those additional
--   features.
-- ----------------------------------------------------------------------------

-- 01 enable new ui
require("vim._core.ui2").enable()

-- 02 Set leader key.
vim.g.mapleader = " "

-- 03 Add Theme
vim.pack.add({ "https://github.com/pappasam/papercolor-theme-slim" })

vim.cmd("colorscheme PaperColorSlim")

-- Ensure it gets applied when the background changes between light and dark.
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    -- Apply PaperColor again to update its internal theme switch
    vim.cmd("colorscheme PaperColorSlim")
  end,
})

-- 04 Load mini
vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

require("mini.icons").setup()

-- 05 Load configuration
require("config")
