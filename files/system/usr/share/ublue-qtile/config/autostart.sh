#!/usr/bin/env bash
picom -b &
# wallpaper (shipped in the image at a system path)
feh --bg-fill /usr/share/ublue-qtile/wallpaper/od_arch.png &
# polkit agent: lxpolkit on the image (polkit-gnome isn't in Fedora 44)
lxpolkit &
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
# Idle lock: -detect-sleep resets the countdown after resume so a long
# suspend doesn't re-lock the screen right after unlocking
xautolock -detect-sleep -time 10 -locker "betterlockscreen -l" &
pactl load-module module-switch-on-connect
remmina -i &
