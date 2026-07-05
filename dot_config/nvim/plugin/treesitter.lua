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

vim.api.nvim_create_autocmd("FileType", {
  desc = "Start (and install) Treesitter parser",
  pattern = "*",
  callback = function(args)
    local ts = require("nvim-treesitter")

    -- make sure there is an available parser, otherwise vim will
    -- just fail.
    if vim.tbl_contains(ts.get_available(), args.match) then
      ts.install({ args.match }):wait(300000)

      -- handle do/end blocks in ruby/elixir/lua
      require("nvim-treesitter-endwise")
      -- auto close tags in xml/html
      require("nvim-ts-autotag").setup({})

      -- start treesitter
      vim.treesitter.start()
      -- Use treesitter for code folding.
      vim.wo.foldexpr = "v:lua:vim.treesitter.foldexpr()"
      vim.wo.foldmethod = "expr"

      -- disable vim's smartindent and use treesitter's instead.
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.bo.smartindent = false
    end
  end,
})

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

-- nvim-treesitter was archived, so I am installing it with the version pinned to the last commit in case
-- something happens.

vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "4916d6592ede8c07973490d9322f187e07dfefac",
  },
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/RRethy/nvim-treesitter-endwise",
  "https://github.com/windwp/nvim-ts-autotag",
})
