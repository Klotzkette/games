#!/bin/bash
# Build Kanzlei Tic Tac Toe for all platforms
# Usage: bash build.sh [win|mac|linux|all]
set -e
cd "$(dirname "$0")"

# Generate icons if needed
if [ ! -f icons/icon.png ]; then
    echo "Generating icons..."
    node generate-icons.js
fi

# Install deps if needed
if [ ! -d node_modules ]; then
    echo "Installing dependencies..."
    npm install
fi

TARGET="${1:-all}"

case "$TARGET" in
    win|windows)
        echo "Building for Windows..."
        npx electron-builder --win --x64
        echo "Output: dist/win-unpacked/ and dist/*.exe"
        ;;
    mac|macos|darwin)
        echo "Building for macOS..."
        npx electron-builder --mac
        echo "Output: dist/mac/ and dist/*.dmg"
        ;;
    linux)
        echo "Building for Linux..."
        npx electron-builder --linux
        echo "Output: dist/*.AppImage"
        ;;
    all)
        echo "Building for all platforms..."
        echo ""
        echo "Note: DMG creation requires macOS, NSIS installer requires Wine on Linux."
        echo "Using dir targets for cross-platform compatibility..."
        echo ""
        npx electron-builder --win --x64 -c.win.target=dir -c.win.signAndEditExecutable=false
        npx electron-builder --mac --x64 -c.mac.target=dir -c.mac.identity=null
        npx electron-builder --linux -c.linux.target=dir
        # Zip results
        cd dist
        [ -d win-unpacked ] && zip -r -q "KanzleiTicTacToe-Windows-x64.zip" win-unpacked/ && echo "Created: KanzleiTicTacToe-Windows-x64.zip"
        [ -d mac ] && zip -r -q "KanzleiTicTacToe-macOS-x64.zip" mac/ && echo "Created: KanzleiTicTacToe-macOS-x64.zip"
        [ -d linux-unpacked ] && zip -r -q "KanzleiTicTacToe-Linux-x64.zip" linux-unpacked/ && echo "Created: KanzleiTicTacToe-Linux-x64.zip"
        cd ..
        echo ""
        echo "All builds complete! Check dist/ directory."
        ;;
    *)
        echo "Usage: bash build.sh [win|mac|linux|all]"
        exit 1
        ;;
esac

echo ""
echo "For native installers (DMG/NSIS), build on the target platform:"
echo "  macOS:   npm run build:mac   (creates .dmg)"
echo "  Windows: npm run build:win   (creates .exe installer)"
echo "  Linux:   npm run build:linux (creates .AppImage)"
