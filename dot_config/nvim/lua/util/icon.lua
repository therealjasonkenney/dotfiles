-- ----------------------------------------------------------------------------
-- Icon utilities
-- * The main usecase for these is enable switching between glyphs which
--   work when not in ssh and using ascii mode which changes things to
--   ascii text which is compatible with most terminals and ssh.
-- ----------------------------------------------------------------------------

local M = {}

M.supports_glyph = function()
  local env = vim.env
  local lang = env.LC_ALL
  local term = env.TERM

  if vim.g.neovide then
    return true
  elseif lang == "enUS.UTF-8" and term == "xterm-256color" then
    return true
  else
    return false
  end
end

return M
