# System Detective - Autonomous Access Challenge

**Date:** 2026-02-06  
**Problem:** Can't autonomously navigate Figma/Wiley systems - requires Nicholas to open pages manually

---

## Current Blockers

**Browser Relay (Chrome extension):**
- ❌ Blocked on Wiley domains (MDM restrictions)
- ❌ Can't navigate Figma files (needs manual page switching)
- ⚠️ Works: only when Nicholas manually opens tab + badge ON

**Impact:**
- Nicholas becomes MY assistant (opens pages for me)
- Inverts relationship (I'm supposed to be the secretary)
- Can't investigate systems autonomously

---

## Solutions to Master

### 1. **Figma API** (HIGH PRIORITY)
**Status:** Not configured  
**What we need:**
- Personal Access Token (Nicholas generates once)
- File ID from URLs
- API endpoints:
  - `GET /v1/files/:key` - Get file structure
  - `GET /v1/files/:key/nodes` - Get specific nodes/pages
  - `GET /v1/files/:key/components` - List all components

**Benefits:**
- Autonomous navigation (list all pages, iterate through them)
- Compare design vs production programmatically
- No browser dependency

**Action:** Set up Figma API token + test basic queries

---

### 2. **Jira API** (WORKING ✅)
**Status:** Functional  
**What works:**
- Read issues, descriptions, subtasks
- Update descriptions (append parent context)
- Query by JQL

**Limitations:**
- Can't see rendered Jira page (only data)
- Good enough for task management

---

### 3. **Wiley Systems** (BLOCKED)
**Status:** MDM blocks DevTools Protocol  
**Workarounds attempted:**
- Browser relay → blocked
- Screenshots → manual, not autonomous

**Potential solutions:**
- Wiley API (if exists?) - research needed
- Playwright/Puppeteer with different auth (may still be blocked)
- Accept limitation: manual screenshots for Wiley-specific UIs

---

## Design Principle

**I should navigate systems autonomously, not ask Nicholas to open pages.**

**Bad flow:**
1. Nicholas: "Check all Figma pages"
2. Me: "Open page 1"
3. Nicholas: *opens page*
4. Me: "Now open page 2"
5. Nicholas: *opens page* (repeat 10x)

**Good flow:**
1. Nicholas: "Check all Figma pages"
2. Me: *queries Figma API, gets all pages*
3. Me: *iterates through pages autonomously*
4. Me: "Done. Found 3 discrepancies. Here's the report."

---

## Next Steps

**Immediate (today?):**
1. Research Figma API docs
2. Generate Personal Access Token
3. Test basic API calls (get file structure)
4. Update System Detective skill with Figma API method

**Future:**
- Research Wiley internal APIs (if accessible)
- Document what CAN'T be automated (accept limitations)
- Fallback: ask for screenshots only when no API exists

---

## Success Criteria

**System Detective should be able to:**
- ✅ Navigate Jira autonomously (working)
- 🚧 Navigate Figma autonomously (needs API setup)
- ❌ Navigate Wiley UIs (blocked, needs workaround or acceptance)

**Goal:** Nicholas gives high-level command, I execute without back-and-forth page opening.

---

*Last updated: 2026-02-06*
