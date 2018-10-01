setxkbmap gb
sleep .2
xmodmap -e "clear Lock"
sleep .2
xmodmap -e "keycode 66 = Escape NoSymbol Escape"
