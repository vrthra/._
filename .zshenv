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

# -----------------------------------------------------------------------------
# we need this if we are working on an NFS homedirectory system with multiple OS
# -----------------------------------------------------------------------------
ARCH=`uname -s`_`uname -p`

# -----------------------------------------------------------------------------
# History
# -----------------------------------------------------------------------------
HISTFILE=~/.zsh/.history.`hostname`
SAVEHIST=1000
HISTSIZE=1000
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
i_PATH=$i_BIN:$i_BIN/$ARCH
# -----------------------------------------------------------------------------
# PATH, careful - if home is nfs mounted, it would be a long wait.
# -----------------------------------------------------------------------------
PATH=$H_PATH:$PATH
# -----------------------------------------------------------------------------
# any arch specific
# -----------------------------------------------------------------------------
[ -e ~/.zsh/$ARCH.zshenv ] && . ~/.zsh/$ARCH.zshenv

# -----------------------------------------------------------------------------
# Any local changes. (I like the zsh oneline for)
# -----------------------------------------------------------------------------
[ -n "$(setopt nullglob; echo ~/.zsh/zshenv.*)" ] && for i in ~/.zsh/zshenv.*; . ${i} 

# -----------------------------------------------------------------------------
# turnoff all_export so that no further options are exported.
# -----------------------------------------------------------------------------
unsetopt all_export
