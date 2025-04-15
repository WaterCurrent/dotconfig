bindkey -e
HISTORY_IGNORE="(ls|pwd|exit|top|htop|poweroff|shutdown|reboot|man)"

# autoload #{{{1
autoload -Uz vcs_info; vcs_info
autoload -Uz compinit; compinit
autoload -Uz colors; colors
autoload -Uz promptinit; promptinit
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
#}}}1

# setopt #{{{1
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_no_store
setopt list_packed
setopt prompt_subst
setopt nobeep
setopt auto_menu
setopt auto_pushd
setopt auto_param_keys
setopt share_history
setopt extended_history
setopt append_history
setopt extended_glob
setopt brace_ccl
setopt chase_links
setopt noautoremoveslash
setopt no_flow_control
setopt magic_equal_subst
setopt ignoreeof
setopt transient_rprompt
setopt nonomatch
#}}}1

# zstyle #{{{1
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
zstyle ':completion:*:doas:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ":chpwd:*" recent-dirs-default true
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "[%F{green}%c%u%b%f]"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
#}}}1

# prompt #{{{1
case ${USERNAME} in
	'root')
		PROMPT="%F{red}%n%f@%F{green}%m%f%F{red}%#%f "
		RPROMPT="%{$fg[black]%(?.$bg[green].$bg[red])%}<%?> \$history[\$((\$HISTCMD-1))]%{$reset_color%}"
		RPROMPT='${vcs_info_msg_0_} '$RPROMPT
		SPROMPT="correct: %R %F{green}->%f %r [nyae]? "
		;;
	*)
		PROMPT="%F{green}%n%f@%F{green}%m%f%F{white}%#%f "
		RPROMPT="%{$fg[black]%(?.$bg[green].$bg[red])%}<%?> \$history[\$((\$HISTCMD-1))]%{$reset_color%}"
		RPROMPT='${vcs_info_msg_0_} '$RPROMPT
		SPROMPT="correct: %R %F{green}->%f %r [nyae]? "
		;;
esac
#}}}1

# alias #{{{1
alias sudo="sudo "
alias doas="doas "
alias c="clear"
alias ls="ls $LS_OPTIONS"
alias sl="ls $LS_OPTIONS"
alias la="ls -Al $LS_OPTIONS"
alias al="ls -Al $LS_OPTIONS"
alias ll="ls -l  $LS_OPTIONS"
alias lc="ls -c  $LS_OPTIONS"
alias llc="ls -Alc $LS_OPTIONS"
alias less="less $LESS_OPTIONS"
alias grep="grep $GREP_OPTIONS"
alias diff="diff $DIFF_OPTIONS"
alias dmesg="dmesg $DMESG_OPTIONS"
alias drill="drill -z"
alias ip="ip $IP_OPTIONS"
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
alias tmux='tmux -u2'
alias update-dotfiles='cd ~/.dotconfig&&git pull&&cd'
#}}}1

[ -f ~/.zshrc_`uname` ] && . ~/.zshrc_`uname`

[[ -e ~/.zshrc.local ]] && source ~/.zshrc.local
# Load all user local zshrc snippets
for i in ${ZDOTDIR:-$HOME}/.zshrc.local.d/*(.N); do source $i; done; unset i

# --- Autocompile
[[ ~/.zshrc -nt ~/.zshrc.zwc ]] && zcompile ~/.zshrc

# vim: ts=2 sw=2 sts=2 sr noet foldmethod=marker foldlevel=0 nowrap
