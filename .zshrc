bindkey -e
autoload -Uz vcs_info; vcs_info
autoload -Uz compinit; compinit
autoload -Uz colors; colors
autoload -Uz promptinit; promptinit
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs

setopt \
hist_ignore_all_dups \
hist_ignore_space \
hist_reduce_blanks \
hist_save_no_dups \
hist_no_store \
list_packed \
prompt_subst \
nobeep \
auto_menu \
auto_pushd \
auto_param_keys \
share_history \
extended_history \
extended_glob \
brace_ccl \
chase_links \
noautoremoveslash \
no_flow_control \
magic_equal_subst \
ignoreeof \
correct \
transient_rprompt \
nonomatch

# linux or mac
[ -f ~/.zshrc_`uname` ] && . ~/.zshrc_`uname`

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
precmd () { vcs_info }

PROMPT="[%n@%m:%F{yellow}%2~%f%F{yellow}%f]%F{yellow}%#%f "
RPROMPT="%{$fg[black]%(?.$bg[green].$bg[red])%}<%?> \$history[\$((\$HISTCMD-1))]%{$reset_color%}"
RPROMPT='${vcs_info_msg_0_} '$RPROMPT
SPROMPT="correct: %R %F{green}->%f %r [nyae]? "

function ssh() {
  if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
    tmux rename-window ${@: -1}
    command ssh "$@"
    tmux set-window-option automatic-rename "on" 1>/dev/null
  else
    command ssh "$@"
  fi
}

function _ssh {
  compadd `grep -r 'Host ' ~/.ssh/conf.d/**/*.hosts | awk '{print $2}' | sort`;
}

alias sudo="sudo "
alias doas="doas "
alias c="clear"
alias ls="ls $LS_OPTIONS"
alias la="ls -Al $LS_OPTIONS"
alias al="ls -Al $LS_OPTIONS"
alias ll="ls -l  $LS_OPTIONS"
alias lc="ls -c  $LS_OPTIONS"
alias llc="ls -Alc $LS_OPTIONS"
alias less="less $LESS_OPTIONS"
alias grep="grep $GREP_OPTIONS"
alias diff="diff $DIFF_OPTIONS"
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

if [ -e ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

