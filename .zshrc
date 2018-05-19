bindkey -e
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz compinit
compinit
autoload colors
colors
autoload -Uz promptinit
promptinit

setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_no_store
setopt list_packed
setopt prompt_subst
setopt nobeep
setopt auto_menu
setopt no_flow_control
#setopt auto_cd
setopt auto_pushd
setopt share_history
setopt extended_history
setopt auto_param_keys
setopt brace_ccl
setopt chase_links
setopt noautoremoveslash
setopt magic_equal_subst

zstyle ':completion:*:default' list-colors ${LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' list-colors 'di=36' 'ln=35'
zstyle ':completion:*:default' list-colors ${LS_COLORS}
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "[%F{green}%c%u%b%f]"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

PROMPT="%F{yellow}%#%f "
RPROMPT="%n@%m:%F{yellow}%2~%f"
SPROMPT="correct: %R -> %r ? "

GREP_OPTIONS="--color=auto --binary-files=without-match"
LS_OPTIONS="--color=auto"

ssh() {
  if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
    tmux rename-window ${@: -1}
    command ssh "$@"
    tmux set-window-option automatic-rename "on" 1>/dev/null
  else
    command ssh "$@"
  fi
}

alias sudo="sudo "
alias doas="doas "
alias ls="ls $LS_OPTIONS"
alias la="ls -Al $LS_OPTIONS"
alias al="ls -Al $LS_OPTIONS"
alias ll="ls -l  $LS_OPTIONS"
alias lc="ls -c  $LS_OPTIONS"
alias llc="ls -Alc $LS_OPTIONS"
alias less="less -R"
alias grep="grep $GREP_OPTIONS"
alias diff="diff --color=auto"
alias emerge="emerge --quiet"
alias eqf='equery f'
alias equ='equery u'
alias eqh='equery h'
alias eqa='equery a'
alias eqb='equery b'
alias eql='equery l'
alias eqd='equery d'
alias eqg='equery g'
alias eqc='equery c'
alias eqk='equery k'
alias eqm='equery m'
alias eqy='equery y'
alias eqs='equery s'
alias eqw='equery w'
