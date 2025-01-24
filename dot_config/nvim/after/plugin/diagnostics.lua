-- ----------------------------------------------------------------------------
-- # Diagnostics Setup
--
-- ## Settings
-- * Disable diagnostic float (Use trouble instead).
-- * Do not sort by severity.
-- * Use nerd font glyphs for signs if able.
-- * Underline code with diagnostic messages.
-- * Do not update while editing.
-- * Use tiny-inline-diagnostic to render the messages instead.
-- * Virtual Text is disabled, otherwise we would render all
--   diagnostics at once.
-- ----------------------------------------------------------------------------
local icons = require("config").icons()

vim.diagnostic.config({
  float = false,
  severity_sort = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.error,
      [vim.diagnostic.severity.WARN] = icons.warning,
      [vim.diagnostic.severity.INFO] = icons.info,
      [vim.diagnostic.severity.HINT] = icons.hint,
    },
  },
  underline = true,
  update_in_insert = false,
  virtual_text = false,
})
