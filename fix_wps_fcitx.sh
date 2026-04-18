#!/bin/bash

set -ex

sed -i "\$s/^/QT_IM_MODULE=fcitx5 /" "/usr/bin/wps"
sed -i "\$s/^/QT_IM_MODULE=fcitx5 /" "/usr/bin/wpp"
sed -i "\$s/^/QT_IM_MODULE=fcitx5 /" "/usr/bin/et"
sed -i "\$s/^/QT_IM_MODULE=fcitx5 /" "/usr/bin/wpspdf"
