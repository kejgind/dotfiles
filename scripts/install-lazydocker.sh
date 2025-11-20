#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}")/.. && pwd)

echo "Installing Lazydocker configuration..."

rm -rf $HOME/.config/lazydocker
mkdir -p $HOME/.config/lazydocker
ln -s $DOTFILES/lazydocker/config.yml $HOME/.config/lazydocker/config.yml

echo "Lazydocker configuration installed successfully!"
