#!/bin/bash
# Turns any photo-N.jpg/.png/.heic/etc. in this folder into a web-sized photo-N.webp,
# then moves the original to ~/Pictures/itsbenduncan-originals so it never lands in git.
#   ./convert.sh                 convert everything that isn't webp yet
#   ./convert.sh 2:90            also rotate photo-2 90° clockwise (270 = counter-clockwise)
set -euo pipefail
cd "$(dirname "$0")"
ORIG="$HOME/Pictures/itsbenduncan-originals"; mkdir -p "$ORIG"
ARGS=("$@")
rot_for() { for a in ${ARGS[@]+"${ARGS[@]}"}; do [ "${a%%:*}" = "$1" ] && { echo "${a#*:}"; return; }; done; echo ""; }
shopt -s nullglob nocaseglob
for f in photo-[0-9]*.* sheet-[0-9]*.* pano.*; do
  ext="$(echo "${f##*.}" | tr 'A-Z' 'a-z')"; base="${f%.*}"; n="${base#photo-}"; max=1400; [ "$base" = "pano" ] && max=2400
  [ "$ext" = "webp" ] && continue
  r="$(rot_for "$n")"
  tmp="$(mktemp -t ibd).png"
  sips -s format png "$f" --out "$tmp" >/dev/null
  [ -n "$r" ] && sips -r "$r" "$tmp" >/dev/null
  w=$(sips -g pixelWidth "$tmp" | awk "/pixelWidth/{print \$2}"); h=$(sips -g pixelHeight "$tmp" | awk "/pixelHeight/{print \$2}"); [ $(( w > h ? w : h )) -gt $max ] && sips -Z $max "$tmp" >/dev/null
  cwebp -quiet -q 80 -metadata none "$tmp" -o "$base.webp"
  rm -f "$tmp"; mv "$f" "$ORIG/$f"
  echo "$f -> $base.webp ($(( $(stat -f%z "$base.webp") / 1024 )) KB)${r:+, rotated ${r}°}"
done
