local M = {}

local function close_all()
  require("neo-tree.command").execute({ action = "close" })
end

local function open_fs()
  require("neo-tree.command").execute({ source = "filesystem" })
end

---runs when the NeoTree plugin is loaded.
--- * Automatically closes any neotree windows on quit.
--- * Enables the winbar.
M.config = function()
  require("neo-tree").setup({
    source_selector = {
      winbar = true,
    },
  })

  local augroup = vim.api.nvim_create_augroup("Neotree", { clear = false })

  vim.api.nvim_create_autocmd("QuitPre", {
    callback = close_all,
    desc = "Close neotree on quit.",
    group = augroup,
  })
end

return M
