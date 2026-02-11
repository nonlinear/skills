---
name: notify
description: "Detect user presence (idle/active) and choose notification channel. Triggers: 'me avisa quando X', 'let me know when Y', 'lmk Z'. Monitors task completion, notifies via Telegram (away) or in-chat (active). Uses macOS ioreg for idle detection."
type: public
version: 1.0.0
status: stable
dependencies:
  - ioreg
  - telegram-api
author: nonlinear
license: MIT
---

# Notify Skill

**Detects user presence and chooses notification channel.**

## When to Use

User says one of these → Monitor task + notify when done:
- "me avisa quando [...]"
- "me avisa [...]"
- "let me know when [...]"
- "let me know [...]"
- "lmk when [...]"
- "lmk [...]"
- "LMK [...]"

## How It Works

**Detection:** macOS idle time via `ioreg`

```bash
# Get idle time in seconds
ioreg -c IOHIDSystem | awk '/HIDIdleTime/ {print int($NF/1000000000)}'
```

**Logic:**
- **Idle < 5 minutes** → User present, reply in current chat
- **Idle ≥ 5 minutes** → User away, send to Telegram

## Usage Pattern

**User says:** "me avisa quando o deploy terminar"

**AI does:**
1. Monitor the task (deploy, build, download, etc.)
2. When task completes, check idle time
3. Notify via appropriate channel

## Implementation

```bash
#!/bin/bash
# check-idle.sh

IDLE_SECONDS=$(ioreg -c IOHIDSystem | awk '/HIDIdleTime/ {print int($NF/1000000000)}')
IDLE_THRESHOLD=300  # 5 minutes

if [ "$IDLE_SECONDS" -ge "$IDLE_THRESHOLD" ]; then
  echo "telegram"
else
  echo "here"
fi
```

## Example

```javascript
// Pseudo-code for AI workflow
async function notifyWhenDone(taskName, checkFunction) {
  // Wait for task to complete
  while (!checkFunction()) {
    await sleep(10000); // Check every 10s
  }
  
  // Task done - check where to notify
  const channel = await checkIdleTime();
  
  if (channel === "telegram") {
    await sendTelegram(`✅ ${taskName} terminado!`);
  } else {
    return `✅ ${taskName} terminado!`; // Reply in chat
  }
}
```

## Notes

- macOS only (ioreg)
- Requires Telegram configured in TOOLS.md
- Threshold: 5 minutes (configurable)

---

**Created:** 2026-02-04
