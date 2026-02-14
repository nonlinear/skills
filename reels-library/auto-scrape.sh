#!/bin/bash
# Auto-scrape Instagram saved posts (cron 3AM)
# Processes "All" collection (collection 1), limit 50 posts per day

set -e

cd ~/Documents/life

# Check if already logged in (cookie exists)
# If not, skip (needs manual login first time)
if [ ! -f ~/.instagram_cookies ]; then
    echo "No Instagram session found. Run manual login first."
    exit 1
fi

# Run reels_library.py with auto-inputs
# Collection 1 (All), 50 posts limit
echo -e "1\n50\n" | /opt/homebrew/bin/python3.11 tasks/reels-library/reels_library.py

# Optional: Auto-sort into topic files
# /opt/homebrew/bin/python3.11 tasks/reels-library/sort_reels_tags.py

echo "✓ Auto-scrape complete. New reels in links/reels.md"
