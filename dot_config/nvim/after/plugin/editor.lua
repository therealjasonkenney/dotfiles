-- ----------------------------------------------------------------------------
-- Editor Settings and Keymaps
-- * Map J and K to move selected text as a group.
-- * Map <leader>s to start substitution at cursor.
-- * Keep cursor at location when joining lines.
-- * Always confirm when exiting neovim.
-- * Enable mouse functionality.
-- * Intent with 2 spaces instead of tabs.
-- * Show Relative Line Numbers.
-- * Show hidden characters such as Tabs.
-- * Soft wrap a line, allow for breaking at whitespace.
-- Make search highlights go away after you enter insert mode.
-- Thanks to thePrimogen for some of these settings and maps
-- https://www.youtube.com/watch?v=w7i4amO_zaE
-- ----------------------------------------------------------------------------

local map = vim.keymap.set
local opt = vim.opt

-- Defaults, may be overridden in ftplugin files

opt.confirm = true
opt.expandtab = true
opt.linebreak = true
opt.list = true -- this is how you show tabs.
opt.number = true
opt.mouse = "a"
opt.relativenumber = true
opt.shiftround = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2

-- Move selected text as a group
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Keep cursor at location when joining lines.
map("n", "J", "mzJ`z", { desc = "[J]oin lines." })

-- Search and replace word at cursor.
map(
  "n",
  "<leader>s",
  ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
  { desc = "Search and replace word at cursor" }
)
