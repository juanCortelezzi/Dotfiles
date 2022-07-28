if [[ "$(tty)" = "/dev/tty1" ]]; then
    export PATH="/home/wiz/.local/bin:$PATH"
    # pgrep dwm || startx ~/.config/X11/xinitrc
fi
