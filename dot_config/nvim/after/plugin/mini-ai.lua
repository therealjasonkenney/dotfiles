-- -----------------------------------------------------------------------------
-- mini.ai adds more capture groups to vim's vi / va functionality
-- (like selecting inside or outside parenthesis)
-- This setup uses treesitter-textobjects to add common capture groups per
-- language and nvim-treesitter to query the syntax-tree of the language and
-- determine groupings.
-- -----------------------------------------------------------------------------

local ai = require("mini.ai")
local spec = ai.gen_spec.treesitter

ai.setup({
  custom_textobjects = {
    ["="] = spec({
      a = "@assignment.outer",
      i = "@assignment.inner",
      l = "@assignment.lhs",
      r = "@assignment.rhs",
    }),
    a = spec({ a = "@parameter.outer", i = "@parameter.inner" }),
    c = spec({ a = "@class.outer", i = "@class.inner" }),
    f = spec({ a = "@call.outer", i = "@call.inner" }),
    i = spec({ a = "@conditional.outer", i = "@conditional.inner" }),
    l = spec({ a = "@loop.outer", i = "@loop.inner" }),
    m = spec({ a = "@function.outer", i = "@function.inner" }),
  },
})
