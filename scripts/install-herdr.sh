#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}")/.. && pwd)

echo "Installing herdr configuration..."

mkdir -p $HOME/.config/herdr
rm -f $HOME/.config/herdr/config.toml
ln -s $DOTFILES/herdr/config.toml $HOME/.config/herdr/config.toml

# herdr-app (GUI): theme symlinked, settings.json patched (app rewrites it, no symlink)
APP=$HOME/.config/herdr-app
mkdir -p $APP/themes
ln -sf $DOTFILES/herdr/app/themes/catppuccin-mocha.json $APP/themes/catppuccin-mocha.json

[ -f $APP/settings.json ] || echo '{}' > $APP/settings.json
tmp=$(mktemp)
jq '.theme = "catppuccin-mocha" | .font = "JetBrainsMono Nerd Font"' $APP/settings.json > $tmp && mv $tmp $APP/settings.json

echo "herdr configuration installed successfully!"
