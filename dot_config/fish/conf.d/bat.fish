# Only load if its Interactive
status is-interactive; type -q bat; and begin

  # Use bat for manpaging
  set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
end
