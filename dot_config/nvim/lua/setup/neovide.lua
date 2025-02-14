-- ----------------------------------------------------------------------------
-- Setup for the Neovide GUI Client.
-- ----------------------------------------------------------------------------

local M = {}

local function paste()
  local reg = "+"

  local lines = vim.builtin.getreg(reg)
  local type = vim.builtin.getregtype(reg)
  local after = false
  local follow = false

  vim.api.nvim_put(lines, type, after, follow)
end

M.setup = function()
  vim.o.guifont = "Hack Nerd Font Mono:h24"
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false

  -- Put in cmd+ keymaps that normally would be forwarded by the
  -- terminal that are not in neovide.
  vim.keymap.set(
    { "i", "t", "c" },
    "<D-v>",
    paste,
    { desc = "Paste from System Clipboard" }
  )
end

return M
