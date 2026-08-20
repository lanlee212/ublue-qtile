#!/bin/sh
# Resume recovery for the suspend lock (locking itself is handled by the
# betterlockscreen@<user>.service unit).
#
# Runs as root (systemd executes everything in system-sleep/ on sleep events).
#
# On resume:
#  - the xautolock idle-lock countdown is restarted: it kept running during
#    suspend, so without this it fires (re-locks) right after the user
#    unlocks. -detect-sleep alone is unreliable on systemd suspends.
#  - i3lock often loses its X connection during suspend (amdgpu etc.) and
#    exits silently: wake would show a stale lock frame for a second, then
#    the desktop. Re-lock after wake if nothing is holding the lock.

_session_user() {
    for sid in $(loginctl list-sessions --no-legend 2>/dev/null | awk '{print $1}'); do
        [ -n "$sid" ] || continue
        stype=$(loginctl show-session "$sid" -p Type --value 2>/dev/null)
        case "$stype" in
            x11|wayland)
                user=$(loginctl show-session "$sid" -p Name --value 2>/dev/null)
                [ -n "$user" ] && { echo "$user"; return 0; }
                ;;
        esac
    done
    return 1
}

_session_xauth() {
    uid=$(id -u "$1" 2>/dev/null)
    for f in /run/user/${uid}/xauth_* /run/user/${uid}/gdm/Xauthority /home/${1}/.Xauthority; do
        [ -r "$f" ] && { echo "$f"; return 0; }
    done
    return 1
}

case "$1" in
    post)
        user=$(_session_user) || exit 0
        xauth=$(_session_xauth "$user") || xauth=""
        pkill -x xautolock 2>/dev/null
        sleep 1
        DISPLAY=:0 XAUTHORITY="$xauth" runuser -u "$user" -- \
            xautolock -detect-sleep -time 10 -locker "betterlockscreen -l" >/dev/null 2>&1 &
        if ! pgrep -x i3lock >/dev/null 2>&1; then
            DISPLAY=:0 XAUTHORITY="$xauth" runuser -u "$user" -- \
                /usr/bin/betterlockscreen -l >/dev/null 2>&1 &
        fi
        ;;
esac
exit 0
