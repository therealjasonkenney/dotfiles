-- ---------------------------------------------------------------------------
-- Common configuration for the filetypes that use ruby_lsp.
-- ---------------------------------------------------------------------------

local M = {}

---comment
---@param bufnr number The current buffer.
---@return vim.lsp.ClientConfig
M.config = function(bufnr)
  local util = require("util")

  -- Get executable paths, ruby uses asdf version manager which makes
  -- shims, this is still... dangerous because the shims might get
  -- their wires crossed, but I have yet to think of a better solution
  -- for the moment :(
  local cmd = vim.fn.expand("$HOME/.local/share/asdf/shims/ruby-lsp")

  local root_dir = vim.fs.root(bufnr, { "Gemfile" })

  return {
    name = "ruby_lsp",
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    cmd = { cmd },
    filetypes = { "eruby", "ruby", "rbs" },
    on_init = util.add_cmp_capabilities,
    root_dir = root_dir,
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
end

return M
