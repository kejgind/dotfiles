#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}")/.. && pwd)

echo "Installing pacman hooks..."

if ! command -v pacman &> /dev/null; then
    echo "  pacman not found, skipping"
    exit 0
fi

# Copy (not symlink) - hooks run as root, user-writable target = root exec
sudo install -Dm644 $DOTFILES/pacman/hooks/paccache.hook /etc/pacman.d/hooks/paccache.hook

echo "Pacman hooks installed successfully!"
