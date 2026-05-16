# Shorin Niri Slim

A **lightweight, low-resource** port of the [Shorin Niri](https://github.com/SHORiN-KiWATA/shorin-niri) desktop configuration for Fedora, Arch, and any modern Linux distribution.

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
| **Waybar themes** | Dual (default + Win11Like) | Single default (both available) |
| **Key bindings** | Extension hotkeys included | Clean — core only |
| **Hardware** | Modern desktop | Low-end / iGPU friendly |

Full keybinding layout, window rules, workspace logic and visual design are **preserved intact**.

---

## Changes from Original Slim (Cross-Distro Adaptation)

| Change | Reason |
|--------|--------|
| Removed `waybar-niri-Win11Like` theme entirely | Unnecessary; single default theme is cleaner |
| Added `custom/colorize` waybar button + `Mod+Ctrl+F10` keybind | Manual color refresh: matugen reads current wallpaper and updates all component colors |
| Removed `custom/actions` from waybar layout | `command-center.sh` was Arch-only (paru/yay/pacman/shorin CLI) → replaced with empty stub |
| Removed `custom/updates` from waybar layout | `check-updates.sh` was Arch-only (checkupdates/paru/yay) → replaced with empty stub |
| `apt.fish` → universal package wrapper | Old version only supported Arch (paru>yay>pacman); now auto-detects dnf/apt/pacman/zypper/xbps |
| `fastfetch` logo → `type: "small"` | No image source → ASCII fallback was too large on small screens (X250) |
| `~/.cargo/bin` added to `$PATH` in fish config | So cargo-installed tools like `matugen` are found |
| `polkit-kde` required (Fedora) | Fedora removed polkit-gnome; config spawns both paths, missing one fails silently |
| `xorg-xwayland` → `xorg-x11-server-Xwayland` | Package name changed on Fedora 44+ |
| `xorg-xprop` → `xprop` | Package name changed on Fedora 44+ |
| `swayosd` COPR added (`phynecs/swayosd`) | Not in Fedora main repos |
| Waybar style.css updated | Replaced old `#custom-actions` with `#custom-colorize` |
| Wallpaper backend confirmed as `swaybg` | Used by waypaper; no extra daemons |

---

## Dependencies

### Core
```
niri waybar fuzzel mako kitty swaylock swayidle swayosd brightnessctl
NetworkManager-tui  # nmtui, for WiFi setup
polkit-kde          # Fedora: use polkit-kde, NOT polkit-gnome
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
grim slurp satty
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
**Required:** JetBrainsMono Nerd Font (for waybar icons) — download from [nerdfonts.com](https://www.nerdfonts.com/fonts)

### Utilities
```
bat eza fish starship zoxide jq fastfetch btop gdu
ImageMagick pavucontrol gnome-keyring fzf
```

### Display & cursor
```
xorg-x11-server-Xwayland qt5-qtwayland qt6-qtwayland xdg-terminal-exec
breeze-cursor-theme xprop
```

### Audio & Bluetooth
```
pipewire-pulseaudio playerctl bluez bluez-tools power-profiles-daemon
```

### Browser
```
firefox
```

---

## Installation

### Fedora (personal experience)

> These steps are based on my actual setup on Fedora 44 (X250 ThinkPad).
> Most packages are in Fedora's main repos, but some need extra sources.

#### 1. Enable extra repos
```bash
sudo dnf install -y \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf copr enable -y yalter/niri       # niri compositor
sudo dnf copr enable -y phynecs/swayosd   # OSD popups
```

#### 2. Install DNF packages

**Note:** `--allowerasing` is needed because `power-profiles-daemon` conflicts with `tuned-ppd`.
Some packages (waypaper, satty, starship) aren't in DNF repos, they're handled separately below.

```bash
sudo dnf install -y --allowerasing \
  niri waybar fuzzel mako kitty swaylock swayidle swayosd brightnessctl \
  NetworkManager-tui polkit-kde xdg-desktop-portal-gnome \
  fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-rime \
  cliphist wl-clipboard grim slurp \
  google-noto-sans-fonts google-noto-cjk-fonts google-noto-emoji-fonts \
  jetbrains-mono-fonts \
  bat eza fish zoxide jq fastfetch btop gdu \
  ImageMagick pavucontrol gnome-keyring fzf \
  xorg-x11-server-Xwayland qt5-qtwayland qt6-qtwayland xdg-terminal-exec \
  breeze-cursor-theme xprop firefox \
  libnotify pipewire-pulseaudio playerctl python3 network-manager-applet \
  ddcutil power-profiles-daemon bluez bluez-tools upower python3-pip \
  thunar thunar-archive-plugin thunar-volman file-roller \
  gvfs-smb gvfs-mtp tumbler ffmpegthumbnailer webp-pixbuf-loader \
  sound-theme-freedesktop
```

#### 3. Install packages not in DNF repos

```bash
# waypaper (Python)
pip install waypaper --user

# starship (cross-distro install script)
curl -sS https://starship.rs/install.sh | sh

# satty — download binary from GitHub Releases
SATTY_VER=$(curl -s https://api.github.com/repos/gabm/satty/releases/latest | grep tag_name | cut -d'"' -f4)
wget -P /tmp "https://github.com/gabm/satty/releases/download/${SATTY_VER}/satty-${SATTY_VER}-x86_64-unknown-linux-gnu.tar.gz"
tar -xzf /tmp/satty-*.tar.gz -C /tmp
sudo cp /tmp/satty-*/satty /usr/local/bin/

# cava — build from source if COPR unavailable
sudo dnf install -y gcc-c++ make automake autoconf libtool \
  alsa-lib-devel pulseaudio-libs-devel fftw-devel iniparser-devel
git clone https://github.com/karlstav/cava.git /tmp/cava
cd /tmp/cava && ./autogen.sh && ./configure && make -j$(nproc) && sudo make install

# matugen — color extraction tool for custom/colorize button
cargo install matugen
```

#### 4. JetBrainsMono Nerd Font (waybar icons)

```bash
wget -P /tmp https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
sudo mkdir -p /usr/share/fonts/JetBrainsMonoNerd
sudo unzip /tmp/JetBrainsMono.zip -d /usr/share/fonts/JetBrainsMonoNerd/
sudo fc-cache -fv
```

#### 5. Deploy configs

```bash
cd ~/shorin-niri-slim
cp -r dotfiles/.config/* ~/.config/
cp -r dotfiles/.local/* ~/.local/
cp dotfiles/.vimrc ~/
mkdir -p ~/图片/Wallpapers ~/图片/Screenshots
cp -r Wallpapers/* ~/图片/Wallpapers/
chmod +x ~/.config/niri/scripts/* ~/.config/waybar/scripts/* \
        ~/.config/fuzzel/scripts/* ~/.local/bin/*
```

#### 6. Start niri

Select **Niri** from your display manager, or run:
```bash
niri-session
```

### Arch
```bash
sudo pacman -S niri waybar fuzzel mako kitty swaylock swayidle swayosd \
  brightnessctl fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-rime \
  waypaper swaybg cliphist wl-clipboard grim slurp satty \
  noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-jetbrains-mono \
  ttf-jetbrains-mono-nerd bat eza fish starship zoxide jq fastfetch btop \
  gdu imagemagick pavucontrol gnome-keyring fzf xorg-xwayland \
  qt5-wayland qt6-wayland xdg-terminal-exec breeze-cursor-theme \
  xorg-xprop firefox libnotify pipewire-pulse playerctl python \
  network-manager-applet ddcutil power-profiles-daemon bluez bluez-utils \
  upower thunar thunar-archive-plugin thunar-volman file-roller \
  gvfs gvfs-smb gvfs-mtp tumbler ffmpegthumbnailer webp-pixbuf-loader \
  sound-theme-freedesktop
```

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

## Notes

### Lock Screen
`swaylock -f -i ~/图片/111046153_p0.jpg` — change the wallpaper path to match yours. Fallback: `swaylock -f -c 1e1e2e`.

### swayidle not starting?
- Use `spawn-sh-at-startup` for tilde paths, or absolute paths.
- Auto-start commands only run on niri startup, not config reload.
- Make scripts executable: `chmod +x ~/.config/niri/scripts/*.sh`

### polkit
On Fedora, install `polkit-kde` instead of `polkit-gnome`. The config spawns both; the missing one silently fails.

### Distro Compatibility
All scripts have been made distro-agnostic where possible. The `custom/actions` and `custom/updates` waybar modules have been removed from the layout as they contained Arch-specific logic. The `apt.fish` fish function now auto-detects your package manager (dnf, apt, pacman, zypper, xbps).

### Credits
- Original [Shorin Niri](https://github.com/SHORiN-KiWATA/shorin-niri) by [SHORiN-KiWATA](https://github.com/SHORiN-KiWATA)
- [Niri](https://github.com/YaLTeR/niri) — the scrolling tiling Wayland compositor
- Slim edition adapted for cross-distro low-resource use
