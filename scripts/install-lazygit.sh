#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}")/.. && pwd)

echo "Installing Lazygit configuration..."

rm -rf $HOME/.config/lazygit
mkdir -p $HOME/.config/lazygit
ln -s $DOTFILES/lazygit/config.yml $HOME/.config/lazygit/config.yml

echo "Lazygit configuration installed successfully!"
