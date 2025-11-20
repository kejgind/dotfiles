#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}")/.. && pwd)

echo "Installing Tmux configuration..."

rm -rf $HOME/.tmux
rm -rf $HOME/.tmux.conf
mkdir -p $HOME/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
ln -s $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf

# Install tmux plugins automatically (equivalent to prefix + I)
$HOME/.tmux/plugins/tpm/bin/install_plugins

echo "Tmux configuration installed successfully!"
