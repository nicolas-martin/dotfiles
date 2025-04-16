#!/usr/bin/env bash

NAME="${NAME:-spotify}"

# Check if Spotify is running
if ! pgrep -xq Spotify; then
  echo "[spotify plugin] Spotify is not running" >&2
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

STATE=$(osascript -e 'tell application "Spotify" to player state as string')
if [[ "$STATE" != "playing" ]]; then
  echo "[spotify plugin] Spotify is not playing" >&2
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

TITLE=$(osascript -e 'tell application "Spotify" to name of current track')
ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track')

if [[ -n "$TITLE" && -n "$ARTIST" ]]; then
  sketchybar --set "$NAME" label="$ARTIST – $TITLE" drawing=on
else
  sketchybar --set "$NAME" label="No info" drawing=on
fi

