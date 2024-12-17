#!/bin/sh
#
#

set -e

GNUPGHOME="$HOME/.local/share/gnupg"
OS=$(uname -s)

if [ "$OS" = "Darwin" ] ; then
  PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
fi

SHELL_PATH=$(command -v fish)

mkdir -p $GNUPGHOME
chmod 700 "$GNUPGHOME"

gpg --homedir "$GNUPGHOME" -k

# Import public keys and trust values
gpg --homedir "$GNUPGHOME" --import-ownertrust "$HOME/.local/share/chezmoi/src/gpg.ownertrust.txt"
gpg --homedir "$GNUPGHOME" --import "$HOME/.local/share/chezmoi/src/yk.public.asc"

# Add fish to /etc/shells if its not there.
if [ -z "$(grep -F -- $SHELL_PATH /etc/shells)" ]; then
  echo "Adding $SHELL_PATH to /etc/shells"
  echo $SHELL_PATH | sudo tee -a /etc/shells > /dev/null
fi

# Change login shell to fish
echo "Setting shell to $SHELL_PATH"
chsh -s $SHELL_PATH

# Configure Fish.
# I use universal variables here because this ensures its loaded before any
# config or tool is run.

# Set GNUPGHOME to the directory we just loaded certs into.
# (which should be XDG compliant).
echo "Setting gpg homedir to $GNUPGHOME"
fish -c "set -Ux GNUPGHOME '$GNUPGHOME'"

# Set XDG_CACHE_HOME to ~/.cache or ~/Library/Caches depending on OS.
case $OS in
  # MacOS knows ~/Library/Caches is a cache directory
  # so we should use that whenever possible.
  Darwin)
    echo "Setting XDG Cache home to $HOME/Library/Caches"
    fish -c "set -Ux XDG_CACHE_HOME '$HOME/Library/Caches'"
    ;;
  *)
    echo "Setting XDG Cache home to $HOME/.cache"
    fish -c "set -Ux XDG_CACHE_HOME '$HOME/.cache'"
    ;;
esac

# Update bat theme cache.
bat cache --build
