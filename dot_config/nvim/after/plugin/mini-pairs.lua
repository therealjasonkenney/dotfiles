-- -----------------------------------------------------------------------------
-- mini-pairs
-- Automatically add ) ', ", ], } when typing (, ', ", ], }
-- -----------------------------------------------------------------------------
local later = MiniDeps.later

later(function()
  require("mini.pairs").setup()
end)
