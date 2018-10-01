setxkbmap fr
sleep .2
xmodmap -e "keycode 66 = Escape NoSymbol Escape"
sleep .2
xmodmap -e "clear Lock"
