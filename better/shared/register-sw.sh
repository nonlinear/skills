#!/bin/bash
# Register Service Worker for better offline storage
# Usage: register-sw.sh {app} {url}

set -e

APP="$1"
APP_URL="$2"

if [ -z "$APP" ] || [ -z "$APP_URL" ]; then
  echo "Usage: $0 {app} {url}"
  echo "Example: $0 kavita http://media.adal-rigel.ts.net:5000"
  exit 1
fi

SHARED_DIR="$(cd "$(dirname "$0")" && pwd)"
SW_FILE="$SHARED_DIR/service-worker.js"

if [ ! -f "$SW_FILE" ]; then
  echo "❌ Service Worker not found: $SW_FILE"
  exit 1
fi

echo "🏴 Registering Service Worker for $APP..."
echo "   URL: $APP_URL"
echo ""

# Generate registration script
REG_SCRIPT=$(cat <<EOF
if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('/service-worker.js')
    .then((registration) => {
      console.log('✅ SW registered for $APP:', registration);
      alert('Better $APP: Offline storage enabled!');
    })
    .catch((error) => {
      console.error('❌ SW registration failed:', error);
      alert('Failed to enable offline storage: ' + error);
    });
} else {
  alert('Service Workers not supported in this browser');
}
EOF
)

echo "📋 Copy this Service Worker file to $APP_URL/service-worker.js:"
echo "   $SW_FILE"
echo ""
echo "🌐 Then open $APP in browser and run this in console:"
echo ""
echo "$REG_SCRIPT"
echo ""
echo "💡 Or use browser extension to inject SW automatically"
