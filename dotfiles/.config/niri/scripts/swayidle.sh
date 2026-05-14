#!/usr/bin/env bash

# swayidle: 15 分钟锁屏，30 分钟熄屏，60 分钟休眠
exec swayidle -w \
timeout 900  'swaylock -f -c 1e1e2e &' \
timeout 1800 'niri msg action power-off-monitors' \
resume       'niri msg action power-on-monitors' \
timeout 3600 'systemctl suspend'