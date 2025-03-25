#!/bin/sh
#
#

ASDF_DIR="$HOME/.local/share/asdf"
ASDF_DATA_DIR="$ASDF_DIR"

ARCH=$(uname -m)
OS=$(uname -s)

if [ "$OS" = "Darwin" ]; then
  # Homebrew on OSX (Arm) puts everything in /opt/homebrew
  PATH="/opt/homebrew/bin:$PATH"
  eval "$(brew shellenv)"

  # Install ASDF and Ruby Dependencies if they do not exist.
  brew list coreutils || brew install coreutils
  brew list curl || brew install curl
  brew list gmp || brew install gmp
  brew list libyaml || brew install libyaml
fi

# Install ASDF if it does not exist.
if [ ! -d "$ASDF_DIR" ]; then
  echo "Installing ASDF"
  git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR" --branch v0.14.1
fi

# Load ASDF
. "$ASDF_DIR/asdf.sh"

if [ ! -d "$ASDF_DATA_DIR/plugins/ruby" ]; then
  asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
fi
