bindkey -e
# autoload {{{
autoload -Uz vcs_info; vcs_info
autoload -Uz compinit; compinit
autoload -Uz colors; colors
autoload -Uz promptinit; promptinit
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
# }}}

# setopt #{{{
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
setopt extended_glob
setopt brace_ccl
setopt chase_links
setopt noautoremoveslash
setopt no_flow_control
setopt magic_equal_subst
setopt ignoreeof
setopt transient_rprompt
setopt nonomatch
# }}}

# linux or mac
[ -f ~/.zshrc_`uname` ] && . ~/.zshrc_`uname`

# zstyle {{{
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
# }}}

# precmd () {{{
precmd () {
	vcs_info
}
#}}}

# zshaddhistory() {{{
zshaddhistory() {
    local line=${1%%$'\n'}
    local cmd=${line%% *}

    # 以下の条件をすべて満たすものだけをヒストリに追加する
    [[ ${#line} -ge 5
        && ${cmd} != (l|l[sal])
        && ${cmd} != (c|cd)
        && ${cmd} != (m|man)
        && ${cmd} != (reboot|shutdown|poweroff)
        && ${cmd} != (top|htop)
    ]]
}
#}}}

function ssh() { #{{{
  if [[ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" =~ "tmux" ]]; then
    local pane_id=$(tmux display-message -p '#{pane_id}')
    local reset_cmd="tmux select-pane -t $pane_id -P 'fg=default,bg=default'; tmux set-window-option -t $pane_id.window_index automatic-rename on 1>/dev/null"

    trap "$reset_cmd" EXIT

    if [[ "$(grep -r 'Host ' ~/.ssh/conf.d/**/*.prod.hosts | awk '{print $2}' | grep $1 | head -n 1)" = "$1" ]]; then
      tmux select-pane -t $pane_id -P 'fg=colour255 bg=colour052'
    fi

    if [[ "$(grep -r 'Host ' ~/.ssh/conf.d/**/*.stg.hosts | awk '{print $2}' | grep $1 | head -n 1)" = "$1" ]]; then
      tmux select-pane -t $pane_id -P 'fg=colour255 bg=colour017'
    fi

    tmux rename-window "${@: -1}"
    command ssh "$@"
    clear
  else
    command ssh "$@"
  fi
} #}}}

function _ssh { # {{{
  local files=(~/.ssh/conf.d/**/*.hosts)
  if [[ ${#files[@]} -gt 0 ]]; then
    compadd `grep -r 'Host ' ~/.ssh/conf.d/**/*.hosts |grep -v 'Match' |grep -v ':#Host' | awk '{print $2}' | sort | uniq`;
    compadd `grep -r 'Match host ' ~/.ssh/conf.d/**/*.hosts | grep -v ':#Host' | awk '{print $3}' | sort | uniq`;
  fi
} #}}}

function cd() { # {{{
  builtin cd "$@"

  if [[ -z "$VIRTUAL_ENV" && ! -e ~/.python-version ]] ; then
    ## If env folder is found then activate the vitualenv
    if [[ -d ./.venv ]] ; then
      source ./.venv/bin/activate
    fi
  else
    ## check the current folder belong to earlier VIRTUAL_ENV folder
    # if yes then do nothing
    # else deactivate
    parentdir="$(dirname "$VIRTUAL_ENV")"
    if [[ "$PWD"/ != "$parentdir"/* && ! -e ~/.python-version ]] ; then
      deactivate
    fi
  fi
} # }}}

# prompt {{{
case ${USERNAME} in
	'root')
		#PROMPT="%F{red}%n%f@%F{green}%m%f:%F{cyan}%2~%f%F{red}%#%f "
		PROMPT="%F{red}%n%f@%F{green}%m%f%F{red}%#%f "
		RPROMPT="%{$fg[black]%(?.$bg[green].$bg[red])%}<%?> \$history[\$((\$HISTCMD-1))]%{$reset_color%}"
		RPROMPT='${vcs_info_msg_0_} '$RPROMPT
		SPROMPT="correct: %R %F{green}->%f %r [nyae]? "
		;;
	*)
		#PROMPT="%F{green}%n%f@%F{green}%m%f:%F{cyan}%2~%f%F{white}%#%f "
		PROMPT="%F{green}%n%f@%F{green}%m%f%F{white}%#%f "
		RPROMPT="%{$fg[black]%(?.$bg[green].$bg[red])%}<%?> \$history[\$((\$HISTCMD-1))]%{$reset_color%}"
		RPROMPT='${vcs_info_msg_0_} '$RPROMPT
		SPROMPT="correct: %R %F{green}->%f %r [nyae]? "
		;;
esac
# }}}

# alias {{{
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
# }}}

if [ -e ~/.fzf.zsh ]; then # {{{
  source ~/.fzf.zsh
fi # }}}

if [ -e ~/.zshrc.local ]; then # {{{
  source ~/.zshrc.local
fi # }}}

if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then # {{{
  zcompile ~/.zshrc
fi # }}}

# vim: ts=2 sw=2 sts=2 sr noet foldmethod=marker foldlevel=0 nowrap
