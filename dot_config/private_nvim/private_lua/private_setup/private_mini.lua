local M = {}

---mini.nvim requires each module get loaded on its own
---so we need to do that here as well as configure them
---as needed.
---Should be run via init for lazy.
M.setup = function()
  -- Common dependency: the icons used in mini.
  require("mini.icons").setup()

  -- Status Line Dependencies
  require("mini.diff").setup() -- diff file information (not sure if I need this all the time)
  require("mini.git").setup() -- git status.

  require("mini.statusline").setup()

  -- Tabline (Shows buffers in a nice tab :) )
  require("mini.tabline").setup()
end

return M
