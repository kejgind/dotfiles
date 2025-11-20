#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}")/.. && pwd)

echo "Installing Yazi configuration..."

rm -rf $HOME/.config/yazi
mkdir -p $HOME/.config/yazi

# Create symlinks for all Yazi config files
for yazi_config in $DOTFILES/yazi/*; do
    ln -s "$yazi_config" "$HOME/.config/yazi/$(basename $yazi_config)"
done

echo "Yazi configuration installed successfully!"
