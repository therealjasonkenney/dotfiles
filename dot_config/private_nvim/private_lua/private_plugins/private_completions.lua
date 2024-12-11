local function safe_select(fallback)
  local cmp = require("cmp")

  if cmp.visible() and cmp.get_active_entry() then
    cmp.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    })
  else
    fallback()
  end
end

local function config()
  local cmp = require("cmp")

  require("luasnip.loaders.from_vscode").lazy_load()

  cmp.setup({
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      -- Enter only selects a snippet IF it has been selected.
      ["<CR>"] = {
        i = safe_select,
        s = cmp.mapping.confirm({ select = true }),
        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      },
    }),
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
      { name = "luasnip" },
      { name = "friendly_snippets" },
    }, {
      { name = "buffer" },
    }),
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
  })
end

return {
  {
    "hrsh7th/nvim-cmp",
    config = config,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.3.0",
        dependencies = {
          "saadparwaiz1/cmp_luasnip",
          "rafamadriz/friendly-snippets",
        },
      },
    },
  },
}
