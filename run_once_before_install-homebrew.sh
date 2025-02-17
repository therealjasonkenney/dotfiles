#!/bin/sh
#
#

ARCH=$(uname -m)
OS=$(uname -s)

if [ "$ARCH" = "arm64" ]; then
  BREW="/opt/homebrew/bin/brew"
else
  BREW="/usr/local/bin/brew"
fi

# Install homebrew if it does not exist.
if [ ! -x "$BREW" ] ; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
