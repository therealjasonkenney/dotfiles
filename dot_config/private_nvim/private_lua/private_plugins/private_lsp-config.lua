local function float_prefix(diagnostic, i, total)
  local prefixes = {}

  prefixes[vim.diagnostic.severity.ERROR] = "E"
  prefixes[vim.diagnostic.severity.HINT] = "H"
  prefixes[vim.diagnostic.severity.INFO] = "I"
  prefixes[vim.diagnostic.severity.WARN] = "W"

  local format = "[%1s (%02d/%02d)]: "
  local sign = prefixes[diagnostic.severity]

  return string.format(format, sign, i, total)
end

local function on_attach(ev)
  local builtin = require("telescope.builtin")
  local keybinds = require("keybinds")
  local bufnr = ev.buffer

  local opts = { buffer = bufnr }

  -- Use LSP for these.
  keybinds.set_code_action("n", vim.lsp.buf.code_action, opts)

  keybinds.set_goto_declaration("n", vim.lsp.buf.declaration, opts)
  keybinds.set_prev_diagnostic("n", vim.diagnostic.get_prev, opts)
  keybinds.set_next_diagnostic("n", vim.diagnostic.get_next, opts)
  keybinds.set_rename("n", vim.lsp.buf.rename, opts)
  keybinds.set_show_hover("n", vim.lsp.buf.hover, opts)
  keybinds.set_open_float("n", vim.diagnostic.open_float, opts)

  -- Use telescope for some stuff here.
  keybinds.set_goto_definition("n", builtin.lsp_definitions, opts)
  keybinds.set_goto_type_def("n", builtin.lsp_type_definitions, opts)
  keybinds.set_goto_references("n", builtin.lsp_references, opts)
  keybinds.set_show_diagnostics("n", function()
    builtin.diagnostics({ bufnr = bufnr })
  end, opts)
end

local function lsp_config()
  local lspconfig = require("lspconfig")

  local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

  lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, {
    capabilities = capabilities,
    on_attach = on_attach,
  })

  require("mason-lspconfig").setup_handlers({
    function(server)
      lspconfig[server].setup({})
    end,
    ["biome"] = require("plugins.lsp.biome").on_setup,
    ["lua_ls"] = require("plugins.lsp.lua_ls").on_setup,
  })

  vim.diagnostic.config({
    float = {
      border = "rounded",
      source = true,
      header = "Diagnostics\n--------",
      prefix = float_prefix,
    },
    severity_sort = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    virtual_text = false,
  })
end

return {
  -- Language servers and installation.
  {
    "neovim/nvim-lspconfig",
    config = lsp_config,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "nvim-telescope/telescope.nvim",
      {
        "elixir-tools/elixir-tools.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
      },
      "lbrayner/vim-rzip", -- required for tsserver & yarn to behave.
    },
  },
}
