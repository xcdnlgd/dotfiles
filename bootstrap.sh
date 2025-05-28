#!/bin/bash
set -x

mkdir -p $HOME/.config
mkdir -p $HOME/scripts

ln -s $PWD/.tmux.conf $HOME

ln -s $PWD/.config/starship.toml $HOME/.config

echo 'source ~/scripts/zshrc.zsh' > $HOME/.zshrc
ln -s $PWD/scripts/zshrc.zsh $HOME/scripts

mkdir -p $HOME/.config/yazi
ln -s $PWD/.config/yazi/keymap.toml $HOME/.config/yazi

mkdir -p $HOME/.config/wireplumber/wireplumber.conf.d
ln -s $PWD/.config/wireplumber/wireplumber.conf.d/51-disable-suspension.conf $HOME/.config/wireplumber/wireplumber.conf.d

mkdir -p $HOME/.config/fish
ln -s $PWD/.config/fish/config.fish $HOME/.config/fish

mkdir -p $HOME/.local/share/fcitx5/rime
ln -s $PWD/.local/share/fcitx5/rime/default.custom.yaml $HOME/.local/share/fcitx5/rime
mkdir -p $HOME/.config/environment.d
ln -s $PWD/.config/environment.d/im.conf $HOME/.config/environment.d

mkdir -p $HOME/.config/fontconfig/conf.d/
ln -s $PWD/.config/fontconfig/conf.d/64-language-selector-prefer.conf $HOME/.config/fontconfig/conf.d/

mkdir -p $HOME/.cargo
ln -s $PWD/.cargo/config.toml $HOME/.cargo

mkdir -p $HOME/.config/mpv
ln -s $PWD/.config/mpv/mpv.conf $HOME/.config/mpv

ln -s $PWD/.clang-format $HOME
