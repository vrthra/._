# -----------------------------------------------------------------------------
# Fancy colors
# red 31 green 32 yellow 33 blue 34 magenta 35 cyan 36 white 37 black 30
# '%K{black}%F{red}|%k%f'
# `echotc Co` gets you the supported colors in a terminal.
# -----------------------------------------------------------------------------

[ -z "$i_CDSTACK" ] || i_CDSTACK=0
[ -z "$i_fcolor" ] || i_fcolor=blue

i_prompt() {
  case "$UID-$i_CDSTACK" in
    0-*) PS1="# "
    *-0) PS1="%K{black}%F{i_fcolor}|%k%f "
    *-*) PS1="$i_CDSTACK%K{black}%F{i_fcolor}|%k%f "
  esac
}

# -----------------------------------------------------------------------------
# We dont need to reinitialize some things.
# start GUARD {
# -----------------------------------------------------------------------------
if [ -z "$i_NOINIT" ]
then

# -----------------------------------------------------------------------------
# title
# -----------------------------------------------------------------------------
title() {
    print $i_TITLE;
}

case $TERM in
  xterm*) precmd () {print -Pn "\e]0;%m [$(title)] : %~\a"} ;;
esac

# -----------------------------------------------------------------------------
# Special handling for tmux. We dont need it in zshenv. So it is here.

[ -n "$TMUX" ] && export TERM=screen-256color
# -----------------------------------------------------------------------------

stty intr '^C'
unalias -m '*'
stty erase 

# -----------------------------------------------------------------------------
# Avoid the nasty unable to write history file on sudo syndrome.
# -----------------------------------------------------------------------------
case $USER in
  *root*) HISTFILE=/tmp/.zsh_history_${USER}_${HOST} ;;
esac

# any arch specific
# -----------------------------------------------------------------------------
[ -e ~/.zsh/$ARCH.zshrc ] && . ~/.zsh/$ARCH.zshrc

# -----------------------------------------------------------------------------
# Any local changes. (I like the zsh oneline for)
# -----------------------------------------------------------------------------
for i in ~/.zsh/zshrc.*; . ${i}

source ~/.zsh/opt
source ~/.zsh/fn

# -----------------------------------------------------------------------------
# end GUARD }
fi
# -----------------------------------------------------------------------------

