function tmux_path
    set -l path (test -n "$argv[1]"; and echo "$argv[1]"; or echo (pwd))

    if string match -q "$HOME*" "$path"
        set path (string replace "$HOME" "~" "$path")
    end

    set -l dirs (string split / $path)
    set -l short_path ""

    for i in (seq 1 (math (count $dirs) - 1))
        set short_path "$short_path"(string sub -l 1 $dirs[$i])"/"
    end

    set short_path "$short_path$dirs[-1]"

    echo $short_path
end
