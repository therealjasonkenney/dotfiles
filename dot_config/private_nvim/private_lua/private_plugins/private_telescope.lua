local function config()
  local builtin = require("telescope.builtin")
  local keybinds = require("keybinds")

  keybinds.set_file_list("n", builtin.find_files, {})
  keybinds.set_file_search("n", builtin.live_grep, {})

  require("telescope").setup({
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({}),
      },
    },
    pickers = {
      diagnostics = {
        wrap_results = true,
      },
    },
  })

  require("telescope").load_extension("ui-select")
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = config,
    branch = "master",
  },
}
