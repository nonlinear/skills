#!/bin/bash
# Toggle better-openclaw ON/OFF (modify index.html directly)

set -e

OPENCLAW_HTML="/opt/homebrew/lib/node_modules/openclaw/dist/control-ui/index.html"
BETTER="$OPENCLAW_HTML.better"

# Check if better version exists
if [ ! -f "$BETTER" ]; then
  echo "❌ Better version not found: $BETTER"
  exit 1
fi

# Detect current state (check if <style> tag exists in index.html)
if grep -q "<style>" "$OPENCLAW_HTML"; then
  # Currently ON → turn OFF (restore original)
  echo "🏴 Turning better-openclaw OFF..."
  cat > "$OPENCLAW_HTML" << 'EOF'
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>OpenClaw Control</title>
    <meta name="color-scheme" content="dark light" />
    <link rel="icon" type="image/svg+xml" href="./favicon.svg" />
    <link rel="icon" type="image/png" sizes="32x32" href="./favicon-32.png" />
    <link rel="apple-touch-icon" sizes="180x180" href="./apple-touch-icon.png" />
    <script type="module" crossorigin src="./assets/index-Cx1_w3YP.js"></script>
    <link rel="stylesheet" crossorigin href="./assets/index-DNdFNvs2.css">
  </head>
  <body>
    <openclaw-app></openclaw-app>
  </body>
</html>
EOF
  echo "✅ Better OpenClaw is now OFF (original restored)"
else
  # Currently OFF → turn ON
  echo "🏴 Turning better-openclaw ON..."
  cp "$BETTER" "$OPENCLAW_HTML"
  echo "✅ Better OpenClaw is now ON (CSS injected)"
fi

echo ""
echo "🔄 Reload webchat to see changes: http://127.0.0.1:18789/chat"
