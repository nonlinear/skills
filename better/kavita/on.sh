#!/bin/bash
# Turn better-kavita ON - Register Service Worker

set -e

KAVITA_DIR="$(cd "$(dirname "$0")" && pwd)"
SHARED_DIR="$KAVITA_DIR/../shared"

# Get Kavita URL from .env
source ~/.openclaw/workspace/.env 2>/dev/null || source ~/Documents/personal/.env

KAVITA_URL="${NAS_HOST:+http://$NAS_HOST:5000}"

if [ -z "$KAVITA_URL" ]; then
  echo "❌ KAVITA_URL not configured"
  echo "   Add to .env: NAS_HOST=your-nas-hostname"
  exit 1
fi

"$SHARED_DIR/register-sw.sh" kavita "$KAVITA_URL"
