# Kanzlei Tic Tac Toe — Downloads

## Standalone HTML (sofort spielbar)

**[tic-tac-toe.html](./tic-tac-toe.html)** — Einfach herunterladen und im Browser öffnen!

## Desktop-Apps selber bauen

Die Windows (.exe) und macOS (.app) Binaries sind zu groß für Git (~400 MB).
So baust du sie selbst:

```bash
git clone -b claude/enhance-tic-tac-toe-game-oI4gq https://github.com/Klotzkette/games.git
cd games
npm install
bash build.sh all
```

Die fertigen Builds liegen dann in `dist/`:
- `dist/win-unpacked/Kanzlei Tic Tac Toe.exe` — Windows
- `dist/mac/Kanzlei Tic Tac Toe.app` — macOS
- `dist/KanzleiTicTacToe-Windows-x64.zip` — Windows ZIP
- `dist/KanzleiTicTacToe-macOS-x64.zip` — macOS ZIP

## Features

- Tic Tac Toe als Gerichtsverhandlung: Kläger ✕ vs. Beklagter ○
- § Paragraph-Regen über den gesamten Bildschirm
- 80er-MIDI-Synthwave-Musik (FM-Synth, Arpeggiator, TR-808 Drums)
- Boom-Sounds, Swoosh, Gavel-Strikes — alles Web Audio API
- CRT-Scanlines, Retro-Grid, Neon-Glow — voller 80er-Look
- 24+ Juristenhumor-Sprüche während des Spiels
- Richterhammer-Animation und Stempel-Overlay bei Sieg
