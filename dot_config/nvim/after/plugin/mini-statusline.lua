-- ----------------------------------------------------------------------------
-- # Mini Status Line
-- Renders a line below each buffer displaying status information.
--
-- ## Setup
-- * requires mini.diff
-- * requires mini.git
-- * requires mini.icons
-- * Loaded after colorscheme is set.
--
-- ## Settings
-- * Uses the default settings which have it dislay:
--   - MODE
--   - Diff info, Git info, Diagnostics and LSP info
--   - filename
--   - filetype
--   - location of cursor.
-- * Uses icons from mini.icons
-- * Uses diff information from mini.diff
-- * Uses git information from mini.git
-- * Sets neovims' built-in statusline.
--
-- ----------------------------------------------------------------------------
local icons = require("config").icons()
local sl = require("mini.statusline")

local function active_content()
  -- these are just the defaults.
  local mode, mode_hl = sl.section_mode({ trunc_width = 120 })
  local git = sl.section_git({ trunc_width = 40 })
  local diff = sl.section_diff({ trunc_width = 75 })
  local lsp = sl.section_lsp({ trunc_width = 75 })
  local filename = sl.section_filename({ trunc_width = 140 })
  local fileinfo = sl.section_fileinfo({ trunc_width = 120 })
  local location = sl.section_location({ trunc_width = 75 })
  local search = sl.section_searchcount({ trunc_width = 75 })
  -- this syncs the signs of diagnostics with what I set elsewhere.
  local diagnostics = sl.section_diagnostics({
    signs = {
      ERROR = icons.error,
      INFO = icons.info,
      HINT = icons.hint,
      WARN = icons.warn,
    },
    trunc_width = 75,
  })

  return sl.combine_groups({
    { hl = mode_hl, strings = { mode } },
    {
      hl = "MiniStatuslineDevinfo",
      strings = { git, diff, diagnostics, lsp },
    },
    "%<", -- Mark general truncate point
    { hl = "MiniStatuslineFilename", strings = { filename } },
    "%=", -- End left alignment
    { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
    { hl = mode_hl, strings = { search, location } },
  })
end

sl.setup({
  content = {
    active = active_content,
  },
})
