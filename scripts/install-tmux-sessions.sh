#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}")/.. && pwd)

echo "Installing tmux session manager (t script)..."

mkdir -p $HOME/.local/bin
ln -sf $DOTFILES/scripts/tmux-sessions/t $HOME/.local/bin/

echo "Tmux session manager installed successfully!"
