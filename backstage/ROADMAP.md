# Skills - Roadmap



### v0.1.0 - Promoting Skills

**Status:** 🏗️ ACTIVE

**Description:** Marketing and visibility strategy for published skills

**Problem:**
Skills published to ClawHub need better visibility and discovery.

**Solution:**
1. **Portfolio page:** Link published skills on nonlinear.nyc (where? how?)
2. **Better descriptions:** Mermaid diagrams, clear use cases, screenshots
3. **Promotion pipeline:** Newsletter? Social media pins? Community engagement?

**Tasks:**
- [ ] Research: Where to link skills on nonlinear.nyc? (portfolio section, skills page, blog?)
- [ ] Design: Skill showcase template (diagram + description + link)
- [ ] Document: Promotion checklist (when to promote, which channels)
- [ ] Implement: Create portfolio/skills page on nonlinear.nyc
- [ ] Test: Promote reminder-research as pilot (measure installs, feedback)

**Success:**
- Published skills get 10+ installs
- Clear path: publish → promote → measure
- Repeatable promotion workflow

---

### v0.2.0 - backstage-skill

**Status:** 📋 BACKLOG

**Description:** Universal pre-commit workflow skill (published to ClawHub)

**Tasks:**
- [ ] Auto-create backstage files if missing (ROADMAP, CHANGELOG, HEALTH, POLICY templates)
- [ ] Merge context-switch skill logic (project transitions + HEALTH checks)
- [ ] Merge roadmap skill logic (epic planning, grooming, emoji shortcuts)
- [ ] Add README.md to backstage-skill/ folder
- [ ] Document skill usage examples
- [ ] Test on multiple projects (life, librarian, wiley)

**Published:** https://clawhub.ai/skills/backstage (v0.1.0)

---

### v0.3.0 - Dealing with Companion Skills

**Status:** 🏗️ ACTIVE

**Description:** Version parity, symlinks, update detection for external skills

**Problem:**
- Companion skills (backstage-skill, librarian) live outside skills project
- Version mismatches between skill and project expectations
- Symlink dependencies (backstage/global/)
- No update detection

**Tasks:**
- [x] Phase 1: Symlink strategy (admin vs external users)
- [ ] Phase 2: Parity detection (version checks, self-report, parity file)
- [ ] Phase 3: Graceful degradation (hard fail vs soft warn vs feature detect)
- [ ] Phase 4: Update prompts (suggest updates when detected)
- [ ] **Debug: Global POLICY syntax not reverberating on skill** (template changes don't propagate to READMEs)
- [ ] **Resolve auto-push/auto-commit rules** (need rules for in/out of branches)

**Open questions:**
- Symlink for everyone? (admin vs external)
- Parity on SOME projects, not others? (project-specific versions)
- Skill says "update me"? (where, when, how)

**Success:**
- Version mismatches detected automatically
- Clear update path
- Graceful degradation when features missing
- Projects can pin specific companion skill versions

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

### v1.2.0 - context-switch

**Status:** 📋 BACKLOG

**Description:** Project/epic transitions with HEALTH checks

**Tasks:**
- [ ] merge with backstage skill

---

### v1.3.0 - apple-reminders-processing

**Status:** 📋 BACKLOG

**Description:** Process reminders without notes

**Tasks:**
- [ ] why is it a skill? isnt it a HEARTBEAT?
- [ ] extend to apple notes
- [ ] Document usage examples
- [ ] Test and validate

---

### v1.4.0 - notify

**Status:** 📋 BACKLOG

**Description:** Notifications

**Tasks:**

- [ ] Whats this?

---

### v1.5.0 - roadmap

**Status:** 📋 BACKLOG

**Description:** Roadmap management

**Tasks:**
- [ ] merge to backstage

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

### v2.0.0 - use-for

**Status:** 📋 BACKLOG

**Description:** Skill suggester (scans all skills, suggests based on context)

**Tasks:**
- [ ] Define skill purpose
- [ ] Add SKILL.md with frontmatter
- [ ] Document usage examples
- [ ] Test and validate

---

## Companion Skills (Reference Only)

**These skills live in other projects:**

- `librarian-companion` → See `~/Documents/librarian/backstage/ROADMAP.md`
- `design-discrepancy` → See `~/Documents/wiley/backstage/ROADMAP.md` (if exists)
- `backstage` → See `~/.openclaw/skills/backstage/` (global skill)

---

## Deprecated/Cleanup

### v0.1.0 - Cleanup

**Status:** 📋 BACKLOG

**Tasks:**
- [ ] Delete `iching` (old version, use `i-ching`)
- [ ] Resolve `mapping-to-roadmap` (delete or document)

---

_Add more epics as you plan features_
