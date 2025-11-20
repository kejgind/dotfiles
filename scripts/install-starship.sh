#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}")/.. && pwd)

echo "Installing Starship configuration..."

rm -rf $HOME/.config/starship.toml
ln -s $DOTFILES/starship/starship.toml $HOME/.config/starship.toml

echo "Starship configuration installed successfully!"
