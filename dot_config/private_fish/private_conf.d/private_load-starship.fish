# I use starship to setup my prompt.
set -q __fish_config_sourced; and exit

# Only load if its Interactive
status is-interactive; and begin
  starship init fish | source
end
