-- ----------------------------------------------------------------------------
-- # Which Key
-- Helps with remembering neovim keybinds by showing a float as you type
-- a keybind.
--
-- ## Keybinds
--
-- |            |                |
-- | ---------- | -------------- |
-- | `<space>?` | Show keybinds. |
-- ----------------------------------------------------------------------------

vim.pack.add({ "https://github.com/folke/which-key.nvim" })

local map = vim.keymap.set

map("n", "<leader>?", function()
  require("which-key").show({ global = true })
end, { desc = "Show keybinds" })
