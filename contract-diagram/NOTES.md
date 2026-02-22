
## Future: Hot Reload Without New Tabs

**Problem:** Currently `open` command creates new tab each time. Need same-page reload.

**Options:**
1. **WebSocket injection:** watch-reload.py sends message, page auto-refreshes
2. **AppleScript Safari:** Tell Safari to reload specific tab by URL
3. **Browser automation:** Playwright/Puppeteer controlled instance

**Current workaround:** Manual refresh or new tab via `open` with timestamp.

**Decision needed:** Which approach fits arch skill best?


## Reload Without Stealing Focus

**Problem:** `open URL` creates new tab AND switches focus (interrupts work)

**Solution:** `open -g URL` (background, no focus steal)

**Usage:**
```bash
open -g "http://localhost:8765/contract.html?md=file.md&t=$(date +%s)"
```

**Effect:** New tab opens, browser updates, but you stay in current app (editor, terminal, etc.)

