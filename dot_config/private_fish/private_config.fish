# Only execute this file once per shell.
set -q __fish_config_sourced; and exit
set -g __fish_config_sourced 1

# Always ensure these three paths are ordered as such,
# this ensures binaries that are installed by homebrew
# or rustup take precedence.

fish_add_path -m '/opt/homebrew/bin'
fish_add_path -m '/Applications/Postgres.app/Contents/Versions/latest/bin'
fish_add_path -m "$CARGO_HOME/bin"
