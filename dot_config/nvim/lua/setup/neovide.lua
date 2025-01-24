-- ----------------------------------------------------------------------------
-- Setup for the Neovide GUI Client.
-- ----------------------------------------------------------------------------

local M = {}

M.setup = function()
  vim.o.guifont = "Hack Nerd Font Mono:h24"
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
end
