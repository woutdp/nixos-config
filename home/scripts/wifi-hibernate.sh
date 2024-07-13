#!/bin/sh
##
## URL: https://community.frame.work/t/responded-arch-hibernation-woes-on-amd-13/45474/65
## FILE: /lib/systemd/system-sleep/archlinux-fw13-amd-radios.sh
##
# grab this from lspci or lshw (driver=$wifi)
wifi="mt7921e"
logger "$0 - radios $1. wifi: $wifi"
if [ "$1" == "pre" ]; then
  rfkill block all
  sleep 1
  [ -n "$wifi" ] && modprobe -r $wifi
fi
if [ "$1" == "post" ]; then
  [ -n "$wifi" ] && modprobe $wifi
  sleep 1
  rfkill unblock all
  systemctl restart NetworkManager.service
fi
