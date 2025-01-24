-- ----------------------------------------------------------------------------
-- # Tiny Inline Diagnostic
-- Renders diagnostic messages inline with line-breaks
-- and background color to improve readability.
-- This plugin uses neovim's virtual_text to add additional vertical
-- space between lines if needed to display a message.
--
-- ## Settings
-- * Wrap long diagnostic messages.
-- * Display multi-line messages.
-- * Unless its configured with vim.diagnostics, only show
--   the message for the line the cursor is on.
-- ----------------------------------------------------------------------------

require("tiny-inline-diagnostic").setup({
  break_line = {
    enabled = true,
  },
  multilines = {
    always_show = true,
    enabled = true,
  },
})
