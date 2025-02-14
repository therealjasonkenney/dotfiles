local M = {}

---Provides icons outside of mini.icons with a ascii fallback
---if glyphs are not supported.
---@return table
M.config = function()
  local util = require("util")

  if util.supports_glyph() then
    return {
      code_action = "💡",
      error = " ",
      info = " ",
      hint = "󰘥 ",
      warning = " ",
    }
  else
    return {
      code_action = "A",
      error = "E",
      info = "I",
      hint = "H",
      warning = "W",
    }
  end
end

return M
