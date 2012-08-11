# colors
getcolor() {
case "$1" in
  red) print "31m";;
  green) print "32m";;
  yellow) print "33m";;
  blue) print "34m";;
  magenta) print "35m";;
  cyan) print "36m";;
  white) print "37m";;
  black) print "30m";;
esac
}
[ -z "$z_PS1_COLOR" ] || z_PS1_COLOR="34m"
# export PS1='%K{white}%F{red}<red on white>%f%k<default colours>'
# echotc Co
mycolor() {
    case $UID in
        0) print "31m" ;;
        *) print ${z_PS1_COLOR} ;;
    esac
}
myprompt() {
    case $UID in
        0) print "# " ;;
        *) print "| " ;;
    esac
}

[ -z "$z_CDNUM" ] || z_CDNUM=0

cdnum() {
    case $z_CDNUM in
        0) print '' ;;
        *) print $z_CDNUM ;;
    esac
}

PS1="%{[0;$(mycolor)%}$(cdnum)$(myprompt)%{[0m%}"

title() {
    print $TFUNC;
}

# for title
case $TERM in
    xterm*) precmd () {print -Pn "\e]0;%m [$(title)] : %~\a"} ;;
esac

[ -n "$TMUX" ] && export TERM=screen-256color
[ -z "$NOINIT" ] || source ~/.zsh/custom
source ~/.zsh/opt
source ~/.zsh/fn

