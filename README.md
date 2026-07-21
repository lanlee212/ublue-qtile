# ublue-qtile

Minimal Fedora Atomic image with **Qtile** WM + **SDDM** display manager, built with [BlueBuild](https://blue-build.org).

Based on `ublue-os/base-main` — no GNOME, no KDE, just a clean base.

## What's included

- **Qtile** (Wayland + X11 sessions available in SDDM)
- **SDDM** display manager (default session: Qtile Wayland)
- **Alacritty** / **Kitty** terminals
- **Rofi** launcher
- **Dunst** notifications
- **Thunar** + **Nemo** file managers
- **Geany** text editor
- **Papirus** icons
- **Grim/Slurp** screenshot tools
- **Picom** X11 compositor
- **Pavucontrol**, **Blueman**, **NetworkManager applet**

## Installation

### Rebase from an existing Fedora Atomic installation

```bash
# First rebase to the unsigned image, to get the proper signing keys and policies installed:
rpm-ostree rebase ostree-unverified-registry:ghcr.io/lanlee212/ublue-qtile:latest
systemctl reboot

# Then rebase to the signed image:
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/lanlee212/ublue-qtile:latest
systemctl reboot
```

### Fresh install

1. Install [Fedora Silverblue](https://fedoraproject.org/silverblue/) 42 normally
2. Or direct ISO from your GitHub Actions artifacts
3. Rebase as above

## Post-install

At the SDDM login screen, select **Qtile** or **Qtile (X11)** as your session.

To create your qtile config:
```bash
mkdir -p ~/.config/qtile
cp /usr/share/doc/qtile/default_config.py ~/.config/qtile/config.py
```

## Customizing

Edit `recipes/recipe.yml` and push — GitHub Actions rebuilds automatically.
