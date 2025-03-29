-- ---------------------------------------------------------------------------
-- LSP client for C (and other languages)
-- ---------------------------------------------------------------------------

---@type vim.lsp.ClientConfig
return {
  name = "clangd",
  cmd = { "/usr/bin/clangd" },
  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offsetEncoding = { "utf-8", "utf-16" },
  },
  filetypes = { "c" },
  root_markers = { "compile_commands.json" },
}
