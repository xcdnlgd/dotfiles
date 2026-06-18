#!/bin/bash

set -ex

cp /usr/share/applications/linuxqq.desktop ~/.local/share/applications/
sed -i "s/%U/--ozone-platform-hint=auto --enable-wayland-ime %U/" ~/.local/share/applications/linuxqq.desktop
