#!/usr/bin/env python3
"""
Generate data/corporate.json from nonlinear ROADMAP.md
Run: python3 ~/Documents/apps/agenda/generate-corporate-json.py
"""
import json
import os
import re

ROADMAP_PATH = os.path.expanduser("~/Documents/nonlinear/backstage/ROADMAP.md")
OUTPUT_PATH = os.path.join(os.path.dirname(__file__), "data", "corporate.json")

def parse_roadmap():
    """Parse ROADMAP.md and extract epics."""
    if not os.path.exists(ROADMAP_PATH):
        return {"epics": []}
    
    with open(ROADMAP_PATH, 'r') as f:
        content = f.read()
    
    epics = []
    
    # Match epic blocks: ## vX.Y.Z
    epic_pattern = r'## (v[\d\.]+)\n\n### (.*?)\n\n(.*?)(?=\n## |\Z)'
    matches = re.findall(epic_pattern, content, re.DOTALL)
    
    for version, title, body in matches:
        # Extract goal
        goal_match = re.search(r'\*\*Goal:\*\* (.*)', body)
        goal = goal_match.group(1).strip() if goal_match else ""
        
        # Extract tasks (count checkboxes)
        tasks = re.findall(r'- \[([ x])\]', body)
        total_tasks = len(tasks)
        completed_tasks = sum(1 for t in tasks if t == 'x')
        
        # Determine status
        if completed_tasks == total_tasks and total_tasks > 0:
            status = "✅ Done"
        elif completed_tasks > 0:
            status = f"🔄 In Progress ({completed_tasks}/{total_tasks})"
        else:
            status = "📋 Planned"
        
        epics.append({
            "version": version,
            "title": title,
            "status": status,
            "goal": goal,
            "tasks": {
                "total": total_tasks,
                "completed": completed_tasks
            }
        })
    
    return {"epics": epics}

if __name__ == "__main__":
    print("🔄 Generating corporate.json from nonlinear ROADMAP.md...")
    data = parse_roadmap()
    
    os.makedirs(os.path.dirname(OUTPUT_PATH), exist_ok=True)
    
    with open(OUTPUT_PATH, 'w') as f:
        json.dump(data, f, indent=2)
    
    print(f"✅ Generated: {OUTPUT_PATH}")
    print(f"   {len(data['epics'])} epics found")
