#!/usr/bin/env bash

read -r -p "Man: " program

if [[ -z $program ]]; then
	exit 0
fi

tmux neww "man $program | bat"
