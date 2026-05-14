# Shorin Niri Slim

A **lightweight, low-resource** port of the [Shorin Niri](https://github.com/SHORiN-KiWATA/shorin-niri) desktop configuration for Fedora and any modern Linux distribution.

This edition keeps only the **essential components** — no custom extensions, no daemons, no dynamic color engine, no background blur, no fancy animations. It is designed for **low-end hardware** and users who value **stability and low resource usage** over visual effects, while keeping the clean look of rounded corners, subtle transparency, and a cohesive color scheme.

---

## Changes from the Original

| Aspect | Original | This Edition |
|--------|----------|--------------|
| **Animations** | Spring physics (bouncy) | Simple duration + linear curve — minimal GPU impact |
| **Background blur** | 3 passes with xray | **Disabled** — zero GPU cost |
| **Dynamic color** | matugen engine (auto-generates colors from wallpaper) | **Static hardcoded colors** — no runtime dependency |
| **Wallpaper daemon** | awww (persistent background process) | **waypaper + swaybg** — no persistent daemon, only runs when changing wallpaper |
| **Lock screen** | hyprlock (blur + animation + config parser) | **swaylock** — minimal, one binary |
| **Custom extensions** | niri-sidebar, niriusd, linuxqq-clipsync | **Removed** |
| **Auto-start processes** | 16+ daemons | **8 essential only** |
| **Key bindings** | Included extension + theming hotkeys | **Clean** — only core Niri operations |
| **Scripts** | 10+ custom scripts | **4 retained** — keybind helper, force-kill, window switcher, power menu |
| **Waybar themes** | Dual themes (default + Win11Like) | **Single default** |
| **Hardware target** | Modern desktop / laptop | **Low-end / integrated GPU friendly** |

The full keybinding layout, window rules, workspace logic, and basic visual design are **preserved intact**.

---

## Dependencies

### Core Runtime

```
niri              — scrolling tiling Wayland compositor
waybar            — status bar
fuzzel            — application launcher
mako              — notification daemon
kitty             — terminal emulator
swaylock          — screen locker
swayidle          — idle management daemon
swayosd           — on-screen display (volume, brightness)
brightnessctl     — backlight control
polkit-gnome      — authentication agent
xdg-desktop-portal-gnome  — file picker / screen sharing portal
```

### Input Method

```
fcitx5            — input method framework
fcitx5-configtool — GUI config tool
fcitx5-gtk        — GTK frontend
fcitx5-qt         — Qt frontend
fcitx5-rime       — Rime engine
rime-ice          — Rime dictionary data (manual install)
```

### Wallpaper

```
waypaper          — wallpaper manager frontend (uses swaybg backend)
```

### Clipboard

```
cliphist          — clipboard history manager
wl-clipboard      — wl-copy / wl-paste
```

### Screenshot

```
grim              — screenshot tool
slurp             — region selection
```

### File Manager & Thumbnails (optional)

```
thunar            — file manager
thunar-archive-plugin
thunar-volman
file-roller       — archive manager
gvfs-smb          — SMB support
gvfs-mtp          — MTP (phone) support
tumbler           — thumbnail service
poppler-glib      — PDF thumbnails
ffmpegthumbnailer — video thumbnails
```

### Fonts

```
google-noto-fonts
google-noto-cjk-fonts
google-noto-emoji-fonts
jetbrains-mono-fonts
```

For Nerd Font icons in waybar, download **JetBrainsMono Nerd Font** manually from [nerdfonts.com](https://www.nerdfonts.com/fonts).

### Utilities

```
bat               — better cat
eza               — better ls
fish              — shell
starship          — prompt
zoxide            — smarter cd
jq                — JSON processor
fastfetch         — system info
btop              — system monitor
gdu               — disk usage
ImageMagick       — image processing
pavucontrol       — PulseAudio volume control
gnome-keyring     — credential storage
```

### Display & Session

```
xorg-xwayland     — X11 app support
qt5-qtwayland     — Qt5 Wayland support
qt6-qtwayland     — Qt6 Wayland support
xdg-terminal-exec — default terminal resolver
```

### Cursor

```
breeze-cursor-theme
```

### Browser

```
firefox
```

---

## Installation

### 1. Install the dependencies above using your system package manager

Fedora:
```
sudo dnf install niri waybar fuzzel mako kitty swaylock swayidle swayosd ...
```

Arch:
```
sudo pacman -S niri waybar fuzzel mako kitty swaylock swayidle ...
```

Debian/Ubuntu (may need backports or manual builds for niri):
```
sudo apt install niri waybar fuzzel mako kitty swaylock swayidle ...
```

### 2. Clone and deploy configs

```bash
git clone <this-repo-url> ~/shorin-niri
cd ~/shorin-niri

cp -r dotfiles/.config/* ~/.config/
cp -r dotfiles/.local/* ~/.local/
mkdir -p ~/Pictures/Wallpapers
cp -r Wallpapers/* ~/Pictures/Wallpapers/
```

### 3. Configure waypaper to use swaybg backend

Edit `~/.config/waypaper/config.ini`:

```ini
[Settings]
backend = swaybg
```

### 4. Start the session

Select **Niri** from your display manager (SDDM, GDM, etc.), or run:

```bash
niri-session
```

> The original `shorinniri` CLI tool (init/update/remove) is **not included** in this edition. Simply copy the dotfiles directly.

---

## Post-Install

- **Wallpaper**: `Mod+Alt+W` to open waypaper picker, or `Mod+F10` for random
- **Lock screen**: `Mod+Alt+L` (uses swaylock with dark background)
- **Input method**: Restart fcitx5 with `Mod+F1` if needed
- **Monitor config**: Edit `~/.config/niri/output.kdl` for your display(s)

---

## Keybinding Quick Reference

Press **`Mod+Shift+/`** inside Niri to show the full help overlay.

| Category | Key | Action |
|----------|-----|--------|
| Focus | `Mod+H/L` / `Mod+←/→` | Focus column left/right |
| Focus | `Mod+J/K` / `Mod+↑/↓` | Focus window up/down |
| Focus | `Mod+A/D` | Move window between columns |
| Move | `Mod+Ctrl+H/L` | Move column left/right |
| Move | `Mod+Ctrl+J/K` | Move window up/down |
| Workspace | `Mod+1-9` | Switch to workspace N |
| Workspace | `Mod+U/I` | Previous/next workspace |
| Layout | `Mod+R` | Cycle column width |
| Layout | `Mod+F` | Maximize column |
| Layout | `Mod+V` | Toggle floating |
| Layout | `Mod+X` | Toggle tabbed display |
| Layout | `Mod+Q` | Close window |
| Layout | `Alt+F4` | Force kill window |
| Multi-monitor | `Mod+Shift+H/L` | Focus adjacent monitor |
| Multi-monitor | `Mod+Shift+Alt+W/S/A/D` | Move workspace to monitor |
| Screenshot | `Print` | Select area screenshot |
| Lock | `Mod+Alt+L` | Lock screen |
| Power | `Mod+Shift+P` | Power menu |
| Terminal | `Mod+T` | Kitty (shared instance) |
| Launcher | `Mod+Z` | Fuzzel app launcher |
| Clipboard | `Mod+Alt+V` | Clipboard history |
| Wallpaper | `Mod+F10` | Random wallpaper |
| Help | `Mod+Shift+/` | Show all keybindings |

---

## Credits

- Original Shorin Niri by [SHORiN-KiWATA](https://github.com/SHORiN-KiWATA)
- [Niri](https://github.com/YaLTeR/niri) — the scrolling tiling Wayland compositor
- This minimal edition adapted for low-resource hardware and Fedora
