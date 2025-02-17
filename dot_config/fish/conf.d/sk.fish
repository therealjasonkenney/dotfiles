# Only load if its Interactive
status is-interactive; and type -q fd; and type -q sk; and begin

  # Use fd instead of find when using sk
  set -gx SKIM_DEFAULT_COMMAND "fd --type f"
end
