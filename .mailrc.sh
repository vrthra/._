. ~/.pass

#set record=+Sent
cat <<'EOF' | sed -e "s/%name%/$mailx_name/g" -e "s/%email%/$mailx_email/g" -e "s/%pass%/$mailx_password/g" > .mailrc
account onid {
  set imap-use-starttls
  set folder="imap://%onid_email%@imap.onid.oregonstate.edu"
  set password-%onid_email%@imap.onid.oregonstate.edu="%onid_pass%"
  set record="+sent-mail"
  set from="%onid_name% <%onid_email%>"
  set smtp-use-starttls
  set smtp=smtp://mail.oregonstate.edu
  set smtp-auth=login
  set smtp-auth-user=%onid_email%
  set smtp-auth-password="%onid_pass%"

  set ssl-verify=ignore
  shortcut main +INBOX
}
account gmail {
  set folder=imaps://%gmail_email%@imap.gmail.com
  set record=+[Gmail]/Sent\ Mail
  set from="%gmail_name <%gmail_email%>"
  set smtp-use-starttls
  set smtp=smtp://smtp.gmail.com:587
  set smtp-auth=login
  set smtp-auth-user=%gmail_email%
  set smtp-auth-password="%gmail_pass%"

  shortcut main +INBOX
  set ssl-verify=ignore
}
account 8vrtra {
  set folder=imaps://%%@imap.gmail.com
  set password-%%@imap.gmail.com="%%"
  set record=+[Gmail]/Sent\ Mail
  set from="%%"
  set smtp-use-starttls
  set smtp=smtp://smtp.gmail.com:587
  set smtp-auth=login
  set smtp-auth-user=%%
  set smtp-auth-password="%%"

  shortcut main +INBOX
  shortcut git +git
  set ssl-verify=ignore
}

account 9vrtra {
  set folder=imaps://%%@imap.gmail.com
  set password-%%@imap.gmail.com="%%"
  set record=+[Gmail]/Sent\ Mail
  set from="Rahul Gopinath <%%>"
  set smtp-use-starttls
  set smtp=smtp://smtp.gmail.com:587
  set smtp-auth=login
  set smtp-auth-user=%%
  set smtp-auth-password="%%"

  shortcut main +INBOX
  shortcut git +git
  set ssl-verify=ignore
}

set pipe-text/html="w3m -dump -T text/html"

#set askattach
#set askcc
set autocollapse
set autothread
set emptystart

set quiet
set prompt="?| "

#set indentprefix=">"

set imap-keepalive=240
set imap-list-depth=5

# Discard these headers on reply
discard Received
discard Sender
discard Status
discard Message
discard Return-path
discard Delivered-To
discard X-Sieve
discard X-Virus-Scanned
discard User-Agent
discard X-Spam-Flag
discard X-Spam-Score
discard X-Spam-Status
discard Content-Type
discard X-Mailer
discard X-DCC-sonic.net-Metrics
discard X-Greylist
discard X-AntiVirus
discard X-Spam-Level

# use more for lines more than..
set crt=25

# for top command
set toplines=10

# edit headers also in ~v
set editheaders

# also search /xx:yy
set searchheaders

set regex-search
set imap-cache=~/.mailx-cache

set headline="%>%a%m %18f %i%s"
#%>%a%m %18f %16d %4l/%-5o %i%s
set noheader
set showlast
set showto
set skipemptybody
EOF
