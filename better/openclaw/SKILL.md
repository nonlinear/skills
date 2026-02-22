---
name: better-openclaw
type: better
version: 0.2.0
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
  injection: server-side
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

**Toggle ON/OFF:**
```bash
~/.openclaw/workspace/skills/better/openclaw/toggle.sh
```

**Script automatically:**
- Detects current state (ON vs OFF)
- **ON:** Injects CSS into OpenClaw gateway HTML
- **OFF:** Restores original HTML
- Prompts to reload webchat

**Edit CSS:**
- Modify `redesign.css`
- Run `toggle.sh` twice (OFF → ON) to reload changes

---

## How It Works

**Server-side CSS injection:**
1. OpenClaw gateway serves HTML at `/opt/homebrew/lib/node_modules/openclaw/dist/control-ui/index.html`
2. `toggle.sh` modifies this file directly:
   - **ON:** Injects `<style>...</style>` before `</head>`
   - **OFF:** Restores original HTML (no CSS)
3. Reload webchat → CSS applies to all browsers (Safari, Firefox, Chrome, etc.)

**No browser-specific dependencies** (no Chrome DevTools Protocol, no extensions).

---

## Files

- **`redesign.css`** - Custom stylesheet (source of truth)
- **`toggle.sh`** - Toggle ON/OFF (modifies gateway HTML)
- **`index.html.better`** - Cached version with CSS injected

---

## Technique

**Direct HTML modification**

Gateway serves static HTML → modify before serving → CSS applies universally.

See: `css-customization.md` for canonical technique documentation.

---

**Updated:** 2026-02-21  
**Part of:** better/ skills (app customization)
