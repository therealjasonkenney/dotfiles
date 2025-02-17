# Only load if its Interactive
status is-interactive; and type -q starship; and begin

  # Use starship for prompt, its files should be loaded per XDG guidelines.
  set -gx STARSHIP_CACHE  {$XDG_CACHE_HOME}/starship
  set -gx STARSHIP_CONFIG {$HOME}/.config/starship.toml

  starship init fish | source
end
