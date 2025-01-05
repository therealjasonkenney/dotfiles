local map = vim.keymap.set
local util = require("util")

local bufnr = vim.api.nvim_get_current_buf()

util.ensure_installed("lua-language-server")
util.ensure_installed("stylua")

-- Add code completion.
local capabilities = require("cmp_nvim_lsp").default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

local cmd =
  vim.fn.expand("$HOME/.local/share/nvim/mason/bin/lua-language-server")

-- Set LSP
vim.lsp.start({
  name = "luals",
  capabilities = capabilities,
  cmd = { cmd },
  filetypes = { "lua" },
  log_level = vim.lsp.protocol.MessageType.Warning,
  root_dir = vim.fs.root(bufnr, { ".luarc.json" }),
  single_file_support = true,
})

-- Set the formatter
require("conform").formatters_by_ft.lua = { "stylua" }

-- Setup Lua specific keybinds.
map(
  "n",
  "<leader>ld",
  vim.diagnostic.open_float,
  { desc = "[l]ua: show [d]iagnostics" }
)
