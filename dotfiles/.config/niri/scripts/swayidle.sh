#!/usr/bin/env bash

# swayidle: 闲置锁屏 + 合盖/休眠前自动锁屏
exec swayidle -w \
    timeout 900  'swaylock -f -c 1e1e2e &' \
    timeout 1800 'niri msg action power-off-monitors' \
    resume       'niri msg action power-on-monitors' \
    timeout 3600 'systemctl suspend' \
    before-sleep 'swaylock -f -c 1e1e2e'
