# Arch Learnings from Librarian v0.15.0

**Context:** Working on librarian skill protocol while exercising arch skill.

**Goal:** Capture learnings to generalize arch process later.

---

## Session 2026-02-15

### Finding 1: Mermaid CSS Variables Don't Work

**Problem:** Used `stroke:var(--approved-border)` in linkStyle → Typora/Mermaid doesn't support CSS variables.

**Attempted fix:** Replace with hex `#00AA00` → worked but broke arch principle.

**Arch principle violated:** "Colors must come from variables + classDef, not hardcoded hex (part of PROCESS)."

**Why matters:** Colors in diagrams = architectural decisions (not decoration). Need systematic color management from START.

**Nicholas directive:** "preciso que toda definicao de cores parta DIRETO do variables e classes, sem non-css solutions pra estilizar os nodes. pq eh parte do PROCESSO de arch. concentra."

**Resolution:** Removed all styles temporarily (vanilla diagram). Will create proper CSS variable + classDef template later.

**Lesson for arch skill:**
- Mermaid diagrams need CSS infrastructure UPFRONT (not retrofit)
- Variables + classDef = architectural decision layer
- Workarounds break the design process (not acceptable)

---

## Next Steps (Post-Librarian)

1. Create mermaid CSS template (variables + classDef standard)
2. Document arch color philosophy (why colors = decisions, not decoration)
3. Add to arch SKILL.md workflow (step 1 = define color palette)
4. Test with real diagrams (librarian, other projects)

---

## Raw Notes

(Add findings here as they come up during librarian work)

