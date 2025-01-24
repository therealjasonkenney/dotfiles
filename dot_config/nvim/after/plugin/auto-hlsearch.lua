-- -----------------------------------------------------------------------------
-- Auto HLSearch
-- Remove highlighting from searches when entering insert mode.
--
-- ## Setup
-- * Loaded on `VimEnter` which is after all files are sourced, windows and
--   buffers are setup.
--
-- -----------------------------------------------------------------------------
local augroup = vim.api.nvim_create_augroup("auto_hlsearch", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("auto-hlsearch").setup({})
  end,
  desc = "Configure auto-hlsearch",
  group = augroup,
})
