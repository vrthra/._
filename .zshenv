# -----------------------------------------------------------------------------
# .zshenv is sourced in every zsh session, while .zshrc is only used in
# interactive sessions,
# i.e. when you open a shell on your computer.  specifically, .zshrc will
# not be executed in `ssh mymachine ls` but .zshenv will be
#
# on `ssh 'ls'`, -> .zshenv
# on `zsh`, -> .zshenv, .zshrc
# on `tmux new`, -> .zshenv, .zshrc, .zlogin
# on `screen`, -> .zshenv, .zshrc
#
# -----------------------------------------------------------------------------
# setopt all_export causes all variables defined after to be exported.
# -----------------------------------------------------------------------------
setopt all_export

if [ -z "$i_NOINIT" ]
then
# -----------------------------------------------------------------------------
# we need this if we are working on an NFS homedirectory system with multiple OS
# -----------------------------------------------------------------------------
ARCH=`uname -s`_`uname -p`
fi

# -----------------------------------------------------------
# We set our editor to avoid unplesentness.
EDITOR=vim
CVSEDITOR=$EDITOR

# -----------------------------------------------------------------------------
# see bin/compile-terminfo.sh for information on how to create this.
# -----------------------------------------------------------------------------
TERMINFO=~/.terminfo
# -----------------------------------------------------------------------------
# HOME dirs
# -----------------------------------------------------------------------------
i_H=$HOME/.home
i_BIN=$i_H/bin
i_LIB=$i_H/lib
# -----------------------------------------------------------------------------
# PATH, careful - if home is nfs mounted, it would be a long wait.
# -----------------------------------------------------------------------------
i_PATH=$i_BIN:$i_BIN/$ARCH
i_UPATH=/bin:/sbin:/usr/bin:/usr/sbin:/opt/bin:/opt/sbin:/usr/local/bin:/usr/local/sbin:/opt/csw/bin:/usr/sfw/bin:/usr/gnu/bin
PATH=$i_PATH:$i_UPATH:$PATH
# -----------------------------------------------------------------------------
# Just so R does not crib.
# -----------------------------------------------------------------------------
R_HISTFILE=~/.Rhistory

# -----------------------------------------------------------------------------
# latex texmf home
#  kpsewhich -var-value TEXMFHOME 
# -----------------------------------------------------------------------------
HOMETEXMF=~/.texmf
TEXMFHOME=~/.texmf
# -----------------------------------------------------------------------------
# NNTP for tin -r
# -----------------------------------------------------------------------------
NNTPSERVER=free.teranews.com
# -----------------------------------------------------------------------------
# any arch specific
# -----------------------------------------------------------------------------
[ -e ~/.zsh/$ARCH.zshenv ] && . ~/.zsh/$ARCH.zshenv

# -----------------------------------------------------------------------------
if [ -z "$i_NOINIT" ]
then
# -----------------------------------------------------------------------------
# History
# -----------------------------------------------------------------------------
SAVEHIST=1000
HISTSIZE=1000

# -----------------------------------------------------------------------------
# Avoid the nasty unable to write history file on sudo syndrome.
# HISTFILE=~/.zsh/.history.`hostname` if you have nfs homedir
# -----------------------------------------------------------------------------
case $USER in
  *root*) HISTFILE=/tmp/.zsh_history_${USER}_${HOST} ;;
  *) HISTFILE=~/.zsh/.history
esac

fi
# -----------------------------------------------------------------------------
# Any local changes.
# -----------------------------------------------------------------------------
[ -n "$(setopt nullglob; echo ~/.zsh/zshenv.*)" ] && for i in ~/.zsh/zshenv.*; . ${i}
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Special handling for tmux.

[ -n "$TMUX" ] && TERM=screen-256color
# -----------------------------------------------------------------------------
# turnoff all_export so that no further options are exported.
# -----------------------------------------------------------------------------
unsetopt all_export
