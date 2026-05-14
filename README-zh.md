# Shorin Niri — 精简版

[Shorin Niri](https://github.com/SHORiN-KiWATA/shorin-niri) 桌面配置的**轻量低配友好**移植版，迁移至 **Fedora**（也适用于其他现代 Linux 发行版，只需少量调整）。

本分支移除了自研扩展、非必需守护进程和高负载视觉效果，在低端硬件上提供流畅的 Niri 体验。

---

## 与原版的差异

| 方面 | 原版 | 本版 |
|------|------|------|
| **动画** | 低阻尼弹簧（有回弹） | 高阻尼、低刚度 — 更快、渲染开销更低 |
| **背景模糊** | 3 次采样，大偏移 | 1 次采样，最小偏移 |
| **窗口阴影** | 柔度 20，扩展 2 | 柔度 12，扩展 1 |
| **锁屏模糊** | blur_size 5, passes 4 | blur_size 3, passes 2 |
| **自研扩展** | niri-sidebar, niriusd, linuxqq-clipsync | **已移除** — 全部自研扩展均已剥离 |
| **自启进程** | 16+ 个守护进程 | 仅保留 11 个核心进程 |
| **快捷键** | 包含扩展热键 | 干净 — 仅保留核心 Niri 操作 |
| **硬件目标** | 现代桌面 / 笔记本 | **低配 / 集成显卡友好** |

完整的快捷键布局、窗口规则、工作区逻辑和基础视觉设计**均完整保留**。

---

## 依赖包

### COPR 软件源

```bash
# Niri 窗口管理器
sudo dnf copr enable erikreider/niri

# Hyprlock (锁屏)
sudo dnf copr enable solopasha/hyprlock

# Waybar (任务栏最新版)
sudo dnf copr enable erikreider/waybar
```

### 核心运行时

```bash
# 窗口管理器 & 桌面 Portal
sudo dnf install niri xdg-desktop-portal-gnome xdg-desktop-portal-gtk xdg-terminal-exec

# 状态栏、启动器、通知、OSD
sudo dnf install waybar fuzzel mako libnotify swayosd brightnessctl

# 壁纸守护 & 颜色生成
# awww:    https://github.com/TH0R5T3N/awww (源码编译)
# matugen: https://github.com/InioX/matugen (源码编译)
# waypaper:sudo dnf install waypaper (或 pip install waypaper)
```

### 显示 & 会话

```bash
sudo dnf install xorg-xwayland qt5-qtwayland qt6-qtwayland
```

### 输入法 (fcitx5)

```bash
sudo dnf install fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-rime
# Rime 词库:
#   rime-ice: https://github.com/iDvel/rime-ice (克隆到 ~/.local/share/fcitx5/rime)
#   rime-llm-translator: https://github.com/SHORiN-KiWATA/rime-llm-translator
```

### 文件管理器 & 缩略图

```bash
sudo dnf install thunar thunar-archive-plugin thunar-volman file-roller \
  gvfs-smb gvfs-mtp gvfs-gphoto2 \
  tumbler poppler-glib ffmpegthumbnailer webp-pixbuf-loader libgsf
```

### 剪贴板

```bash
sudo dnf install cliphist wl-clipboard
```

### 终端

```bash
sudo dnf install kitty
```

### 字体

```bash
sudo dnf install google-noto-fonts google-noto-cjk-fonts google-noto-emoji-fonts \
  jetbrains-mono-fonts
# Nerd Font 变体: 从以下地址手动下载 JetBrainsMono Nerd Font:
#   https://www.nerdfonts.com/fonts
```

### 工具类

```bash
sudo dnf install ImageMagick bat eza fish starship zoxide jq fastfetch btop gdu \
  chafa timg strace pavucontrol gnome-keyring polkit-gnome
```

### 截图 & 录屏

```bash
sudo dnf install grim slurp satty wf-recorder wl-screenrec
```

### 锁屏

```bash
sudo dnf install hyprlock swayidle
```

### 光标主题

```bash
sudo dnf install breeze-cursor-theme
```

### 浏览器

```bash
sudo dnf install firefox
```

### 一键安装（核心包）

```bash
sudo dnf install niri xdg-desktop-portal-gnome waybar fuzzel mako kitty \
  thunar file-roller cliphist wl-clipboard fcitx5 fcitx5-configtool \
  fcitx5-gtk fcitx5-qt fcitx5-rime grim slurp hyprlock swayidle \
  polkit-gnome ImageMagick bat fish starship jq fastfetch btop pavucontrol \
  google-noto-fonts google-noto-emoji-fonts jetbrains-mono-fonts \
  breeze-cursor-theme brightnessctl firefox
```

---

## 安装步骤

### 1. 安装所有依赖（见上方各章节）

### 2. 克隆并部署配置

```bash
git clone https://github.com/YOUR_USER/shorin-niri.git ~/shorin-niri
cd ~/shorin-niri

# 将配置文件部署到家目录
cp -r dotfiles/.config/* ~/.config/
cp -r dotfiles/.local/* ~/.local/

# 部署壁纸
mkdir -p ~/Pictures/Wallpapers
cp -r Wallpapers/* ~/Pictures/Wallpapers/
```

### 3. 启动会话

在显示管理器（SDDM、GDM 等）中选择 **Niri**，或手动启动：

```bash
niri-session
```

> **Fedora / 非 Arch 用户注意：**  
> 原版的 `shorinniri` CLI 工具（init/update/remove）是 Arch AUR 辅助脚本，**此处不使用**。在 Fedora 和其他发行版上，直接按上方步骤复制配置文件即可。本仓库中的 `shorinniri` 脚本仅作为参考。

---

## 安装后配置

- **壁纸**：`waypaper --random` 或按 `Mod+F10`
- **输入法**：首次登录后重启 fcitx5（`Mod+F1`）
- **配色方案**：运行 `matugen image ~/Pictures/Wallpapers/your-wallpaper.jpg` 然后 `~/.config/scripts/matugen-update.sh`
- **显示器配置**：编辑 `~/.config/niri/output.kdl` 以匹配你的显示器

---

## 快捷键速查

在 Niri 中按 **`Mod+Shift+/`**（Super + Shift + /）可显示完整快捷键表。

| 分类 | 按键 | 功能 |
|------|------|------|
| 聚焦 | `Mod+H/L` / `Mod+←/→` | 向左/右切换列 |
| 聚焦 | `Mod+J/K` / `Mod+↑/↓` | 向上/下切换窗口 |
| 移动 | `Mod+Ctrl+H/L` | 向左/右移动列 |
| 移动 | `Mod+Ctrl+J/K` | 向上/下移动窗口 |
| 工作区 | `Mod+1-9` | 切换到指定工作区 |
| 工作区 | `Mod+U/I` / `Mod+PageUp/Down` | 上/下一个工作区 |
| 布局 | `Mod+R` | 循环切换列宽（1/3 — 1/2 — 2/3） |
| 布局 | `Mod+F` | 最大化列 |
| 布局 | `Mod+V` | 切换浮动模式 |
| 布局 | `Mod+X` | 切换标签页模式 |
| 布局 | `Mod+Q` | 关闭窗口 |
| 布局 | `Alt+F4` | 强制杀死窗口 |
| 多显示器 | `Mod+Shift+H/L` | 向左/右切换显示器 |
| 多显示器 | `Mod+Shift+Alt+W/S/A/D` | 移动工作区到显示器 |
| 截图 | `Print` | 选区截图 |
| 锁屏 | `Mod+Alt+L` | 锁屏 |
| 电源 | `Mod+Shift+P` | 电源菜单（锁屏/休眠/重启/关机） |
| 终端 | `Mod+T` | Kitty 终端（共享实例） |
| 启动器 | `Mod+Z` | Fuzzel 应用启动器 |
| 剪贴板 | `Mod+Alt+V` | 剪贴板历史 |
| 壁纸 | `Mod+F10` | 随机切换壁纸 |

---

## 致谢

- 原版 Shorin Niri 作者 [SHORiN-KiWATA](https://github.com/SHORiN-KiWATA)
- [Niri](https://github.com/YaLTeR/niri) — 滚动平铺 Wayland 窗口管理器
- 本精简版适配 Fedora 及低资源硬件
