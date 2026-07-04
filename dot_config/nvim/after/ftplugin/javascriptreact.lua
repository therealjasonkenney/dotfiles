local util = require("util")

local bufnr = vim.api.nvim_get_current_buf()

local root_dir = vim.fs.root(bufnr, { "eslint.config.mjs" })

-- clear out the spacing augroup.
vim.api.nvim_create_augroup("default_spacing", { clear = true })

vim.bo.shiftwidth = 2

util.ensure_installed("prettierd", function()
  util.enable_formatting(bufnr, false)
end)

if root_dir then
  util.ensure_installed("eslint-lsp", function()
    local config = vim.lsp.config.eslint

    vim.lsp.start(config, {
      bufnr = bufnr,
      reuse_client = config.reuse_client,
      _root_markers = config.root_markers,
    })
  end)
end
