// Generate PNG icon from SVG for all platforms
const sharp = require('sharp');
const path = require('path');
const fs = require('fs');

const svgPath = path.join(__dirname, 'icons', 'icon.svg');
const svg = fs.readFileSync(svgPath);

async function generateIcons() {
    // Main PNG (512x512) for electron-builder
    await sharp(svg).resize(512, 512).png().toFile(path.join(__dirname, 'icons', 'icon.png'));
    console.log('Created icon.png (512x512)');

    // 256x256 for Windows .ico (electron-builder converts PNG to ICO automatically)
    await sharp(svg).resize(256, 256).png().toFile(path.join(__dirname, 'icons', 'icon-256.png'));
    console.log('Created icon-256.png');

    // 1024x1024 for macOS (electron-builder converts PNG to ICNS automatically)
    await sharp(svg).resize(1024, 1024).png().toFile(path.join(__dirname, 'icons', 'icon-1024.png'));
    console.log('Created icon-1024.png');

    console.log('Done!');
}

generateIcons().catch(console.error);
