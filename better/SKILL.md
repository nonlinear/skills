# Better - App Customization Skills

**Master skill for browser/app customizations.**

---

## What is Better?

**Better** = Make apps work the way WE want.

Not redesign. Not fixes. Not plugins.

**Honest truth:** We improve things for OUR use.

---

## Skills in Better/

Each app gets its own folder:

- **`better/openclaw/`** - Clean OpenClaw UI (CSS dark theme, minimal layout)
- **`better/kavita/`** - Offline Kavita reading (Service Worker cache)
- **`better/komga/`** - Offline Komga reading (Service Worker cache)

---

## How It Works

**Each skill:**
1. Has its own `SKILL.md` with frontmatter
2. Uses `type: better` classification
3. Nested `better:` block with app details
4. References canonical technique docs

**Frontmatter example:**
```yaml
---
name: openclaw
type: better
version: 0.1.0
better:
  type: css
  app:
    name: OpenClaw
    url: https://openclaw.ai
    version: 2026.2.9
  browser: chrome
---
```

---

## Techniques

**CSS** - Custom stylesheets (dark themes, layout tweaks)  
**Service Worker** - PWA offline caching (read without internet)  
**Browser Extension** - Chrome/Firefox extensions  
**Bookmarklet** - JavaScript bookmarklets  
**Userscript** - Tampermonkey/Greasemonkey scripts

---

## Why "Better"?

Because it's honest.

We're not fixing bugs. We're not following standards.

**We're making things work the way WE want.**

That's better. For us. 🏴
