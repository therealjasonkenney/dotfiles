-- ----------------------------------------------------------------------------
-- # 󰴭 Ruby Configuration
--
-- ## Plugins
-- These plugins are installed here because I only use
-- the debugger in a handful of languages.
-- * nvim-dap (Debugger interface)
-- * nvim-dap-ruby (Ruby specific DAP configuration)
-- * neotest (Test runner interface)
-- * neotest-rspec (Rspec neotest adapter)

-- ## Settings
-- |              |                       |                     |
-- | ------------ | --------------------- | ------------------- |
-- | Debugger     | `rdbg`                | Project local       |
-- | Indent width | 2                     | Tabs are spaces     |
-- | Formatter    | `rubyfmt`             | Installed via mason |
-- | LSP          | `ruby-lsp`            | Installed via asdf  |
-- | Root         | `Gemfile`             |                     |
--
-- ## Autocompletion
-- * Signature Help
-- * Treesitter
-- * LSP
-- * LuaSnips Snippets (with rails snippets)
--
-- ----------------------------------------------------------------------------
local add = MiniDeps.add
local util = require("util")

local bufnr = vim.api.nvim_get_current_buf()

util.ensure_installed("rubyfmt", function()
  util.enable_formatting(bufnr, false)
end)

-- Get executable paths, ruby uses asdf version manager which makes
-- shims, this is still... dangerous because the shims might get
-- their wires crossed, but I have yet to think of a better solution
-- for the moment :(
local cmd = vim.fn.expand("$HOME/.local/share/asdf/shims/ruby-lsp")

local root_dir = vim.fs.root(bufnr, { "Gemfile" })

-- Setup debugger
require("dap-ruby").setup()
util.enable_dap(bufnr)

if root_dir then
  -- Setup neotest
  require("neotest").setup({
    adapters = {
      require("neotest-rspec"),
    },
  })
end

-- Fix indent when typing '.'
for idx, v in ipairs(vim.opt.indentkeys) do
  if v == "." then
    table.remove(vim.opt.indentkeys, idx)
  end
end

-- If we have a solargraph config, we should assume solargraph has been installed
-- and we will then start an LSP. I might add support to start rubocop or ruby_lsp
-- if I ever use them.
if root_dir then
  local augroup = vim.api.nvim_create_augroup("ruby", { clear = false })

  -- Add rails specific snippets.
  vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
      require("luasnip").filetype_extend("ruby", { "rails" })
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
    group = augroup,
  })

  vim.lsp.start({
    name = "ruby_lsp",
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    cmd = { cmd },
    filetypes = { "eruby", "ruby" },
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
    root_dir = root_dir,
  })
end
