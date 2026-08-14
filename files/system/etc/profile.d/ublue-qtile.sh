# First-login setup for ublue-qtile: copy the default qtile config + dunst
# theme into the user's home (no-clobber, idempotent). Sourced by sddm's
# Xsession via /etc/profile before qtile starts.
if [ -d /usr/share/ublue-qtile/config ] && [ ! -f "${HOME}/.config/qtile/config.py" ]; then
    mkdir -p "${HOME}/.config/qtile" "${HOME}/.config/dunst"
    cp -rn /usr/share/ublue-qtile/config/. "${HOME}/.config/qtile/"
    cp -rn /usr/share/ublue-qtile/dunst/. "${HOME}/.config/dunst/"
    chmod +x "${HOME}/.config/qtile/autostart.sh"
fi
