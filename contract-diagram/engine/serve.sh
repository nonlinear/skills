#!/bin/bash
# Arch Engine - Localhost Server Launcher

ENGINE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PORT=8080

echo "🏴 Arch Engine starting..."
echo "Engine: $ENGINE_DIR"
echo "Port: $PORT"
echo ""
echo "Usage: http://localhost:$PORT/?md=/path/to/file.md"
echo ""
echo "Example tape:"
echo "  http://localhost:$PORT/?md=../../librarian/backstage/epic-notes/v0.15.0-skill-protocol.md"
echo ""
echo "Press Ctrl+C to stop"
echo ""

cd "$ENGINE_DIR" && python3 -m http.server $PORT
