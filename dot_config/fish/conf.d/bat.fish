status is-interactive; and begin

    # Use bat for manpaging
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
end
