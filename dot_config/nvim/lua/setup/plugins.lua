-- ----------------------------------------------------------------------------
-- # Plugin Installation
-- Installs my plugins using mini.deps, they are then later setup in
-- `after/plugins` or `after/ftplugins`
--
-- |                        | Lang   | Description                            |
-- | ---------------------- |------- | -------------------------------------- |
-- | auto-hlsearch          | All    | Turns off search highlights when       |
-- |                        |        | edting.                                |
-- | dap                    | 󰴭 󱘗   | Interface for interacting with         |
-- |                        |        | debuggers.                             |
-- | cmp                    | All    | Auto-completion.                       |
-- | elixir-tools           |       | Configures and installs elixir LSP.    |
-- | img-clip               | 󰍔      | Generate markdown from pasting an img. |
-- | mason                  |        | Manages and installs formatters,       |
-- |                        |        | linters, and language servers.         |
-- | neotest                |󰴭       | Test runner.                           |
-- | neotree                | All    | Buffer, File, Git browser.             |
-- | papercolor-theme       | All    | Color scheme for light and dark modes. |
-- | render-markdown        | 󰍔      | Renders markdown when in normal mode.  |
-- | tiny-inline-diagnostic | 󰌞 󰘦 󰴭 | Diagnostics are inline, wrapped and    |
-- |                        | 󱘗 󰛦   | highlighted for readability.           |
-- | treesitter             | All    | Syntax highlighting, folding, and      |
-- |                        |        | indenting.                             |
-- | treesitter-endwise     |  󰢱 󰴭 | Automatically add `end` for blocks.    |
-- | teesitter-textobjects  | All    | Add community provided groupings for   |
-- |                        |        | auto pairs and travel.                 |
-- | trouble                | 󰌞 󰘦 󰴭 | I for diagnostics, document symbols,   |
-- |                        | 󱘗 󰛦   | lsp defs/references, and quickfix.     |
-- | which-key              | All    | Helps with remembering keybindings.    |
-- ----------------------------------------------------------------------------

local M = {}

M.install_plugins = function()
  local add = MiniDeps.add

  add("stevearc/conform.nvim")

  add({
    source = "asiryk/auto-hlsearch.nvim",
    checkout = "1.1.0",
  })

  add({
    source = "hrsh7th/nvim-cmp",
    depends = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "ray-x/cmp-treesitter",
    },
  })

  add({
    source = "mfussenegger/nvim-dap",
    depends = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "suketa/nvim-dap-ruby",
    },
  })

  add({
    source = "elixir-tools/elixir-tools.nvim",
    depends = { "nvim-lua/plenary.nvim" },
  })

  add("HakonHarnes/img-clip.nvim")

  add({
    source = "williamboman/mason.nvim",
    hooks = {
      post_checkout = function()
        vim.cmd("MasonUpdate")
      end,
    },
  })

  add({
    source = "nvim-neotest/neotest",
    depends = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "olimorris/neotest-rspec",
    },
  })

  add({
    source = "nvim-neo-tree/neo-tree.nvim",
    checkout = "3.26",
    depends = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
  })

  add({
    source = "MeanderingProgrammer/render-markdown.nvim",
    depends = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim",
    },
  })

  add("rachartier/tiny-inline-diagnostic.nvim")

  add({
    source = "nvim-treesitter/nvim-treesitter",
    hooks = {
      post_checkout = function()
        vim.cmd("TSUpdate")
      end,
    },
  })

  add({
    source = "RRethy/nvim-treesitter-endwise",
    depends = { "nvim-treesitter/nvim-treesitter" },
  })

  add({
    source = "nvim-treesitter/nvim-treesitter-textobjects",
    depends = { "nvim-treesitter/nvim-treesitter" },
  })

  add("folke/trouble.nvim")
  add({
    source = "windwp/nvim-ts-autotag",
    depends = { "nvim-treesitter/nvim-treesitter" },
  })

  add("folke/which-key.nvim")
  add({ source = "vimpostor/vim-lumen", checkout = "v1.0" })
end

return M
