local cmp = require("cmp_nvim_lsp")

local capabilities = cmp.default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

local util = require("util")

util.ensure_installed("taplo")

local taplo = util.mason_path() .. "/taplo"

vim.lsp.start({
  name = "taplo",
  capabilities = capabilities,
  cmd = { taplo, "lsp", "stdio" },
  filetypes = { "toml" },
})
