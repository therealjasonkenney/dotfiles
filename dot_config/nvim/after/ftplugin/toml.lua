local util = require("util")

local bufnr = vim.api.nvim_get_current_buf()

util.ensure_installed("taplo", function()
  local taplo = util.mason_path() .. "/taplo"

  vim.lsp.start({
    name = "taplo",
    cmd = { taplo, "lsp", "stdio" },
    filetypes = { "toml" },
  })

  util.enable_formatting(bufnr, true)
end)
