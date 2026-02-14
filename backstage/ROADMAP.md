# Skills - Roadmap



### v0.1.0 - Skill Reordering

**Status:** 🏗️ ACTIVE

**Description:** Reorganize skills structure + promote published skills

**Problem:**
- Companion skills (backstage-skill, librarian) live in skills/ but should live in projects
- Published skills need better visibility and discovery
- README should auto-generate from frontmatter

**Tasks:**

**Companion skills reordering:**
- [x] Move reels-library from life/tasks/ to skills/ (transform to skill epic)
- [x] Create epic: v2.0.0 - open-with ("abra X" → app mapping)
- [x] Refactor README.md (table format, frontmatter-driven status)
- [x] Update skills/POLICY.md (README table = frontmatter-driven, auto-discovery, top-aligned)
- [x] Regenerate README table from SKILL.md frontmatters (HTML, valign=top)
- [x] Update POLICY: companions auto-discovered via ~/Documents/*/skill/
- [x] Update POLICY: status without emoji (raw frontmatter values)
- [x] Decide: two tables (standalone + companions) ✅
- [x] Move librarian/ to librarian/skill/ (on epic/v0.15.0-skill-protocol branch), create symlink ✅
- [x] Remove librarian .git (follows parent project) ✅
- [ ] Add "Diagram" column to README tables (link to SKILL.md)
- [ ] POLICY: Every SKILL.md must have diagram after frontmatter
- [ ] Script: Auto-generate missing diagrams (preserve existing, create from skill logic)
- [ ] Remove backstage-skill/ and librarian/ from skills folder (duplicates, are companions)
- [ ] Update OpenClaw system prompt (remove backstage-skill/librarian from available_skills)
- [ ] Move backstage-skill/ to backstage/skill/, create symlink
- [ ] Create skill-protocol.md (frontmatter/formatting rules for all skills)
- [ ] Update skills/POLICY.md to reference skill-protocol.md
- [ ] Companion skills reference skill-protocol.md (prevent drift)
- [ ] Create companion-skills.md blueprint documentation
- [ ] Move companion epics from skills/ROADMAP to project roadmaps
- [ ] Script: auto-generate README table from SKILL.md frontmatters (automate)

**Skill promotion:**
- [ ] Research: Where to link skills on nonlinear.nyc? (portfolio section, skills page, blog?)
- [ ] Design: Skill showcase template (diagram + description + link)
- [ ] Document: Promotion checklist (when to promote, which channels)
- [ ] Implement: Create portfolio/skills page on nonlinear.nyc
- [ ] Test: Promote reminder-research as pilot (measure installs, feedback)

**Philosophy:**
"Companion skills pertencem ao projeto que participam"
- Source in project (git, commits, paridade)
- Discovery via symlinks (~/.openclaw/workspace/skills/)
- Versioning follows project ROADMAP

**Success:**
- Companion skills live in projects, symlinked for discovery
- README auto-generates from frontmatter
- Published skills get 10+ installs
- Clear path: publish → promote → measure
- Repeatable pattern for future companions

---

### v1.0.0 - arch

**Status:** 📋 BACKLOG

**Description:** Architecture design exercises

**Tasks:**
- [ ] https://social.praxis.nyc/@nonlinear/116037514895910044
- [ ] how do we promote it?
- [ ] how you START an exercise? how you CONTINUE? how you do 2 at same time?
- [ ] Add SKILL.md with frontmatter
- [ ] Diary?
- [ ] Test and validate

---

### v1.1.0 - i-ching

**Status:** 📋 BACKLOG

**Description:** I Ching divination

**Tasks:**
- [ ] different divination ways
  - [ ] dice (2 trigrams)
  - [ ] cards (one hexagram)
  - [ ] coins (6 lines, plus mutable lines)

- [ ] como conectar com OUTRO skill, librarian, mas poder funcionar SEM ele?
- [ ] Document usage examples
- [ ] iching oracle diary?
- [ ] Test and validate

---

### v1.4.0 - notify

**Status:** 📋 BACKLOG

**Description:** Notifications

**Tasks:**

- [ ] Whats this?

---

### v1.6.0 - system-detective

**Status:** 📋 BACKLOG

**Description:** System diagnostics

**Tasks:**
- [ ] Hmmmm... isso conectar com relay ON, ne?
- [ ] rlay ON keystroke

---

### v1.7.0 - find-books

**Status:** 📋 BACKLOG

**Description:** Book search

**Tasks:**
- [ ] it is librarian, but cant be toooo close since its piracy

## 

### v2.0.0 - open-with

**Status:** 📋 BACKLOG

**Description:** "Open in app" as a skill - maps file types/contexts to default apps

**Problem:**
- "Abra X" should open in correct app (Typora, VSCode, Excel, etc.)
- Context matters: README → Typora, .py → VSCode, .xlsx → Excel
- Need extensible mapping (user preferences, project defaults)

**Tasks:**
- [ ] Define open-with mapping (file extensions → apps)
- [ ] Support context overrides (project-specific apps)
- [ ] Handle URLs (browser tabs, specific profiles)
- [ ] Document usage examples
- [ ] Test and validate

**Examples:**
- `open README.md` → Typora
- `open script.py` → VSCode
- `open data.xlsx` → Excel (local app)
- `open https://example.com` → Chrome

---

### v2.1.0 - use-for

**Status:** 📋 BACKLOG

**Description:** Skill suggester (scans all skills, suggests based on context)

**Tasks:**
- [ ] Define skill purpose
- [ ] Add SKILL.md with frontmatter
- [ ] Document usage examples
- [ ] Test and validate

---
