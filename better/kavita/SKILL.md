---
name: better-kavita
type: better
version: 0.1.0
status: draft
description: Offline reading for Kavita (Service Worker cache for comics/books)
author: nonlinear
license: MIT
better:
  type: service-worker
  app:
    name: Kavita
    url: https://kavitareader.com
    version: 0.7.14
  platform: web
  browser: all
  reference: service-worker-offline.md
---

# Better Kavita

**Enable offline reading for Kavita web app.**

---

## What It Does

**Service Worker caching for Kavita:**
- 📚 Cache comics/books (read offline)
- 🚀 Faster reading (no network latency)
- 📱 Reduce mobile data (cache once, read many times)

---

## How to Use

**Turn ON:**
```bash
~/Documents/skills/better/toggle-better.sh kavita on
```

**Turn OFF:**
```bash
~/Documents/skills/better/toggle-better.sh kavita off
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
