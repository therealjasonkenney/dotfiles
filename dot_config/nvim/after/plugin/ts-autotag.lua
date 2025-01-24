-- -----------------------------------------------------------------------------
-- nvim-ts-autotag
-- Automatically add </x> whenever <x> is typed. Useful for html and similar
-- languages.
-- -----------------------------------------------------------------------------
local later = MiniDeps.later

later(function()
  require("nvim-ts-autotag").setup({})
end)
