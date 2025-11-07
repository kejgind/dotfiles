#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

#Fish-shell
rm -rf $HOME/.config/fish
mkdir -p $HOME/.config/fish/functions
ln -s $DOTFILES/fish/config.fish $HOME/.config/fish/config.fish

# Create symlinks for all fish functions
for fish_function in $DOTFILES/fish/functions/*.fish; do
    ln -s "$fish_function" "$HOME/.config/fish/functions/$(basename $fish_function)"
done

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

# Install tmux plugins automatically (equivalent to prefix + I)
$HOME/.tmux/plugins/tpm/bin/install_plugins

#Yazi
rm -rf $HOME/.config/yazi
mkdir -p $HOME/.config/yazi

# Create symlinks for all Yazi config files
for yazi_config in $DOTFILES/yazi/*; do
    ln -s "$yazi_config" "$HOME/.config/yazi/$(basename $yazi_config)"
done

#Lazygit
rm -rf $HOME/.config/lazygit
mkdir -p $HOME/.config/lazygit
ln -s $DOTFILES/lazygit/config.yml $HOME/.config/lazygit/config.yml

#Lazydocker
rm -rf $HOME/.config/lazydocker
mkdir -p $HOME/.config/lazydocker
ln -s $DOTFILES/lazydocker/config.yml $HOME/.config/lazydocker/config.yml

#Neovim
rm -rf $HOME/.config/nvim
ln -s $DOTFILES/nvim $HOME/.config/nvim

#Scripts
mkdir -p $HOME/.local/bin
ln -sf $DOTFILES/scripts/t $HOME/.local/bin/
