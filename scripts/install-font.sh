#!/usr/bin/env bash

# Prompt for font URL
read -p "Enter the URL to a font zip file: " FONT_URL

# Exit if no URL provided
if [ -z "$FONT_URL" ]; then
  echo "No URL provided. Exiting without installing fonts."
  exit 0
fi

echo "Installing fonts from $FONT_URL..."

# Create a temporary directory
TEMP_DIR=$(mktemp -d)

# Download the font zip file
wget -O "$TEMP_DIR/font.zip" "$FONT_URL"

# Unzip the font file
unzip "$TEMP_DIR/font.zip" -d "$TEMP_DIR"

# Create fonts directory if it doesn't exist
mkdir -p "$HOME/.local/share/fonts"

# Move the font files to the user fonts directory
mv "$TEMP_DIR"/*.{ttf,otf} "$HOME"/.local/share/fonts/ 2>/dev/null

# Update the font cache
fc-cache -f -v

# Clean up
rm -rf "$TEMP_DIR"

echo "Fonts installed successfully!"
