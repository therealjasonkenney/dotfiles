local M = {}

M.setup = function()
  -- --------------------------
  -- Bootstrap lazy.nvim
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=v10.24.2",
      lazypath,
    })
  end

  -- Add lazy to the runtime path.
  vim.opt.rtp:prepend(lazypath)
end

return M
