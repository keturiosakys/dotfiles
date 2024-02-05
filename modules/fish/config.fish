fish_config theme choose "Rosé Pine"

set fzf_directory_opts --bind "enter:become(nvim {} &> /dev/tty)"

set --export fzf_history_opts "--nth=4.."
set fzf_preview_dir_cmd eza -1 --color=always
set fzf_preview_file_cmd bat --color=always

function _nvim_fzf
	fd --type f --hidden --follow --exclude .git |
		fzf \
			--preview "$fzf_preview_file_cmd {}" \
			--bind "enter:become($EDITOR {} 2>/dev/null)"
end

function _rg_fzf_nvim
  set RG_PREFIX "rg --column --line-number --no-heading --color=always --smart-case "

  : | fzf --ansi --disabled --query "" \
      --bind "start:reload:$RG_PREFIX {q}" \
      --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
      --delimiter : \
      --preview "bat --color=always {1} --highlight-line {2}" \
      --bind "enter:become($EDITOR {1} +{2})"
end

bind \co _nvim_fzf
bind \e\co _rg_fzf_nvim

