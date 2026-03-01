#!/usr/bin/env bash
#
# tmux_path -- shorten a path for tmux status bar display
# Abbreviates all parent directories to their first character,
# keeps the last component full. e.g. ~/Sites/myproject -> ~/S/myproject
#

path="${1:-$(pwd)}"

# Replace $HOME with ~
if [[ "$path" == "$HOME"* ]]; then
    path="~${path#$HOME}"
fi

# Split path and shorten all but last component
IFS='/' read -ra dirs <<< "$path"
short_path=""
last_idx=$(( ${#dirs[@]} - 1 ))

for i in "${!dirs[@]}"; do
    if (( i == last_idx )); then
        short_path+="${dirs[$i]}"
    elif [[ -n "${dirs[$i]}" ]]; then
        short_path+="${dirs[$i]:0:1}/"
    else
        short_path+="/"
    fi
done

echo "$short_path"
