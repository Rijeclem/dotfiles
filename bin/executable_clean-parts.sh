#!/bin/bash
DOWNLOADS="$HOME/Downloads"

# Find and delete every .doc.part file
find "$DOWNLOADS" -type f -name "*.part" -print -delete

echo "All .doc.part files in $DOWNLOADS have been deleted."
