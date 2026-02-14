#!/bin/bash
# Transcribe Instagram Reel - Full Workflow
# 1. Download video
# 2. Transcribe with Whisper
# 3. Save to life/links/transcriptions/
# 4. Update source markdown file with link back
# 5. Delete video
# 6. Report time elapsed

set -e

if [ $# -lt 2 ]; then
    echo "Usage: $0 <instagram-url> <source-markdown-file>"
    echo "Example: $0 https://www.instagram.com/p/ABC123/ ~/Documents/life/links/ai.md"
    exit 1
fi

URL="$1"
SOURCE_FILE="$2"
START_TIME=$(date +%s)

# Extract post ID
POST_ID=$(echo "$URL" | grep -oE '/(p|reel)/([^/]+)' | cut -d'/' -f3)

if [ -z "$POST_ID" ]; then
    echo "❌ Could not extract post ID from URL"
    exit 1
fi

TRANSCRIPT_DIR="$HOME/Documents/life/links/transcriptions"
TRANSCRIPT_FILE="$TRANSCRIPT_DIR/${POST_ID}.md"

# Check if already transcribed
if [ -f "$TRANSCRIPT_FILE" ]; then
    END_TIME=$(date +%s)
    ELAPSED=$((END_TIME - START_TIME))
    echo "✅ Already transcribed (cached): $TRANSCRIPT_FILE"
    echo "⏱️  Time: ${ELAPSED}s"
    cat "$TRANSCRIPT_FILE"
    exit 0
fi

mkdir -p "$TRANSCRIPT_DIR"
TEMP_DIR=$(mktemp -d)

echo "📥 [1/5] Downloading reel: $POST_ID"
yt-dlp "$URL" -o "$TEMP_DIR/video.mp4" --quiet --no-warnings 2>&1

if [ ! -f "$TEMP_DIR/video.mp4" ]; then
    echo "❌ Download failed"
    rm -rf "$TEMP_DIR"
    exit 1
fi

echo "📝 [2/5] Transcribing with Whisper (medium model)..."
cd "$TEMP_DIR"
whisper video.mp4 --model medium --output_format txt --output_dir . >/dev/null 2>&1

if [ ! -f "$TEMP_DIR/video.txt" ]; then
    echo "❌ Transcription failed"
    rm -rf "$TEMP_DIR"
    exit 1
fi

echo "💾 [3/5] Saving transcript: transcriptions/${POST_ID}.md"

# Extract metadata from source file
TITLE=$(grep "$URL" "$SOURCE_FILE" 2>/dev/null | sed -E 's/.*\[(.+)\]\(.*/\1/' || echo "(no title)")
AUTHOR=$(grep "$URL" "$SOURCE_FILE" 2>/dev/null | grep -oE '@[a-zA-Z0-9_.]+' | head -1 || echo "")
TAGS=$(grep "$URL" "$SOURCE_FILE" 2>/dev/null | grep -oE '#[a-zA-Z0-9_-]+' || echo "")
DATE=$(grep "$URL" "$SOURCE_FILE" 2>/dev/null | grep -oE '#[0-9]{4}-[0-9]{2}-[0-9]{2}' | sed 's/#//' | head -1 || echo "")

# Create markdown with metadata
cat > "$TRANSCRIPT_FILE" <<EOF
# [$TITLE]($URL)

**Author:** $AUTHOR  
**Tags:** $TAGS  
**Date:** $DATE  

---

## Transcript

$(cat "$TEMP_DIR/video.txt")
EOF

echo "🔗 [4/5] Updating source file: $(basename "$SOURCE_FILE")"
# Find line with URL and add transcript link if not already there
if grep -q "$URL" "$SOURCE_FILE"; then
    # Check if transcript link already exists
    if ! grep -A1 "$URL" "$SOURCE_FILE" | grep -q "📝 transcriptions/${POST_ID}.md"; then
        # Add transcript line right after the URL line
        sed -i.bak "/$(echo "$URL" | sed 's/[\/&]/\\&/g')/a\\
  📝 transcriptions/${POST_ID}.md
" "$SOURCE_FILE"
        rm "${SOURCE_FILE}.bak"
        echo "   ✅ Added transcript link to markdown"
    else
        echo "   ℹ️  Transcript link already exists"
    fi
else
    echo "   ⚠️  URL not found in source file (skipping update)"
fi

echo "🗑️  [5/5] Cleaning up video files..."
rm -rf "$TEMP_DIR"

END_TIME=$(date +%s)
ELAPSED=$((END_TIME - START_TIME))

echo ""
echo "✅ COMPLETE!"
echo "⏱️  Total time: ${ELAPSED}s"
echo ""
echo "--- TRANSCRIPT ---"
cat "$TRANSCRIPT_FILE"
echo ""
echo "📂 Saved: transcriptions/${POST_ID}.md"
echo "🔗 Linked in: $(basename "$SOURCE_FILE")"
