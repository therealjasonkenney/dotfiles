-- Utilities for my neovim config.

local M = {}

---Enables formatting
--- * Sets format command to gq
--- * Adds autocmd to format on save
---@param bufnr number Current buffer
---@param lsp_fallback boolean Use lsp formatting as a fallback.
M.enable_formatting = function(bufnr, lsp_fallback)
  local augroup = vim.api.nvim_create_augroup("formatting", { clear = false })
  local autoformat_opts = { async = false, buf = bufnr, timeout_ms = 500 }
  local format_opts = { async = true }

  if lsp_fallback then
    autoformat_opts.lsp_format = "fallback"
    format_opts.lsp_format = "fallback"
  end

  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function()
      require("conform").format(autoformat_opts)
    end,
    desc = "Format on Save",
    group = augroup,
  })

  vim.keymap.set({ "n", "v" }, "gq", function()
    require("conform").format(format_opts)
  end, { buffer = bufnr, desc = "Format" })

  vim.bo.formatexpr = "v:lua.require'conform'.formatexpr()"
end

return M
