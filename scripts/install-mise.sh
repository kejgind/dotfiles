#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}")/.. && pwd)

echo "Installing mise configuration..."

mkdir -p $HOME/.config/mise
rm -f $HOME/.config/mise/config.toml
ln -s $DOTFILES/mise/config.toml $HOME/.config/mise/config.toml

# Install tools listed in config (node, php, claude, opencode, npm globals...)
if command -v mise &>/dev/null; then
    mise install
else
    echo "  mise not found, skipping tool install (install mise, then run 'mise install')"
fi

echo "mise configuration installed successfully!"
