#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}")/.. && pwd)
SHELL_CHOICE="${1:-fish}"

echo "Installing Ghostty configuration..."

rm -rf $HOME/.config/ghostty
mkdir -p $HOME/.config/ghostty/themes
ln -s $DOTFILES/ghostty/themes/catppuccin-mocha.conf $HOME/.config/ghostty/themes/catppuccin-mocha.conf

# Generate config with correct shell-integration for chosen shell
sed "s/^shell-integration = .*/shell-integration = $SHELL_CHOICE/" \
    $DOTFILES/ghostty/config > $HOME/.config/ghostty/config

echo "Ghostty configuration installed (shell-integration=$SHELL_CHOICE)!"
