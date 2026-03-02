#!/bin/bash
# Icon generation script — requires ImageMagick or librsvg
# Run: bash icons/create-icons.sh

set -e
cd "$(dirname "$0")"

echo "Generating PNG from SVG..."
# Try rsvg-convert first, fall back to ImageMagick
if command -v rsvg-convert &> /dev/null; then
    rsvg-convert -w 1024 -h 1024 icon.svg -o icon.png
elif command -v convert &> /dev/null; then
    convert -background none -resize 1024x1024 icon.svg icon.png
else
    echo "Install librsvg or ImageMagick to generate icons"
    echo "  macOS: brew install librsvg"
    echo "  Linux: sudo apt install librsvg2-bin"
    exit 1
fi

# macOS .icns (requires iconutil on macOS)
if command -v iconutil &> /dev/null; then
    echo "Generating .icns for macOS..."
    mkdir -p icon.iconset
    for size in 16 32 64 128 256 512; do
        rsvg-convert -w $size -h $size icon.svg -o "icon.iconset/icon_${size}x${size}.png"
        double=$((size * 2))
        rsvg-convert -w $double -h $double icon.svg -o "icon.iconset/icon_${size}x${size}@2x.png"
    done
    iconutil -c icns icon.iconset -o icon.icns
    rm -rf icon.iconset
    echo "Created icon.icns"
fi

# Windows .ico (requires ImageMagick)
if command -v convert &> /dev/null; then
    echo "Generating .ico for Windows..."
    convert icon.png -define icon:auto-resize=256,128,64,48,32,16 icon.ico
    echo "Created icon.ico"
fi

echo "Done! Generated icons:"
ls -la icon.*
