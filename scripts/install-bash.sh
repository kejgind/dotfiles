#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}")/.. && pwd)

echo "Installing Bash shell configuration..."

# --------------------------------------------------------------------------
# Install ble.sh (Bash Line Editor) if not already present
# --------------------------------------------------------------------------
if [ ! -f "$HOME/.local/share/blesh/ble.sh" ]; then
    echo "  Installing ble.sh (nightly)..."
    BLESH_TMP=$(mktemp -d)
    curl -sL https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf - -C "$BLESH_TMP"
    bash "$BLESH_TMP/ble-nightly/ble.sh" --install ~/.local/share
    rm -rf "$BLESH_TMP"
    echo "  ble.sh installed to ~/.local/share/blesh/"
else
    echo "  ble.sh already installed, skipping download"
fi

# --------------------------------------------------------------------------
# Symlink bash config files
# --------------------------------------------------------------------------
rm -f $HOME/.bashrc
rm -f $HOME/.bash_profile
rm -f $HOME/.bash_aliases
rm -f $HOME/.bash_functions
rm -f $HOME/.blerc

ln -s $DOTFILES/bash/.bashrc $HOME/.bashrc
ln -s $DOTFILES/bash/.bash_profile $HOME/.bash_profile
ln -s $DOTFILES/bash/.bash_aliases $HOME/.bash_aliases
ln -s $DOTFILES/bash/.bash_functions $HOME/.bash_functions
ln -s $DOTFILES/bash/.blerc $HOME/.blerc

# --------------------------------------------------------------------------
# Install standalone tmux_path script
# --------------------------------------------------------------------------
mkdir -p $HOME/.local/bin
rm -f $HOME/.local/bin/tmux_path
cp $DOTFILES/scripts/tmux-path.sh $HOME/.local/bin/tmux_path
chmod +x $HOME/.local/bin/tmux_path

echo "Bash shell configuration installed successfully!"
