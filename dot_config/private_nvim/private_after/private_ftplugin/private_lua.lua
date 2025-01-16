local util = require("util")

local bufnr = vim.api.nvim_get_current_buf()

util.ensure_installed("stylua", function()

  util.ensure_installed("lua-language-server", function()
    -- load completion plugin
    local cmp = require("cmp_nvim_lsp")

    local capabilities =
      cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

    local cmd = util.mason_path() .. "/lua-language-server"

    -- Set LSP
    vim.lsp.start({
      name = "luals",
      capabilities = capabilities,
      cmd = { cmd },
      filetypes = { "lua" },
      root_dir = vim.fs.root(bufnr, { ".luarc.json" }),
    })
  end)
end)
