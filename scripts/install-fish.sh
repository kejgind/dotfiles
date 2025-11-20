#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}")/.. && pwd)

echo "Installing Fish shell configuration..."

rm -rf $HOME/.config/fish
mkdir -p $HOME/.config/fish/functions
ln -s $DOTFILES/fish/config.fish $HOME/.config/fish/config.fish

# Create symlinks for all fish functions
for fish_function in $DOTFILES/fish/functions/*.fish; do
    ln -s "$fish_function" "$HOME/.config/fish/functions/$(basename $fish_function)"
done

echo "Fish shell configuration installed successfully!"
