#!/bin/sh
echo -n "Enter email: "
read email
echo -n "Enter pass: "
read pass
cat <<EOF
[user]
	email = $email
	name = rahul
	password = $pass
[credential]
	helper = cache --timeout=360000

[pretty]
  graph = %Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset

[alias]
  lg = log --pretty=graph
  graph = log --graph --date-order -C -M --pretty=format:\"<%h> %ad [%an] %Cgreen%d%Creset %s\" --all --date=short
  this = !git branch | sed -ne '/^ *\\*/p' | cut -f 2 -d' '
  amend = commit --amend

[color]
  diff = auto

[log]
	decorate = full
EOF

