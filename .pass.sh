#!/bin/bash

readx() {
  local v var val
  var=$2
  val=$(eval echo \$$var)
  echo -n "$1($val):"
  read v
  case x$v in
    x) ;;
    *) eval "$var='$v'";;
  esac
}

[ -e ~/.pass ] && . ~/.pass || :

echo > ~/.pass.tmp

readx "Git:Name" git_name
readx "Git:Password" git_password
readx "Git:Email" git_email

cat <<EOF >> ~/.pass.tmp
# git:
  git_name="$git_name"
  git_password="$git_password"
  git_email="$git_email"

EOF

cat ~/.pass.tmp > ~/.pass
