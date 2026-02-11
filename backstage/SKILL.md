---
name: backstage
description: "Manage backstage workflow in projects (ROADMAP, POLICY, HEALTH, CHANGELOG). Triggers: 'backstage start', 'vamos trabalhar no X', 'backstage health'. Installs protocol if missing, updates global rules, runs health checks, shows active epics. Use for: epic planning, project setup, quality enforcement, context switching."
type: public
version: 0.3.0
status: stable
dependencies:
  - https://github.com/nonlinear/backstage
  - curl
  - bash
  - jq
author: nonlinear
license: MIT
---

# Backstage - Project Management Protocol

**Standalone skill for backstage workflow management.**

---

## What It Does

Manages the backstage protocol in any project:
- Install backstage structure (ROADMAP, POLICY, HEALTH, CHANGELOG)
- Update global rules from GitHub
- Run health checks (project + global)
- Display active epics

**Philosophy:** Every project has backstage/ folder. ROADMAP = what you're building. POLICY = how you build. HEALTH = what you test.

---

## Trigger

User says:
- "backstage start" / "vamos trabalhar no X"
- "backstage health"
- "context switch to [project]"
- Any variation requesting project context

---

## Flow

### 1. Check if backstage exists

```bash
PROJECT_PATH="${PROJECT_PATH:-.}"

if [ ! -d "$PROJECT_PATH/backstage" ]; then
  INSTALL_NEEDED=true
else
  INSTALL_NEEDED=false
fi
```

**If not found:** Ask user: "No backstage/ folder found. Install? (y/n)"

---

### 2. Install Backstage (if needed)

**Source:** `github.com/nonlinear/backstage` branch `main`

**Files to copy:**
1. Templates → `backstage/` (ROADMAP, CHANGELOG, POLICY, HEALTH)
2. Global rules → `backstage/global/` (POLICY, HEALTH)

```bash
mkdir -p backstage/global

# Fetch templates
for file in ROADMAP CHANGELOG POLICY HEALTH; do
  curl -fsSL "https://raw.githubusercontent.com/nonlinear/backstage/main/templates/${file}-template.md" \
    -o "backstage/${file}.md"
done

# Fetch global files
for file in POLICY.md HEALTH.md; do
  curl -fsSL "https://raw.githubusercontent.com/nonlinear/backstage/main/global/${file}" \
    -o "backstage/global/${file}"
done
```

**Result:** "✅ Backstage installed! Edit backstage/ROADMAP.md to plan"

---

### 3. Check for updates (if backstage exists)

**Version detection:**

```bash
LOCAL_VERSION=$(grep "backstage rules" backstage/README.md | grep -oE 'v[0-9.]+' | head -1)
REMOTE_VERSION=$(curl -s "https://raw.githubusercontent.com/nonlinear/backstage/main/README.md" | grep "backstage rules" | grep -oE 'v[0-9.]+' | head -1)
```

**Update check:** Once per day (tracked via `.last-update-check`)

**If versions differ:**
- Show tease message (changelog highlights)
- Ask: "Update? (y/n)"
- Save answer to skip re-asking today

---

### 4. Update Backstage (if user says yes)

**What to update:** `backstage/global/` only (replace, no merge)

```bash
rm -rf backstage/global
mkdir -p backstage/global

for file in POLICY.md HEALTH.md; do
  curl -fsSL "https://raw.githubusercontent.com/nonlinear/backstage/main/global/${file}" \
    -o "backstage/global/${file}"
done
```

**After update:** "✅ Updated! Run 'backstage start' again"

---

### 5. Execute POLICY protocol

**Read both:**
- `backstage/global/POLICY.md`
- `backstage/POLICY.md` (if exists)

**Rule:** Project POLICY wins over global (polycentric governance)

**What POLICY does:**
- Updates navigation blocks in core files
- Updates version numbers
- Creates/updates progress diagrams (mermaid)

*(Currently placeholder - full logic in GitHub repo)*

---

### 6. Execute HEALTH protocol

**Read both:**
- `backstage/global/HEALTH.md`
- `backstage/HEALTH.md` (if exists)

**Rule:** Project HEALTH wins over global

**What HEALTH does:**

Extract and run bash code blocks:

```bash
grep -A 50 '```bash' HEALTH.md | while IFS= read -r line; do
  # Run checks, report results
done
```

**Results:**
- ✅ All pass → "All health checks passed!"
- ❌ Some fail → "Failed: [list]"

**Auto-fix:** Try simple fixes (create missing files, etc)
**Recheck:** Run again after auto-fix
**If still failing:** Report to user, continue (don't block)

---

### 7. Display "What's next?"

**Show active epics from ROADMAP:**

```bash
grep -E '^## v[0-9.]+|^### ' backstage/ROADMAP.md | while read line; do
  echo "  • v${VERSION} - ${TITLE}"
done
```

**Result:**

```
📌 What's next?

Active epics:
  • v0.1.0 - Environment Setup
  • v0.2.0 - Navigation Logic

✅ Session ready! 🚀
```

---

## Error Handling

**Network errors:**
- Warn: "⚠️ Network error - couldn't check updates"
- Continue workflow (don't block)

**Missing files:**
- Auto-create if possible
- Otherwise: warn + continue

**Health check failures:**
- Show which checks failed
- Suggest fixes (case-by-case)
- Don't block session start

---

## Commands

**Main workflow:**
```
backstage start [project-path]
```

**Health checks only:**
```
backstage health
```

**Manual install:**
```
backstage install
```

**Force update:**
```
backstage update
```

---

## Integration with Other Skills

**context-switch:** Calls backstage start when switching projects
**roadmap:** Edits backstage/ROADMAP.md
**Skills project:** Uses backstage for its own management

**Backstage = meta-skill** (manages projects that use skills)

---

## Philosophy

**Backstage exists to reduce metabolic cost:**
- ROADMAP = visible priorities (ADHD-friendly)
- HEALTH = automated quality checks
- POLICY = documented conventions
- CHANGELOG = what we did (memory aid)

**Polycentric governance:**
- Global rules = defaults
- Project rules = override
- No central authority

**Rituals:**
- Morning: backstage start (load context)
- Evening: backstage health (close clean)
- Switch: backstage start [project] (new context)

**Diagram > prose:** Mermaid flows show system state visually.

---

## Notes

**This skill is standalone** (no external prompt needed).

**Backstage repo:** https://github.com/nonlinear/backstage

**Use cases:**
- Project setup (new repo)
- Epic planning (ROADMAP grooming)
- Quality enforcement (HEALTH checks)
- Context switching (load project state)

**Related skills:**
- context-switch (uses backstage)
- roadmap (edits ROADMAP.md)
