# ==============================================================================
# Function: apt (Universal Package Manager Wrapper for Fish)
# Description: Routes common 'apt' commands to the system's native package
#              manager. Supports dnf (Fedora/RHEL), apt-get (Debian/Ubuntu),
#              pacman (Arch), zypper (openSUSE), and xbps (Void).
# ==============================================================================

function apt -d "Universal wrapper: routes apt commands to native pkg manager"
    set -l is_zh 0
    if string match -q -r "^zh_" "$LC_ALL" "$LC_MESSAGES" "$LANG"
        set is_zh 1
    end

    # --- Detect native package manager ---
    set -l pm
    set -l pm_update
    set -l pm_install
    set -l pm_remove
    set -l pm_search
    set -l pm_show
    set -l pm_clean
    set -l needs_sudo "yes"

    if command -q dnf
        set pm dnf
        set pm_update "dnf upgrade"
        set pm_install "dnf install"
        set pm_remove "dnf remove"
        set pm_search "dnf search"
        set pm_show "dnf info"
        set pm_clean "dnf clean all"
    else if command -q apt-get
        set pm apt-get
        set pm_update "apt-get update && apt-get upgrade"
        set pm_install "apt-get install"
        set pm_remove "apt-get remove"
        set pm_search "apt-cache search"
        set pm_show "apt-cache show"
        set pm_clean "apt-get clean"
    else if command -q pacman
        set pm pacman
        set pm_update "pacman -Syu"
        set pm_install "pacman -S"
        set pm_remove "pacman -Rns"
        set pm_search "pacman -Ss"
        set pm_show "pacman -Si"
        set pm_clean "pacman -Sc"
    else if command -q zypper
        set pm zypper
        set pm_update "zypper update"
        set pm_install "zypper install"
        set pm_remove "zypper remove"
        set pm_search "zypper search"
        set pm_show "zypper info"
        set pm_clean "zypper clean"
    else if command -q xbps-install
        set pm xbps
        set pm_update "xbps-install -Su"
        set pm_install "xbps-install"
        set pm_remove "xbps-remove -R"
        set pm_search "xbps-query -Rs"
        set pm_show "xbps-query -Rs"
        set pm_clean "xbps-remove -O"
    else
        if test $is_zh -eq 1
            echo "错误：未检测到支持的包管理器 (dnf/apt/pacman/zypper/xbps)"
        else
            echo "Error: No supported package manager found (dnf/apt/pacman/zypper/xbps)"
        end
        return 1
    end

    # --- Parse action ---
    if test (count $argv) -eq 0
        if test $is_zh -eq 1
            echo "用法: apt {update|install|remove|search|show|clean|help} [包名...]"
            echo "检测到包管理器: $pm"
        else
            echo "Usage: apt {update|install|remove|search|show|clean|help} [package...]"
            echo "Detected: $pm"
        end
        return 1
    end

    set -l action $argv[1]
    set -e argv[1]

    switch $action
        case help -h --help
            if test $is_zh -eq 1
                echo "通用包管理器包装器 (检测到: $pm)"
                echo "用法: apt <命令> [包名...]"
                echo ""
                echo "命令:"
                echo "  update       更新软件包"
                echo "  install      安装软件包"
                echo "  remove       卸载软件包"
                echo "  search       搜索软件包"
                echo "  show         显示软件包信息"
                echo "  clean        清理缓存"
                echo "  help         显示此帮助"
            else
                echo "Universal package manager wrapper (detected: $pm)"
                echo "Usage: apt <command> [package...]"
                echo ""
                echo "Commands:"
                echo "  update       Update packages"
                echo "  install      Install packages"
                echo "  remove       Remove packages"
                echo "  search       Search packages"
                echo "  show         Show package info"
                echo "  clean        Clean cache"
                echo "  help         Show this help"
            end

        case update upgrade
            if test "$needs_sudo" = "yes"
                sudo $pm_update
            else
                $pm_update
            end

        case install
            if test (count $argv) -eq 0
                if test $is_zh -eq 1
                    echo "错误：请指定要安装的软件包。"
                else
                    echo "Error: Specify packages to install."
                end
                return 1
            end
            if test "$needs_sudo" = "yes"
                sudo $pm_install $argv
            else
                $pm_install $argv
            end

        case remove
            if test (count $argv) -eq 0
                if test $is_zh -eq 1
                    echo "错误：请指定要卸载的软件包。"
                else
                    echo "Error: Specify packages to remove."
                end
                return 1
            end
            if test "$needs_sudo" = "yes"
                sudo $pm_remove $argv
            else
                $pm_remove $argv
            end

        case search
            if test (count $argv) -eq 0
                if test $is_zh -eq 1
                    echo "错误：请指定搜索词。"
                else
                    echo "Error: Specify search term."
                end
                return 1
            end
            $pm_search $argv

        case show
            if test (count $argv) -eq 0
                if test $is_zh -eq 1
                    echo "错误：请指定要查看的软件包。"
                else
                    echo "Error: Specify package to show."
                end
                return 1
            end
            $pm_show $argv

        case clean
            if test "$needs_sudo" = "yes"
                sudo $pm_clean
            else
                $pm_clean
            end

        case '*'
            if test $is_zh -eq 1
                echo "错误：不支持的命令: $action"
                echo "运行 'apt help' 查看可用命令。"
            else
                echo "Error: Unknown command: $action"
                echo "Run 'apt help' for valid commands."
            end
            return 1
    end
end
