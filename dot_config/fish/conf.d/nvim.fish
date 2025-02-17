# Only load if its Interactive
status is-interactive; type -q nvim; and begin

  # Use neovim as the editor.
  set -gx EDITOR nvim
end

status is-interactive; type -q neovide; and begin

  # Use neovide as fullscreen editor.
  set -gx VISUAL neovide
end
