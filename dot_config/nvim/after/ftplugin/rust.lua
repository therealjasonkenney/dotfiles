local util = require("util")

vim.bo.shiftwidth = 4

local bufnr = vim.api.nvim_get_current_buf()

local vscode_dir = vim.fs.root(0, { ".vscode" })

if vscode_dir and vim.fn.filereadable(vscode_dir .. "/.vscode/launch.json") then
  util.ensure_installed("codelldb", function()
    local dap = require("dap")

    -- codelldb default configuration.
    dap.adapters.codelldb = {
      type = "executable",
      command = util.mason_path() .. "/codelldb",
    }

    util.enable_dap(bufnr)
  end)
end

if vim.fs.root(0, { "Cargo.toml" }) then
  local cmp = require("cmp")

  cmp.setup.buffer({ enabled = true })

  util.enable_formatting(bufnr, true)
end
