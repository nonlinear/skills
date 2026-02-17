#!/bin/bash
# Toggle better-openclaw (CSS injection on/off)
# Usage: ./toggle.sh [on|off]

set -e

OPENCLAW_DIR="$(cd "$(dirname "$0")" && pwd)"
STATE_FILE="$OPENCLAW_DIR/.state"

# Read current state
if [ -f "$STATE_FILE" ]; then
  CURRENT_STATE=$(cat "$STATE_FILE")
else
  CURRENT_STATE="off"
fi

# Determine action
ACTION="${1:-toggle}"

case "$ACTION" in
  on)
    TARGET_STATE="on"
    ;;
  off)
    TARGET_STATE="off"
    ;;
  toggle)
    if [ "$CURRENT_STATE" = "on" ]; then
      TARGET_STATE="off"
    else
      TARGET_STATE="on"
    fi
    ;;
  status)
    if [ "$CURRENT_STATE" = "on" ]; then
      echo "✅ better-openclaw is ACTIVE"
    else
      echo "⚪ better-openclaw is inactive"
    fi
    exit 0
    ;;
  *)
    echo "Usage: $0 [on|off|toggle|status]"
    exit 1
    ;;
esac

# Execute
if [ "$TARGET_STATE" = "on" ]; then
  echo "🏴 Turning better-openclaw ON..."
  "$OPENCLAW_DIR/on.sh"
  echo "on" > "$STATE_FILE"
  echo "✅ Better OpenClaw is now ACTIVE"
else
  echo "🏴 Turning better-openclaw OFF..."
  "$OPENCLAW_DIR/off.sh"
  echo "off" > "$STATE_FILE"
  echo "⚪ Better OpenClaw is now INACTIVE"
fi
