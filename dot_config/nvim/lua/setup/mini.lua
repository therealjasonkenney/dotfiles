local M = {}

---mini.nvim requires each module get loaded on its own
---so we need to do that here as well as configure them
---as needed.
---Should be run via init for lazy.
M.setup = function()
  local path_package = vim.fn.stdpath("data") .. "/site/"
  local mini_path = path_package .. "pack/deps/start/mini.nvim"

  if not vim.loop.fs_stat(mini_path) then
    local clone_cmd = {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/echasnovski/mini.nvim",
      mini_path,
    }

    vim.fn.system(clone_cmd)
    vim.cmd.packadd({ "mini.nvim" })
    vim.cmd.helptags({ "ALL" })

    print("Installed mini.nvim")
  end

  require("mini.deps").setup({
    path = { package = path_package },
  })
end

return M
