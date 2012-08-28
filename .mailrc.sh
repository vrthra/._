. ~/.pass

cat <<'EOF' | sed -e "s/%name%/$name_9/g" -e "s/%email%/$email_9/g" -e "s/%pass%/$password_9/g" > .mailrc
account 9mail {
  set folder=imaps://%email%@imap.gmail.com
  set password-%email%@imap.gmail.com="%pass%"
  set record=+Sent
  set from="%name% %email%"
  set smtp-use-starttls
  set smtp=smtp://smtp.gmail.com:587
  set smtp-auth=login
  set smtp-auth-user=%email%
  set smtp-auth-password="%pass%"
}
EOF
