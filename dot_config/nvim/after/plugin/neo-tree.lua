-- ----------------------------------------------------------------------------
-- # Neo Tree
-- Filesytem, git, and buffer browser.
--
-- ## Events
--
-- |          |                                         |
-- | -------- | --------------------------------------- |
-- | VimEnter | Load NeoTree                            |
-- | QuitPre  | Close any opened NeoTree windows.       |
--
-- ## Keymaps
--
-- |          |                                         |
-- | -------- | --------------------------------------- |
-- | `\`      | Load the filesytem in a float           |
-- | `|`      | Open a window on the left with a winbar |
--
-- ## Settings
-- * Enable a winbar with buffer | git | file tabs.
-- ----------------------------------------------------------------------------

-- Install neo-tree and its dependencies.
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = "3.26" },
})

-- Disable netrw file explorer.
vim.api.nvim_create_augroup("FileExplorer", { clear = true })

vim.schedule(function()
  require("neo-tree").setup({
    source_selector = {
      winbar = true,
    },
  })

  local augroup = vim.api.nvim_create_augroup("neotree", { clear = true })

  vim.api.nvim_create_autocmd("QuitPre", {
    callback = function()
      require("neo-tree.command").execute({ action = "close" })
    end,
    desc = "Close neotree on quit.",
    group = augroup,
  })

  local map = vim.keymap.set

  map("n", "\\", function()
    require("neo-tree.command").execute({
      position = "current",
      reveal_force_cwd = true,
      toggle = true,
    })
  end, { desc = "Open file browser in current window" })

  map("n", "|", function()
    require("neo-tree.command").execute({ reveal = true })
  end, { desc = "Open file browser on the left" })

  print("Neo-tree loaded and configured.")
end)
