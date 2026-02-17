#!/bin/bash
# Refresh all agenda data (Jira + Life + Projects)
# Used by: cronjob (every hour) + reload button (manual)

set -e  # Exit on error

AGENDA_DIR="$HOME/Documents/apps/agenda"
DATA_DIR="$AGENDA_DIR/data"
LIFE_ROADMAP="$HOME/Documents/personal/backstage/ROADMAP.md"
STATUS_FILE="$AGENDA_DIR/.refresh-status"

cd "$AGENDA_DIR"

# Mark as running
echo '{"running":true,"last_run":null}' > "$STATUS_FILE"

echo "🔄 Refreshing agenda data..."

# 1. Update Jira tasks
echo "📋 Fetching Jira tasks..."
python3 update-agenda.py

# 2. Fetch task descriptions
echo "📝 Fetching task descriptions..."
python3 fetch-descriptions.py

# 3. Generate personal.json from personal ROADMAP
echo "🌟 Generating personal epics..."
python3 generate-life-json.py

# 4. Generate corporate.json from nonlinear ROADMAP
echo "💼 Generating corporate epics..."
python3 generate-corporate-json.py

# 5. Generate projects.json (list Documents/* with ROADMAP)
echo "📁 Generating projects list..."
python3 generate-projects-json.py

# Remove old docs.json generation (Settings tab removed)
# echo "⚙️ Generating docs sections..."
# python3 generate-docs-json.py

# Mark as done
NOW=$(date +%s)
echo "{\"running\":false,\"last_run\":$NOW}" > "$STATUS_FILE"

echo "✅ Agenda refresh complete!"
