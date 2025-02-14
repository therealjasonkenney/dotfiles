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
  local capabilities =
    vim.tbl_deep_extend("error", vim.lsp.protocol.make_client_capabilities(), {
      textDocument = {
        completion = {
          editsNearCursor = true,
        },
      },
      offsetEncoding = { "utf-8", "utf-16" },
    })

  vim.lsp.start({
    name = "clangd",
    cmd = { "/usr/bin/clangd" },
    capabilities = capabilities,
    filetypes = { "c" },
    on_init = util.add_cmp_capabilities,
    root_dir = root_dir,
  })

  util.enable_formatting(bufnr, true)
end
