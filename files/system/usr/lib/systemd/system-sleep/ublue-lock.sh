#!/bin/sh
# Lock the active graphical session before suspend/sleep — same behavior as
# the desktop's betterlockscreen@.service hook.
#
# Runs as root (systemd executes everything in system-sleep/ on sleep events).
# Finds the first x11/wayland session, then launches betterlockscreen as that
# user with the session's XAUTHORITY (SDDM keeps it in /run/user/<uid>/).

case "$1" in
    pre)
        for sid in $(loginctl list-sessions --no-legend 2>/dev/null | awk '{print $1}'); do
            [ -n "$sid" ] || continue
            stype=$(loginctl show-session "$sid" -p Type --value 2>/dev/null)
            case "$stype" in
                x11|wayland)
                    user=$(loginctl show-session "$sid" -p Name --value 2>/dev/null)
                    [ -n "$user" ] || continue
                    uid=$(id -u "$user" 2>/dev/null)
                    xauth=""
                    for f in /run/user/${uid}/xauth_* /run/user/${uid}/gdm/Xauthority /home/${user}/.Xauthority; do
                        [ -r "$f" ] && xauth="$f" && break
                    done
                    DISPLAY=:0 XAUTHORITY="$xauth" runuser -u "$user" -- \
                        /usr/bin/betterlockscreen -l >/dev/null 2>&1 &
                    sleep 1
                    break
                    ;;
            esac
        done
        ;;
esac
exit 0
