#!/bin/bash
# Design Architecture - Collaborative mermaid diagram design
# Version: 0.1.0

set -e

COMMAND="${1:-help}"
PROJECT_PATH="${2:-.}"

info() { echo -e "\033[0;34mℹ️  $1\033[0m"; }
success() { echo -e "\033[0;32m✅ $1\033[0m"; }
error() { echo -e "\033[0;31m❌ $1\033[0m"; }

case "$COMMAND" in
    help)
        cat << 'EOF'
Design Architecture Skill - Collaborative diagram design

Usage:
  design-architecture start [name]    # Start new architecture design
  design-architecture list            # List saved architectures
  design-architecture open [name]     # Open in Typora

Examples:
  design-architecture start webhook-system
  design-architecture list
  design-architecture open webhook-system

Skill dumps templates and principles. AI iterates with you.
EOF
        ;;
        
    start)
        NAME="${2:-architecture}"
        OUTPUT="epic-notes/${NAME}-architecture.md"
        
        if [ -f "$OUTPUT" ]; then
            error "File exists: $OUTPUT"
            echo "Use 'design-architecture open $NAME' to edit"
            exit 1
        fi
        
        info "Creating new architecture: $NAME"
        
        cat > "$OUTPUT" << 'TEMPLATE'
# [System Name] - Architecture

**Created:** $(date +%Y-%m-%d)  
**Status:** Draft

---

## Legend

**Colors:**
- 🟦 Blue = User input / external triggers
- 🟨 Yellow = Interface / wrapper layer
- 🟩 Green = Business logic / data
- 🟧 Orange = Processing / AI
- 🟪 Purple = Infrastructure (git, DB, queues)

**Arrows:**
- `→` Solid = data flow
- `⤷` Dashed = conditional
- `↺` Curved = loop

**Shapes:**
- `[ ]` Rectangle = process
- `{ }` Diamond = decision
- `(( ))` Cylinder = data store

---

## Diagram

```mermaid
flowchart TD
    START["🟦 Trigger"] --> PROCESS["🟩 Process"]
    PROCESS --> END["✅ Complete"]
    
    style START fill:#2196F3,stroke:#1565C0,color:#fff
    style PROCESS fill:#4CAF50,stroke:#2E7D32,color:#fff
```

---

## Components

| Component | Responsibility | Technology |
|-----------|----------------|------------|
| X | Does Y | Z |

---

## Trade-offs

**Pros:**
- ✅ ...

**Cons:**
- ❌ ...

---

## Next Steps

- [ ] Task 1
- [ ] Task 2

---

**Notes:**
- ...
TEMPLATE
        
        success "Created: $OUTPUT"
        
        # Open in Typora if available
        if command -v typora &> /dev/null; then
            open -a Typora "$OUTPUT"
            info "Opened in Typora"
        fi
        
        info "📌 Now iterate with AI to refine diagram"
        ;;
        
    list)
        info "Saved architectures:"
        ls -1 epic-notes/*-architecture.md 2>/dev/null || echo "  (none yet)"
        ;;
        
    open)
        NAME="${2:-architecture}"
        FILE="epic-notes/${NAME}-architecture.md"
        
        if [ ! -f "$FILE" ]; then
            error "Not found: $FILE"
            exit 1
        fi
        
        if command -v typora &> /dev/null; then
            open -a Typora "$FILE"
            success "Opened: $FILE"
        else
            cat "$FILE"
        fi
        ;;
        
    *)
        error "Unknown command: $COMMAND"
        echo ""
        echo "Usage: design-architecture {help|start|list|open}"
        exit 1
        ;;
esac

exit 0
