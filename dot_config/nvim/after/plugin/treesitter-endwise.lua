-- -----------------------------------------------------------------------------
-- nvim-treesitter-endwise
-- This adds automatic additions of 'end' to supported languages like lua, elixir, and ruby.
-- -----------------------------------------------------------------------------
local later = MiniDeps.later

later(function()
  require("nvim-treesitter-endwise")
end)
