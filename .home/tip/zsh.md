### Zsh

- access the words in the same line: !#:<n>
e.g

    curl http://betterthangrep.com/ack-standalone > ~.home/bin/ack && chmod 0755 !#:3
    curl http://betterthangrep.com/ack-standalone > ~.home/bin/ack && chmod 0755 !:3
    mv myfile !:1

- Get the entire command lien rather than word

    curl http://betterthangrep.com/ack-standalone > ~.home/bin/ack && chmod 0755 !:-0
    curl http://betterthangrep.com/ack-standalone > ~.home/bin/ack && chmod 0755 !:-3

#### History

To avoid history in a sessino

    | fc -p
    .. commands
    | fc -P
