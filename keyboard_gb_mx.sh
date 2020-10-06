setxkbmap gb extd -option altwin:swap_lalt_lwin
xmodmap -e "clear Lock"
sleep .2
xmodmap -e "keycode 66 = Escape NoSymbol Escape"
xmodmap -e "keycode 49 = backslash bar"
xmodmap -e "keycode 94 = dead_grave notsign"
xmodmap -e "keycode 134 = ISO_Level3_Shift"
xmodmap -e "keycode 108 = Super_R"
