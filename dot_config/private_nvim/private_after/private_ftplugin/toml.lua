local lsp_util = require("util.lsp")
local util = require("util")

util.ensure_installed("taplo")

local taplo = util.mason_path() .. "/taplo"

vim.lsp.start({
  name = "taplo",
  capabilities = lsp_util.default_capabilities(),
  cmd = { taplo, "lsp", "stdio" },
  filetypes = { "toml" },
})

lsp_util.format_on_save()
