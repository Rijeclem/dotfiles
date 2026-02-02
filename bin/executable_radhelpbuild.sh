#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$HOME/MEGA/BASENOTE/PROGRAMMING/Linux/radhelp"
OBSIDIAN_HOTKEYS="$HOME/MEGA/BASENOTE/PROGRAMMING/Obsidian BASENOTE/Hotkey Bible.md"

cat \
    "$BASE_DIR/Hotkey Bible Prefix.md" \
    "$OBSIDIAN_HOTKEYS" \
    >"$BASE_DIR/Hotkeys.md"

echo "✔ Hotkeys.md "

md2po $BASE_DIR/Hotkeys.md $BASE_DIR/Kısayollar.pot
md2po $BASE_DIR/Usage.md $BASE_DIR/Kullanım.pot
md2po $BASE_DIR/Introduction.md $BASE_DIR/Giriş.pot

msgmerge --update --backup=none \
    $BASE_DIR/Kısayollar.po \
    $BASE_DIR/Kısayollar.pot

msgmerge --update --backup=none \
    $BASE_DIR/Kullanım.po \
    $BASE_DIR/Kullanım.pot

msgmerge --update --backup=none \
    $BASE_DIR/Giriş.po \
    $BASE_DIR/Giriş.pot

echo "✔ Updates using msgmerge"

po2md -t $BASE_DIR/Introduction.md -i $BASE_DIR/Giriş.po -o $BASE_DIR/Giriş.md
po2md -t $BASE_DIR/Usage.md -i $BASE_DIR/Kullanım.po -o $BASE_DIR/Kullanım.md
po2md -t $BASE_DIR/Hotkeys.md -i $BASE_DIR/Kısayollar.po -o $BASE_DIR/Kısayollar.md

echo "✔ po2md(3) "

sed -i \
    -e 's/\bIntroduction\.md\b/Giriş.md/g' \
    -e 's/\bUsage\.md\b/Kullanım.md/g' \
    -e 's/\bHotkeys\.md\b/Kısayollar.md/g' \
    "$BASE_DIR/Giriş.md" \
    "$BASE_DIR/Kullanım.md" \
    "$BASE_DIR/Kısayollar.md"

echo "✔ fixing translated manual links"

echo "✔✔✔ rebuilt!"
