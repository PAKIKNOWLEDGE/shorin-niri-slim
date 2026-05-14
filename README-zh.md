# Shorin Niri Slim — 极简版

[Shorin Niri](https://github.com/SHORiN-KiWATA/shorin-niri) 桌面配置的**轻量精简版**，迁移至 **Fedora**，也适用于任何现代 Linux 发行版。

本版本仅保留**核心刚需组件**——无自研扩展、无守护进程、无动态配色引擎、无背景模糊、无花哨动画。专为**低配硬件**和追求**稳定低占用**的用户设计，同时保留圆角、微透明和统一配色的清爽外观。

---

## 与原版的差异

| 方面 | 原版 | 本版 |
|------|------|------|
| **动画** | 弹簧物理（有回弹） | 简单时长 + 线性曲线 — GPU 影响极小 |
| **背景模糊** | 3 次采样 + xray | **已禁用** — 零 GPU 开销 |
| **动态配色** | matugen 引擎（随壁纸自动生成） | **静态硬编码配色** — 无运行时依赖 |
| **壁纸守护** | awww（常驻后台进程） | **waypaper + swaybg** — 无常驻进程，换壁纸时才运行 |
| **锁屏** | hyprlock（模糊 + 动画 + 配置解析） | **swaylock** — 单一二进制，极致轻量 |
| **自研扩展** | niri-sidebar, niriusd, linuxqq-clipsync | **已移除** |
| **自启进程** | 16+ 守护进程 | **仅 8 个核心进程** |
| **快捷键** | 包含扩展和主题切换热键 | **干净** — 仅保留核心 Niri 操作 |
| **脚本** | 10+ 自定义脚本 | **保留 4 个** — 快捷键帮助、强杀窗口、窗口切换、电源菜单 |
| **Waybar 主题** | 双主题（默认 + Win11 风格） | **单一默认** |
| **硬件目标** | 现代桌面 / 笔记本 | **低配 / 集成显卡友好** |

完整的快捷键布局、窗口规则、工作区逻辑和基础视觉设计**均完整保留**。

---

## 依赖包

### 核心运行时

```
niri              — 滚动平铺 Wayland 窗口管理器
waybar            — 状态栏
fuzzel            — 应用启动器
mako              — 通知守护
kitty             — 终端模拟器
swaylock          — 锁屏
swayidle          — 闲置管理守护
swayosd           — 屏幕显示（音量、亮度）
brightnessctl     — 背光控制
polkit-gnome      — 权限认证代理
xdg-desktop-portal-gnome  — 文件选择器 / 屏幕共享 portal
```

### 输入法

```
fcitx5            — 输入法框架
fcitx5-configtool — 配置工具
fcitx5-gtk        — GTK 前端
fcitx5-qt         — Qt 前端
fcitx5-rime       — Rime 引擎
rime-ice          — Rime 词库数据（需手动安装）
```

### 壁纸

```
waypaper          — 壁纸管理前端（使用 swaybg 后端）
```

### 剪贴板

```
cliphist          — 剪贴板历史管理
wl-clipboard      — wl-copy / wl-paste
```

### 截图

```
grim              — 截图工具
slurp             — 区域选择
```

### 文件管理器 & 缩略图（可选）

```
thunar            — 文件管理器
thunar-archive-plugin
thunar-volman
file-roller       — 压缩包管理器
gvfs-smb          — SMB 支持
gvfs-mtp          — MTP（手机）支持
tumbler           — 缩略图服务
poppler-glib      — PDF 缩略图
ffmpegthumbnailer — 视频缩略图
```

### 字体

```
google-noto-fonts
google-noto-cjk-fonts
google-noto-emoji-fonts
jetbrains-mono-fonts
```

waybar 图标需要 Nerd Font，请从 [nerdfonts.com](https://www.nerdfonts.com/fonts) 下载 **JetBrainsMono Nerd Font**。

### 工具类

```
bat               — 更好的 cat
eza               — 更好的 ls
fish              — shell
starship          — 提示符
zoxide            — 智能 cd
jq                — JSON 处理器
fastfetch         — 系统信息
btop              — 系统监视器
gdu               — 磁盘分析
ImageMagick       — 图片处理
pavucontrol       — 音频控制
gnome-keyring     — 凭据存储
```

### 显示 & 会话

```
xorg-xwayland     — X11 应用支持
qt5-qtwayland     — Qt5 Wayland 支持
qt6-qtwayland     — Qt6 Wayland 支持
xdg-terminal-exec — 默认终端解析器
```

### 光标

```
breeze-cursor-theme
```

### 浏览器

```
firefox
```

---

## 安装步骤

### 1. 使用你的系统包管理器安装以上依赖

Fedora：
```
sudo dnf install niri waybar fuzzel mako kitty swaylock swayidle swayosd ...
```

Arch：
```
sudo pacman -S niri waybar fuzzel mako kitty swaylock swayidle ...
```

### 2. 克隆并部署配置

```bash
git clone <本仓库地址> ~/shorin-niri
cd ~/shorin-niri

cp -r dotfiles/.config/* ~/.config/
cp -r dotfiles/.local/* ~/.local/
mkdir -p ~/Pictures/Wallpapers
cp -r Wallpapers/* ~/Pictures/Wallpapers/
```

### 3. 配置 waypaper 使用 swaybg 后端

编辑 `~/.config/waypaper/config.ini`：

```ini
[Settings]
backend = swaybg
```

### 4. 启动会话

在显示管理器（SDDM、GDM 等）中选择 **Niri**，或手动运行：

```bash
niri-session
```

> 原版的 `shorinniri` CLI 工具（init/update/remove）**本版已移除**，直接复制配置文件即可。

---

## 安装后配置

- **壁纸**：`Mod+Alt+W` 打开 waypaper 选择器，或 `Mod+F10` 随机切换
- **锁屏**：`Mod+Alt+L`（使用 swaylock，深色背景）
- **输入法**：若需重启 fcitx5，按 `Mod+F1`
- **显示器**：编辑 `~/.config/niri/output.kdl` 匹配你的屏幕

---

## 快捷键速查

在 Niri 中按 **`Mod+Shift+/`** 显示完整快捷键帮助。

| 分类 | 按键 | 功能 |
|------|------|------|
| 聚焦 | `Mod+H/L` / `Mod+←/→` | 向左/右切换列 |
| 聚焦 | `Mod+J/K` / `Mod+↑/↓` | 向上/下切换窗口 |
| 聚焦 | `Mod+A/D` | 将窗口移入/移出相邻列 |
| 移动 | `Mod+Ctrl+H/L` | 向左/右移动列 |
| 移动 | `Mod+Ctrl+J/K` | 向上/下移动窗口 |
| 工作区 | `Mod+1-9` | 切换到指定工作区 |
| 工作区 | `Mod+U/I` | 上/下一个工作区 |
| 布局 | `Mod+R` | 循环切换列宽 |
| 布局 | `Mod+F` | 最大化列 |
| 布局 | `Mod+V` | 切换浮动模式 |
| 布局 | `Mod+X` | 切换标签页模式 |
| 布局 | `Mod+Q` | 关闭窗口 |
| 布局 | `Alt+F4` | 强制杀死窗口 |
| 多显示器 | `Mod+Shift+H/L` | 切换相邻显示器 |
| 多显示器 | `Mod+Shift+Alt+W/S/A/D` | 移动工作区到指定显示器 |
| 截图 | `Print` | 选区截图 |
| 锁屏 | `Mod+Alt+L` | 锁屏 |
| 电源 | `Mod+Shift+P` | 电源菜单 |
| 终端 | `Mod+T` | Kitty（共享实例） |
| 启动器 | `Mod+Z` | Fuzzel 应用启动器 |
| 剪贴板 | `Mod+Alt+V` | 剪贴板历史 |
| 壁纸 | `Mod+F10` | 随机切换壁纸 |
| 帮助 | `Mod+Shift+/` | 显示所有快捷键 |

---

## 致谢

- 原版 Shorin Niri 作者 [SHORiN-KiWATA](https://github.com/SHORiN-KiWATA)
- [Niri](https://github.com/YaLTeR/niri) — 滚动平铺 Wayland 窗口管理器
- 本极简版适配低资源硬件及 Fedora
