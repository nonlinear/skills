#!/bin/bash
# Transcribe Instagram Reel (local Whisper)
# Usage: transcribe-reel.sh <instagram-url>

set -e

if [ $# -eq 0 ]; then
    echo "Usage: $0 <instagram-url>"
    echo "Example: $0 https://www.instagram.com/p/DUe_s5WkxWg/"
    exit 1
fi

URL="$1"
POST_ID=$(echo "$URL" | grep -oE '/(p|reel)/([^/]+)' | cut -d'/' -f3)

if [ -z "$POST_ID" ]; then
    echo "Error: Could not extract post ID from URL"
    exit 1
fi

TRANSCRIPT_DIR="$HOME/Documents/life/tasks/reels-library/transcripts"
TRANSCRIPT_FILE="$TRANSCRIPT_DIR/${POST_ID}.txt"

# Check if already transcribed
if [ -f "$TRANSCRIPT_FILE" ]; then
    echo "✅ Already transcribed: $TRANSCRIPT_FILE"
    cat "$TRANSCRIPT_FILE"
    exit 0
fi

mkdir -p "$TRANSCRIPT_DIR"
TEMP_DIR=$(mktemp -d)

echo "📥 Downloading reel: $POST_ID"
yt-dlp "$URL" -o "$TEMP_DIR/video.mp4" --quiet --no-warnings

if [ ! -f "$TEMP_DIR/video.mp4" ]; then
    echo "❌ Download failed"
    rm -rf "$TEMP_DIR"
    exit 1
fi

echo "📝 Transcribing (Whisper medium model)..."
echo "   (First run downloads ~1.5GB model, then cached)"

# Whisper outputs to same directory as input
cd "$TEMP_DIR"
whisper video.mp4 --model medium --language en --output_format txt --output_dir . >/dev/null 2>&1

if [ -f "$TEMP_DIR/video.txt" ]; then
    # Save transcript
    mv "$TEMP_DIR/video.txt" "$TRANSCRIPT_FILE"
    
    echo ""
    echo "✅ Transcription saved: $TRANSCRIPT_FILE"
    echo ""
    echo "--- TRANSCRIPT ---"
    cat "$TRANSCRIPT_FILE"
    echo ""
    echo "📋 Add to markdown:"
    echo "  📝 transcripts/${POST_ID}.txt"
else
    echo "❌ Transcription failed"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Cleanup
rm -rf "$TEMP_DIR"
