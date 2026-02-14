#!/bin/bash
# Reels Library - Auto Scrape (Cron 3AM)
# Daily Instagram saved posts scraper

# PROBLEM: Instagram login expires (~30 days)
# SOLUTION: Cookie persistence (save session after manual login)

# SETUP (run once):
# 1. Manual login: cd ~/Documents/life && python3.11 tasks/reels-library/reels_library.py
# 2. Script saves cookies to ~/.instagram_session.json
# 3. Cron reuses cookies (until expiration)
# 4. When cookies expire → Telegram notification → manual re-login

# CRON ENTRY:
# 0 3 * * * ~/Documents/life/tasks/reels-library/auto-scrape-cron.sh

set -e

COOKIE_FILE="$HOME/.instagram_session.json"
LOG_FILE="$HOME/Documents/life/tasks/reels-library/auto-scrape.log"

cd ~/Documents/life

# Check if cookies exist
if [ ! -f "$COOKIE_FILE" ]; then
    echo "[$(date)] ERROR: No Instagram session. Run manual login first." >> "$LOG_FILE"
    # TODO: Send Telegram notification
    exit 1
fi

# Check cookie age (warn if >25 days old)
COOKIE_AGE=$(( ($(date +%s) - $(stat -f %m "$COOKIE_FILE")) / 86400 ))
if [ $COOKIE_AGE -gt 25 ]; then
    echo "[$(date)] WARNING: Cookies are $COOKIE_AGE days old. Re-login soon." >> "$LOG_FILE"
    # TODO: Send Telegram warning
fi

# Run scraper (TODO: modify reels_library.py to accept --auto flag)
# For now: manual run required (Instagram login can't be fully automated)

echo "[$(date)] Auto-scrape skipped - requires modified script for cookie persistence" >> "$LOG_FILE"

# NEXT STEPS:
# 1. Modify reels_library.py to save/load cookies from $COOKIE_FILE
# 2. Add --auto flag (uses saved cookies, no manual login)
# 3. Add --collection <num> and --limit <num> flags
# 4. Then: auto-scrape.sh can run fully unattended
