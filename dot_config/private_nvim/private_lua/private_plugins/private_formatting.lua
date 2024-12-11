local function config()
  local keybinds = require("keybinds")

  require("conform").setup({
    default_format_opts = {
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      lua = { "stylua" },
      markdown = { "mdformat" },
      python = { "ruff" },
      ruby = { "rubyfmt" },
      rust = { "rustfmt" },
    },
    format_on_save = {
      timeout_ms = 500,
    },
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
  })

  require("mason-conform").setup()

  keybinds.set_format("", function()
    require("conform").format({ async = true })
  end, {})
end

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = config,
  dependencies = {
    "williamboman/mason.nvim",
    "zapling/mason-conform.nvim",
  },
}
