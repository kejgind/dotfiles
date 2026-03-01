#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

# Parse command line flags
INSTALL_FONTS=false
SHELL_CHOICE=""

for arg in "$@"; do
    case $arg in
        --shell=*)
            SHELL_CHOICE="${arg#*=}"
            if [[ "$SHELL_CHOICE" != "bash" && "$SHELL_CHOICE" != "fish" ]]; then
                echo "Error: --shell must be 'bash' or 'fish'"
                exit 1
            fi
            ;;
        --fonts)
            INSTALL_FONTS=true
            ;;
        --all)
            INSTALL_FONTS=true
            ;;
        *)
            echo "Unknown option: $arg"
            echo "Usage: $0 [--shell=bash|fish] [--fonts] [--all]"
            echo "  --shell=bash  Install Bash shell config (with ble.sh)"
            echo "  --shell=fish  Install Fish shell config"
            echo "  --fonts       Install fonts (will prompt for URL)"
            echo "  --all         Install everything including fonts"
            exit 1
            ;;
    esac
done

echo "=== Installing dotfiles ==="
echo ""

# Install shell configuration
if [[ -n "$SHELL_CHOICE" ]]; then
    echo "Installing $SHELL_CHOICE shell configuration..."
    $DOTFILES/scripts/install-${SHELL_CHOICE}.sh
    $DOTFILES/scripts/install-starship.sh
    echo ""
else
    echo "No shell specified, skipping shell config (use --shell=bash or --shell=fish)"
    echo ""
fi

# Install core applications (shell-aware where needed)
echo "Installing core applications..."
$DOTFILES/scripts/install-ghostty.sh "$SHELL_CHOICE"
$DOTFILES/scripts/install-tmux.sh "$SHELL_CHOICE"
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
