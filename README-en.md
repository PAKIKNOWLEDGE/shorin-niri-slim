# Shorin Niri — Streamlined Edition

A **lightweight, low-end friendly** port of the [Shorin Niri](https://github.com/SHORiN-KiWATA/shorin-niri) desktop configuration, transplanted to **Fedora** (and usable on any modern Linux distribution with minimal adjustments).

This fork strips out custom extensions, non-essential daemons, and resource-heavy eye candy to deliver a snappy Niri experience on modest hardware.

---

## What's Different from the Original

| Aspect | Original | This Edition |
|--------|----------|--------------|
| **Animations** | Spring physics with low damping (bouncy) | High damping, lower stiffness — faster, cheaper to render |
| **Background blur** | 3 passes, large offset | 1 pass, minimal offset |
| **Window shadows** | Softness 20, spread 2 | Softness 12, spread 1 |
| **Lock screen blur** | blur_size 5, passes 4 | blur_size 3, passes 2 |
| **Custom extensions** | niri-sidebar, niriusd, linuxqq-clipsync | **Removed** — all self-developed extensions stripped |
| **Auto-start processes** | 16+ daemons | 11 core-only daemons |
| **Key bindings** | Included extension hotkeys | Clean — only core Niri operations retained |
| **Hardware target** | Modern desktop / laptop | **Low-end / integrated GPU friendly** |

The full keybinding layout, window rules, workspace logic, and basic visual design are **preserved intact**.

---

## Dependencies

### Repositories (COPR)

```bash
# Niri compositor
sudo dnf copr enable erikreider/niri

# Hyprlock (for lock screen)
sudo dnf copr enable solopasha/hyprlock

# Waybar (latest version)
sudo dnf copr enable erikreider/waybar
```

### Core Runtime

```bash
# Compositor & desktop portal
sudo dnf install niri xdg-desktop-portal-gnome xdg-desktop-portal-gtk xdg-terminal-exec

# Status bar, launcher, notifications, OSD
sudo dnf install waybar fuzzel mako libnotify swayosd brightnessctl

# Wallpaper daemon & color generation
# awww:    https://github.com/TH0R5T3N/awww (build from source)
# matugen: https://github.com/InioX/matugen (build from source)
# waypaper:sudo dnf install waypaper  (or pip install waypaper)
```

### Display & Session

```bash
sudo dnf install xorg-xwayland qt5-qtwayland qt6-qtwayland
```

### Input Method (fcitx5)

```bash
sudo dnf install fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-rime
# Rime data:
#   rime-ice: https://github.com/iDvel/rime-ice (clone to ~/.local/share/fcitx5/rime)
#   rime-llm-translator: https://github.com/SHORiN-KiWATA/rime-llm-translator
```

### File Manager & Thumbnails

```bash
sudo dnf install thunar thunar-archive-plugin thunar-volman file-roller \
  gvfs-smb gvfs-mtp gvfs-gphoto2 \
  tumbler poppler-glib ffmpegthumbnailer webp-pixbuf-loader libgsf
```

### Clipboard

```bash
sudo dnf install cliphist wl-clipboard
```

### Terminal

```bash
sudo dnf install kitty
```

### Fonts

```bash
sudo dnf install google-noto-fonts google-noto-cjk-fonts google-noto-emoji-fonts \
  jetbrains-mono-fonts
# Nerd-font variant: Download JetBrainsMono Nerd Font manually from:
#   https://www.nerdfonts.com/fonts
```

### Utilities

```bash
sudo dnf install ImageMagick bat eza fish starship zoxide jq fastfetch btop gdu \
  chafa timg strace pavucontrol gnome-keyring polkit-gnome
```

### Screenshot & Screen Recording

```bash
sudo dnf install grim slurp satty wf-recorder wl-screenrec
```

### Lock Screen

```bash
sudo dnf install hyprlock swayidle
```

### Cursor Theme

```bash
sudo dnf install breeze-cursor-theme
```

### Browser

```bash
sudo dnf install firefox
```

### One-liner (essential packages)

```bash
sudo dnf install niri xdg-desktop-portal-gnome waybar fuzzel mako kitty \
  thunar file-roller cliphist wl-clipboard fcitx5 fcitx5-configtool \
  fcitx5-gtk fcitx5-qt fcitx5-rime grim slurp hyprlock swayidle \
  polkit-gnome ImageMagick bat fish starship jq fastfetch btop pavucontrol \
  google-noto-fonts google-noto-emoji-fonts jetbrains-mono-fonts \
  breeze-cursor-theme brightnessctl firefox
```

---

## Installation

### 1. Install all dependencies (see sections above)

### 2. Clone & deploy configs

```bash
git clone https://github.com/YOUR_USER/shorin-niri.git ~/shorin-niri
cd ~/shorin-niri

# Deploy dotfiles to your home directory
cp -r dotfiles/.config/* ~/.config/
cp -r dotfiles/.local/* ~/.local/

# Deploy wallpapers
mkdir -p ~/Pictures/Wallpapers
cp -r Wallpapers/* ~/Pictures/Wallpapers/
```

### 3. Start the session

Select **Niri** from your display manager (SDDM, GDM, etc.), or launch manually:

```bash
niri-session
```

> **Note for Fedora / non-Arch users:**  
> The original `shorinniri` CLI tool (init/update/remove) is an Arch AUR helper script and is **not used here**. On Fedora and other distros, simply copy the dotfiles as shown above. The `shorinniri` script in this repository is provided for reference only.

---

## Post-Install

- **Wallpaper**: `waypaper --random` or press `Mod+F10`
- **Input method**: Restart fcitx5 after first login (`Mod+F1`)
- **Color scheme**: Run `matugen image ~/Pictures/Wallpapers/your-wallpaper.jpg` then `~/.config/scripts/matugen-update.sh`
- **Output config**: Edit `~/.config/niri/output.kdl` to match your monitor(s)

---

## Keybinding Quick Reference

Press **`Mod+Shift+/`** (Super + Shift + /) inside Niri to show the full keybinding cheat sheet.

| Category | Key | Action |
|----------|-----|--------|
| Focus | `Mod+H/L` / `Mod+←/→` | Focus column left/right |
| Focus | `Mod+J/K` / `Mod+↑/↓` | Focus window up/down |
| Move | `Mod+Ctrl+H/L` | Move column left/right |
| Move | `Mod+Ctrl+J/K` | Move window up/down |
| Workspace | `Mod+1-9` | Switch to workspace |
| Workspace | `Mod+U/I` / `Mod+PageUp/Down` | Previous/next workspace |
| Layout | `Mod+R` | Cycle column width (1/3 — 1/2 — 2/3) |
| Layout | `Mod+F` | Maximize column |
| Layout | `Mod+V` | Toggle floating |
| Layout | `Mod+X` | Toggle tabbed display |
| Layout | `Mod+Q` | Close window |
| Layout | `Alt+F4` | Force kill window |
| Multi-monitor | `Mod+Shift+H/L` | Focus monitor left/right |
| Multi-monitor | `Mod+Shift+Alt+W/S/A/D` | Move workspace to monitor |
| Screenshot | `Print` | Select area screenshot |
| Lock | `Mod+Alt+L` | Lock screen |
| Power | `Mod+Shift+P` | Power menu (lock/suspend/reboot/shutdown) |
| Terminal | `Mod+T` | Kitty (shared instance) |
| Launcher | `Mod+Z` | Fuzzel app launcher |
| Clipboard | `Mod+Alt+V` | Clipboard history |
| Wallpaper | `Mod+F10` | Random wallpaper |

---

## Credits

- Original Shorin Niri by [SHORiN-KiWATA](https://github.com/SHORiN-KiWATA)
- [Niri](https://github.com/YaLTeR/niri) — the scrolling tiling Wayland compositor
- This streamlined edition adapted for Fedora and low-resource hardware
