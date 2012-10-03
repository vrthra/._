#!/bin/sh

echo -n "Git:Name:"
read git_name
echo -n "Git:Password:"
read git_password
echo -n "Git:Email:"
read git_email

cat <<'EOF' | sed -e "s/%name%/$name/g"\
                  -e "s/%password%/$password/g" \
                  -e "s/%email%/$email/g" \
                  > ~/.pass
git_name=%git_name%
git_password="%git_password%"
git_email=%git_email%
EOF
