-- --------------------------
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=v10.24.2",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- --------------------------

-- Must set leader before loading lazy
vim.g.mapleader = " "

local opt = vim.opt

-- Use two spaces instead of tabs.
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.shiftround = true -- Round indent

opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.linebreak = true -- Wrap lines at convenient points
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.relativenumber = true -- Relative line numbers
opt.shell = "/bin/sh"

-- Neovide specific settings
if vim.g.neovide then
  require("config.neovide").setup()
end

-- Configure diagnostics
require("config.diagnostics").setup()

-- load all plugins/*.lua files
require("lazy").setup("plugins")
