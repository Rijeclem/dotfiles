#!/bin/bash

set -u

file="$1"

if [[ -z "$file" || ! -e "$file" ]]; then
    exit 0
fi

mime=$(xdg-mime query filetype "$file")

# Get registered applications for this MIME type.
mapfile -t apps < <(
    gio mime "$mime" 2>/dev/null |
        sed -n '/Registered applications:/,/Recommended applications:/p' |
        sed '1d;$d' |
        sed 's/^[[:space:]]*//' |
        grep '\.desktop$'
)

if ((${#apps[@]} == 0)); then
    exit 0
fi

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

mkdir -p "$tmp/applications"
mkdir -p "$tmp/bin"

for desktop in "${apps[@]}"; do
    desktop_file=""

    for dir in \
        "$HOME/.local/share/applications" \
        /usr/local/share/applications \
        /usr/share/applications; do
        if [[ -f "$dir/$desktop" ]]; then
            desktop_file="$dir/$desktop"
            break
        fi
    done

    [[ -z "$desktop_file" ]] && continue

    name=$(awk -F= '$1=="Name" {print substr($0,index($0,"=")+1); exit}' "$desktop_file")
    icon=$(awk -F= '$1=="Icon" {print substr($0,index($0,"=")+1); exit}' "$desktop_file")

    [[ -z "$name" ]] && name="${desktop%.desktop}"

    # Create a wrapper which launches the REAL desktop entry
    # with our selected file.
    wrapper="$tmp/bin/$desktop"

    cat >"$wrapper" <<EOF
#!/bin/bash
gio launch "$desktop_file" "$file"
EOF

    chmod +x "$wrapper"

    # Create a temporary desktop entry for Wofi.
    cat >"$tmp/applications/open-with-$desktop" <<EOF
[Desktop Entry]
Type=Application
Name=$name
Icon=$icon
Exec=$wrapper
Terminal=false
NoDisplay=false
EOF
done

# Launch Wofi using the same drun mode you normally use.
XDG_DATA_HOME="$tmp" \
    wofi \
    --show drun \
    --style "$HOME/.config/wofi/styles.css" \
    --prompt "Open with" \
    --cache-file /dev/null
