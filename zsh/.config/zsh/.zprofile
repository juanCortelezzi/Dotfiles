export PATH="$HOME/.local/bin:$PATH"

if [[ "$(tty)" = "/dev/tty1" ]]; then
    if uwsm check may-start; then
        # any wayland compositor
        # exec systemd-cat -t uwsm_start uwsm start default

        # jump to the hyprland desktop
        exec uwsm start -S hyprland.desktop
    fi
fi
