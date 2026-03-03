#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}")/.. && pwd)
SHELL_CHOICE="${1:-fish}"

echo "Installing Tmux configuration..."

rm -rf $HOME/.tmux
rm -rf $HOME/.tmux.conf
mkdir -p $HOME/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# Install standalone tmux_path script (works with any shell)
mkdir -p $HOME/.local/bin
rm -f $HOME/.local/bin/tmux_path
cp $DOTFILES/scripts/tmux-path.sh $HOME/.local/bin/tmux_path
chmod +x $HOME/.local/bin/tmux_path

# Install tmux.conf (shell-agnostic, uses standalone tmux_path)
cp $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf

# Install tmux plugins automatically (equivalent to prefix + I)
$HOME/.tmux/plugins/tpm/bin/install_plugins

echo "Tmux configuration installed successfully!"
