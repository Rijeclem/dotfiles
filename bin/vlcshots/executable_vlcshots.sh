#!/bin/bash
# vlcshots.sh — generate markdown list of VLC snapshots and move them to Obsidian attachments

# Configurable paths
SRC_DIR=~/bin/vlcshots/VLCout
DEST_DIR=~/MEGA/BASENOTE/Junk/Attachments
OUTPUT_FILE=~/bin/vlcshots/screenshots.md

# Safety checks
if [ ! -d "$SRC_DIR" ]; then
  echo "❌ Source directory not found: $SRC_DIR"
  exit 1
fi
if [ ! -d "$DEST_DIR" ]; then
  echo "❌ Destination directory not found: $DEST_DIR"
  exit 1
fi

# Create or clear the output file
>"$OUTPUT_FILE"

# Generate markdown list
echo "📝 Generating $OUTPUT_FILE ..."
found_files=false
shopt -s nullglob
for img in "$SRC_DIR"/*.{jpg,jpeg,png,JPG,JPEG,PNG}; do
  filename=$(basename "$img")
  echo "![[${filename}]]" >>"$OUTPUT_FILE"
  echo "" >>"$OUTPUT_FILE"
  found_files=true
done
shopt -u nullglob

if [ "$found_files" = false ]; then
  echo "⚠️ No images found in $SRC_DIR"
  exit 0
fi

# Move image files
echo "📦 Moving image files to $DEST_DIR ..."
mv "$SRC_DIR"/*.{jpg,jpeg,png,JPG,JPEG,PNG} "$DEST_DIR"/ 2>/dev/null

echo "✅ Done!"
echo "   Markdown list: $OUTPUT_FILE"
echo "   Images moved → $DEST_DIR"
