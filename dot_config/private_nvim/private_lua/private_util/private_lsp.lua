local M = {}

---Default lsp capabilties including code completion.
---@return table
M.default_capabilities = function()
  local cmp = require("cmp_nvim_lsp")

  return cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
end

---Sets up format on save using the lsp instead of conform.
M.format_on_save = function()
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  local bufnr = vim.api.nvim_get_current_buf()

  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format()
    end,
  })
end

---Finds the first parent directory containing a file in file_list
---for the current buffer.
---
---Used for LSP configuration
---@param file_list string[]
---@return string | nil
M.get_root_dir = function(file_list)
  local bufnr = vim.api.nvim_get_current_buf()

  return vim.fs.root(bufnr, file_list)
end

return M
