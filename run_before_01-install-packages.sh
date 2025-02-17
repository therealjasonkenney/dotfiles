#!/bin/sh
#
#

ARCH=$(uname -m)
OS=$(uname -s)

case $OS in
  Darwin)
    export HOMEBREW_BUNDLE_FILE_GLOBAL="$HOME/.config/brewfile/Brewfile"

    if [ "$ARCH" = "arm64" ]; then
      BREW="/opt/homebrew/bin/brew"
    else
      BREW="/usr/local/bin/brew"
    fi

    # Install homebrew if it does not exist.
    if [ ! command -v "$BREW" ] ; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    eval "$($BREW shellenv)"

    brew upgrade

    brew bundle install --cleanup --zap --global

  *)
    xargs sudo apt-get -y install < "$HOME/.config/packages.txt"
    ;;
esac
