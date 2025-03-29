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
local ts = require("nvim-treesitter.configs")
local util = require("util")

local bufnr = vim.api.nvim_get_current_buf()

local root_dir = vim.fs.root(bufnr, { "Gemfile" })

-- disable treesitter indent as its broken in ruby
ts.detach_module("indent", bufnr)

-- If rubocop is configured enable formatting.
if root_dir and vim.fn.filereadable(root_dir .. "/.rubocop.yml") then
  util.enable_formatting(bufnr, false)
end

-- for now we use ruby_lsp as I cannot get solargraph to work.
if root_dir then
  local config = vim.lsp.config.ruby_lsp

  vim.lsp.start(config, {
    bufnr = bufnr,
    reuse_client = config.reuse_client,
    _root_markers = config.root_markers,
  })
end
