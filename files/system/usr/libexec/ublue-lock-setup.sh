#!/bin/sh
# First-boot enable of the per-user suspend lock (betterlockscreen@<user>).
# The image doesn't know the username at build time; the first user on
# atomic images is uid 1000.
set -e
user=$(getent passwd 1000 | cut -d: -f1)
if [ -n "$user" ]; then
    systemctl enable "betterlockscreen@${user}.service"
    touch /etc/.ublue-lock-setup
fi
