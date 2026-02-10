#!/bin/bash
# Context Switch - Project/Epic transitions with HEALTH checks
# Usage: context-switch.sh [--morning|--evening|project-name|epic-name]

set -e

WORKSPACE="$HOME/.openclaw/workspace"
BACKSTAGE="$WORKSPACE/backstage"
STATE_FILE="$WORKSPACE/.current-context.json"
HISTORY_FILE="$WORKSPACE/.context-history-$(date +%Y-%m-%d).jsonl"

# Initialize state if missing
if [ ! -f "$STATE_FILE" ]; then
  echo '{"project":null,"epic":null,"since":null}' > "$STATE_FILE"
fi

# Helper: Get current context
get_current() {
  jq -r ".$1 // \"null\"" "$STATE_FILE"
}

# Helper: Set context
set_context() {
  local project="$1"
  local epic="$2"
  local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  
  jq -n \
    --arg p "$project" \
    --arg e "$epic" \
    --arg t "$timestamp" \
    '{project: $p, epic: $e, since: $t}' > "$STATE_FILE"
  
  # Log to history
  echo "{\"timestamp\":\"$timestamp\",\"action\":\"switch\",\"project\":\"$project\",\"epic\":\"$epic\"}" >> "$HISTORY_FILE"
}

# Helper: Clear context
clear_context() {
  echo '{"project":null,"epic":null,"since":null}' > "$STATE_FILE"
  local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  echo "{\"timestamp\":\"$timestamp\",\"action\":\"close\",\"project\":null,\"epic\":null}" >> "$HISTORY_FILE"
}

# Helper: Run HEALTH check
run_health() {
  local project="$1"
  local health_file="$BACKSTAGE/$project/HEALTH.md"
  
  if [ -f "$health_file" ]; then
    echo "HEALTH_CHECK|$project|$health_file"
  else
    echo "NO_HEALTH|$project"
  fi
}

# Helper: Check if target is a project
is_project() {
  [ -d "$BACKSTAGE/$1" ] && [ -f "$BACKSTAGE/$1/HEALTH.md" ]
}

# Helper: List available projects
list_projects() {
  echo "AVAILABLE_PROJECTS"
  for dir in "$BACKSTAGE"/*/ ; do
    if [ -f "$dir/HEALTH.md" ]; then
      basename "$dir"
    fi
  done
}

# Helper: Check if target is an epic in current project
is_epic() {
  local current_project=$(get_current "project")
  local roadmap="$BACKSTAGE/$current_project/ROADMAP.md"
  
  if [ -f "$roadmap" ]; then
    grep -qi "$1" "$roadmap" && echo "yes" || echo "no"
  else
    echo "no"
  fi
}

# MAIN LOGIC

ACTION="${1:-list}"

case "$ACTION" in
  --morning)
    echo "MORNING_RITUAL"
    
    # Check day of week for Wiley
    DOW=$(date +%u)  # 1=Monday, 5=Friday
    
    run_health "main"
    
    if [ "$DOW" -ge 1 ] && [ "$DOW" -le 5 ]; then
      # M-F: also check Wiley
      if is_project "wiley"; then
        run_health "wiley"
      fi
    fi
    
    set_context "main" "null"
    ;;
    
  --evening)
    echo "EVENING_RITUAL"
    
    CURRENT_PROJECT=$(get_current "project")
    
    if [ "$CURRENT_PROJECT" != "null" ]; then
      run_health "$CURRENT_PROJECT"
    fi
    
    echo "VICTORY_LAP"
    clear_context
    ;;
    
  list|"")
    CURRENT_PROJECT=$(get_current "project")
    CURRENT_EPIC=$(get_current "epic")
    
    echo "CURRENT_CONTEXT|$CURRENT_PROJECT|$CURRENT_EPIC"
    list_projects
    ;;
    
  *)
    # Target specified - determine if project or epic
    TARGET="$1"
    CURRENT_PROJECT=$(get_current "project")
    CURRENT_EPIC=$(get_current "epic")
    
    if is_project "$TARGET"; then
      # Switching projects
      echo "SWITCH_PROJECT|$CURRENT_PROJECT|$TARGET"
      
      if [ "$CURRENT_PROJECT" != "null" ] && [ "$CURRENT_PROJECT" != "$TARGET" ]; then
        run_health "$CURRENT_PROJECT"
      fi
      
      run_health "$TARGET"
      set_context "$TARGET" "null"
      
    elif [ "$(is_epic "$TARGET")" = "yes" ]; then
      # Switching epic within same project
      echo "SWITCH_EPIC|$CURRENT_PROJECT|$CURRENT_EPIC|$TARGET"
      
      run_health "$CURRENT_PROJECT"
      set_context "$CURRENT_PROJECT" "$TARGET"
      
    else
      echo "UNKNOWN_TARGET|$TARGET"
      list_projects
      exit 1
    fi
    ;;
esac
