function pbgh
    git log | head -1 | cut -d' ' -f2 | pbcopy
end
