#!/usr/bin/env fish
#
#

set -l root "$HOME/.local/share/chezmoi"

mkdir -p $GNUPGHOME
and chmod 700 "$GNUPGHOME"
or return

gpg -k

# Import public keys and trust values
gpg --import-ownertrust "$root/src/gpg.ownertrust.txt"
gpg --import "$root/src/yk.public.asc"

return
