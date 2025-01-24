-- -----------------------------------------------------------------------------
-- # cmp
-- Provides auto-completion based on lsp and other sources.
-- -----------------------------------------------------------------------------

local augroup = vim.api.nvim_create_augroup("user_cmp", { clear = false })

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    local cmp = require("cmp")
    local util = require("util.cmp")

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      formatting = {
        format = util.cmp_format,
      },
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = {
          i = util.safe_select,
          s = cmp.mapping.confirm({ select = true }),
          c = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
        },
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp_signature_help", max_item_count = 5 },
        { name = "nvim_lsp", max_item_count = 5 },
        { name = "luasnip", max_item_count = 5 },
        { name = "treesitter", max_item_count = 5 },
      }, {
        { name = "buffer", max_item_count = 2 },
      }),
    })
  end,
  group = augroup,
})
