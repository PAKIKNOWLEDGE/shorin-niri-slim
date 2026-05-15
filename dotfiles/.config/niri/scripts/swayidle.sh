#!/usr/bin/env bash

# swayidle: 闲置锁屏 + 合盖/休眠前自动锁屏
exec swayidle -w \
    timeout 900  'swaylock -f -i ~/图片/111046153_p0.jpg &' \
    timeout 1800 'niri msg action power-off-monitors' \
    resume       'niri msg action power-on-monitors' \
    timeout 3600 'systemctl suspend' \
    before-sleep 'swaylock -f -i ~/图片/111046153_p0.jpg'
