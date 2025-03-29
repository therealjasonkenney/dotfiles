-- ----------------------------------------------------------------------------
-- Configuration for C
-- ----------------------------------------------------------------------------

local util = require("util")

local bufnr = vim.api.nvim_get_current_buf()

local root_dir = vim.fs.root(bufnr, { "compile_commands.json" })

if root_dir and vim.fn.filereadable(root_dir .. "/.vscode/launch.json") then
  util.ensure_installed("codelldb", function()
    local dap = require("dap")

    dap.adapters.codelldb = {
      type = "executable",
      command = util.mason_path() .. "/codelldb",
    }

    util.enable_dap(bufnr)
  end)
end

if root_dir then
  local config = vim.lsp.config.clangd

  vim.lsp.start(config, {
    bufnr = bufnr,
    reuse_client = config.reuse_client,
    _root_markers = config.root_markers,
  })

  util.enable_formatting(bufnr, true)
end
