#!/bin/sh
# pass contains the machine specific values.
. ~/.pass

cat <<'EOF' | sed -e "s/%name%/$git_name/g" -e "s/%email%/$git_email/g" -e "s/%pass%/$git_password/g" > .gitconfig
[user]
	name = %name%
	password = %pass%
	email = %email%
[credential]
	helper = cache --timeout=360000

[pretty]
  graph = %Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset

[alias]
  lg = log --pretty=graph
  graph = log --graph --date-order -C -M --pretty=format:\"<%h> %ad [%an] %Cgreen%d%Creset %s\" --all --date=short
  this = !git branch | sed -ne '/^ *\\*/p' | cut -f 2 -d' '
  amend = commit --amend
  xo = "!f() { git log ..o/$1; }; f"
  ox = "!f() { git log o/$1..; }; f"
  xi = !git log ..i/`git mybranch`
  ix = !git log i/`git mybranch`..
  st = !git status -sb | sed -e '/??/d'
  check = diff --check

[color]
  diff = auto

[log]
	decorate = full
EOF

