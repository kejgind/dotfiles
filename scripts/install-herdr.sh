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

# mods symlinked; keys.json patched (app rewrites it)
mkdir -p $APP/mods
for m in $DOTFILES/herdr/app/mods/*/; do
  m=${m%/}
  rm -rf $APP/mods/$(basename $m)
  ln -s $m $APP/mods/$(basename $m)
done
# mods can't import outside their folder: pane-resize-* get a copy of the shared core
for m in $DOTFILES/herdr/app/mods/pane-resize-*/; do
  cp $DOTFILES/herdr/app/mods/pane-equalize/core.js $m/core.js
done
[ -f $APP/keys.json ] || echo '{}' > $APP/keys.json
tmp=$(mktemp)
jq '.global += {
  "ctrl-shift-g": "mod.open:lazygit-repos",
  "ctrl-alt-=": "mod.open:pane-equalize",
  "ctrl-alt-h": "mod.open:pane-resize-left",
  "ctrl-alt-j": "mod.open:pane-resize-down",
  "ctrl-alt-k": "mod.open:pane-resize-up",
  "ctrl-alt-l": "mod.open:pane-resize-right"
}' $APP/keys.json > $tmp && mv $tmp $APP/keys.json

# copy-on-select: primary selection owned by herdr-app -> dedent -> clipboard (systemd user service)
mkdir -p $HOME/.local/bin $HOME/.config/systemd/user
cp $DOTFILES/scripts/tmux-dedent-copy.sh $HOME/.local/bin/tmux_dedent_copy
cp $DOTFILES/scripts/herdr-copy-on-select.sh $HOME/.local/bin/herdr-copy-on-select
chmod +x $HOME/.local/bin/tmux_dedent_copy $HOME/.local/bin/herdr-copy-on-select
cp $DOTFILES/herdr/herdr-copy-on-select.service $HOME/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable herdr-copy-on-select.service
systemctl --user restart herdr-copy-on-select.service

echo "herdr configuration installed successfully!"
