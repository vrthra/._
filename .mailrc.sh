. ~/.pass

#set record=+Sent
cat <<'EOF' | sed -e "s/%name%/$mailx_name/g" -e "s/%email%/$mailx_email/g" -e "s/%pass%/$mailx_password/g" > .mailrc
account gmail {
  set folder=imaps://%email%@imap.gmail.com
  set password-%email%@imap.gmail.com="%pass%"
  set record=+[Gmail]/Sent\ Mail
  set from="%name% %email%"
  set smtp-use-starttls
  set smtp=smtp://smtp.gmail.com:587
  set smtp-auth=login
  set smtp-auth-user=%email%
  set smtp-auth-password="%pass%"

  shortcut main +INBOX
  shortcut git +git
  set ssl-verify=ignore
}

set pipe-text/html="lynx -dump -force_html /dev/stdin"

set askattach
set askcc
set autocollapse
set autothread
set emptystart

set imap-keepalive=240
set imap-list-depth=5
EOF
