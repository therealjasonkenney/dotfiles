local function config()
  require("neo-tree").setup({
    default_component_configs = {
      git_status = {
        symbols = {
          added = "[a]",
          deleted = "[d]",
          modified = "[m]",
          renamed = "[r]",
          untracked = "?",
          ignored = "",
          unstaged = "!",
          staged = "+",
          conflict = "c",
        },
      },
      icon = {
        folder_closed = "[ ]",
        folder_open = "[>]",
        folder_empty = "[-]",
        default = "-"
      },
      indent = {
        expander_collapsed = "",
        expander_expanded = "",
      }
    }
  })

  vim.keymap.set(
    "n",
    "<leader>nf",
    ":Neotree filesystem reveal left<CR>"
  )
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  config = config,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim"
  },
  tag = "3.26",
}
