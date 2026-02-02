#!/bin/bash
# rad-font_installer.sh
# Install all TTF/OTF fonts from the current directory (or a ZIP if present)
# Usage: ./rad-font_installer.sh

set -e

# Prepare user fonts directory
FONT_DIR="$HOME/.local/share/fonts/installed_fonts"
mkdir -p "$FONT_DIR"

# First, check for TTF/OTF files in current directory
shopt -s nullglob
FONT_FILES=( *.ttf *.otf )

# If no fonts, check for a zip file and extract
if [[ ${#FONT_FILES[@]} -eq 0 ]]; then
    ZIP_FILE=$(ls *.zip 2>/dev/null | head -n1)
    if [[ -z "$ZIP_FILE" ]]; then
        echo "No .ttf/.otf fonts or .zip file found in the current directory."
        exit 1
    fi

    # If unzip is available, extract
    if command -v unzip >/dev/null 2>&1; then
        TMP_DIR=$(mktemp -d)
        echo "Extracting fonts from $ZIP_FILE..."
        unzip -o "$ZIP_FILE" -d "$TMP_DIR" >/dev/null
        FONT_FILES=( "$TMP_DIR"/*.ttf "$TMP_DIR"/*.otf )
        if [[ ${#FONT_FILES[@]} -eq 0 ]]; then
            echo "No fonts found inside ZIP."
            rm -rf "$TMP_DIR"
            exit 1
        fi
    else
        echo "No fonts in current directory and unzip not installed. Cannot proceed."
        exit 1
    fi
fi

# Install fonts safely (skip duplicates)
echo "Installing fonts..."
for f in "${FONT_FILES[@]}"; do
    BASENAME=$(basename "$f")
    if [[ -f "$FONT_DIR/$BASENAME" ]]; then
        echo "Skipping existing font: $BASENAME"
    else
        mv "$f" "$FONT_DIR/"
        echo "Installed: $BASENAME"
    fi
done

# Clean up temp dir if used
[[ -n "$TMP_DIR" ]] && rm -rf "$TMP_DIR"

# Refresh font cache
echo "Refreshing font cache..."
fc-cache -fv >/dev/null

echo "All done! Fonts installed to $FONT_DIR."
echo "You can now select them in Obsidian or other apps."

