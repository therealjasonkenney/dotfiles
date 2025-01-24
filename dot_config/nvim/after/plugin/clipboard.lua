-- Configures neovim's clipboard and copy+paste behavior.
-- with thanks to thePrimogen https://www.youtube.com/watch?v=w7i4amO_zaE

local map = vim.keymap.set
local os = vim.loop.os_uname().sysname

-- Note '_ is the void register, which lets you perform actions
-- without copying to the clipboard.
map(
  "x",
  "<leader>p",
  "\"_dP",
  { desc = "Replace text, without copying to the clipboard." }
)

map(
  { "n", "v" },
  "<leader>d",
  "\"_d",
  { desc = "Delete without copying to the clipboard" }
)

-- Note the + register is the system clipboard.
map(
  { "n", "v" },
  "<leader>y",
  "\"+y",
  { desc = "Copy to the system clipboard." }
)

map("n", "<leader>Y", "\"+y", { desc = "Copy to the system clipboard." })

-- If we are using MacOS lets make use of the CMD key when using vim
-- in a gui like neovide, which also does not quite work with terminal
-- specific keybindings for CMD.
-- this is mostly for ease of use since I have muscle memoried
-- CMD+c and CMD+v
if vim.g.neovide and os == "Darwin" then
  map("v", "<D-c>", "\"+y", { desc = "Copy to system clipboard" })
  map({ "n", "v" }, "<D-v>", "\"+P", { desc = "Paste from system clipboard" })
  map(
    { "!", "c", "t" },
    "<D-v>",
    "<C-R>+",
    { desc = "Paste from system clipboard" }
  )
  map("i", "<D-v>", "<ESC>l\"+Pli", { desc = "Paste from system clipboard" })

  -- Cut to system clipboard
  map({ "n", "v" }, "<D-x>", "\"+d", { desc = "Cut to system clipboard" })
end
