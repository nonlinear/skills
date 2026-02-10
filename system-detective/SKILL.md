# System Detective Skill

**Triggers:** `investiga`, `consulta`, `vê`, `sniff`, `inspeciona`

**Purpose:** Auto-detect the right tool to investigate/inspect systems, URLs, or topics.

---

## Decision Tree

When user says "investiga X" or "vê X":

### 1. **Detect context type:**

**A. Jira (Wiley tasks):**
- URL contains `jira.wiley.com` or `wiley-global.atlassian.net`
- Keywords: `task`, `ticket`, `UXPMS-XXX`
- **Action:** Use `jira-check.py` or Jira REST API
- **Credentials:** `~/Documents/wiley/jira-check.py` (API token embedded)

**B. Figma (design files):**
- URL contains `figma.com/design` or `figma.com/board`
- Keywords: `figma`, `design`, `figjam`
- **Action:** Use Figma MCP (`mcporter call "Figma Desktop.get_metadata"`)
- **Note:** Figma Desktop must be running

**C. Books/Topics (librarian):**
- **Default fallback** when no specific system detected
- Any conceptual query, topic, or "what is X?" question
- Direct triggers: `pesquisa`, `research`
- **Action:** Use librarian skill (`~/Documents/librarian/engine/scripts/research.py`)
- **Follow librarian rules:** cite sources, check books first, NEVER generic advice

**Detection logic:**
- If detective trigger (`investiga|consulta|vê|sniff`) + no URL/system match → librarian
- Topics are NOT hardcoded (dynamic based on book index)
- Examples: "investiga servitors", "vê o que diz sobre familiars", "consulta chaos magick"

**D. NAS apps (home server):**
- URL contains `192.168.1.152` or keywords: `kavita`, `paperless`, `homeassistant`, `changedetection`, `searxng`
- **Action:** 
  - Browser relay (if badge ON)
  - SSH + curl fallback: `ssh nonlinear@192.168.1.152 "curl -s http://localhost:PORT"`
- **NAS services:**
  - Kavita: `:5000` (ebooks)
  - Paperless: `:8010` (documents)
  - Home Assistant: `:8123` (devices, automation)
  - changedetection.io: `:5555` (price tracking)
  - SearXNG: `:8888` (meta-search)

**E. RPM/Wiley systems:**
- URL contains `.wiley.host` or `.wiley.com`
- **Action:** Manual (browser relay blocked by MDM)
  - Ask for screenshot
  - Guide navigation verbally
- **Known issue:** Chrome relay fails on Wiley domains (corporate restriction)

**F. Web URLs (general):**
- HTTP/HTTPS URL not matching above
- **Action:**
  1. Try browser relay (if badge ON and not Wiley)
  2. Fallback: `web_fetch` (markdown extraction)

**G. Ambiguous/unclear:**
- Ask user: "Quer que eu investigue via Jira, Figma, livros, ou web?"

---

## Examples

**User:** "investiga UXPMS-168"  
→ Jira API (get issue details)

**User:** "vê o Figma do RPM"  
→ Figma MCP (needs URL or current selection)

**User:** "pesquisa tarot no livro"  
→ Librarian skill (research.py)

**User:** "sniff kavita"  
→ Browser relay (if ON) or SSH curl to :5000

**User:** "consulta RPM login page"  
→ Manual (screenshot request, Wiley domain blocked)

**User:** "investiga https://example.com"  
→ Browser relay or web_fetch

---

## NAS Inventory (192.168.1.152)

**Services running:**
- **Kavita** (`:5000`) - Ebook library, EPUB/PDF reader
- **Paperless-ngx** (`:8010`) - Document management (OCR, tags, archive)
- **Home Assistant** (`:8123`) - Smart home automation, lights, climate
- **changedetection.io** (`:5555`) - Website monitoring, price tracking
- **SearXNG** (`:8888`) - Privacy-focused meta-search engine

**Access methods:**
- Local network: `http://192.168.1.152:PORT`
- Remote (Tailscale, iPad/iPhone only): `http://media.adal-rigel.ts.net:PORT`
- SSH: `ssh nonlinear@192.168.1.152` (password: `sambalele`, sudo required for docker)

**Browser relay:** Works for Kavita, others untested (badge ON required)

---

## Tools Reference

**Jira:**
- Script: `python3 ~/Documents/wiley/jira-check.py`
- API: `https://wiley-global.atlassian.net/rest/api/3/`
- Auth: Embedded in jira-check.py

**Figma:**
- MCP: `mcporter call "Figma Desktop.get_metadata" --nodeId "X:Y"`
- Requires: Figma Desktop app running

**Librarian:**
- Script: `cd ~/Documents/librarian/engine/scripts && python3 research.py "query" --top-k N`
- Always cite sources (book title, page, chapter)

**Browser relay:**
- Check tabs: `browser action=tabs profile=chrome`
- Snapshot: `browser action=snapshot profile=chrome`
- Badge must be ON (per-tab)

**Web fetch:**
- Tool: `web_fetch url="https://..." extractMode="markdown"`
- Fallback when relay unavailable

---

## Notes

- **Wiley MDM blocks Chrome DevTools Protocol** on `.wiley.host` domains
- **Figma MCP may be offline** (check with `mcporter list`)
- **NAS accessible only on home network** (MacBook can't use Tailscale)
- **Librarian priority:** Check books BEFORE giving generic advice
- **2-minute rule:** If investigation >2min, create epic

---

**Last updated:** 2026-02-05
