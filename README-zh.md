# Shorin Niri Slim — 极简版

[Shorin Niri](https://github.com/SHORiN-KiWATA/shorin-niri) 桌面配置的**轻量精简版**，适用于 Fedora、Arch 及任何现代 Linux 发行版。

仅保留**核心刚需组件**——无自研扩展、无背景模糊、无动态配色引擎、无常驻守护进程。在低配硬件上流畅运行，同时保留圆角、微透明和统一配色的清爽外观。

---

## 与原版的差异

| 方面 | 原版 | Slim |
|------|------|------|
| **动画** | 弹簧物理（有回弹） | 简单时长 + ease-out |
| **背景模糊** | 3 次采样 + xray | 已禁用 |
| **动态配色** | matugen 引擎 | 静态硬编码配色 |
| **壁纸** | awww（常驻守护） | waypaper + swaybg |
| **锁屏** | hyprlock（模糊 + 动画） | swaylock — 单一二进制 |
| **自研扩展** | niri-sidebar, niriusd, linuxqq-clipsync | 已移除 |
| **自启进程** | 16+ 守护进程 | 仅 8 个核心 |
| **脚本** | 10+ 自定义脚本 | 保留 4 个 |
| **Waybar 主题** | 双主题 | 单一默认 |
| **快捷键** | 含扩展热键 | 干净 — 仅核心操作 |
| **硬件目标** | 现代桌面 | 低配 / 核显友好 |

完整的快捷键布局、窗口规则、工作区逻辑和视觉设计**均完整保留**。

---

## 相对原 Slim 版的改动（跨发行版适配）

| 改动 | 原因 |
|------|------|
| 彻底删除 `waybar-niri-Win11Like` 主题 | Win11 配 niri？一个清爽主题就够了 |
| 新增 `custom/colorize` waybar 按钮 + `Mod+Ctrl+F10` | 手动取色刷新全部配色 |
| 移除 waybar 布局中的 `custom/actions` | `command-center.sh` 仅支持 Arch → 替换为空桩 |
| 移除 waybar 布局中的 `custom/updates` | `check-updates.sh` 仅支持 Arch → 替换为空桩 |
| `apt.fish` → 通用包管理器包装器 | 旧版只认 Arch；现在自动检测 dnf/apt/pacman/zypper/xbps |
| `fastfetch` 徽标 → `type: "small"` | 无图片源时 ASCII 在 X250 上太大 |
| fish 配置添加 `~/.cargo/bin` 到 `$PATH` | 确保 cargo 安装的工具能被找到 |
| `polkit-kde` 替代 polkit-gnome | Fedora 已移除 polkit-gnome |
| `xorg-xwayland` → `xorg-x11-server-Xwayland` | Fedora 44+ 包名变更 |
| `xorg-xprop` → `xprop` | Fedora 44+ 包名变更 |
| 新增 `phynecs/swayosd` COPR | swayosd 不在 Fedora 官方源 |
| waybar style.css 更新 | `#custom-actions` 替换为 `#custom-colorize` |
| 壁纸后端确认为 `swaybg` | 无常驻守护进程 |

---

## 依赖包

### 核心
```
niri waybar fuzzel mako kitty swaylock swayidle swayosd brightnessctl
NetworkManager-tui  # nmtui，WiFi 配置工具
polkit-kde          # Fedora 请用 polkit-kde，不要用 polkit-gnome
xdg-desktop-portal-gnome
```

### 输入法
```
fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-rime
rime-ice（手动安装）
```

### 壁纸
```
waypaper swaybg
```

### 剪贴板
```
cliphist wl-clipboard
```

### 截图
```
grim slurp satty
```

### 文件管理器（可选）
```
thunar thunar-archive-plugin thunar-volman file-roller
gvfs-smb gvfs-mtp tumbler ffmpegthumbnailer webp-pixbuf-loader
```

### 字体
```
google-noto-sans-fonts google-noto-cjk-fonts google-noto-emoji-fonts
jetbrains-mono-fonts
```
**必装：** JetBrainsMono Nerd Font（waybar 图标需要）— 从 [nerdfonts.com](https://www.nerdfonts.com/fonts) 下载

### 工具类
```
bat eza fish starship zoxide jq fastfetch btop gdu
ImageMagick pavucontrol gnome-keyring fzf
```

### 显示 & 光标
```
xorg-x11-server-Xwayland qt5-qtwayland qt6-qtwayland xdg-terminal-exec
breeze-cursor-theme xprop
```

### 音频 & 蓝牙
```
pipewire-pulseaudio playerctl bluez bluez-tools power-profiles-daemon
```

### 浏览器
```
firefox
```

---

## 安装步骤

### Fedora（个人经验）

> 以下步骤基于我在 Fedora 44（X250 ThinkPad）上的实际安装过程。
> 大部分包在 Fedora 官方源里，部分需要第三方源。

#### 1. 启用额外源
```bash
sudo dnf install -y \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf copr enable -y yalter/niri       # niri 窗口管理器
sudo dnf copr enable -y phynecs/swayosd   # OSD 提示
```

#### 2. 安装 DNF 包

**注意：** `--allowerasing` 是因为 `power-profiles-daemon` 和 `tuned-ppd` 冲突。
waypaper、satty、starship 不在 DNF 源里，后面单独装。

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

#### 3. 不在 DNF 源里的包

```bash
# waypaper（Python）
pip install waypaper --user

# starship（跨发行版安装脚本）
curl -sS https://starship.rs/install.sh | sh

# satty — 从 GitHub Release 下二进制
SATTY_VER=$(curl -s https://api.github.com/repos/gabm/satty/releases/latest | grep tag_name | cut -d'"' -f4)
wget -P /tmp "https://github.com/gabm/satty/releases/download/${SATTY_VER}/satty-${SATTY_VER}-x86_64-unknown-linux-gnu.tar.gz"
tar -xzf /tmp/satty-*.tar.gz -C /tmp
sudo cp /tmp/satty-*/satty /usr/local/bin/

# cava — 编译安装
sudo dnf install -y gcc-c++ make automake autoconf libtool \
  alsa-lib-devel pulseaudio-libs-devel fftw-devel iniparser-devel
git clone https://github.com/karlstav/cava.git /tmp/cava
cd /tmp/cava && ./autogen.sh && ./configure && make -j$(nproc) && sudo make install

# matugen — 取色工具
cargo install matugen
```

#### 4. JetBrainsMono Nerd Font（waybar 图标）

```bash
wget -P /tmp https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
sudo mkdir -p /usr/share/fonts/JetBrainsMonoNerd
sudo unzip /tmp/JetBrainsMono.zip -d /usr/share/fonts/JetBrainsMonoNerd/
sudo fc-cache -fv
```

#### 5. 部署配置

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

#### 6. 启动 niri

在显示管理器选择 **Niri**，或直接运行：
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

## 快捷键速查

在 Niri 中按 **`Mod+Shift+/`** 显示完整快捷键列表。

| 按键 | 功能 |
|------|------|
| `Mod+Enter` | 终端（kitty） |
| `Mod+Space` | 应用启动器（fuzzel） |
| `Mod+Q` | 关闭窗口 |
| `Mod+H/L` / `←/→` | 左右切换列聚焦 |
| `Mod+J/K` / `↑/↓` | 上下切换窗口聚焦 |
| `Mod+Ctrl+H/L` | 左右移动列 |
| `Mod+1-9` | 切换工作区 |
| `Mod+F` | 最大化列 |
| `Mod+V` | 切换浮动 |
| `Mod+R` | 循环切换列宽 |
| `Mod+Tab` | 快速窗口切换 |
| `Alt+Tab` | 内置缩略图切换器 |
| `Mod+Shift+E` | 退出 niri |
| `Mod+Alt+L` | 锁屏 |
| `Mod+Shift+P` | 电源菜单 |
| `Mod+F10` | 随机壁纸 |
| `Mod+Ctrl+F10` | 取色刷新配色 |
| `Print` | 截图 |
| `Mod+Alt+V` | 剪贴板历史 |
| `Mod+F1` | 开关 fcitx5 |

---

## 注意事项

### 锁屏
`swaylock -f -i ~/图片/111046153_p0.jpg` — 把壁纸路径改成你的。备用：`swaylock -f -c 1e1e2e`。

### swayidle 没启动？
- `spawn-at-startup` 不会展开 `~`，要用 `spawn-sh-at-startup` 或者写绝对路径。
- 自动启动只在 niri 启动时执行，热重载不生效。
- 确保脚本可执行：`chmod +x ~/.config/niri/scripts/*.sh`

### polkit
Fedora 已移除 `polkit-gnome`，请装 `polkit-kde`。配置里两个路径都写了，不存在的那个会静默失败。

### 发行版兼容性
所有脚本已尽可能去除发行版专属逻辑。waybar 的 `custom/actions` 和 `custom/updates` 模块因包含 Arch 专属内容已从布局中移除。`apt.fish` 现在会自动检测系统包管理器（dnf、apt、pacman、zypper、xbps）。

### 取色
点击 waybar 的 `[󰏘]` 按钮或按 `Mod+Ctrl+F10`，matugen 会根据当前壁纸重新生成全套配色（waybar、niri、kitty、mako 等）。需要先安装 matugen（`cargo install matugen`）。

### 致谢
- 原版 [Shorin Niri](https://github.com/SHORiN-KiWATA/shorin-niri) 作者 [SHORiN-KiWATA](https://github.com/SHORiN-KiWATA)
- [Niri](https://github.com/YaLTeR/niri) — 滚动平铺 Wayland 窗口管理器
- Slim 版适配跨发行版低资源使用
