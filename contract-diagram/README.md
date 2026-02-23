# Arch Engine - Mermaid Diagram Viewer

**Tape machine architecture for rendering mermaid diagrams with external CSS.**

---

## Concept

**Engine = HTML wrapper** (plays tapes)  
**Tape = MD files** with mermaid diagrams (data)

The engine loads any markdown file and renders its mermaid diagrams with a unified CSS system.

---

## Quick Start

1. **Start engine:**
   ```bash
   ~/Documents/skills/arch/engine/serve.sh
   ```

2. **Open in browser:**
   ```
   http://localhost:8080/?md=/path/to/file.md
   ```

3. **Example (librarian tape):**
   ```
   http://localhost:8080/?md=../../librarian/backstage/epic-notes/v0.15.0-skill-protocol.md
   ```

---

## Components

- **index.html** - Viewer (fetches MD, extracts mermaid, renders)
- **styles.css** - CSS variables + mermaid customization
- **serve.sh** - Localhost launcher (port 8080)
- **README.md** - This file

---

## How It Works

### 1. URL Parameter

Pass MD file path via `?md=` query parameter (relative to engine directory).

### 2. Fetch & Parse

Engine fetches MD file, extracts mermaid code blocks (```` ```mermaid ... ``` ````).

### 3. Render

Mermaid.js renders diagrams, CSS applies styling via class selectors.

---

## CSS Variables

Define colors ONCE in `styles.css`:

```css
:root {
    --approved-border: #00AA00;
    --blocker-bg: #FF0000;
    --pending-bg: #FFD700;
    --in-progress-bg: #4A90E2;
}
```

Applied via selectors (no inline styles in mermaid code):

```css
.mermaid .node.approved rect {
    stroke: var(--approved-border) !important;
    stroke-width: 3px !important;
}
```

---

## Adding New Tapes

1. **Create MD file** with mermaid diagram anywhere
2. **Point engine to file:**
   ```
   http://localhost:8080/?md=/path/to/new-file.md
   ```
3. **Diagrams render automatically** with unified CSS

No need to modify engine code!

---

## Design Principles

### Clean Diagrams

Mermaid code stays vanilla (no inline styles):

```mermaid
graph LR
    A[Task] --> B[Done]
```

### External CSS

All styling via CSS variables + selectors (single source of truth).

### Reusable

Any project can use engine (just point to different MD files).

---

## Limitations

**Path resolution:** Currently relative to engine directory. For absolute paths or different projects, may need symlinks or path adjustments.

**CSS application:** Mermaid doesn't support CSS variables INSIDE diagrams, so we apply styles via external selectors. This means class-based styling (`.node.approved`) works, but direct variable references in mermaid code don't.

---

## Future Improvements

- [ ] Absolute path support (or config file for tape locations)
- [ ] Multiple diagrams per page (with navigation)
- [ ] Theme switcher (dark mode, color schemes)
- [ ] Export rendered diagrams (SVG/PNG)

---

**Built:** 2026-02-15  
**Epic:** skills v1.1.0 (Architecture Design Workflow)  
**Dual track:** librarian v0.15.0 (first tape)
