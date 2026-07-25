#!/bin/bash

set -ex

cp /usr/share/applications/xmind.desktop ~/.local/share/applications/
sed -i "s/%U/--ozone-platform-hint=auto --enable-wayland-ime %U/" ~/.local/share/applications/xmind.desktop
