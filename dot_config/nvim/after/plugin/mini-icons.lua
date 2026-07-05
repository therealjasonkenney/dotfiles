-- ----------------------------------------------------------------------------
-- Mini Icons
-- Common Icons for use in neovim with a text fallback when a nerdfont is not
-- available.
--
-- * Use mini.icons for LSP icons.
-- * Mock web_devicons (used by Neotree)
-- * Add a command to allow copying an icon to the clipboard.
-- ----------------------------------------------------------------------------

local micons = require("mini.icons")
local util = require("util")

if util.supports_glyph() then
  micons.config.style = "glyph"
else
  micons.config.style = "ascii"
end

micons.mock_nvim_web_devicons()

micons.tweak_lsp_kind()

vim.api.nvim_create_user_command("CopyIcon", function(args)
  -- This requires two arguments
  if not args or #args.fargs < 2 then
    return
  end

  -- strip outer quotes
  local category = string.gsub(args.fargs[1], "\"(.+)\"", "%1")
  local name = string.gsub(args.fargs[2], "\"(.+)\"", "%1")

  local icon = micons.get(category, name)

  -- If the third argument is present, use that as the register
  local clipboard = args.fargs[3] or ""

  -- Copy to clipboard.
  vim.fn.setreg(clipboard, icon)
end, {
  desc = "Copies an icon from mini, CopyIcon <category> <name> <clipboard>",
})

vim.api.nvim_create_user_command("UseAscii", function()
  require("util").use_ascii()
end, { desc = "Sets all icons to use ascii." })

vim.api.nvim_create_user_command("UseGlyph", function()
  require("util").use_glyph()
end, { desc = "Sets all icons to use nerd font glyphs." })
