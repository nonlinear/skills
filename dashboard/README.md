# Agenda

A personal dashboard

---

## What It Is

Agenda = unified dashboard (HTML + JSON) com tudo que Nicholas precisa ver diariamente:
- **Jira tasks** (overdue, today, soon)
- **Calendar events** (today + tomorrow)
- **Moon phase** (current cycle + meditation)
- **Projects** (active + pending)
- **Skills** (installed + available)
- **Memory** (recent + long-term)
- **Wiley links** (Jira, Storybook, Design Discrepancy)

---

## How It Works

**Stack:**
- `agenda.html` - Frontend (HTML + vanilla JS)
- `data/*.json` - Backend (auto-generated via scripts)
- `python3 -m http.server 8765` - Local webserver (always-on)

**Data flow:**
1. **Cronjob** runs `refresh-agenda.sh` at 3AM daily
2. Scripts fetch data (Jira API, Calendar, ROADMAP.md parsing)
3. JSON files updated in `data/`
4. Frontend auto-reloads data (no refresh needed)

**Localhost:** http://localhost:8765/agenda.html

---

## Files

### Frontend
- `agenda.html` - Dashboard UI

### Data Scripts
- `refresh-agenda.sh` - Master refresh (all data sources)
- `update-agenda.py` - Jira tasks fetch
- `fetch-descriptions.py` - Jira task descriptions
- `generate-life-json.py` - Life epics from ROADMAP
- `generate-projects-json.py` - Projects list
- `generate-docs-json.py` - Docs sections

### Data Files (auto-generated)
- `data/jira.json` - Jira tasks (symlink to workspace)
- `data/jira-tasks.json` - Task details
- `data/calendar-today.json` - Today's events (symlink)
- `data/calendar-tomorrow.json` - Tomorrow's events (symlink)
- `data/moon-phase.json` - Moon data
- `data/life.json` - Life epics
- `data/life-epics.json` - Epic details
- `data/projects.json` - Projects list (symlink)
- `data/docs.json` - Documentation sections

### Config
- `.refresh-status` - Refresh status tracker

---

## Setup

### 1. Start Localhost
```bash
cd ~/Documents/apps/agenda
python3 -m http.server 8765 &
```

Or use manager:
```bash
~/.openclaw/workspace/scripts/localhost-manager.sh start
```

### 2. Open Dashboard
```bash
open http://localhost:8765/agenda.html
```

Or set as Mac Web App (Safari):
1. Open agenda.html in Safari
2. File → Add to Dock
3. Opens as standalone app (no browser chrome)

### 3. Cronjob (auto-refresh)
Already configured (runs 3AM daily):
```cron
0 3 * * * /Users/nfrota/Documents/apps/agenda/refresh-agenda.sh
```

---

## Manual Refresh

```bash
cd ~/Documents/apps/agenda
bash refresh-agenda.sh
```

Or click reload button in agenda.html UI.

---

## Dependencies

**Python scripts:**
- `gog` CLI (Google Calendar)
- Jira API access (credentials in .env)

**Symlinks:**
- `data/jira.json` → `~/.openclaw/workspace/data/jira.json`
- `data/calendar-*.json` → `~/.openclaw/workspace/data/calendar-*.json`
- `data/projects.json` → `~/.openclaw/workspace/data/projects.json`

---

🤖

| Backstage files                                              | Description        |
| ------------------------------------------------------------ | ------------------ |
| [README](README.md)                                          | Our project        |
| [CHANGELOG](backstage/CHANGELOG.md)                          | What we did        |
| [ROADMAP](backstage/ROADMAP.md)                              | What we wanna do   |
| POLICY: [project](backstage/POLICY.md), [global](backstage/global/POLICY.md) | How we go about it |
| HEALTH: [project](backstage/HEALTH.md), [global](backstage/global/HEALTH.md) | What we accept     |

We use **[backstage protocol](https://github.com/nonlinear/backstage)**, v0.3.5
🤖
