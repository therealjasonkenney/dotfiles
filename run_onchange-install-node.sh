#!/bin/sh
#
#

# ###########################################################################
# Installs nodejs and dependencies if it is enabled
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

  # Install ASDF and Node Dependencies if they do not exist.
  echo "[Nodejs Install]: Checking dependencies"
  brew list coreutils || brew install coreutils
fi

# Install ASDF if it does not exist.
if [ ! -d "$ASDF_DIR" ]; then
  echo "[Nodejs Install]: Installing ASDF"
  git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR" \
    --branch v0.14.1
fi

# Load ASDF
. "$ASDF_DIR/asdf.sh"

if [ ! -d "$ASDF_DATA_DIR/plugins/nodejs" ]; then
  echo "[Nodejs Install]: Installing ASDF plugin."
  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
fi
