-- ----------------------------------------------------------------------------
-- ## Keymaps
-- |            |                                              |
-- | ---------- | -------------------------------------------- |
-- | `J`        | Move selection down                          |
-- | `K`        | Move selection up                            |
-- | `<space>s` | Search and replace word at cursor.           |
-- | `<space>y` | Copy text to system clipboard.               |
-- | `<space>Y` | Copy lines to system clipboard.              |
-- | `<space>p` | Append or swap from the system clipboard. |
-- | `<space>P` | Insert or replace from the system clipboard. |

-- Thanks to thePrimogen for some of these settings and maps
-- https://www.youtube.com/watch?v=w7i4amO_zaE
-- ----------------------------------------------------------------------------

local map = vim.keymap.set

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

-- Note the + register is the system clipboard.
map(
  { "n", "v", "o" },
  "<leader>y",
  "\"+y",
  { desc = "Copy to the system clipboard." }
)

map(
  { "n", "o" },
  "<leader>Y",
  "\"+Y",
  { desc = "Copy to the system clipboard." }
)

map(
  { "n", "o" },
  "<leader>p",
  "\"+p",
  { desc = "Append from the system clipboard" }
)

map(
  { "n", "o" },
  "<leader>P",
  "\"+P",
  { desc = "Insert from the system clipboard" }
)

map("v", "<leader>p", "\"+p", { desc = "Swap text with the system clipboard" })

map("v", "<leader>P", "\"+P", { desc = "Replace from the system clipboard" })

-- Add file header
map("n", "<leader>h", function()
  local bufnr = vim.api.nvim.get_current_buf()
  local strict = true
  local token = vim.bo.commentstring
  local hdr = string.rep(string.sub(token, 1, 1), 75)
  local line_idx = 0
  local window = vim.api.nvim.get_current_win()

  local lines = {
    token .. " " .. hdr,
    token .. " ",
    token .. " " .. hdr,
  }

  vim.api.nvim_buf_set_lines(bufnr, line_idx, line_idx, strict, lines)
  vim.ap.nvim_win_set_cursor(window, { 1, 2 })
end, { desc = "Add comment header to file" }
)
