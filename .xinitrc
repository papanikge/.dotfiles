# Cursor and trayer(-top-bar) settings
xsetroot -cursor_name left_ptr
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 3 --transparent true --alpha 0 --tint 0x000000 --height 16 &

# For the wallpapers (through feh)
sh ~/.fehbg &

# Let's go...
exec xmonad
