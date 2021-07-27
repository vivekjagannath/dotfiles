fpath+=${ZDOTDIR:-~}/.zsh_functions

# Enable colors and change prompt:
autoload -U colors && colors
PROMPT="%F{blue}%~%f%B%F{yellow} %f%b  "
#          

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

function ranger-cd {
    local IFS=$'\t\n'
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    local ranger_cmd=(
        command
        ranger
        --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
    )

    ${ranger_cmd[@]} "$@"
    if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
        cd -- "$(cat "$tempfile")" || return
    fi
    command rm -f -- "$tempfile" 2>/dev/null
    command clear
}

#Aliases
alias f='ranger-cd'
alias v='vim'
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Basic auto/tab complete:
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

#Right prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{yellow} (%b)%r%f'
zstyle ':vcs_info:*' enable gitautoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{yellow} (%b)%r%f'
zstyle ':vcs_info:*' enable git

# vi mode
bindkey -v

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || 
	[[ $1 = 'block' ]]; then
      echo -ne '\e[2 q'
  elif [[ ${KEYMAP} == main ]] || 
	  [[ ${KEYMAP} == viins ]] || 
	  [[ ${KEYMAP} = '' ]] || 
	  [[ $1 = 'beam' ]]; then
  	echo -ne '\e[6 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
	zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
	echo -ne "\e[6 q"
}
zle -N zle-line-init
echo -ne '\e[6 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[6 q' ;} # Use beam shape cursor for each new prompt.

# zsh-syntax-highlighting; should be last.
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
