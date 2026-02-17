#!/bin/bash
# Toggle Better - Turn app customizations on/off
# Usage: toggle-better.sh {app} [on|off|status]

set -e

BETTER_DIR="$(cd "$(dirname "$0")" && pwd)"
STATE_FILE="$BETTER_DIR/.state.json"

# Initialize state file if missing
if [ ! -f "$STATE_FILE" ]; then
  echo '{}' > "$STATE_FILE"
fi

# Helper: Get app state
get_state() {
  local app="$1"
  jq -r ".\"$app\".active // false" "$STATE_FILE"
}

# Helper: Set app state
set_state() {
  local app="$1"
  local active="$2"
  local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  
  jq --arg app "$app" \
     --arg active "$active" \
     --arg ts "$timestamp" \
     '.[$app] = {active: ($active == "true"), since: $ts}' \
     "$STATE_FILE" > "$STATE_FILE.tmp" && mv "$STATE_FILE.tmp" "$STATE_FILE"
}

# Helper: Show status
show_status() {
  echo "🏴 Better Status:"
  echo ""
  
  for app_dir in "$BETTER_DIR"/*/; do
    app=$(basename "$app_dir")
    [ "$app" = "*" ] && continue
    [ ! -f "$app_dir/SKILL.md" ] && continue
    
    active=$(get_state "$app")
    if [ "$active" = "true" ]; then
      echo "  ✅ $app - ACTIVE"
    else
      echo "  ⚪ $app - inactive"
    fi
  done
}

# Main logic
APP="${1:-}"
ACTION="${2:-toggle}"

if [ -z "$APP" ] || [ "$APP" = "status" ]; then
  show_status
  exit 0
fi

# Check if app exists
if [ ! -d "$BETTER_DIR/$APP" ]; then
  echo "❌ App not found: $APP"
  echo ""
  echo "Available apps:"
  ls -1 "$BETTER_DIR" | grep -v "toggle-better.sh\|SKILL.md\|.state.json"
  exit 1
fi

# Get current state
CURRENT_STATE=$(get_state "$APP")

# Determine action
case "$ACTION" in
  on)
    TARGET_STATE="true"
    ;;
  off)
    TARGET_STATE="false"
    ;;
  toggle)
    if [ "$CURRENT_STATE" = "true" ]; then
      TARGET_STATE="false"
    else
      TARGET_STATE="true"
    fi
    ;;
  *)
    echo "❌ Invalid action: $ACTION"
    echo "Usage: toggle-better.sh {app} [on|off|toggle]"
    exit 1
    ;;
esac

# Execute script
if [ "$TARGET_STATE" = "true" ]; then
  echo "🏴 Turning better ON for $APP..."
  if [ -f "$BETTER_DIR/$APP/on.sh" ]; then
    "$BETTER_DIR/$APP/on.sh"
    set_state "$APP" "true"
    echo "✅ Better $APP is now ACTIVE"
  else
    echo "❌ Missing on.sh script for $APP"
    exit 1
  fi
else
  echo "🏴 Turning better OFF for $APP..."
  if [ -f "$BETTER_DIR/$APP/off.sh" ]; then
    "$BETTER_DIR/$APP/off.sh"
    set_state "$APP" "false"
    echo "⚪ Better $APP is now INACTIVE"
  else
    echo "❌ Missing off.sh script for $APP"
    exit 1
  fi
fi
