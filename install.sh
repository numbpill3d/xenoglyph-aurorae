#!/usr/bin/env bash
# Xenoglyph — Aurorae Window Decoration: install.  ./install.sh
set -euo pipefail
HERE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
DST=${XDG_DATA_HOME:-$HOME/.local/share}/aurorae/themes/Xenoglyph
rm -rf "$DST"; mkdir -p "$DST"
for f in "$HERE"/* "$HERE"/.[!.]*; do
    [[ -e $f ]] || continue
    case ${f##*/} in README.md|LICENSE|install.sh|screenshots|.git) continue ;; esac
    cp -r "$f" "$DST"/
done
mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/fonts/xenoglyph"; cp "$HERE"/fonts/*.otf "${XDG_DATA_HOME:-$HOME/.local/share}/fonts/xenoglyph/"; fc-cache -f >/dev/null 2>&1 || true
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key library org.kde.kwin.aurorae
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key theme __aurorae__svg__Xenoglyph
kwriteconfig6 --file kdeglobals --group WM --key activeFont "OMW Ayembedt,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
qdbus6 org.kde.KWin /KWin reconfigure 2>/dev/null || true
