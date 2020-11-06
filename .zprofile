export LANG=en_US.UTF-8
export HISTSIZE=999999
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=$HISTSIZE
export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
export ZLS_COLORS=$LS_COLORS
export LESS='-g -i -M -R -S -W -z-4 -x4 -# 1'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
export EDITOR=vim

if [ -e ~/.zprofile_`uname` ]; then
    source ~/.zprofile_`uname` 
fi

if [ -e ~/.zprofile.local ]; then
    source ~/.zprofile.local
fi
