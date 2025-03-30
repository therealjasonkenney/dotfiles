# Only load if its Interactive
status is-interactive; type -q neovide; and begin

  # Use nvim as fullscreen editor.
  set -gx VISUAL nvim
end
