local function on_attach()
  local keybinds = require("keybinds")

  keybinds.set_show_macro("v", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
end

local function config()
  local elixir = require("elixir")
  local elixirls = require("elixir.elixirls")

  elixir.setup({
    nextls = { enable = true },
    elixirls = {
      enable = true,
      settings = elixirls.settings({
        dialyzerEnabled = false,
        enableTestLenses = false,
      }),
      on_attach = on_attach,
    },
    projectionist = {
      enable = true,
    },
  })
end

return {
  "elixir-tools/elixir-tools.nvim",
  config = config,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  version = "*",
}
