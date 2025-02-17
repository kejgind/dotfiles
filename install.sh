#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

#Starship
rm -rf $HOME/.config/starship.toml
ln -s $DOTFILES/starship/starship.toml $HOME/.config/starship.toml

#Ghostty
rm -rf $HOME/.config/ghostty
mkdir -p $HOME/.config/ghostty
ln -s $DOTFILES/ghostty/config $HOME/.config/ghostty/config

#Tmux
rm -rf $HOME/.tmux.conf
ln -s $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf

#Fish-shell
rm -rf $HOME/.config/fish
mkdir -p $HOME/.config/fish
ln -s $DOTFILES/fish/config.fish $HOME/.config/fish/config.fish

#Yazi
rm -rf $HOME/.config/yazi
mkdir -p $HOME/.config/yazi
ln -s $DOTFILES/yazi/yazi.toml $HOME/.config/yazi/yazi.toml
ln -s $DOTFILES/yazi/theme.toml $HOME/.config/yazi/theme.toml
ln -s $DOTFILES/yazi/Catppuccin-mocha.tmTheme $HOME/.config/yazi/Catppuccin-mocha.tmTheme

#Scripts
mkdir -p $HOME/.local/bin
ln -sf $DOTFILES/scripts/t $HOME/.local/bin/t
