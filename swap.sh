#!/bin/bash
set -ex

sudo dd if=/dev/zero of=/swapfile bs=1M count=16384 status=progress # 创建 16G 的交换空间（大小 >= 电脑实际运行内存的 60%）
sudo chmod 600 /swapfile # 设置正确的权限
sudo mkswap /swapfile # 格式化 Swap 文件
sudo swapon /swapfile # 挂载 Swap 文件

echo "/swapfile  none  swap  defaults  0 0" | sudo tee -a /etc/fstab
