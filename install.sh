#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

#Fish-shell
rm -rf $HOME/.config/fish
mkdir -p $HOME/.config/fish/functions
ln -s $DOTFILES/fish/config.fish $HOME/.config/fish/config.fish
ln -s $DOTFILES/fish/functions/tmux_path.fish $HOME/.config/fish/functions/tmux_path.fish

#Starship
rm -rf $HOME/.config/starship.toml
ln -s $DOTFILES/starship/starship.toml $HOME/.config/starship.toml

#Ghostty
rm -rf $HOME/.config/ghostty
mkdir -p $HOME/.config/ghostty
ln -s $DOTFILES/ghostty/config $HOME/.config/ghostty/config

#Tmux
rm -rf $HOME/.tmux
rm -rf $HOME/.tmux.conf
mkdir -p $HOME/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
ln -s $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf

#Yazi
rm -rf $HOME/.config/yazi
mkdir -p $HOME/.config/yazi
ln -s $DOTFILES/yazi/yazi.toml $HOME/.config/yazi/yazi.toml
ln -s $DOTFILES/yazi/theme.toml $HOME/.config/yazi/theme.toml
ln -s $DOTFILES/yazi/Catppuccin-mocha.tmTheme $HOME/.config/yazi/Catppuccin-mocha.tmTheme

#Lazygit
rm -rf $HOME/.config/lazygit
mkdir -p $HOME/.config/lazygit
ln -s $DOTFILES/lazygit/config.yml $HOME/.config/lazygit/config.yml

#Scripts
mkdir -p $HOME/.local/bin
ln -sf $DOTFILES/scripts/t $HOME/.local/bin/
