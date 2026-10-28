#!/bin/bash
set -ex

cp ./90-custom-keyboard.hwdb /etc/udev/hwdb.d/
systemd-hwdb update

# Hide the phantom "System Control" joystick exposed by the NuPhy Air75 V2
cp ./71-nuphy-air75-system-control.rules /etc/udev/rules.d/
udevadm control --reload-rules
udevadm trigger --subsystem-match=input --action=change
udevadm settle

# The rule drops the uaccess tag, but an ACL granted earlier in this boot is
# not revoked automatically, so drop it explicitly.
for name in /sys/class/input/event*/device/name; do
    [ -e "$name" ] || continue
    if [ "$(cat "$name")" = "NuPhy NuPhy Air75 V2 System Control" ]; then
        setfacl -b "/dev/input/$(basename "$(dirname "$(dirname "$name")")")"
    fi
done
