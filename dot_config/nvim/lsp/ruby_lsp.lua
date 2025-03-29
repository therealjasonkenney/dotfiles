-- ---------------------------------------------------------------------------
-- Shopify Ruby LSP Client
-- ---------------------------------------------------------------------------

-- Get executable paths, ruby uses asdf version manager which makes
-- shims, this is still... dangerous because the shims might get
-- their wires crossed, but I have yet to think of a better solution
-- for the moment :(
local cmd = vim.fn.expand("$HOME/.local/share/asdf/shims/ruby-lsp")

---@type vim.lsp.Config
return {
  name = "ruby_lsp",
  cmd = { cmd },
  filetypes = { "ruby", "rbs" },
  root_markers = { "Gemfile" },
  settings = {
    rubyLsp = {
      enabledFeatures = {
        codeActions = true,
        completion = true,
        diagnostics = true,
        documentHighlights = false,
        documentLink = false,
        documentSymbols = true,
        hover = true,
        inlayHint = true,
        foldingRanges = false,
        formatting = false,
        onTypeFormatting = false,
        selectionRanges = false,
        semanticHighlighting = false,
      },
    },
  },
}
