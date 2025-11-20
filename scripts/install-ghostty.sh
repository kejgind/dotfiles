#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}")/.. && pwd)

echo "Installing Ghostty configuration..."

rm -rf $HOME/.config/ghostty
mkdir -p $HOME/.config/ghostty/themes
ln -s $DOTFILES/ghostty/config $HOME/.config/ghostty/config
ln -s $DOTFILES/ghostty/themes/catppuccin-mocha.conf $HOME/.config/ghostty/themes/catppuccin-mocha.conf

echo "Ghostty configuration installed successfully!"
