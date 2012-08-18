#!/bin/sh

echo -n "Name:"
read name
echo -n "Password:"
read password
echo -n "Email:"
read email

cat <<'EOF' | sed -e "s/%name%/$name/g"\
                  -e "s/%password%/$password/g" \
                  -e "s/%email%/$email/g" \
                  > ~/.pass
git_name=%name%
git_password="%password%"
git_email=%email%
EOF
