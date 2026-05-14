if status is-interactive
    # Commands to run in interactive sessions can go here
end

# 关闭欢迎语
set fish_greeting ""
# 优先加载本地 bin
set -p PATH ~/.local/bin

# starship 提示符
starship init fish | source
# zoxide 智能跳转
zoxide init fish --cmd cd | source

# yazi 退出后自动 cd 到浏览目录
function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

# bat 代替 cat
function cat
	command bat $argv
end

# eza 代替 ls
function ls
	command eza --icons $argv
end
function lt
	command eza --icons --tree $argv
end

# 便捷缩写
abbr fa fastfetch
abbr reboot 'systemctl reboot'
