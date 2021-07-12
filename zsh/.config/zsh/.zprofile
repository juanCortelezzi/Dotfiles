if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep dwm || startx ~/.config/X11/xinitrc
fi
