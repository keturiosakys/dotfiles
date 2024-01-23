#!/usr/bin/env bash

read -r -p "TLDR: " program

if [[ -z $program ]]; then
	exit 0
fi

tmux neww "tldr $program | bat"
