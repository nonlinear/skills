#!/bin/bash
# Check macOS idle time and return notification channel

IDLE_SECONDS=$(/usr/sbin/ioreg -c IOHIDSystem | awk '/HIDIdleTime/ {print int($NF/1000000000)}')
IDLE_THRESHOLD=300  # 5 minutes

if [ "$IDLE_SECONDS" -ge "$IDLE_THRESHOLD" ]; then
  echo "telegram"
else
  echo "here"
fi
