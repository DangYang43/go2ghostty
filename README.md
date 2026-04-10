# go2ghostty

**English** | [中文](README.zh.md)

I used to use [Go2Shell](https://zipzapmac.com/go2shell) together with macOS's built-in Terminal. After switching to [Ghostty](https://ghostty.org), I found that Go2Shell doesn't support it — so I built this.

go2ghostty is a macOS Finder toolbar button that opens Ghostty in the current Finder directory, just like Go2Shell but for Ghostty.

## Features

- One-click to open Ghostty from the Finder toolbar
- Automatically `cd` to the current Finder window's directory
- Shows the current directory path highlighted in blue at the top of the terminal
- Falls back to `$HOME` if no Finder window is open

## Requirements

- **Apple Silicon**, macOS 11.0+
- [Ghostty](https://ghostty.org) installed at `/Applications/Ghostty.app`

## Install

```bash
./install.sh
```

This copies the `.app` bundle to `/Applications`.

### Add to Finder Toolbar manually

1. Open a Finder window
2. Hold `⌘ Command` and drag `go2ghostty.app` from `/Applications` into the Finder toolbar
3. Release to drop it in place

## Uninstall

```bash
./install.sh uninstall
```

## Files

| File | Description |
|------|-------------|
| `go2ghostty` | Main bash script — gets current Finder path and launches Ghostty |
| `get_finder_path` | Compiled binary — handles the Finder toolbar button click |
| `Info.plist` | macOS app bundle metadata |
| `Resources/Ghostty.icns` | App icon |

## How it works

When you click the toolbar button:

1. `get_finder_path` (toolbar binary) is triggered by macOS
2. It calls `go2ghostty` (bash script)
3. The script queries Finder's current directory via AppleScript
4. A temporary init script is created that prints the path and then `exec`s an interactive zsh session
5. Ghostty opens a new window running that init script, which loads your `.zshrc` normally