# Mapping to Roadmap Skill

**What it does:** Analyze conversation/findings → map to existing epics OR create new epics

**When to use:** After sessions, meetings, or when Nicholas says "don't want to lose this"

---

## Trigger Patterns

- "map this to roadmap"
- "destrincha essa conversa"
- "não quero perder isso"
- "onde isso vai no roadmap?"

---

## Protocol

### 1. Analyze Conversation
**Identify themes:**
- What was built/shipped?
- What was learned?
- What failed (document as parity)?
- What's planned next?

**Group by context:**
- Does this relate to existing epic?
- Is this NEW enough for own epic?
- Is this just a note (add to epic-notes, not epic itself)?

---

### 2. Match to Existing Epics

**Read ROADMAP.md first:**
```bash
cat ~/.openclaw/workspace/ROADMAP.md
```

**Check backstage/main/ for epic details:**
```bash
ls ~/.openclaw/workspace/backstage/main/ | grep -E "^v0\.|epic-|fae"
```

**Decision tree:**
- **Exact match** → Update epic-note (add section)
- **Related match** → Update epic-note (expand context)
- **No match** → Consider new epic

---

### 3. Create New Epic (if needed)

**Criteria for NEW epic:**
1. **Distinct problem space** (not subset of existing epic)
2. **Multiple components** (not single task)
3. **Affects multiple projects** OR **significant effort** (days/weeks, not hours)
4. **Has own lifecycle** (can be completed/shipped independently)

**Format:**
```markdown
# vX.Y.Z - Epic Name

**Status:** 🆕 NEW (YYYY-MM-DD)
**Priority:** HIGH/MED/LOW
**Why epic:** [Justify why separate epic]

## Problem
[What's broken/missing]

## Goal
[What we're building]

## Components
1. Thing A
2. Thing B
3. Thing C

## Success Metrics
- [ ] Metric 1
- [ ] Metric 2

## Next Steps
1. Step 1
2. Step 2
```

**Filename:** `backstage/main/vX.Y.Z-epic-name.md`

**Version number:** Check highest existing, increment (currently v0.18.0 = next)

---

### 4. Update ROADMAP.md

**Add summary section:**
```markdown
## Epic Name
**Status:** Status here
**Goal:** One-line goal
**Next step:** What's next
**Details:** [link](backstage/main/vX.Y.Z-epic-name.md)
```

**Update footer:**
```markdown
*Last updated: YYYY-MM-DD*
*Current focus: [updated list]*
```

---

### 5. Report Back

**Format:**
```markdown
## Epics ALTERADOS (N):
1. Epic A - what changed
2. Epic B - what changed

## Epics CRIADOS (N):
1. vX.Y.Z Epic Name - what it is

## Arquivos:
- N created
- N modified

## Pendente (if any):
- Thing needing clarification
```

---

## Example Usage

**User:** "destrincha essa conversa e mova pro roadmap"

**Claw:**
1. Analyzes conversation
2. Identifies themes (Paperless, Parity, IEEE timelog, etc.)
3. Matches to existing epics (NAS Cleanup, Finances, etc.)
4. Creates NEW epic if justified (Parity System)
5. Updates epic-notes + ROADMAP.md
6. Reports back: "5 altered, 1 created"

---

## What NOT to Map

**Skip these:**
- Single commands/fixes (too small for epic)
- Temporary debugging (not permanent knowledge)
- Conversation fluff (small talk, clarifications)
- Duplicate info (already documented elsewhere)

**Rule:** If it's < 1 hour of work OR doesn't create reusable knowledge → skip

---

## Output Files

**Always update:**
- Relevant epic-notes (backstage/main/vX.Y.Z-*.md)
- ROADMAP.md (summary section)

**Sometimes create:**
- New epic-note (if criteria met)

**Never touch:**
- AGENTS.md (unless skill/policy change)
- SOUL.md (unless personality/behavior change)
- Other project roadmaps (stay in main workspace)

---

## Refinement Notes

**What worked today (2026-02-09):**
- ✅ Analyzed whole conversation systematically
- ✅ Grouped by theme before mapping
- ✅ Justified new epic (Parity = system, not just docs)
- ✅ Updated existing epics with new sections
- ✅ Clear report back (5 altered, 1 created)

**What to improve:**
- ⚠️ Automate version number detection (check highest vX.Y.Z)
- ⚠️ Template for epic creation (speed up process)
- ⚠️ Better decision criteria (when NEW epic vs expand existing?)

---

**Skill status:** ✅ Working (based on 2026-02-09 session)  
**Next refinement:** After next "map to roadmap" request
