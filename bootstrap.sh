#!/usr/bin/env sh
set -x

mkdir -p $HOME/.config
mkdir -p $HOME/scripts

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s $PWD/.tmux.conf $HOME
ln -s $PWD/.config/starship.toml $HOME/.config
echo 'source ~/scripts/zshrc.zsh' > $HOME/.zshrc
ln -s $PWD/scripts/zshrc.zsh $HOME/scripts
