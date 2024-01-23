#!/usr/bin/env bash
selected=$(cat /Users/laurynas-fp/.config/tmux/scripts/tmux-cht-langs /Users/laurynas-fp/.config/tmux/scripts/tmux-cht-utils | fzf)

if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

if grep -qs "$selected" ~/.config/tmux/scripts/tmux-cht-langs; then
    query=$(echo "$query" | tr ' ' '+')
    # tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query | bat --paging=always & while [ : ]; do sleep 1; done" 
    tmux neww bash -c "curl -s cht.sh/$selected/$query | bat --paging=always"
else
    tmux neww bash -c "curl -s cht.sh/$selected~$query | bat --paging=always"
fi
