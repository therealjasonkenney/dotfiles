#!/bin/sh
#
#

set -e

OS=$(uname -s)

if [ "$OS" = "Darwin" ] ; then
  export PATH="/opt/homebrew/bin:$PATH"
fi

export GNUPGHOME="$HOME/.local/share/gnupg"

mkdir -p $GNUPGHOME
chmod 700 "$GNUPGHOME"

gpg -k

# Import public keys and trust values
gpg --import-ownertrust "$HOME/.local/share/chezmoi/src/gpg.ownertrust.txt"
gpg --import "$HOME/.local/share/chezmoi/src/yk.public.asc"
