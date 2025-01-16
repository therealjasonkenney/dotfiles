local config = require("config")
local setup = require("setup")

-- Setup and load lazy
setup.lazy()

-- Must set leader before loading lazy
vim.g.mapleader = " "

local opt = vim.opt

-- These are defaults, not sure if they are
-- needed if an LSP is loaded o.0
-- Use two spaces instead of tabs.
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.shiftround = true -- Round indent

setup.ui()

-- OS specific settings
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.shell = "/bin/sh"

-- Neovide specific settings
if vim.g.neovide then
  setup.neovide()
end

-- Configure diagnostics
vim.diagnostic.config(config.diagnostics())

-- Configure lsp
setup.lsp()

-- load all plugins/*.lua files
require("lazy").setup("plugins")
