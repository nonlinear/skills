#!/bin/bash
# Start agenda app (http server + refresh backend)
# Run: ~/Documents/life/agenda/start-agenda.sh

AGENDA_DIR="$HOME/Documents/life/agenda"
cd "$AGENDA_DIR"

# Kill existing servers
pkill -f "python.*8765"
pkill -f "python.*8766"

# Start HTTP server (agenda app)
python3 -m http.server 8765 > /dev/null 2>&1 &
echo "✅ Agenda app: http://localhost:8765/agenda.html"

# Start refresh backend
python3 refresh-server.py > /dev/null 2>&1 &
echo "✅ Refresh backend: http://localhost:8766/refresh"

echo ""
echo "🎯 Open: http://localhost:8765/agenda.html"
