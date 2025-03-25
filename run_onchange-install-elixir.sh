#!/bin/sh
#
#

# ###########################################################################
# Installs elixir and dependencies if it is enabled
# in ~/.config/chezmoi/chezmoi.toml
# ###########################################################################

ASDF_DIR="$HOME/.local/share/asdf"
ASDF_DATA_DIR="$ASDF_DIR"

ARCH=$(uname -m)
OS=$(uname -s)

if [ "$OS" = "Darwin" ]; then
  # Homebrew on OSX (Arm) puts everything in /opt/homebrew
  PATH="/opt/homebrew/bin:$PATH"
  eval "$(brew shellenv)"

  # Install ASDF and Elixir Dependencies if they do not exist.
  echo "[Elixir Install]: Checking dependencies"
  brew list coreutils || brew install coreutils
  brew list curl || brew install curl
  brew list erlang || brew install erlang@27
fi

# Install ASDF if it does not exist.
if [ ! -d "$ASDF_DIR" ]; then
  echo "[Elixir Install]: Installing ASDF"
  git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR" \
    --branch v0.14.1
fi

# Load ASDF
. "$ASDF_DIR/asdf.sh"

if [ ! -d "$ASDF_DATA_DIR/plugins/elixir" ]; then
  echo "[Elixir Install]: Installing plugin."
  asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git
fi
