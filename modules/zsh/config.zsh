zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*' file-sort modification
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' fzf-min-height 50
zstyle ':fzf-tab:*' fzf-bindings 'tab:accept'
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-y:accept'
zstyle ':fzf-tab:*' fzf-preview 'if [[ ! -d $realpath ]]; then bat --color=always $realpath; else eza -1 --icons --color=always $realpath; fi'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':completion:*:descriptions' format '[%d]'
# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps -p $word -o command -w | tail -n +2'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
# zstyle ':fzf-tab:complete:launchctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 launchctl status $word'

# Pure Prompt
zstyle :prompt:pure:git:stash show yes
export PURE_PROMPT_SYMBOL=';'

function _nvim_fzf() {
  fd --type f --hidden --follow --exclude .git |
    fzf \
    --preview 'bat --color=always {}' \
    --bind 'enter:become(nvim {})' \
}

zle -N _nvim_fzf

function kubens() {
  kubectl config set-context --current --namespace=$(kubectl get namespace --no-headers | fzf | awk '{ print $1}')
}

function tailf() {
	tail -f $1 | fzf +s
}

function jqf() {
	: | fzf \
		--print-query \
		--layout=reverse \
		--preview "cat ${1} | jq {q}"
}

#function pr() {
#	gh pr list --json='number,title,author' | jq -r '.[] | "#\(.number) - \(.title) | \(.author.name)" '
#
#}

#bindkey "\el" clear-screen
bindkey "^o" _nvim_fzf
bindkey '^gH' _complete_help
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

autoload -z edit-command-line
autoload zmv
zle -N edit-command-line
bindkey "\ee" edit-command-line

source ~/.config/zsh/fzf-git.sh
source ~/.config/zsh/macos.sh

unsetopt BEEP
unsetopt CORRECT
unsetopt CORRECT_ALL
