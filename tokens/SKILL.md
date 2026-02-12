# Tokens Skill

**Purpose:** Centralize API token management - storage + documentation.

**Triggers:**
- "adiciona token X"
- "salva API key pra Y"
- "preciso de token Z"

---

## 🔴 CRITICAL RULE

**ALWAYS check `~/Documents/life/.env` FIRST before asking for tokens!**

---

## Workflow

### When receiving a new token:

1. **Ask for expiration date**
   - "Quando esse token expira?"
   - Format: YYYY-MM-DD or "1 year" / "never"

2. **Store in .env**
   - **Location:** `~/Documents/life/.env` (canonical location)
   - Format: `SERVICE_NAME_TOKEN=value  # Expires: YYYY-MM-DD`
   - Example: `WILEY_JIRA_TOKEN=abc123  # Expires: 2027-02-12`

3. **Create calendar reminder (if expires)**
   - **When:** 7 days before expiration (1 week warning)
   - **Event:** "⚠️ Renew [SERVICE] API token (expires in 7 days)"
   - **Format:** All-day event
   - **Command:** 
     ```bash
     gog calendar create primary \
       --summary "⚠️ Renew SERVICE token" \
       --from "YYYY-MM-DDT00:00:00-05:00" \
       --to "YYYY-MM-DDT23:59:59-05:00" \
       --description "Token expires YYYY-MM-DD. Renew at: [RENEWAL_URL]"
     ```

4. **Document in connections/**
   - Create or update `~/Documents/life/connections/SERVICE.md`
   - **Include:**
     - What token offers (read/write/scope)
     - **When obtained:** YYYY-MM-DD
     - **Expiry date:** YYYY-MM-DD
     - **Renewal link:** URL to get new token
     - How to use (code examples)
   - Link to .env variable name
   - **Example:**
     ```markdown
     ## Token Info
     - **Obtained:** 2026-02-12
     - **Expires:** 2027-02-12
     - **Renew at:** https://id.atlassian.com/manage-profile/security/api-tokens
     - **Scope:** read-write
     - **Variable:** `WILEY_JIRA_TOKEN` (~/Documents/life/.env)
     ```

5. **Update token index**
   - Maintain list in this SKILL.md (see below)

### When needing API access:

1. **✅ ALWAYS check .env first:** `~/Documents/life/.env`
2. **If not found:** Check connections/ for setup instructions
3. **If still missing:** Ask Nicholas for token

---

## Token Index

**Location:** `~/Documents/life/.env`

| Service | Variable | Scope | Expires | Connection Doc |
|---------|----------|-------|---------|----------------|
| Figma | `FIGMA_TOKEN` | read-write | ? | [figma.md](~/Documents/life/connections/figma.md) |
| Jira (Wiley) | `WILEY_JIRA_TOKEN` | read-write | 2027-02-12 | [jira.md](~/Documents/life/connections/jira.md) |
| NAS | `NAS_HOST`, `NAS_USER`, `NAS_PASS` | SSH/SMB access | - | [mac.md](~/Documents/life/connections/mac.md) |
| Home Assistant | `HA_URL`, `HA_TOKEN` | read-write | 2085-06-06 | TOOLS.md |
| Telegram | `TELEGRAM_CHAT_ID`, `TELEGRAM_PHONE` | messaging | - | - |

---

## Commands

### Add token
```bash
# Append to .env (skill will automate)
echo "SERVICE_TOKEN=value" >> ~/Documents/life/.env
```

### Check token exists
```bash
grep SERVICE_TOKEN ~/Documents/life/.env
```

### List all tokens
```bash
cat ~/Documents/life/.env
```

---

## .env Location

**Canonical location:** `~/Documents/life/.env`

**Why here:**
- ✅ Life infrastructure (shareable, public)
- ✅ Survives workspace wipes
- ✅ Consistent with connections/ folder
- ✅ Not tied to OpenClaw workspace

**Python usage:**
```python
from dotenv import load_dotenv
load_dotenv('/Users/nfrota/Documents/life/.env')
```

**Shell usage:**
```bash
source ~/Documents/life/.env
echo $FIGMA_TOKEN
```

---

**Created:** 2026-02-12  
**Location:** `~/Documents/skills/tokens/SKILL.md`
