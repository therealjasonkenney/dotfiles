local config = require("config")
local setup = require("setup")

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
  {
    "echasnovski/mini.nvim",
    init = setup.mini,
    version = "*", -- Use stable branch.
  },
  -- File Manager
  {
    "nvim-neo-tree/neo-tree.nvim",
    tag = "3.26",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = config.neotree,
    keys = {
      {
        "\\",
        function()
          require("neo-tree.command").execute({
            position = "current",
            reveal_force_cwd = true,
            toggle = true,
          })
        end,
        desc = "Open file browser in the current window",
      },
      {
        "|",
        function()
          require("neo-tree.command").execute({ reveal = true })
        end,
        desc = "Open file browser on the left",
      },
    },
    lazy = true,
  },
  -- Debug UI
  {
    "rcarriga/nvim-dap-ui",
    config = config.dapui,
    dependencies = { "nvim-neotest/nvim-nio" },
    lazy = true,
  },
  -- Render diagnostics with multiple lines using
  -- wrapping and highlighting and don't
  -- have them overflow the text we need to edit.
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    opts = {
      break_line = {
        enabled = true,
      },
      multilines = {
        always_show = true,
        enabled = true,
      },
    },
  },
  -- Diagnostics / LSP / QuickFix UI
  {
    "folke/trouble.nvim",
    config = config.trouble,
    cmd = "Trouble",
    init = function()
      vim.api.nvim_create_autocmd("QuickFixCmdPost", {
        callback = function()
          vim.cmd([[Trouble qflist open]])
        end,
      })
    end,
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
