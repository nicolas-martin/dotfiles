#!/usr/bin/env bash
NAME="${NAME:-spotify}"

# If called by SketchyBar event (media_change)
if [[ -n "$INFO" ]]; then
  APP=$(echo "$INFO" | jq -r '.app // empty')
  STATE=$(echo "$INFO" | jq -r '.state // empty')
  TITLE=$(echo "$INFO" | jq -r '.title // empty')
  ARTIST=$(echo "$INFO" | jq -r '.artist // empty')

  if [[ "$STATE" == "playing" && -n "$TITLE" && -n "$ARTIST" ]]; then
    sketchybar --set "$NAME" label="$ARTIST – $TITLE" drawing=on
  else
    sketchybar --set "$NAME" drawing=off
  fi

  exit 0
fi

# If no INFO, poll manually and emit media_change
APP=""
STATE=""
TITLE=""
ARTIST=""

if pgrep -xq Spotify; then
  APP="Spotify"
  STATE=$(osascript -e 'tell application "Spotify" to player state as string')
  if [[ "$STATE" == "playing" ]]; then
    TITLE=$(osascript -e 'tell application "Spotify" to name of current track')
    ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track')
  fi
fi

# echo "[spotify plugin] triggering media_change with:" >&2
# echo "  app: $APP" >&2
# echo "  state: $STATE" >&2
# echo "  title: $TITLE" >&2
# echo "  artist: $ARTIST" >&2
if [[ -n "$TITLE" && -n "$ARTIST" ]]; then
  INFO=$(jq -nc \
    --arg app "$APP" \
    --arg state "$STATE" \
    --arg title "$TITLE" \
    --arg artist "$ARTIST" \
    '{app: $app, state: $state, title: $title, artist: $artist}')



if [[ -n "$INFO" ]]; then
  echo "[spotify plugin] handling media_change with INFO:" >&2
  echo "$INFO" | jq . >&2

  APP=$(echo "$INFO" | jq -r '.app // empty')
  STATE=$(echo "$INFO" | jq -r '.state // empty')
  TITLE=$(echo "$INFO" | jq -r '.title // empty')
  ARTIST=$(echo "$INFO" | jq -r '.artist // empty')

  if [[ "$STATE" == "playing" && -n "$TITLE" && -n "$ARTIST" ]]; then
    sketchybar --set "$NAME" label="$ARTIST – $TITLE" drawing=on
  else
    sketchybar --set "$NAME" drawing=off
  fi

  exit 0
fi

  env INFO="$INFO" sketchybar --trigger media_change
fi
