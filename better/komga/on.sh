#!/bin/bash
# Turn better-komga ON - Register Service Worker

set -e

KOMGA_DIR="$(cd "$(dirname "$0")" && pwd)"
SHARED_DIR="$KOMGA_DIR/../shared"

# Get Komga URL from .env
source ~/.openclaw/workspace/.env 2>/dev/null || source ~/Documents/personal/.env

KOMGA_URL="${NAS_HOST:+http://$NAS_HOST:25600}"

if [ -z "$KOMGA_URL" ]; then
  echo "❌ KOMGA_URL not configured"
  echo "   Add to .env: NAS_HOST=your-nas-hostname"
  exit 1
fi

"$SHARED_DIR/register-sw.sh" komga "$KOMGA_URL"
