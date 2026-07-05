-- -----------------------------------------------------------------------------
-- # cmp
-- Provides auto-completion based on lsp and other sources.
-- -----------------------------------------------------------------------------

---Formats the cmp menu to use icons for lsp and sources.
---@module "cmp"
---@param entry cmp.Entry
---@param vim_item vim.CompletedItem
---@return vim.CompletedItem
local function cmp_format(entry, vim_item)
  local get_icon = require("mini.icons").get

  local icon, hl, is_default = get_icon("lsp", vim_item.kind)

  if is_default then
    -- If no icon is present, just highlight it for now.
    vim_item.kind_hl_group = "CmpItemKind" .. vim_item.kind
  else
    vim_item.kind = icon
    vim_item.kind_hl_group = hl
  end

  local default_menu = "[" .. entry.source.name .. "]"

  vim_item.menu = ({
    buffer = "[B ]",
    treesitter = "[TS]",
    nvim_lsp = "[LS]",
    nvim_lsp_signature_help = "[LS]",
    luasnip = "[S ]",
    friendly_snippets = "[S ]",
  })[entry.source.name] or default_menu

  return vim_item
end

---Ensures when selecting a cmp option that we don't just
---use the first selection while typing.
---@param fallback function
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

vim.pack.add({
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help",
  "https://github.com/saadparwaiz1/cmp_luasnip",
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/ray-x/cmp-treesitter",
  "https://github.com/hrsh7th/nvim-cmp",
})

local augroup = vim.api.nvim_create_augroup("user_cmp", { clear = false })

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    local cmp = require("cmp")

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      formatting = {
        format = cmp_format,
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
          i = safe_select,
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
