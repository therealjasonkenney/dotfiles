-- ---------------------------------------------------------------------------
-- Interfaces with AI Services.
-- ---------------------------------------------------------------------------

local augroup = vim.api.nvim_create_augroup("user_ai", { clear = false })

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    local strategies = {
      chat = nil,
      inline = nil,
      cmd = nil,
    }

    -- Check if we have the api key.
    if os.getenv("COPILOT_API_KEY") then
      strategies.chat = { adapter = "copilot" }
      strategies.inline = { adapter = "copilot" }
      strategies.cmd = { adapter = "copilot" }
    end

    require("codecompanion").setup({
      adapters = {
        opts = {
          language = "English",
          show_defaults = false,
        },
      },
      strategies = strategies,
    })
  end,
})
