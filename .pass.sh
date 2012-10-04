#!/bin/bash

readx() {
  local v var val
  var=$2
  val=$(eval echo \$$var)
  echo -n "  $1($val):"
  read v
  case x$v in
    x) ;;
    *) val=$v
  esac
  echo " $var='$val'" >> ~/.pass.tmp
}

[ -e ~/.pass ] && . ~/.pass || :

echo > ~/.pass.tmp

echo "# git:" | tee -a ~/.pass.tmp
readx "Name" git_name
readx "Password" git_password
readx "Email" git_email
echo

cat ~/.pass.tmp > ~/.pass
~/.gitconfig.sh
