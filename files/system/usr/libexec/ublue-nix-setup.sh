#!/bin/sh
# First-boot Nix install (Determinate Nix installer, systemd init).
# Marker-guarded; runs once. The first user (anaconda-created, uid 1000)
# is added to the nix-users group so they can use the daemon.
set -e

# Wait briefly for the first user to exist (fresh installs create it in anaconda)
user=""
i=0
while [ $i -lt 30 ]; do
    user=$(getent passwd 1000 | cut -d: -f1)
    [ -n "$user" ] && break
    sleep 2
    i=$((i + 1))
done

curl -fsSL https://install.determinate.systems/nix \
    | sh -s -- install linux --no-confirm --init systemd

if [ -n "$user" ]; then
    usermod -aG nix-users "$user" 2>/dev/null || true
fi

touch /etc/.ublue-nix-setup
