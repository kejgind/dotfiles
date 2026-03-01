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

# Generate tmux.conf with shell-appropriate tmux_path call
if [[ "$SHELL_CHOICE" == "fish" ]]; then
    # Use fish function for tmux_path
    cp $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf
else
    # Use standalone tmux_path script (bash or any other shell)
    sed "s|fish -c 'tmux_path #{pane_current_path}'|tmux_path #{pane_current_path}|" \
        $DOTFILES/tmux/tmux.conf > $HOME/.tmux.conf
fi

# Install tmux plugins automatically (equivalent to prefix + I)
$HOME/.tmux/plugins/tpm/bin/install_plugins

echo "Tmux configuration installed successfully!"
