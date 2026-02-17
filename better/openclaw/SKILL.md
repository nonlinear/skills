---
name: openclaw
type: better
version: 0.1.0
status: stable
description: Clean OpenClaw webchat UI (dark theme, minimal layout, hide noise)
author: nonlinear
license: MIT
better:
  type: css
  app:
    name: OpenClaw
    url: https://openclaw.ai
    version: 2026.2.9
  platform: web
  browser: chrome
  reference: css-customization.md
---

# Better OpenClaw

**Make OpenClaw webchat cleaner, darker, more focused.**

---

## What It Does

**CSS customization for OpenClaw webchat:**
- 🌑 Dark theme (easier on eyes)
- 🧹 Minimal layout (hide noise, show content)
- 🎯 Focus mode (reduce distractions)

---

## How to Use

**1. Run injection script:**
```bash
./open-claw.sh
```

**2. Script automatically:**
- Opens Chrome DevTools
- Injects `redesign.css` into OpenClaw webchat
- Keeps running (hot reload on CSS changes)

**3. Edit CSS:**
- Modify `redesign.css`
- Changes apply immediately (hot reload)

---

## Files

- **`redesign.css`** - Custom stylesheet
- **`open-claw.sh`** - Injection script (Chrome DevTools Protocol)

---

## Technique

**CSS injection via Chrome DevTools Protocol**

See: `css-customization.md` for canonical technique documentation.

---

**Updated:** 2026-02-17  
**Part of:** better/ skills (app customization)
