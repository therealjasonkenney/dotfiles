-- Lualine status bar
-- See: https://github.com/nvim-lualine/lualine.nvim/blob/master/README.md
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    return {
      extensions = {},
      options = {
        -- Ensure Left and right sections never overlap the meridian.
        always_divide_middle = true,

        component_seperators = { left = "•", right = "•" },

        -- Disable lualine for these filetypes
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },

        icons_enabled = false,

        -- For these filetypes - treat as inactive.
        ignore_focus = {},

        -- A single status line instead of one for every window.
        global_status = false,

        -- Refresh interval in ms
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },

        section_seperators = { left = "|", right = "|" },

        theme = "ayu",
      },
      -- Lualine's sections are laid out thus
      -- |A|B|C         X|Y|Z|
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
    }
  end,
}
