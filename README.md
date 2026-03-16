# SideBeam

[![License: BSL 1.1](https://img.shields.io/badge/License-BSL%201.1-blue.svg)](LICENSE)
[![macOS 14+](https://img.shields.io/badge/macOS-14%2B-blue)](https://github.com/quanghm/sidebeam/releases)
[![iOS 17+](https://img.shields.io/badge/iOS-17%2B-blue)](https://github.com/quanghm/sidebeam)

A native PDF presenter console for macOS and iPad. Dual-screen presentation with speaker notes, timer, and slide preview — like Keynote's presenter display, but for any PDF.

Auto-detects LaTeX Beamer slides with embedded notes and splits them automatically.

## Features

- **Dual-screen presenting** — slides on the projector, notes + preview on your screen
- **Slide fullscreen toggle** — switch between full presenter layout and slide-only view
- **Beamer page splitting** — auto-detects and splits wide pages (slide + notes)
- **Timer with progress bar** — elapsed time, slide counter, visual progress
- **Recent files** — quick access from the welcome screen (hotkeys `1`–`9`, `0`)
- **Keyboard-driven** — vim-style navigation, all actions accessible via keyboard
- **Light/dark mode** — adapts to system appearance
- **iPad support** — external display via AirPlay/USB-C, swipe gestures, hardware keyboard

## Screenshots

<!-- TODO: Add screenshots of presenter view, projector view, welcome screen -->

## Install

### Homebrew (recommended)

```bash
brew tap quanghm/sidebeam
brew install --cask sidebeam
```

### Manual Download

Download the latest `.app` from [Releases](https://github.com/quanghm/sidebeam/releases), unzip, and run:

```bash
xattr -cr SideBeam.app   # remove quarantine on first run
```

## Quick Start

1. Open a PDF — click **Open PDF…** or press `⌘O`
2. The projector window opens automatically
3. Press `f` to go fullscreen (projector on external display, slide-only on single screen)
4. Navigate with **arrow keys**, `Space`, or `k`/`l`
5. Press `h` for key bindings, `Esc` to exit fullscreen

## Key Bindings

### Presenting

| Key | Action |
|---|---|
| `→` `↓` `Space` `l` `PgDn` | Next slide |
| `←` `↑` `k` `PgUp` | Previous slide |
| `Home` | First slide |
| `End` | Last slide |
| `g` + number + `Enter` | Go to slide |
| `f` | Toggle slide fullscreen + projector |
| `s` | Cycle split mode: none / right / left |
| `b` | Blank/unblank projector |
| `p` | Pause/resume timer |
| `r` | Reset timer |
| `h` | Toggle key bindings |
| `⌘W` | Close presentation |
| `Esc` | Exit fullscreen / close help |
| `q` | Quit |

### Welcome Screen

| Key | Action |
|---|---|
| `1`–`9`, `0` | Open recent file |
| `⌘O` | Open file picker |

## Beamer Setup

SideBeam works with **any PDF**. For LaTeX Beamer presentations with embedded speaker notes, add to your preamble:

```latex
\usepackage{pgfpages}
\setbeameroption{show notes on second screen=right}
```

SideBeam detects the wide pages automatically. Press `s` to cycle split modes if needed.

## iPad

- **External display** — auto-detects AirPlay/USB-C for projector output
- **Hardware keyboard** — same shortcuts as macOS
- **Swipe gestures** — swipe left/right to navigate
- **Touch controls** — prev/next buttons, close, fullscreen toggle
- **Slide fullscreen** — toggle between presenter layout and slide-only

Build with Xcode — open `SideBeam.xcodeproj`, select iPad, and run (⌘R).

## Build from Source

Requires macOS 14+ and Swift 5.9+.

```bash
git clone https://github.com/quanghm/sidebeam.git
cd sidebeam
swift build
swift run SideBeam presentation.pdf
```

To build a `.app` bundle:

```bash
bash scripts/build-app.sh
open .build/SideBeam.app
```

## Documentation

Full documentation at [quanghm.github.io/sidebeam](https://quanghm.github.io/sidebeam/)

## Roadmap

- Countdown timer with configurable alerts
- Sidecar markdown notes (`.notes.md`)
- Cloud integration (Google Drive / OneDrive)
- Slide annotations / pointer
- Localization

## Support

- [Report a bug](https://github.com/quanghm/sidebeam/issues)
- [Sponsor this project](https://github.com/sponsors/quanghm)
- Commercial licensing: [quanghm@gmail.com](mailto:quanghm@gmail.com)

## License

[Business Source License 1.1](LICENSE) — free to use, view, and modify. Commercial PDF presenter applications require a license. Converts to Apache 2.0 on 2029-03-16.
