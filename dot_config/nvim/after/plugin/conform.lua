-- -----------------------------------------------------------------------------
-- # Conform plugin.
-- Provides a common interface for formatters with an LSP fallback.
--
-- ## Non LSP Formatters
-- | Formatter  | Languages |
-- | ---------- | --------- |
-- | erb_format |󰈔 ERB      |
-- | prettierd  |󰌞 󰘦 󰛦      |
-- | rubyfmt    |󰴭          |
-- | stylua     |󰢱          |
--
-- -----------------------------------------------------------------------------

local later = MiniDeps.later

later(function()
  local conform = require("conform")

  conform.setup({
    formatters_by_ft = {
      eruby = { "erb_format" },
      html = { "prettierd" },
      lua = { "stylua" },
      javascript = { "prettierd" },
      javascriptreact = { "prettierd" },
      json = { "prettierd" },
      ruby = { "rubyfmt" },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },
    },
  })
end)

-- Disable default formatting keymaps (they will be added
-- back if supported.)
later(function()
  local unmap = vim.keymap.del

  -- unmap("n", "gw")
  -- unmap("n", "gq")
end)
