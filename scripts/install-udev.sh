#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}")/.. && pwd)

echo "Installing udev rules..."

if ! command -v udevadm &> /dev/null; then
    echo "  udevadm not found, skipping"
    exit 0
fi

# Copy (not symlink) - rules read by root, user-writable target = privilege escalation
for rule in $DOTFILES/udev/rules.d/*.rules; do
    sudo install -Dm644 "$rule" /etc/udev/rules.d/$(basename "$rule")
done
sudo udevadm control --reload

echo "Udev rules installed successfully! (replug devices to apply)"
