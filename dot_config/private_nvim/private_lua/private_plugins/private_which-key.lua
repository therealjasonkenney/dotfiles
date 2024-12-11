local function config()
  local keybinds = require("keybinds")
  local wk = require("which-key")

  wk.setup()

  keybinds.set_show_keys("n", function()
    wk.show({ global = false })
  end, {})
end

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = config,
}
