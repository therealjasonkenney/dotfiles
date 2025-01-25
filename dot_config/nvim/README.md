----------------------------------------------------------------------------
# My Neovim Config
* Optimized for a polyglot programmer setup conflicts between projects.
* I use `mini.deps` because it has the basics of what I need and have
  a better idea of when things get installed and loaded.
* I do not use `lspconfig`, I use the built-in `vim.lsp` client because I do
  not use LSP for most file-types, and when I do, it must be configured, often
  with specific needs. And because as a polyglot programmer I do not want all
  the LSP clients setup all at once (or specifically loading all the other
  plugins specific for those LSP's)
* That also means I ensure installation for mason tools in the `ftplugin` file
  again, it's so my poor laptop does not need to load prettier and node and all
  its things when editing a shell file.
* I rely on `treesitter` with basic completion for most languages.

## Directory Structure
* `lua/config` - Common configuration tables for reuse across files in
                 `after/ftplugin`.
* `lua/setup` - Configuration that must run in a specific order,
                like installing mini, and then the other plugins.
* `after/plugin` - Configuration that can run in any order and is loaded
  after everything else.
* `after/ftplugin` - Language specific configuration, this is where formatting
  debuggers, and language servers are enabled if they are. I only place
  configuration for common languages I use which require those additional
  features.
----------------------------------------------------------------------------
## Settings

* Keep cursor at location when joining lines.
* Always confirm when exiting neovim.
* Enable mouse functionality.
* Intent with 2 spaces instead of tabs.
* Show Relative Line Numbers.
* Show hidden characters such as Tabs.
* Soft wrap a line, allow for breaking at whitespace.
* Thanks to thePrimogen for some of these settings and maps
  https://www.youtube.com/watch?v=w7i4amO_zaE
* Disable diagnostic float (Use trouble instead).
* Do not sort diangostics by severity.
* Use nerd font glyphs for signs if able.
* Underline code with diagnostic messages.
* Do not update diagnostics while editing.

## UI Setup

* **Colorscheme:** `PaperColor-Slim` (Supports light and dark modes)
* **Diagnostics:** Rendered and highlighted inline with vertical space added for large messages.
  Use `trouble` to display window of project diagnostics.
* **Font:** `Hack Nerd Font Mono` (24pt)
* **Signs:** Use nerd-font glyphs, with fallback to `ascii`
* **Tabline:** Render buffer tabs
* **StatusLine:** Render a bar under each window with:
  `[ MODE | diff,git,diagnostics,lsp | filename | filetype | location ]` |

----------------------------------------------------------------------------
## Plugins
Installed using `mini.deps`, they are then later setup in
`after/plugins` or `after/ftplugins`

|                        | Lang   | Description                            |
| ---------------------- |------- | -------------------------------------- |
| `auto-hlsearch`          | All    | Turns off search highlights when       |
|                        |        | edting.                                |
| `dap`                    |Elixir,Ruby,Rust   | Interface for interacting with         |
|                        |        | debuggers.                             |
| `cmp`                    | All    | Auto-completion.                       |
| `elixir-tools`           |Elixir       | Configures and installs elixir LSP.    |
| `img-clip`               |Markdown      | Generate markdown from pasting an img. |
| `mason`                  | All        | Manages and installs formatters,       |
|                        |        | linters, and language servers.         |
| `neotest`                |Ruby       | Test runner.                           |
| `neotree`                | All    | Buffer, File, Git browser.             |
| `papercolor-theme`       | All    | Color scheme for light and dark modes. |
| `render-markdown`        |Markdown      | Renders markdown when in normal mode.  |
| `tiny-inline-diagnostic` | Elixir, Lua, Ruby, Rust          | Diagnostics are inline, wrapped and    |
|                        | JS/TS             | highlighted for readability.           |
| `treesitter`             | All    | Syntax highlighting, folding, and      |
|                        |        | indenting.                             |
| `treesitter-endwise`     |        | Automatically add `end` for blocks.    |
| `teesitter-textobjects`  | All    | Add community provided groupings for   |
|                        |        | auto pairs and travel.                 |
| `trouble`                |Elixir, Lua, Ruby, Rust| Interface for diagnostics, document symbols,   |
|                        | JS/TS      | lsp defs/references, and quickfix.     |
| `which-key`              | All    | Helps with remembering keybindings.    |
----------------------------------------------------------------------------
## Language Settings

| Language    | Indent | Formatter    | LSP                            | Debugger             |
| ----------- | ------ | ------------ | ------------------------------ | -------------------- |
| Elixir      | 2      |`mix format`  | `elixirls`, `nextls`           | `elixir-ls-debugger` |
| HTML        | 2      |`prettierd`   |                                |                      |
| JS/TS       | 2      |`prettierd`   | `typescript-language-server`   |                      |
| JSON        | 2      |`prettierd`   | `vscode-json-language-server`  |                      |
| Lua         | 2      |`stylua`      | `lua-language-server`          |                      |
| Ruby        | 2      |`rubyfmt`     | `ruby_lsp`                     | `rbdbg`              |
| Ruby (ERB)  | 2      |`erb_format`  |                                |                      |
| Rust        | 4      |`rustfmt`     | `rust-analyzer`                | `codelldb`           |
| TOML        | 2      |`taplo`       | `taplo`                        |                      |

## Autocompletion
* Signature Help (When supported)
* Treesitter
* LSP (When supported)
* LuaSnips Snippets
