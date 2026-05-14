# Shorin Niri Slim

A **lightweight, low-resource** port of the [Shorin Niri](https://github.com/SHORiN-KiWATA/shorin-niri) desktop configuration for Fedora and any modern Linux distribution.

Stripped down to **essential components only** — no custom extensions, no background blur, no dynamic color engine, no persistent daemons. Keeps the clean look (rounded corners, subtle transparency, cohesive color scheme) while running smoothly on low-end hardware.

---

## What's Different

| Aspect | Original | Slim |
|--------|----------|------|
| **Animations** | Spring physics (bouncy) | Simple duration + ease-out |
| **Background blur** | 3 passes + xray | **Disabled** |
| **Dynamic color** | matugen engine | **Static hardcoded colors** |
| **Wallpaper** | awww (persistent daemon) | **waypaper + swaybg** |
| **Lock screen** | hyprlock | **swaylock** — single binary |
| **Extensions** | niri-sidebar, niriusd, linuxqq-clipsync | **Removed** |
| **Auto-start** | 16+ daemons | **8 essential only** |
| **Scripts** | 10+ custom scripts | **4 retained** |
| **Waybar themes** | Dual | **Single default** |
| **Key bindings** | Extension hotkeys included | **Clean** — core only |
| **Hardware** | Modern desktop | **Low-end / iGPU friendly** |

Full keybinding layout, window rules, workspace logic and visual design are **preserved intact**.

---

## Dependencies

### Core
```
niri waybar fuzzel mako kitty swaylock swayidle swayosd brightnessctl
polkit-gnome xdg-desktop-portal-gnome
```

### Input method
```
fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-rime
rime-ice (manual install)
```

### Wallpaper
```
waypaper swaybg
```

### Clipboard
```
cliphist wl-clipboard
```

### Screenshot
```
grim slurp
```

### File manager (optional)
```
thunar thunar-archive-plugin thunar-volman file-roller
gvfs-smb gvfs-mtp tumbler ffmpegthumbnailer webp-pixbuf-loader
```

### Fonts
```
google-noto-fonts google-noto-cjk-fonts google-noto-emoji-fonts
jetbrains-mono-fonts
```
Also download **JetBrainsMono Nerd Font** from [nerdfonts.com](https://www.nerdfonts.com/fonts) for waybar icons.

### Utilities
```
bat eza fish starship zoxide jq fastfetch btop gdu
ImageMagick pavucontrol gnome-keyring
```

### Display & cursor
```
xorg-xwayland qt5-qtwayland qt6-qtwayland
xdg-terminal-exec breeze-cursor-theme
```

### Browser
```
firefox
```

---

## Installation

### 1. Install packages

Fedora:
```
sudo dnf install niri waybar fuzzel mako kitty swaylock swayidle swayosd ...
```
Arch:
```
sudo pacman -S niri waybar fuzzel mako kitty swaylock swayidle ...
```

### 2. Clone and deploy

```bash
git clone <repo-url> ~/shorin-niri-slim
cd ~/shorin-niri-slim

cp -r dotfiles/.config/* ~/.config/
cp -r dotfiles/.local/* ~/.local/
mkdir -p ~/图片/Wallpapers
cp -r Wallpapers/* ~/图片/Wallpapers/
```

### 3. Set waypaper backend

Edit `~/.config/waypaper/config.ini`:
```ini
[Settings]
backend = swaybg
```

### 4. Start Niri

Select **Niri** from your display manager, or run:
```bash
niri-session
```

> The original `shorinniri` CLI is **not included** — copy dotfiles directly.

---

## Keybindings Quick Reference

Press **`Mod+Shift+/`** inside Niri for the full help overlay.

| Key | Action |
|-----|--------|
| `Mod+Enter` | Terminal (kitty) |
| `Mod+Space` | App launcher (fuzzel) |
| `Mod+Q` | Close window |
| `Mod+H/L` / `←/→` | Focus column |
| `Mod+J/K` / `↑/↓` | Focus window |
| `Mod+Ctrl+H/L` | Move column |
| `Mod+1-9` | Switch workspace |
| `Mod+F` | Maximize column |
| `Mod+V` | Toggle floating |
| `Mod+R` | Cycle column width |
| `Mod+Tab` | Quick window switch |
| `Alt+Tab` | Thumbnail switcher |
| `Mod+Shift+E` | Quit niri |
| `Mod+Alt+L` | Lock screen |
| `Mod+Shift+P` | Power menu |
| `Print` | Screenshot |
| `Mod+F10` | Random wallpaper |
| `Mod+Alt+V` | Clipboard history |
| `Mod+F1` | Toggle fcitx5 |

---

## Credits

- Original [Shorin Niri](https://github.com/SHORiN-KiWATA/shorin-niri) by [SHORiN-KiWATA](https://github.com/SHORiN-KiWATA)
- [Niri](https://github.com/YaLTeR/niri) — the scrolling tiling Wayland compositor
- Slim edition adapted for low-resource hardware
