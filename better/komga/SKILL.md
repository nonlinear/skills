---
name: better-komga
type: better
version: 0.1.0
status: experimental
description: Offline reading for Komga (Service Worker cache for comics/books)
author: nonlinear
license: MIT
better:
  type: service-worker
  app:
    name: Komga
    url: https://komga.org
    version: 1.11.1
  platform: web
  browser: all
  reference: service-worker-offline.md
---

# Better Komga

**Enable offline reading for Komga web app.**

---

## What It Does

**Service Worker caching for Komga:**
- 📚 Cache comics/books (read offline)
- 🚀 Faster reading (no network latency)
- 📱 Reduce mobile data (cache once, read many times)

---

## How to Use

**Turn ON:**
```bash
~/Documents/skills/better/toggle-better.sh komga on
```

**Turn OFF:**
```bash
~/Documents/skills/better/toggle-better.sh komga off
```

---

## Implementation

Uses shared Service Worker (`better/shared/service-worker.js`):
- Cache-first for media (images, pages)
- Network-first for API (fresh metadata)
- Automatic cache cleanup on version bump

---

## Epic

See: `backstage/epic-notes/v0.4.0-offline-browser-storage.md`

---

**Updated:** 2026-02-17  
**Part of:** better/ skills (app customization)
