local icons = require("config").icons()

require("mini.diff").setup({
  signs = {
    add = icons.git_add,
    change = icons.git_change,
    delete = icons.git_del
  },
})

require("mini.git").setup()
