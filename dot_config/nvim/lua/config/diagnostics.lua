-- ----------------------------------------------------------------------------
-- ## Diagnostic Settings
-- * (not atm) Disable diagnostic float (Use trouble instead).
-- * Do not sort by severity.
-- * Use nerd font glyphs for signs if able.
-- * Underline code with diagnostic messages.
-- * Do not update while editing.
-- * Use tiny-inline-diagnostic to render the messages instead.
-- * Virtual Text is disabled, otherwise we would render all
--   diagnostics at once.
-- ----------------------------------------------------------------------------

local icons = require("config.icons").config()

-- Diagnostics setup.
vim.diagnostic.config({
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = true,
    header = "",
    prefix = " ",
  },
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

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float({
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = true,
      prefix = " ",
      scope = "cursor",
    })
  end,
})
