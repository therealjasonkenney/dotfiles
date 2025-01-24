-- -----------------------------------------------------------------------------
-- # Treesitter Plugin
-- treesitter is a tool used by neovim core to query a languages syntax tree.
-- this plugin enhances this functionality and leverages it for folding, syntax
-- highlighting and selection.
--
-- ## Settings
-- * Automatically install treesitter files when loading a filetype for the first
--   time.
-- * Use treesitter for syntax highliging instead of vim's regex.
-- * Enable incremental selection.
-- * Use treesitter for indenting instead of vim.
-- * Use treesitter for folding.
--
-- ## Keymaps
-- |       | Selection        |
-- | ----- | ---------------- |
-- | `gnn` | cursor           |
-- | `grn` | node             |
-- | `grc` | scope            |
-- | `grm` | node decremental |
--
-- -----------------------------------------------------------------------------
local configs = require("nvim-treesitter.configs")

configs.setup({
  auto_install = true,
  endwise = {
    enable = true,
  },
  ensure_installed = {},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  ignore_install = {},
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = { enable = true },
  sync_install = false,
})

-- Use treesitter for folding.
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

-- Turn off smartindent, use treesitter's indent feature instead.
vim.opt.smartindent = false
