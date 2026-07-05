---@type vim.lsp.ClientConfig
return {
  name = "taplo",
  cmd = function(diagnostics)
    local util = require("util")
    util.ensure_installed("taplo")

    local cmd = util.mason_path() .. "/taplo"
    return vim.lsp.rpc.start({ cmd, "lsp", "stdio" }, diagnostics)
  end,
  filetypes = { "toml" },
}
