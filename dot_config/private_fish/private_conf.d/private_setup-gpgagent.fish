# Sets up GPG Agent for use with SSH and Yubikey.
set -q __fish_config_sourced; and exit

status is-interactive; and begin
  set -x GPG_TTY (tty)
  set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
  gpgconf --launch gpg-agent
end
