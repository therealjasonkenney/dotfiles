# Sets up GPG Agent for use with SSH and Yubikey.

status is-interactive; and type -q gpgconf; and begin

  set -gx GNUPGHOME {$HOME}/.local/share/gnupg
  set -x GPG_TTY (tty)
  set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

  gpgconf --launch gpg-agent
end
