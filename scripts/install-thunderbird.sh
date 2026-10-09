#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}")/.. && pwd)

echo "Installing Thunderbird configuration..."

# Find default profile (installs.ini first, then profiles.ini Default=1)
TB_DIR=""
for d in $HOME/.thunderbird $HOME/.config/thunderbird; do
    [ -f "$d/profiles.ini" ] && TB_DIR=$d && break
done

if [ -z "$TB_DIR" ]; then
    echo "  Thunderbird profile dir not found, skipping (run Thunderbird once first)"
    exit 0
fi

PROFILE=$(grep -m1 '^Default=' "$TB_DIR/installs.ini" 2>/dev/null | cut -d= -f2)
if [ -z "$PROFILE" ]; then
    PROFILE=$(awk -F= '/^\[Profile/{p=""} /^Path=/{p=$2} /^Default=1/{print p; exit}' "$TB_DIR/profiles.ini")
fi

PROFILE_DIR=$TB_DIR/$PROFILE
if [ -z "$PROFILE" ] || [ ! -d "$PROFILE_DIR" ]; then
    echo "  Default profile not found in $TB_DIR, skipping"
    exit 0
fi

mkdir -p $PROFILE_DIR/chrome
rm -f $PROFILE_DIR/chrome/userChrome.css $PROFILE_DIR/user.js
ln -s $DOTFILES/thunderbird/chrome/userChrome.css $PROFILE_DIR/chrome/userChrome.css
ln -s $DOTFILES/thunderbird/user.js $PROFILE_DIR/user.js

echo "Thunderbird configuration installed successfully! ($PROFILE_DIR)"
