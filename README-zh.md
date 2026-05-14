# Shorin Niri Slim — 极简版

[Shorin Niri](https://github.com/SHORiN-KiWATA/shorin-niri) 桌面配置的**轻量精简版**，适用于 Fedora 及任何现代 Linux 发行版。

仅保留**核心刚需组件**——无自研扩展、无背景模糊、无动态配色引擎、无常驻守护进程。在低配硬件上流畅运行，同时保留圆角、微透明和统一配色的清爽外观。

---

## 与原版的差异

| 方面 | 原版 | Slim |
|------|------|------|
| **动画** | 弹簧物理（有回弹） | 简单时长 + ease-out |
| **背景模糊** | 3 次采样 + xray | **已禁用** |
| **动态配色** | matugen 引擎 | **静态硬编码配色** |
| **壁纸** | awww（常驻守护） | **waypaper + swaybg** |
| **锁屏** | hyprlock | **swaylock** — 单一二进制 |
| **自研扩展** | niri-sidebar, niriusd, linuxqq-clipsync | **已移除** |
| **自启进程** | 16+ 守护进程 | **仅 8 个核心** |
| **脚本** | 10+ 自定义脚本 | **保留 4 个** |
| **Waybar 主题** | 双主题 | **单一默认** |
| **快捷键** | 含扩展热键 | **干净** — 仅核心操作 |
| **硬件目标** | 现代桌面 | **低配 / 核显友好** |

完整的快捷键布局、窗口规则、工作区逻辑和视觉设计**均完整保留**。

---

## 依赖包

### 核心
```
niri waybar fuzzel mako kitty swaylock swayidle swayosd brightnessctl
polkit-gnome xdg-desktop-portal-gnome
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
grim slurp
```

### 文件管理器（可选）
```
thunar thunar-archive-plugin thunar-volman file-roller
gvfs-smb gvfs-mtp tumbler ffmpegthumbnailer webp-pixbuf-loader
```

### 字体
```
google-noto-fonts google-noto-cjk-fonts google-noto-emoji-fonts
jetbrains-mono-fonts
```
waybar 图标需要另外下载 **JetBrainsMono Nerd Font**（[nerdfonts.com](https://www.nerdfonts.com/fonts)）

### 工具类
```
bat eza fish starship zoxide jq fastfetch btop gdu
ImageMagick pavucontrol gnome-keyring
```

### 显示 & 光标
```
xorg-xwayland qt5-qtwayland qt6-qtwayland
xdg-terminal-exec breeze-cursor-theme
```

### 浏览器
```
firefox
```

---

## 安装步骤

### 1. 安装依赖

Fedora：
```
sudo dnf install niri waybar fuzzel mako kitty swaylock swayidle swayosd ...
```
Arch：
```
sudo pacman -S niri waybar fuzzel mako kitty swaylock swayidle ...
```

### 2. 克隆并部署

```bash
git clone <仓库地址> ~/shorin-niri-slim
cd ~/shorin-niri-slim

cp -r dotfiles/.config/* ~/.config/
cp -r dotfiles/.local/* ~/.local/
mkdir -p ~/图片/Wallpapers
cp -r Wallpapers/* ~/图片/Wallpapers/
```

### 3. 配置 waypaper 后端

编辑 `~/.config/waypaper/config.ini`：
```ini
[Settings]
backend = swaybg
```

### 4. 启动 Niri

在显示管理器中选择 **Niri**，或手动运行：
```bash
niri-session
```

> 原版 `shorinniri` CLI **本版已移除**，直接复制配置文件即可。

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
| `Print` | 截图 |
| `Mod+F10` | 随机壁纸 |
| `Mod+Alt+V` | 剪贴板历史 |
| `Mod+F1` | 开关 fcitx5 |

---

## 致谢

- 原版 [Shorin Niri](https://github.com/SHORiN-KiWATA/shorin-niri) 作者 [SHORiN-KiWATA](https://github.com/SHORiN-KiWATA)
- [Niri](https://github.com/YaLTeR/niri) — 滚动平铺 Wayland 窗口管理器
- Slim 版适配低资源硬件
