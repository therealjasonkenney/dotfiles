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

local augroup = vim.api.nvim_create_augroup("user.formatting", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  callback = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        eruby = { "erb_format" },
        html = { "prettierd" },
        lua = { "stylua" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        ruby = { "rubocop", "rubyfmt", stop_after_first = true },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
      },
      formatters = {
        rubocop = {
          args = {
            "--server",
            "--auto-correct-all",
            "--stderr",
            "--force-exclusion",
            "--stdin",
            "$FILENAME",
          },
        },
      },
    })
  end,
  desc = "Load the conform formatter",
  group = augroup,
})
