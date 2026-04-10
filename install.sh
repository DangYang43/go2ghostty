#!/bin/bash
set -e

APP_NAME="go2ghostty.app"
APP_DEST="/Applications/${APP_NAME}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [[ "$1" == "uninstall" ]]; then
    echo "Removing ${APP_DEST}..."
    rm -rf "${APP_DEST}"
    echo "Done. Remove from Finder toolbar by holding ⌘ and dragging the button out."
    exit 0
fi

echo "Installing ${APP_NAME} to /Applications..."

mkdir -p "${APP_DEST}/Contents/MacOS"
mkdir -p "${APP_DEST}/Contents/Resources"

cp "${SCRIPT_DIR}/Info.plist"       "${APP_DEST}/Contents/Info.plist"
cp "${SCRIPT_DIR}/go2ghostty"       "${APP_DEST}/Contents/MacOS/go2ghostty"
cp "${SCRIPT_DIR}/get_finder_path"  "${APP_DEST}/Contents/MacOS/get_finder_path"
cp "${SCRIPT_DIR}/Resources/go2ghostty.icns" "${APP_DEST}/Contents/Resources/go2ghostty.icns"

chmod +x "${APP_DEST}/Contents/MacOS/go2ghostty"
chmod +x "${APP_DEST}/Contents/MacOS/get_finder_path"

echo "Done! To add to Finder toolbar:"
echo "  Hold ⌘ and drag 'go2ghostty' from /Applications into the Finder toolbar."
