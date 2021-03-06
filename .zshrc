# -----------------------------------------------------------------------------
# Fancy colors
# red 31 green 32 yellow 33 blue 34 magenta 35 cyan 36 white 37 black 30
# '%K{black}%F{red}|%k%f'
# `echotc Co` gets you the supported colors in a terminal.
# -----------------------------------------------------------------------------

set ${i_fcolor:=blue}
set ${i_CDSTACK:=0}
set ${i_LABEL:=:}


if [ -z "$i_NOINIT" ]
then

# -----------------------------------------------------------------------------
# Ensure that we have ssh setup
# we have done ssh-agent at xmonad startup.
# -----------------------------------------------------------------------------

ssh-add 2> /dev/null

# -----------------------------------------------------------------------------
fi

PROMPT='$($i_LABEL)%(!.%F{red}.%F{$i_fcolor})|%k%f '

# -----------------------------------------------------------------------------
# We dont need to reinitialize some things.
# start GUARD {
# -----------------------------------------------------------------------------
#------------------------------------------------------------------------------
# colourize stderr (from gentoo-wiki.com)
# -----------------------------------------------------------------------------
# exec 2>>(while read line; do
#   print '\e[91m'${(q)line}'\e[0m' > /dev/tty; print -n $'\0'; done &)
# -----------------------------------------------------------------------------
# title
# -----------------------------------------------------------------------------
case $TERM in
  xterm*) precmd () {print -Pn "\e]0;%m [$(${i_TITLE})] : %~\a"} ;;
  screen*) precmd () {print -Pn "\e]0;%m [$(${i_TITLE})] : %~\a"} ;;
esac

if [ -z "$i_NOINIT" ]
then

stty intr '^C'
unalias -m '*'
stty erase 

# any arch specific
# -----------------------------------------------------------------------------
[ -e ~/.zsh/$ARCH.zshrc ] && . ~/.zsh/$ARCH.zshrc
# -----------------------------------------------------------------------------
# end GUARD }
fi
# -----------------------------------------------------------------------------
# Any local changes. (Should not be environment changes. They should go to
# .zsh/zsenv.*)
# -----------------------------------------------------------------------------
[ -n "$(setopt nullglob; echo ~/.zsh/zshrc.*)" ] && for i in ~/.zsh/zshrc.*; . ${i}
# -----------------------------------------------------------------------------
# do not use find . -name \*.me
#alias find='noglob /usr/bin/find'
# -----------------------------------------------------------------------------

source ~/.zsh/options

# dont do compinit if we are root.
case $UID in
    0) ;;
    *) source ~/.zsh/options.complete ;;
esac
source ~/.zsh/fn
#source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
