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

-- Disable netrw file explorer.
vim.api.nvim_create_augroup("FileExplorer", { clear = true })

vim.schedule(function()
  print("Neo-Tree loading")

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
