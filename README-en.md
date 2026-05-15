# Shorin Niri Slim

A **lightweight, low-resource** port of the [Shorin Niri](https://github.com/SHORiN-KiWATA/shorin-niri) desktop configuration for Fedora and any modern Linux distribution.

Stripped down to **essential components only** — no custom extensions, no background blur, no dynamic color engine, no persistent daemons. Keeps the clean look (rounded corners, subtle transparency, cohesive color scheme) while running smoothly on low-end hardware.

---

## What's Different

| Aspect | Original | Slim |
|--------|----------|------|
| **Animations** | Spring physics (bouncy) | Simple duration + ease-out |
| **Background blur** | 3 passes + xray | Disabled |
| **Dynamic color** | matugen engine | Static hardcoded colors |
| **Wallpaper** | awww (persistent daemon) | waypaper + swaybg |
| **Lock screen** | hyprlock (blur + animations) | swaylock — single binary |
| **Extensions** | niri-sidebar, niriusd, linuxqq-clipsync | Removed |
| **Auto-start** | 16+ daemons | 8 essential only |
| **Scripts** | 10+ custom scripts | 4 retained |
| **Waybar themes** | Dual (default + Win11Like) | Single default |
| **Key bindings** | Extension hotkeys included | Clean — core only |
| **Hardware** | Modern desktop | Low-end / iGPU friendly |

Full keybinding layout, window rules, workspace logic and visual design are **preserved intact**.

---

## Dependencies

### Core
```
niri waybar fuzzel mako kitty swaylock swayidle swayosd brightnessctl
NetworkManager-tui  # nmtui, for WiFi setup
polkit-gnome  # Fedora: polkit-kde
xdg-desktop-portal-gnome
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
xorg-xwayland qt5-qtwayland qt6-qtwayland xdg-terminal-exec
breeze-cursor-theme
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

> **Note:** `swayidle` handles idle timeout & pre-sleep lock (lid close / manual suspend). To disable, comment out `spawn-at-startup "~/.config/niri/scripts/swayidle.sh"` in `config.kdl`.

---

## Keybindings

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

## Notes & Known Issues

### Lock Screen
`swaylock -f -i ~/图片/111046153_p0.jpg` — change the wallpaper path to match yours. If the image doesn't exist, fall back to `swaylock -f -c 1e1e2e` (dark background).

### swayidle not starting?
- `spawn-at-startup` in niri does **not** expand `~`. Use `spawn-sh-at-startup` for tilde paths, or an absolute path.
- Auto-start commands only run on **niri startup**, not on config reload. Press `Mod+Shift+E` and re-login.
- Make sure scripts are executable: `chmod +x ~/.config/niri/scripts/*.sh`

### Clipboard
Clipboard history is powered by `cliphist` + `wl-paste --watch`. The TUI is replaced by fuzzel for cross-distro compatibility: `cliphist list | fuzzel --dmenu | cliphist decode | wl-copy`. On Arch you can replace this with `cliphist-tui` if preferred.

### Waybar
Several modules from the original config were removed or simplified: `custom/wfrec` (screen recording removed), `custom/settings` (referred to non-existent `better-control`), `mpris` (not in layout, had typo). The clock `on-click` actions calling GNOME apps (`gnome-clocks`, `gnome-calendar`) were removed for KDE compatibility.

### polkit
On Fedora, `polkit-gnome` has been removed. Install `polkit-kde` instead: `sudo dnf install polkit-kde`. The config spawns both paths; the non-existent one will silently fail.

### Laptop lid close
- If you're running niri **inside a Plasma session**, Plasma's powerdevil may still handle lid-close events. The `before-sleep` hook in swayidle will still fire before suspend, but the sleep itself is managed by Plasma.
- For standalone niri sessions, `systemd-logind` handles lid-close (`HandleLidSwitch=suspend` in `/etc/systemd/logind.conf`).

---

## Credits

- Original [Shorin Niri](https://github.com/SHORiN-KiWATA/shorin-niri) by [SHORiN-KiWATA](https://github.com/SHORiN-KiWATA)
- [Niri](https://github.com/YaLTeR/niri) — the scrolling tiling Wayland compositor
- Slim edition adapted for low-resource hardware
