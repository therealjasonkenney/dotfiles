-- Treesitter helps with syntax highlighting
-- and folding.

local function config()
  local configs = require("nvim-treesitter.configs")

  configs.setup({
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
  })

  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"
  vim.o.foldenable = false
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = config,
  },
  { "windwp/nvim-ts-autotag", lazy = false },
  {
    "RRethy/nvim-treesitter-endwise",
    lazy = false,
  },
}
