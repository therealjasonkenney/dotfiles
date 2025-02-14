local augroup = vim.api.nvim_create_augroup("trouble", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
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
  end,
  desc = "Configure trouble",
  group = augroup,
})

vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    vim.cmd.Trouble({ "close" })
  end,
  group = augroup,
  desc = "On quit close all trouble windows",
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  callback = function()
    vim.cmd.Trouble({ "qflist", "open" })
  end,
  group = augroup,
  desc = "Open trouble when messages are posted to the quick-fix list",
})
