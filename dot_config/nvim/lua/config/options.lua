-- ----------------------------------------------------------------------------
-- ## Editor Settings
-- * Map J and K to move selected text as a group.
-- * Map <leader>s to start substitution at cursor.
-- * Keep cursor at location when joining lines.
-- * Always confirm when exiting neovim.
-- * Enable mouse functionality.
-- * Intent with 2 spaces instead of tabs.
-- * Show Relative Line Numbers.
-- * Show hidden characters such as Tabs.
-- * Soft wrap a line, allow for breaking at whitespace.
-- ----------------------------------------------------------------------------

-- Defaults, may be overridden in ftplugin files

vim.opt.confirm = true
vim.opt.linebreak = true
vim.opt.list = true -- this is how you show tabs.
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.relativenumber = true

-- Set default indent to 2 spaces.
-- Overridden in ftplugin files and editorconfig.
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- OS specific settings
vim.opt.shell = "/opt/homebrew/bin/fish"

-- Make space for gitsigns, diagnostics, and code actions
vim.opt.signcolumn = "yes:3"
