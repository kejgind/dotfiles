#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}")/.. && pwd)

echo "Installing herdr configuration..."

mkdir -p $HOME/.config/herdr
rm -f $HOME/.config/herdr/config.toml
ln -s $DOTFILES/herdr/config.toml $HOME/.config/herdr/config.toml

echo "herdr configuration installed successfully!"
