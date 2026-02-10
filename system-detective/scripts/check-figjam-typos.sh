#!/bin/bash
# Check FigJam board for typos
# Usage: ./check-figjam-typos.sh FILE_KEY

FILE_KEY="${1:-eq0VYeUGYDHkLbIi2leF6p}"
FIGMA_TOKEN="${FIGMA_TOKEN:-$(cat ~/.openclaw/workspace/.env | grep FIGMA_TOKEN | cut -d'=' -f2)}"

echo "🔍 Extracting sticky notes from FigJam..."
curl -s -H "X-Figma-Token: $FIGMA_TOKEN" \
"https://api.figma.com/v1/files/$FILE_KEY?depth=10" | \
jq -r '[.. | .characters? // empty] | unique | .[]' > /tmp/figjam-notes.txt

echo "✅ Extracted $(wc -l < /tmp/figjam-notes.txt) notes"
echo ""
echo "📝 Checking for typos..."
echo ""

python3 << 'PYEOF'
import re

TYPOS = {
    'shoudl': 'should',
    'longewr': 'longer',
    'defaylts': 'defaults',
    'auocomplete': 'autocomplete',
    'suer': 'user',
    'thery': 'they',
    'ongoaing': 'ongoing',
    'teh': 'the',
    'recieve': 'receive',
    'occured': 'occurred',
}

with open('/tmp/figjam-notes.txt', 'r') as f:
    notes = f.readlines()

findings = []
for i, note in enumerate(notes, 1):
    note_clean = note.strip()
    if not note_clean:
        continue
    
    for typo, correction in TYPOS.items():
        if re.search(r'\b' + typo + r'\b', note_clean, re.IGNORECASE):
            match = re.search(r'\b' + typo + r'\b', note_clean, re.IGNORECASE)
            start = max(0, match.start() - 30)
            end = min(len(note_clean), match.end() + 30)
            context = note_clean[start:end]
            
            findings.append({
                'typo': match.group(),
                'correction': correction,
                'context': context.strip()
            })

if findings:
    for idx, f in enumerate(findings, 1):
        print(f"{idx}. **{f['typo']}** → **{f['correction']}**")
        print(f"   \"...{f['context']}...\"")
        print()
else:
    print("✅ No typos found!")

PYEOF
