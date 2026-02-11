---
name: context-switch
description: "Conscious project/epic transitions with HEALTH checks. Triggers: 'bom dia' (morning load main+wiley M-F), 'vamos trabalhar no X' (switch to project/epic), 'boa noite' (evening close + victory lap). Prevents context confusion, enforces HEALTH rituals, detects gaps between docs and reality."
type: public
version: 1.0.0
status: stable
dependencies:
  - jq
author: nonlinear
license: MIT
---

# Context Switch - Project & Epic Management

Smart context switching with HEALTH checks for project/epic transitions.

## Concepts

**Project** = has its own `backstage/[name]/HEALTH.md`  
**Epic** = version/feature mentioned in project's ROADMAP.md  

**Switch logic:**
- Same project, different epic → **1 HEALTH check**
- Different projects → **2 HEALTH checks** (close A, open B)

## Commands

### Morning Ritual
```bash
context-switch.sh --morning
```
- Runs `backstage/main/HEALTH.md`
- **M-F only:** Also runs `backstage/wiley/HEALTH.md`
- Sets current context to `main`

### Evening Ritual
```bash
context-switch.sh --evening
```
- Closes current project (HEALTH check)
- Victory lap across all projects worked today
- Clears context state

### Switch Context
```bash
context-switch.sh <project-or-epic-name>
```

**If target = project:**
1. Close current project (HEALTH check + save state)
2. Open new project (HEALTH check + load context)
3. Update `.current-context.json`

**If target = epic (in current project):**
1. Run current project HEALTH check
2. Load epic context (roadmap/specs)
3. Update epic in `.current-context.json`

**If target unknown:**
- List available projects
- Exit with error

### List Available
```bash
context-switch.sh list
# or just:
context-switch.sh
```
Shows current context + available projects.

## Triggers (for AI)

**Morning:**
- "bom dia"
- "começando o dia"
- "vamos começar"

**Switch:**
- "vamos trabalhar no [X]"
- "vamos falar de [X]"
- "abrir [projeto/epic]"
- "boa tarde" (no args → list options)

**Evening:**
- "boa noite"
- "acabei por hoje"
- "fechar o dia"

## Output Format

Script outputs structured messages for AI to parse:

```
MORNING_RITUAL
HEALTH_CHECK|main|/path/to/HEALTH.md
HEALTH_CHECK|wiley|/path/to/HEALTH.md

SWITCH_PROJECT|main|fitness
HEALTH_CHECK|main|/path/to/HEALTH.md
HEALTH_CHECK|fitness|/path/to/HEALTH.md

SWITCH_EPIC|main|null|fitness-tracker
HEALTH_CHECK|main|/path/to/HEALTH.md

EVENING_RITUAL
HEALTH_CHECK|main|/path/to/HEALTH.md
VICTORY_LAP

CURRENT_CONTEXT|main|fitness-tracker
AVAILABLE_PROJECTS
main
wiley
librarian

UNKNOWN_TARGET|xyz
AVAILABLE_PROJECTS
...
```

## AI Processing Logic

1. **Run script** with appropriate args
2. **Parse output** line by line:
   - `HEALTH_CHECK|project|path` → Read HEALTH.md, run checks, announce status
   - `SWITCH_PROJECT|A|B` → Announce closing A, opening B
   - `SWITCH_EPIC|project|old|new` → Announce epic switch within project
   - `VICTORY_LAP` → Summarize today's work across projects
   - `AVAILABLE_PROJECTS` → Present options to user
3. **After HEALTH check:**
   - Load roadmap/specs if switching
   - Diff reality vs docs (files exist? data present?)
   - Announce gaps/status/next steps

## State Files

**Current context:**
```json
// ~/.openclaw/workspace/.current-context.json
{
  "project": "main",
  "epic": "fitness-tracker",
  "since": "2026-02-05T14:00:00Z"
}
```

**History (append-only):**
```jsonl
// ~/.openclaw/workspace/.context-history-YYYY-MM-DD.jsonl
{"timestamp":"2026-02-05T08:00:00Z","action":"switch","project":"main","epic":null}
{"timestamp":"2026-02-05T14:00:00Z","action":"switch","project":"main","epic":"fitness-tracker"}
{"timestamp":"2026-02-05T22:00:00Z","action":"close","project":null,"epic":null}
```

## Project Structure

Projects MUST have:
```
backstage/
  [project-name]/
    HEALTH.md      ← Required
    ROADMAP.md     ← Optional (lists epics)
    SPECS.md       ← Optional
```

## Examples

**Morning:**
```
User: "bom dia"
AI: Run context-switch.sh --morning
    → Read main/HEALTH.md, check status
    → If M-F, also read wiley/HEALTH.md
    → Announce: "Ready to start. Main project loaded. Wiley also active (work day)."
```

**Switch epic:**
```
User: "vamos trabalhar no fitness"
AI: Run context-switch.sh fitness
    → Detects "fitness" in main/ROADMAP.md (epic)
    → SWITCH_EPIC|main|null|fitness
    → Read main/HEALTH.md once
    → Load fitness roadmap/specs
    → Announce: "Fitness epic loaded. Last work: 6 days ago. Ready to add exercises."
```

**Switch project:**
```
User: "vamos trabalhar no wiley"
AI: Run context-switch.sh wiley
    → SWITCH_PROJECT|main|wiley
    → Close main (HEALTH check)
    → Open wiley (HEALTH check)
    → Announce: "Main closed (paused). Wiley opened. Storybook project active."
```

**Evening:**
```
User: "boa noite"
AI: Run context-switch.sh --evening
    → Close current project (HEALTH)
    → VICTORY_LAP
    → Read .context-history-YYYY-MM-DD.jsonl
    → Announce: "Today worked on: main (fitness epic), wiley. Accomplished: [summary]."
```

## Dependencies
- `jq` (JSON processing)
- `backstage/` folder structure
