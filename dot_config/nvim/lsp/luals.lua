-- ---------------------------------------------------------------------------
-- LuaLS configuration.
-- ---------------------------------------------------------------------------

return {
  cmd = function(dispatchers)
    print("Loading luals config.")
    local cmd = require("util").mason_path() .. "/lua-language-server"
    return vim.lsp.rpc.start({ cmd }, dispatchers)
  end,
  filetypes = { "lua" },
  root_markers = { ".luarc.json" },
}
