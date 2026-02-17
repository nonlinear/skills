#!/bin/bash
# Turn better-openclaw OFF - Remove CSS customization

set -e

echo "🧹 Removing better-openclaw CSS..."

# Kill Chrome DevTools Protocol process
pkill -f "open-claw.sh" 2>/dev/null || true
pkill -f "chrome-devtools-protocol" 2>/dev/null || true

# Reload OpenClaw tab (removes injected CSS)
echo "♻️  Reload OpenClaw tab to see original styles"
echo "   (CSS injection stopped)"

echo "⚪ Better OpenClaw CSS removed"
