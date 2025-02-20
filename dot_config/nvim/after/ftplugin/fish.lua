-- ---------------------------------------------------------------------------
--
-- ---------------------------------------------------------------------------
local util = require("util")

vim.lsp.start({
  name = "fish-lsp",
  cmd = { "fish-lsp", "start" },
  cmd_env = { fish_lsp_show_client_popups = false },
})

vim.keymap.set("n", "<leader>h", function()
  util.add_header("#")
end, { desc = "Add comment header to lua file" })
