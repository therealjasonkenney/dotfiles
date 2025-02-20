# ###########################################################################
# ~/.config/fish/conf.d/direnv.fish
# Sets up direnv for fish.
# - direnv is a tool that lets you load environment variables for
#   a current directory from .envrc and .env files.
# - See: https://direnv.net/
# ###########################################################################

status is-interactive; type -q direnv; and begin
  direnv hook fish | source
end
