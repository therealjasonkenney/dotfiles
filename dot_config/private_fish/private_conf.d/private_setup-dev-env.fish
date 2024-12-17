# Only load if its Interactive
status is-interactive; and begin
  # Get the proper fullpaths for some of
  # our commands since MacOS and Linux
  # put them in /opt/homebrew/bin and /usr/local/bin
  # respectively.
  set -l bat (type -p bat)
  set -l fd (type -p fd)

  # Set Locale to US English (UTF-8).
  set -gx LANG   'en'
  set -gx LC_ALL 'enUS.UTF-8'

  # Neovim is our editor.
  set -gx EDITOR (type -p nvim)

  # Use bat for manpaging
  set -gx MANPAGER "sh -c 'col -bx | $bat -l man -p'"

  # Use skim for fuzzy finding: it defaults to find . but we
  # can replace that with the fd tool which is more efficient
  # for parallel searches.
  set -gx SKIM_DEFAULT_COMMAND "$fd --type f"

  # Ensure our tools (starship and zellij) follow XDG Guidelines.
  set -gx STARSHIP_CACHE    "$XDG_CACHE_HOME/starship"
  set -gx STARSHIP_CONFIG   "$HOME/.config/starship.toml"
  set -gx ZELLIJ_CONFIG_DIR "$HOME/.config/zellij"

  # Setup our snazzy prompt.
  starship init fish | source
end
