#!/usr/bin/env bash

fd -tf -H --exclude .git . ~/Code/keturiosakys/dotfiles/ |
	fzf \
		--preview "bat --color=always {}" \
		--bind "enter:become(nvim {} &> /dev/tty)"
