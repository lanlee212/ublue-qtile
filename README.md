# ublue-qtile

Minimal Fedora Atomic image with **Qtile** (X11) + **SDDM**, built with [BlueBuild](https://blue-build.org).

Based on `ublue-os/base-main` — no GNOME, no KDE, just a clean base. The whole
stack (GTK, Qt, terminal, notifications, popups) is themed **OneDark**.

## What's included

- **Qtile (X11)** — default SDDM session, with OneDark-themed popups:
  - App launcher (`Mod+d`, MRU + fuzzy matching)
  - Notification history (`Mod+\``, click the bell) — positioned above the bar
  - Power menu (`Mod+Shift+Q`) with i3lock/betterlockscreen
- **SDDM** with the Eucalyptus Drop theme + custom wallpaper
- **OneDark theming everywhere**: GTK via [adw-colors](https://github.com/lassekongo83/adw-colors)
  on adw-gtk3-dark, Qt via qt5ct/qt6ct + OneDark color scheme, dunst, picom, qtile bar
- **Ghostty** terminal (Fira Code, One Dark Two theme) — config shipped per-user
- **Nemo** + **Thunar** file managers, **Geany** editor
- **Steam**, **ProtonPlus** (Flatpak), **Aisleriot**, **Brave Origin**
- **Dunst** notifications, **Picom** compositor, **betterlockscreen** (lockscreen
  with the wallpaper; auto-locks on suspend)
- **TLP** power management + **battery gauge** bar widget (only appears on
  machines with a battery)
- **Topgrade** — one command
  updates everything (bootc + Flatpak + firmware)
- **Papirus** icons, stock Fedora kernel
- First login auto-copies the default configs (qtile, dunst, picom, ghostty,
  GTK theme, topgrade) into the user's home — **no-clobber**, your edits survive
  every update

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

At the SDDM login screen, select **Qtile (X11)** as your session.

## Updating

The image rebuilds automatically every day (GitHub Actions schedule) with the
newest Fedora packages; a weekly timer stages updates in the background. To apply:

```bash
topgrade          # bootc upgrade + flatpak + firmware
systemctl reboot
```

Rollback is always one command: `rpm-ostree rollback` (or pick the previous
deployment at the boot menu).

## Customizing

- Edit `recipes/recipe.yml` (packages, COPRs, scripts) and push — GitHub Actions
  rebuilds automatically.
- Shipped files live in `files/system/` (configs, themes, units, first-run logic
  in `/etc/profile.d/ublue-qtile.sh`).

## Acknowledgments

This project is developed with assistance from **Hermes**, an AI agent by
[Nous Research](https://nousresearch.com). Hermes helps with configuration,
debugging, and image maintenance; every change is verified locally and
reviewed and approved by the maintainer (Lee) before being committed and
pushed. Generated or AI-assisted content follows the repository's review
process like any other contribution.
