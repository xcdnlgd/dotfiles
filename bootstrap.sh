#!/usr/bin/env sh
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
