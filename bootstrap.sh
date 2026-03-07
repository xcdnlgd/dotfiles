#!/bin/bash
set -x

create_symlink() {
    local src="$1"
    local dest="$2"

    mkdir -p "$(dirname "$dest")"
    ln -sf "$src" "$dest"
}

scan_and_link() {
    local source_dir="$1"
    local target_dir="$2"

    for item in "$source_dir"/*; do
        if [ -e "$item" ]; then
            local base_name=$(basename "$item")
            local new_source="$source_dir/$base_name"
            local new_target="$target_dir/$base_name"

            if [ -d "$new_source" ]; then
                scan_and_link "$new_source" "$new_target"
            elif [ -f "$new_source" ]; then
                create_symlink "$new_source" "$new_target"
            fi
        fi
    done
}

scan_and_link "$PWD/.config" "$HOME/.config"
scan_and_link "$PWD/.local" "$HOME/.local"

ln -sf $PWD/.tmux.conf $HOME
ln -sf $PWD/.clang-format $HOME

mkdir -p $HOME/scripts
echo 'source ~/scripts/zshrc.zsh' > $HOME/.zshrc
ln -sf $PWD/scripts/zshrc.zsh $HOME/scripts

mkdir -p $HOME/.cargo
ln -sf $PWD/.cargo/config.toml $HOME/.cargo

pushd $HOME/.config/yazi
ya pkg install
popd
