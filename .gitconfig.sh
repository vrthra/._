#!/bin/sh
echo -n "Enter name: "
read name
echo -n "Enter email: "
read email
echo -n "Enter pass: "
read pass
cat <<'EOF' | sed -e "s/%name%/$name/g" -e "s/%email%/$email/g" -e "s/%pass%/$pass/g" > .gitconfig
[user]
	email = %email%
	name = %name%
	password = %pass%
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

[color]
  diff = auto

[log]
	decorate = full
EOF

