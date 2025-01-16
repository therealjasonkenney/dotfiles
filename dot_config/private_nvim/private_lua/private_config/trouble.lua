local M = {}

---close all trouble windows on quit.
local function close_all_windows()
  vim.cmd.Trouble({ "close" })
end

M.config = function()
  require("trouble").setup({
    modes = {
      diagnostics_buffer = {
        mode = "diagnostics",
        filter = { buf = 0 },
        auto_open = false,
        open_no_results = true,
        pinned = true,
        warn_no_results = false,
      },
    },
  })

  local augroup = vim.api.nvim_create_augroup("Trouble", { clear = false })

  vim.api.nvim_create_autocmd("QuitPre", {
    callback = close_all_windows,
    group = augroup,
    desc = "On quit close all trouble windows.",
  })
end

return M
