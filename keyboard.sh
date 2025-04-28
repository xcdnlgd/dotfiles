#!/bin/bash
set -ex

cp ./90-custom-keyboard.hwdb /etc/udev/hwdb.d/
systemd-hwdb update
