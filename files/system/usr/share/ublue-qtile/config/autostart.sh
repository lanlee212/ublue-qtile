#!/usr/bin/env bash
picom -b &
# polkit agent: Fedora keeps it in /usr/libexec, Arch in /usr/lib/polkit-gnome
POLKIT_AGENT="$(command -v polkit-gnome-authentication-agent-1 || echo /usr/libexec/polkit-gnome-authentication-agent-1)"
"$POLKIT_AGENT" &
dunst &
nm-applet --indicator &
wait -n &
kdeconnect-indicator &
wait -n &
blueman-applet &
wait -n &
# MEGA Sync has no Fedora build; skip silently where unavailable
if command -v megasync >/dev/null 2>&1; then
    DO_NOT_UNSET_QT_QPA_PLATFORMTHEME=1 megasync &
fi
xautolock -time 10 -locker "betterlockscreen -l" &
pactl load-module module-switch-on-connect
remmina -i &
