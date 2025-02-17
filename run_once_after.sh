#!/bin/sh
#
#

set -e

GNUPGHOME="$HOME/.local/share/gnupg"

ARCH=$(uname -m)
OS=$(uname -s)

# Darwin does not always have /usr/local/bin in its directory
if [ "$OS" = "Darwin" ]; then
  PATH="/usr/local/bin:$PATH"
fi

# Essential homebrew tools are in /opt/homebrew/bin on ARM.
if [ "$OS" = "Darwin" ] && [ "$ARCH" = "arm64" ]; then
  PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
fi

mkdir -p $GNUPGHOME
chmod 700 "$GNUPGHOME"

gpg --homedir "$GNUPGHOME" -k

# Import public keys and trust values
gpg --homedir "$GNUPGHOME" --import-ownertrust "$HOME/.local/share/chezmoi/src/gpg.ownertrust.txt"
gpg --homedir "$GNUPGHOME" --import "$HOME/.local/share/chezmoi/src/yk.public.asc"

# Update bat theme cache.
bat cache --build
