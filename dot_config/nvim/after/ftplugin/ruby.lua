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
local util = require("util")

local bufnr = vim.api.nvim_get_current_buf()

-- Get executable paths, ruby uses asdf version manager which makes
-- shims, this is still... dangerous because the shims might get
-- their wires crossed, but I have yet to think of a better solution
-- for the moment :(
local bundle = vim.fn.expand("$HOME/.local/share/asdf/shims/bundle")

local root_dir = vim.fs.root(bufnr, { "Gemfile" })

-- If rubocop is configured enable formatting.
if root_dir and vim.fn.filereadable(root_dir .. "/.rubocop.yml") then
  util.enable_formatting(bufnr, false)
end

-- Setup debugger
util.enable_dap(bufnr)

local dap = require("dap")

dap.adapters.ruby = function(callback)
  callback({
    type = "server",
    host = "127.0.0.1",
    port = "${port}",
    executable = {
      command = bundle,
      args = {
        "exec",
        "rdbg",
        "-A",
      },
    },
  })
end

dap.configurations.ruby = {
  {
    type = "ruby",
    name = "attach to running process",
    request = "attach",
    localfs = true,
  },
}

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

-- Use ruby_lsp as solargraph is hard to get working right.
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

  local config = vim.lsp.config.ruby_lsp

  vim.lsp.start(config, {
    bufnr = bufnr,
    reuse_client = config.reuse_client,
    _root_markers = config.root_markers,
  })
end
