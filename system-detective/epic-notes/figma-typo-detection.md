# Figma API - Typo Detection Script

**Date:** 2026-02-06  
**File:** FigJam Board - UX RPM design discrepancies  
**URL:** https://www.figma.com/board/eq0VYeUGYDHkLbIi2leF6p/

---

## Typos Found (2026-02-06)

1. **ongoaing** → **ongoing**
2. **longewr** → **longer**  
3. **auocomplete** → **autocomplete**
4. **suer** → **user**
5. **shoudl** → **should**
6. **defaylts** → **defaults**
7. **thery** → **they**

**Status:** Confirmed by Nicholas, needs manual correction in FigJam

---

## Script: Extract & Check Typos

```bash
# Extract all sticky note text from FigJam
curl -s -H "X-Figma-Token: $FIGMA_TOKEN" \
"https://api.figma.com/v1/files/FILE_KEY?depth=10" | \
jq -r '[.. | .characters? // empty] | unique | .[]' > /tmp/figjam-notes.txt

# Check for common typos
python3 check-typos.py
```

**Script location:** `~/.openclaw/skills/system-detective/scripts/check-figjam-typos.sh`

---

## Figma API Capabilities

**READ-ONLY access:**
- ✅ List pages/frames/components
- ✅ Read sticky note text (`characters` property)
- ✅ Get structure/hierarchy
- ❌ CANNOT edit content (API limitation)

**Workflow:**
1. Claw extracts text via API
2. Claw runs spell check
3. Claw reports typos
4. **Nicholas corrects manually in FigJam**

---

## Reusable for Future

This script works for ANY FigJam board. Just change `FILE_KEY`:

```bash
FILE_KEY="eq0VYeUGYDHkLbIi2leF6p"  # Current: UX RPM discrepancies
# Extract + check
~/.openclaw/skills/system-detective/scripts/check-figjam-typos.sh $FILE_KEY
```

---

*Documented: 2026-02-06 10:52 EST*
