#!/bin/bash
# arch-wrap.sh - Dress the HTML viewer with a contract MD file

set -e

ARCH_TEMPLATE="$HOME/Documents/skills/arch/templates/contract-wrapper.html"
ARCH_WATCH="$HOME/Documents/skills/arch/scripts/watch-reload.py"
PYTHON_BIN="/opt/homebrew/bin/python3.11"  # Use python with websockets installed
PORT=8765
WS_PORT=8767

# Debug mode
if [ "$1" = "debug" ]; then
  echo "🔍 DEBUG MODE"
  echo ""
  echo "📡 HTTP Server (port $PORT):"
  ps aux | grep "[p]ython.*http.server $PORT" || echo "   ❌ Not running"
  echo ""
  echo "👀 WebSocket Watcher (port $WS_PORT):"
  ps aux | grep "[w]atch-reload.py" || echo "   ❌ Not running"
  echo ""
  echo "📝 Watcher logs:"
  tail -20 /tmp/arch-watcher.log 2>/dev/null || echo "   ❌ No logs"
  echo ""
  echo "🌐 Server logs:"
  tail -20 /tmp/arch-server.log 2>/dev/null || echo "   ❌ No logs"
  exit 0
fi

# Get MD file
MD_FILE="${1:-contract.md}"
MD_DIR="$(dirname "$MD_FILE")"
MD_NAME="$(basename "$MD_FILE")"
MD_ABS="$(cd "$MD_DIR" && pwd)/$MD_NAME"

# Check if MD exists
if [ ! -f "$MD_FILE" ]; then
  echo "❌ Error: $MD_FILE not found"
  exit 1
fi

# Copy wrapper to same directory
WRAPPER_PATH="$MD_DIR/contract.html"
cp "$ARCH_TEMPLATE" "$WRAPPER_PATH"

echo "✅ Wrapper created: $WRAPPER_PATH"

# Check if http server is running (use netstat/lsof alternative for macOS sandbox)
if ! ps aux | grep -q "[p]ython.*http.server $PORT"; then
  echo "🚀 Starting localhost server on port $PORT..."
  cd "$MD_DIR"
  python3 -m http.server $PORT > /tmp/arch-server.log 2>&1 &
  sleep 1
  echo "✅ Server running at http://localhost:$PORT"
else
  echo "✅ Server already running on port $PORT"
fi

# Kill old watchers on same port (avoid bind errors)
ps aux | grep "[w]atch-reload.py" | awk '{print $2}' | xargs kill -9 2>/dev/null || true

# Start WebSocket watcher
echo "👀 Starting file watcher on ws://localhost:$WS_PORT..."
cd "$MD_DIR"
$PYTHON_BIN "$ARCH_WATCH" "$MD_ABS" > /tmp/arch-watcher.log 2>&1 &
sleep 2
echo "✅ Watcher running (edit MD → auto-reload)"

# Construct URL
URL="http://localhost:$PORT/contract.html?md=$MD_NAME"

echo ""
echo "🏴 Contract ready (HOT RELOAD enabled):"
echo "   $URL"
echo ""
echo "📝 Source: $MD_FILE"
echo "🌐 Viewer: $WRAPPER_PATH"
echo "👀 Watcher: ws://localhost:$WS_PORT"
echo ""
echo "💡 Edit MD file → browser auto-reloads (no refresh needed)"
echo "💡 Run 'arch-wrap.sh debug' to check status/logs"
echo ""

# Open in browser
if command -v open > /dev/null; then
  open "$URL"
elif command -v xdg-open > /dev/null; then
  xdg-open "$URL"
fi
