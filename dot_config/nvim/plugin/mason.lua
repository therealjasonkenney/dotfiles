-- --------------------------------------------------------------------------------
-- Handles installing, loading and setting up Language Servers, Formatters, Linters,
-- etc that work with neovim.
-- --------------------------------------------------------------------------------

vim.pack.add({
  "https://github.com/williamboman/mason.nvim",
})

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "mason" and kind == "update" then
      if not ev.data.active then
        vim.cmd.packadd("mason")
      end
      vim.cmd("MasonUpdate")
    end
  end,
})

require("mason").setup({})
