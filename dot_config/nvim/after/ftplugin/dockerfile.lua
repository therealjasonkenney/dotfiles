-- ---------------------------------------------------------------------------
-- Configuration for dockerfiles.
-- Use hadolint for linting.
-- ---------------------------------------------------------------------------

vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

local buffer = vim.api.nvim_get_current_buf()

local util = require("util")
local augroup = vim.api.nvim_create_augroup("dockerfiles", { clear = false })

util.ensure_installed("hadolint")

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  buffer = buffer,
  callback = function()
    require("lint").try_lint("hadolint")
  end,
  desc = "Lint dockerfile with hadolint.",
  group = augroup,
})
