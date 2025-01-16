local M = {}

---Configures treesitter
--- * Auto Install syntax grammars for languages.
--- * Automatic adding of 'end' for languages such as elixir, lua and ruby.
--- * Syntax Highlighting
--- * Auto Indent
M.config = function()
  local configs = require("nvim-treesitter.configs")

  configs.setup({
    auto_install = true,
    endwise = {
      enable = true,
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
  })
end

return M
