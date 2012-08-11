# -----------------------------------------------------------
# .zshenv is sourced in every zsh session, while .zshrc is only used in
# interactive sessions,
# i.e. when you open a shell on your computer.  specifically, .zshrc will
# not be executed in `ssh mymachine ls` but .zshenv will be
# -----------------------------------------------------------

# setopt all_export causes all variables defined after to be exported.
setopt all_export

# we need this if we are working on an NFS homedirectory system with multiple OS
# ARCH=`uname -s`_`uname -p`

# -----------------------------------------------------------
# History
# -----------------------------------------------------------
HISTFILE=~/.zsh/.history.`hostname`
SAVEHIST=1000
HISTSIZE=1000
# -----------------------------------------------------------
# We set our editor to avoid unplesentness.
EDITOR=vim
CVSEDITOR=$EDITOR

# -----------------------------------------------------------
# see bin/compile-terminfo.sh for information on how to create this.
# -----------------------------------------------------------
TERMINFO=~/.terminfo
# -----------------------------------------------------------
# turnoff all_export so that no further options are exported.
unsetopt all_export
