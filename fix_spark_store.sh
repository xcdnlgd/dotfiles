#!/bin/bash

set -ex

cp /usr/share/applications/spark-store.desktop ~/.local/share/applications/
sed -i "s/%u/--ozone-platform-hint=auto --enable-wayland-ime %u/" ~/.local/share/applications/spark-store.desktop
