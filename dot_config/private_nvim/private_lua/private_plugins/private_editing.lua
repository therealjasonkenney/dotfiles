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
    config = config.conform,
    event = { "LspAttach" },
    init = function()
      -- Set formatexpr to use conform
      -- Local to buffer
      vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
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
    config = config.cmp,
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
    lazy = true,
  },
  -- Syntax highlighting auto closures and indenting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = config.treesitter,
    init = function()
      -- Use treesitter for folding
      -- local to window
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldenable = false
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
