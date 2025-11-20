#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

# Parse command line flags
INSTALL_FONTS=false

for arg in "$@"; do
    case $arg in
        --fonts)
            INSTALL_FONTS=true
            ;;
        --all)
            INSTALL_FONTS=true
            ;;
        *)
            echo "Unknown option: $arg"
            echo "Usage: $0 [--fonts] [--all]"
            echo "  --fonts    Install fonts (will prompt for URL)"
            echo "  --all      Install everything including fonts"
            exit 1
            ;;
    esac
done

echo "=== Installing dotfiles ==="
echo ""

# Always install core applications
echo "Installing core applications..."
$DOTFILES/scripts/install-fish.sh
$DOTFILES/scripts/install-starship.sh
$DOTFILES/scripts/install-ghostty.sh
$DOTFILES/scripts/install-tmux.sh
$DOTFILES/scripts/install-yazi.sh
$DOTFILES/scripts/install-lazygit.sh
$DOTFILES/scripts/install-lazydocker.sh
$DOTFILES/scripts/install-nvim.sh

echo ""

# Conditionally install fonts
if [ "$INSTALL_FONTS" = true ]; then
    echo "Running font installer..."
    $DOTFILES/scripts/install-font.sh
    echo ""
fi

echo "=== Installation complete! ==="
