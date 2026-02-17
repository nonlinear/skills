#!/bin/bash
# Turn better-openclaw ON - Apply CSS customization

set -e

OPENCLAW_DIR="$(cd "$(dirname "$0")" && pwd)"
CSS_FILE="$OPENCLAW_DIR/redesign.css"

# Check if CSS exists
if [ ! -f "$CSS_FILE" ]; then
  echo "❌ CSS file not found: $CSS_FILE"
  exit 1
fi

# Start Chrome DevTools Protocol injection
echo "🎨 Injecting CSS into OpenClaw..."
"$OPENCLAW_DIR/open-claw.sh" &

echo "✅ Better OpenClaw CSS active"
echo "   Dashboard: http://127.0.0.1:18789/"
echo "   (Keep tab open for hot reload)"
