#!/bin/sh
#
#

ARCH=$(uname -m)
OS=$(uname -s)

case $OS in
  Darwin)
    export HOMEBREW_BUNDLE_FILE_GLOBAL="$HOME/.config/brewfile/Brewfile"

    if [ "$ARCH" = "arm64" ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    else
      eval "$(/usr/local/bin/brew shellenv)"
    fi

    brew bundle install --cleanup --zap --global

    brew upgrade
    ;;
  *)
    xargs sudo apt-get -y install < "$HOME/.config/packages.txt"
    ;;
esac
