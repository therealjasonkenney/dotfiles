-- ---------------------------------------------------------------------------
-- LuaLS configuration.
-- ---------------------------------------------------------------------------
local util = require("util")

---@type vim.lsp.ClientConfig
return {
  cmd = util.mason_cmd("lua-language-server"),
  filetypes = { "lua" },
  root_markers = { ".luarc.json" },
}
