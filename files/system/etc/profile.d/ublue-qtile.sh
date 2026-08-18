# First-login setup for ublue-qtile: copy the default qtile config + dunst
# theme + picom config into the user's home (no-clobber, idempotent). Sourced
# by sddm's Xsession via /etc/profile before qtile starts.
if [ -d /usr/share/ublue-qtile/config ] && [ ! -f "${HOME}/.config/qtile/config.py" ]; then
    mkdir -p "${HOME}/.config/qtile" "${HOME}/.config/dunst"
    cp -rn /usr/share/ublue-qtile/config/. "${HOME}/.config/qtile/"
    cp -rn /usr/share/ublue-qtile/dunst/. "${HOME}/.config/dunst/"
    cp -rn /usr/share/ublue-qtile/picom/picom.conf "${HOME}/.config/picom.conf"
    chmod +x "${HOME}/.config/qtile/autostart.sh"
fi

# Qt6 apps: use the qt6ct platform theme (Fusion + OneDark color scheme)
export QT_QPA_PLATFORMTHEME=qt6ct

# Topgrade config: topgrade only reads ~/.config/topgrade/topgrade.toml
# (no /etc support), so ship it per-user; no-clobber keeps user edits.
if [ -d /usr/share/ublue-qtile/topgrade ]; then
    mkdir -p "${HOME}/.config/topgrade"
    cp -rn /usr/share/ublue-qtile/topgrade/topgrade.toml "${HOME}/.config/topgrade/topgrade.toml"
fi

# OneDark GTK theme (adw-colors): per-user CSS overrides on top of the
# adw-gtk3-dark base theme; no-clobber keeps user edits.
if [ -d /usr/share/ublue-qtile/gtk ]; then
    mkdir -p "${HOME}/.config/gtk-3.0" "${HOME}/.config/gtk-4.0"
    cp -rn /usr/share/ublue-qtile/gtk/gtk3-dark.css "${HOME}/.config/gtk-3.0/gtk.css"
    cp -rn /usr/share/ublue-qtile/gtk/gtk4-dark.css "${HOME}/.config/gtk-4.0/gtk.css"
fi
