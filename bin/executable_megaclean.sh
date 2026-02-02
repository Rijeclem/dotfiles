#!/usr/bin/env bash
# Description: Clean and manage Mega sync issues

allissues=$(mega-sync-issues --detail --limit=0 --output-cols=PATH,LAST_MODIFIED --disable-path-collapse --all | sed '/^\[Details on issue/,+2d')

printf "%s\n" "$allissues"

echo
echo "Choose an option:"
echo "  [L]ASTMOD  | [F]IRSTMOD  | [P]C  | [S]ERVER  | [Q]UIT"
read -rp "> " choice

case "$choice" in
P | p | PC | pc)
  echo "Deleting server-side duplicates..."

  # Extract and clean all cloud-side paths
  cleanpaths=$(echo "$allissues" |
    grep '/OBSIDIAN_MEGA/' |
    sed -E 's|^<CLOUD>/?||; s|[[:space:]]+[0-9]{4}-[0-9]{2}-[0-9]{2}.*$||')

  # If no matches, stop here
  if [[ -z "$cleanpaths" ]]; then
    echo "No server-side files found to delete."
    exit
  fi

  # Confirm before deletion
  echo "The following files will be deleted from MEGA:"
  echo "$cleanpaths"
  echo
  read -rp "Proceed? (y/N): " confirm

  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "$cleanpaths" | while read -r badpath; do
      [[ -z "$badpath" ]] && continue
      echo "→ mega-rm \"$badpath\""
      mega-rm "$badpath"
    done
  else
    echo "Aborted."
  fi
  ;;
S | s | SERVER | server)
  echo "Deleting local duplicates..."

  # Extract and clean all local-side paths
  cleanpaths=$(echo "$allissues" |
    grep '/home/rad/MEGA/BASENOTE/' |
    sed -E 's|^/?<LOCAL>/?||; s|[[:space:]]+[0-9]{4}-[0-9]{2}-[0-9]{2}.*$||')

  # If no matches, stop here
  if [[ -z "$cleanpaths" ]]; then
    echo "No local files found to delete."
    exit
  fi

  # Confirm before deletion
  echo "The following local files will be deleted:"
  echo "$cleanpaths"
  echo
  read -rp "Proceed? (y/N): " confirm

  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "$cleanpaths" | while read -r badpath; do
      [[ -z "$badpath" ]] && continue
      echo "→ rm -f \"$badpath\""
      rm -f "$badpath"
    done
  else
    echo "Aborted."
  fi
  ;;
L | l | LASTMOD | lastmod)
  echo "Sort by last modified (descending):"
  echo "$allissues" | sort -k2 -r
  ;;
F | f | FIRSTMOD | firstmod)
  echo "Sort by first modified (ascending):"
  echo "$allissues" | sort -k2
  ;;
Q | q | QUIT | quit)
  echo "Exiting..."
  exit 0
  ;;
*)
  echo "Invalid choice."
  ;;
esac

echo "Finished!"
echo "$(mega-sync-issues)"
