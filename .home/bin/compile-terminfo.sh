#!/bin/sh
case $1 in
  -h) cat <<EOF
`basename $0` -e
  Used to create a term info file in the home directory if it is not found"
EOF
    exit 0
    ;;
  -e) wget http://www.catb.org/~esr/terminfo/termtypes.ti.gz -O - | gzip -dc > termtypes.ti;
      tic -o ~/.terminfo termtypes.ti
      rm termtypes.ti
    ;;
esac
