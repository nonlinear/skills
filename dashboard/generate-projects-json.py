#!/usr/bin/env python3
"""
Generate data/projects.json from ~/Documents/* with ROADMAP detection
Run: python3 ~/Documents/life/agenda/generate-projects-json.py
"""
import json
import os
from pathlib import Path

DOCS_DIR = Path.home() / "Documents"
OUTPUT_PATH = Path(__file__).parent / "data" / "projects.json"

# Project emoji mapping (customize as needed)
PROJECT_EMOJIS = {
    "life": "🌟",
    "wiley": "💼",
    "librarian": "📚",
    "fitness": "💪",
    "home": "🏠",
    "notes": "📝",
}

def get_project_status(project_path):
    """Determine project status based on ROADMAP existence."""
    roadmap_path = project_path / "backstage" / "ROADMAP.md"
    if roadmap_path.exists():
        return "Active"
    return "Pending"

def get_last_modified(project_path):
    """Get last modified timestamp of project directory."""
    try:
        return int(project_path.stat().st_mtime)
    except:
        return 0

def generate_projects():
    """Generate projects list from ~/Documents."""
    skip = {
        ".DS_Store", ".stfolder", "archive", "apps", ".Trash",
        "inspiration droplet.app", "media droplet.app", "life"
    }
    
    projects = []
    
    for item in DOCS_DIR.iterdir():
        if item.name in skip or not item.is_dir():
            continue
        
        roadmap_path = item / "backstage" / "ROADMAP.md"
        
        project = {
            "name": item.name,
            "path": str(item),
            "emoji": PROJECT_EMOJIS.get(item.name, "📁"),
            "status": get_project_status(item),
            "has_roadmap": roadmap_path.exists(),
            "roadmap_path": str(roadmap_path) if roadmap_path.exists() else None,
            "lastModified": get_last_modified(item)
        }
        
        projects.append(project)
    
    # Sort by lastModified (most recent first)
    projects.sort(key=lambda p: p["lastModified"], reverse=True)
    
    return {"projects": projects}

if __name__ == "__main__":
    print("🔄 Generating projects.json...")
    data = generate_projects()
    
    OUTPUT_PATH.parent.mkdir(exist_ok=True)
    
    with open(OUTPUT_PATH, 'w') as f:
        json.dump(data, f, indent=2)
    
    print(f"✅ Generated: {OUTPUT_PATH}")
    print(f"   {len(data['projects'])} projects found")
    
    # Show status breakdown
    active = sum(1 for p in data['projects'] if p['status'] == 'Active')
    pending = sum(1 for p in data['projects'] if p['status'] == 'Pending')
    print(f"   {active} Active, {pending} Pending")
