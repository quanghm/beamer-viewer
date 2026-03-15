---
layout: home
title: Home
---

# Beamer Viewer

A native macOS/iOS PDF presenter console, inspired by [pdfpc](https://pdfpc.github.io/).

Automatically splits wide Beamer pages into slide and notes halves, with a full presenter console showing current slide, next slide preview, notes, and timer.

## Features

- **Presenter window** — current slide, next slide, notes, timer with progress bar
- **Projector window** — fullscreen on external display
- **Beamer page splitting** — auto-detects wide pages with embedded notes
- **Welcome screen** — recent files with hotkey access
- **Keyboard-driven** — vim-style navigation
- **Light/dark mode** — adapts to system appearance
- **iPad support** — with external display via AirPlay/USB-C (beta)

## Install

### Homebrew (recommended)

```bash
brew tap quanghm/beamer-viewer
brew install --cask beamer-viewer
```

### Manual Download

Download the latest `.app` from [GitHub Releases](https://github.com/quanghm/beamer-viewer/releases), unzip, and run:

```bash
xattr -cr BeamerViewer.app
```

### Build from Source

```bash
git clone https://github.com/quanghm/beamer-viewer.git
cd beamer-viewer
swift build
swift run BeamerViewer
```

## Quick Start

1. Open a PDF — click **Open PDF…** or press **⌘O**
2. The projector window opens automatically
3. Press **f** to go fullscreen on an external display
4. Navigate with **arrow keys**, **Space**, or **k/l**
5. Press **h** for help at any time

[Getting Started →](getting-started)
