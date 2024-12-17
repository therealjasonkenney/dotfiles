#!/bin/sh
#
#

OS=$(uname -s)

case $OS in
  Darwin)
    export HOMEBREW_BUNDLE_FILE_GLOBAL="$HOME/.config/brewfile/Brewfile"

    # Install homebrew if it does not exist.
    if [ ! command -v /opt/homebrew/bin/brew ] ; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    eval "$(/opt/homebrew/bin/brew shellenv)"

    brew upgrade

    brew bundle install --cleanup --zap --global

    # Add homebrew to the path if its not there, fish depends on utils
    # installed via homebrew.
    /opt/homebrew/bin/fish -c 'fish_add_path -m /opt/homebrew/bin'

    ;;
  *)
    xargs sudo apt-get -y install < "$HOME/.config/packages.txt"
    ;;
esac

