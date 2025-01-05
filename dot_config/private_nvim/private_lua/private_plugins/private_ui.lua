return {
  {
    "pappasam/papercolor-theme-slim",
    priority = 1000,
    init = function()
      vim.cmd("colorscheme PaperColorSlim")
      vim.o.guifont = "Hack:h24"
    end,
  },
  -- Switch themes based on MacOS going from light to dark.
  {
    "vimpostor/vim-lumen",
  },
  -- Make search highlights go away after you enter insert mode.
  {
    "asiryk/auto-hlsearch.nvim",
    config = true,
  },
  -- Lualine status bar
  -- See: https://github.com/nvim-lualine/lualine.nvim/blob/master/README.md
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = require("config.lualine").plugin_opts,
  },
  -- File Manager
  {
    "nvim-neo-tree/neo-tree.nvim",
    tag = "3.26",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        "<leader>nf",
        ":Neotree filesystem reveal left<CR>",
        desc = "[n]eotree: open [f]ile explorer",
      },
    },
    opts = require("config.neo-tree").plugin_opts(),
  },
  -- Diagnostics/doc refs ui -- when needed.
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    lazy = true,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = true })
        end,
        desc = "Show keybinds.",
      },
    },
  },
}
