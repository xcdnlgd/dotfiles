#!/bin/bash

set -ex

cp /usr/share/applications/wine.desktop ~/.local/share/applications/
sed -i "s/Exec=/Exec=env LC_ALL=zh_CN.utf8 /" ~/.local/share/applications/wine.desktop
