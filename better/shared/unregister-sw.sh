#!/bin/bash
# Unregister Service Worker for better offline storage
# Usage: unregister-sw.sh {app} {url}

set -e

APP="$1"
APP_URL="$2"

if [ -z "$APP" ] || [ -z "$APP_URL" ]; then
  echo "Usage: $0 {app} {url}"
  echo "Example: $0 kavita http://media.adal-rigel.ts.net:5000"
  exit 1
fi

echo "🏴 Unregistering Service Worker for $APP..."
echo "   URL: $APP_URL"
echo ""

# Generate unregistration script
UNREG_SCRIPT=$(cat <<EOF
if ('serviceWorker' in navigator) {
  navigator.serviceWorker.getRegistrations().then((registrations) => {
    registrations.forEach((registration) => {
      registration.unregister().then((success) => {
        if (success) {
          console.log('✅ SW unregistered for $APP');
        }
      });
    });
    alert('Better $APP: Offline storage disabled');
  });
  
  // Clear caches
  caches.keys().then((cacheNames) => {
    cacheNames.forEach((cacheName) => {
      if (cacheName.includes('better-storage')) {
        caches.delete(cacheName);
        console.log('🧹 Deleted cache:', cacheName);
      }
    });
  });
} else {
  alert('Service Workers not supported in this browser');
}
EOF
)

echo "🌐 Open $APP in browser and run this in console:"
echo ""
echo "$UNREG_SCRIPT"
echo ""
echo "💡 Or use browser DevTools → Application → Service Workers → Unregister"
