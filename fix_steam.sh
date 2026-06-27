#!/bin/bash

set -ex

cp /usr/share/applications/steam.desktop ~/.local/share/applications/
sed -i "s/Exec=/Exec=env XMODIFIERS=@im=fcitx LANG=zh_CN.UTF-8 /" ~/.local/share/applications/steam.desktop
