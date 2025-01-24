local config = require("config")

-- These are plugins specific to editing conviences (that are not already in mini).
return {
  -- Debugging
  {
    "mfussenegger/nvim-dap",
    desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",
    config = config.dap,
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
  },
  -- Formatting
  {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    lazy = true,
  },
  -- Make search highlights go away after you enter insert mode.
  {
    "asiryk/auto-hlsearch.nvim",
    config = true,
  },
  -- Elixir LSP configuration
  {
    "elixir-tools/elixir-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = true,
    version = "*",
  },
  -- LSP/formatter/linter installation
  {
    "williamboman/mason.nvim",
    opts = {
      build = ":MasonUpdate",
    },
  },
  -- Code completion.
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.3.0",
        dependencies = {
          "saadparwaiz1/cmp_luasnip",
          "rafamadriz/friendly-snippets",
        },
      },
    },
    opts = config.cmp,
  },
  -- Syntax highlighting auto closures and indenting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    init = function()
      -- Use treesitter for folding
      -- local to window
    end,
  },
  -- Auto tagging via treesitter
  { "windwp/nvim-ts-autotag", lazy = false },
  -- Automatic closing with 'end' for languages such as lua, elixir and ruby
  {
    "RRethy/nvim-treesitter-endwise",
    lazy = false,
  },
}
