# Roadmap Skill

**Purpose:** Manage roadmaps across projects (main + project-specific). Add items, create epics, groom with numbered emoji shortcuts.

---

## Triggers

- "add to main roadmap: X"
- "add to roadmap: X" (defaults to main)
- "[project]: add to roadmap: X" (project-specific)
- Numbered emoji commands: "merge 5️⃣ on 6️⃣", "move 8️⃣ before 7️⃣", "delete 1️⃣7️⃣"

---

## Roadmap Locations

**Pattern:** `<project-root>/backstage/ROADMAP.md`

**Known projects:**
- **main:** `~/.openclaw/workspace/backstage/main/ROADMAP.md` (default)
- **nonlinear:** `~/Documents/nonlinear/backstage/ROADMAP.md`
- **wiley:** `~/Documents/wiley/backstage/ROADMAP.md`
- **librarian:** `~/Documents/librarian/backstage/ROADMAP.md`

**Epic notes:** `<project-root>/backstage/main/epic-notes/` or `<project-root>/backstage/epic-notes/`

---

## Adding Items to Roadmap

**Syntax:**
```
[project:] add to roadmap: <item>
```

**Examples:**
- "add to main roadmap: fix moon phase rendering"
- "add to roadmap: implement voice commands" (defaults to main)
- "nonlinear: add to roadmap: rever pricing strategy"
- "wiley: add to roadmap: fix storybook grid bug"

**Logic:**
1. **Parse project** (prefix or default to main)
2. **Read ROADMAP.md** from project
3. **Find best epic** (semantic match, keywords)
   - Match by topic (security, fitness, finances, etc.)
   - If ambiguous → ask Nicholas which epic
4. **If no epic exists** → create new epic at end of ROADMAP
5. **Add item** to epic's task list or notes
6. **Save ROADMAP.md**
7. **Confirm** to Nicholas (which epic, where added)

**Confirmation protocol:**
- **Always repeat what you did in ONE line**
- Format: `✅ Added "<item>" to <epic-name> (<project> roadmap)`
- Examples:
  - `✅ Added "fix moon phase rendering" to Moon Rituals (main roadmap)`
  - `✅ Added "rever pricing strategy" to NEW epic Pricing Strategy (nonlinear roadmap)`
  - `✅ Merged New Ways to Communicate (5️⃣) into Audio Interface (6️⃣)`

---

## Creating New Epics

**When creating epic:**
1. **Add to ROADMAP.md** (source of truth)
2. **Create epic-notes file** (if needed): `epic-notes/epic-name.md`
3. **Template:**
   ```markdown
   ### v0.X.0 - Epic Name 🔢
   **Status:** 📋 PLANNING
   
   **Goal:** Brief description
   
   **What it provides:**
   - Item 1
   - Item 2
   
   **Next step:** First action
   **Details:** [backstage/.../epic-notes/epic-name.md](...)
   ```
4. **Assign next version number** (check ROADMAP for latest v0.X.0)
5. **Appears in agenda.html** (Life tab) automatically

---

## Grooming Commands (Numbered Emojis)

**Numbered emojis = agenda.html Life tab accordions (1️⃣-1️⃣7️⃣)**

**Commands:**
- **"merge 5️⃣ on 6️⃣"** → Merge epic 5 into epic 6
- **"move 8️⃣ before 7️⃣"** → Reorder epics (prioritization)
- **"delete 1️⃣7️⃣"** → Remove epic from roadmap
- **"split 1️⃣ into 1️⃣a + 1️⃣b"** → Break epic into sub-epics
- **"rename 3️⃣ to X"** → Change epic name

**Logic:**
1. **Map number to epic** (read agenda.html or ROADMAP.md order)
2. **Perform operation** (merge, move, delete, etc.)
3. **Update ROADMAP.md**
4. **Regenerate agenda.html** (refresh-agenda.sh)
5. **Confirm** changes to Nicholas

---

## Protocol: "add to main roadmap"

**When Nicholas says "add to main roadmap":**

1. ✅ **Check existing epics** in `~/.openclaw/workspace/backstage/main/ROADMAP.md`
2. ✅ **If epic exists** → add item to epic
3. ✅ **If epic doesn't exist** → create new epic
4. ✅ **Result:** Appears in agenda.html (Life tab)
5. ✅ **Grooming:** Nicholas decides later (merge, reorder, etc.)

**Never create epic outside ROADMAP.md!**

---

## Epic Creation Rules

**MANDATORY:**
- ✅ Epic MUST be in ROADMAP.md (source of truth)
- ✅ Epic notes go in `epic-notes/` (NOT root of backstage/)
- ✅ Epic gets version number (v0.X.0)
- ✅ Epic appears in agenda.html automatically

**Location pattern:**
```
<project>/backstage/ROADMAP.md         ← Epic listed here
<project>/backstage/epic-notes/epic-name.md  ← Detailed notes
```

---

## Examples

### Example 1: Add to Main Roadmap
```
User: "add to main roadmap: implement touch ID for secrets vault"

Claw:
1. Read ~/.openclaw/workspace/backstage/main/ROADMAP.md
2. Find "Security" epic (v0.X.0)
3. Add "- [ ] Touch ID prompts for secrets vault" to epic tasks
4. Save ROADMAP.md
5. Confirm: "✅ Added to Security epic (3️⃣)"
```

### Example 2: Add to Project Roadmap (New Epic)
```
User: "nonlinear: add to roadmap: rever pricing strategy"

Claw:
1. Read ~/Documents/nonlinear/backstage/ROADMAP.md
2. No "Pricing" epic exists
3. Create new epic at end:
   ### v0.X.0 - Pricing Strategy 🔢
   **Status:** 📋 PLANNING
   **Goal:** Review and optimize pricing
   - [ ] Rever pricing strategy
4. Save ROADMAP.md
5. Confirm: "✅ Created new epic 'Pricing Strategy' in nonlinear roadmap"
```

### Example 3: Grooming
```
User: "merge 5️⃣ on 6️⃣"

Claw:
1. Read agenda.html or ROADMAP.md
2. Epic 5 = "New Ways to Communicate"
3. Epic 6 = "Audio Interface"
4. Merge tasks from 5 → 6
5. Delete epic 5
6. Renumber epics (6 becomes 5, etc.)
7. Refresh agenda.html
8. Confirm: "✅ Merged 'New Ways to Communicate' into 'Audio Interface'"
```

---

## Voice-Friendly Shortcuts

**Why numbered emojis:**
- ✅ Fast (say "merge 5 on 6" vs full names)
- ✅ Visual (agenda.html shows numbers)
- ✅ Unambiguous (no confusion)
- ✅ Voice-friendly (short, clear)

**Nicholas can groom roadmap via voice while walking, at gym, etc.**

---

## Implementation Notes

**Tools needed:**
- Read/write ROADMAP.md files
- Parse markdown sections (find epics by `### v0.X.0`)
- Semantic matching (find best epic for new item)
- Numbered emoji mapping (agenda.html order)

**Future enhancements:**
- Auto-detect project from context (if discussing nonlinear, default to nonlinear roadmap)
- Suggest epic based on conversation history
- Timeline visualization (what's in progress, what's next)

---

**This is your executive secretary for roadmap management. Park information, groom later.** 📋🏴
