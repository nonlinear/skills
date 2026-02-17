#!/usr/bin/env python3
"""
Generate ⚙️ tab sections data from life project folders
Run: python3 ~/Documents/life/agenda/generate-docs-json.py
"""
import json
import os
from pathlib import Path

WORKSPACE = Path.home() / ".openclaw" / "workspace"
LIFE_PROJECT = Path.home() / "Documents" / "life"
OUTPUT_PATH = Path(__file__).parent / "data" / "docs.json"

def scan_folder(folder_path, glob_pattern="*.md"):
    """Scan folder for markdown files."""
    if not folder_path.exists():
        return []
    
    files = []
    for file in sorted(folder_path.glob(glob_pattern)):
        if file.name.startswith('.'):
            continue
        files.append({
            "name": file.stem,
            "path": str(file),
            "relative": str(file.relative_to(Path.home()))
        })
    return files

def generate_docs():
    """Generate docs sections data."""
    
    # Core Prompts (workspace)
    core_prompts = [
        {"name": "AGENTS", "path": str(WORKSPACE / "AGENTS.md")},
        {"name": "HEARTBEAT", "path": str(WORKSPACE / "HEARTBEAT.md")},
        {"name": "IDENTITY", "path": str(WORKSPACE / "IDENTITY.md")},
        {"name": "SOUL", "path": str(WORKSPACE / "SOUL.md")},
        {"name": "TOOLS", "path": str(WORKSPACE / "TOOLS.md")},
        {"name": "USER", "path": str(WORKSPACE / "USER.md")},
        {"name": "VISION", "path": str(WORKSPACE / "VISION.md")},
    ]
    
    # Important Notes (life project root)
    important_notes = scan_folder(LIFE_PROJECT, "*.md")
    
    # Backstage (life/backstage)
    backstage = scan_folder(LIFE_PROJECT / "backstage", "*.md")
    
    # Skills (life/skills)
    skills_folder = LIFE_PROJECT / "skills"
    skills = []
    if skills_folder.exists():
        for skill_dir in sorted(skills_folder.iterdir()):
            if skill_dir.is_dir() and (skill_dir / "SKILL.md").exists():
                skills.append({
                    "name": skill_dir.name,
                    "path": str(skill_dir / "SKILL.md"),
                    "folder": str(skill_dir)
                })
    
    # Gaps (life/backstage/gaps)
    gaps = scan_folder(LIFE_PROJECT / "backstage" / "gaps", "*.md")
    
    # Epic Notes (life/backstage/epic-notes)
    epic_notes = scan_folder(LIFE_PROJECT / "backstage" / "epic-notes", "*.md")
    
    # Memory (workspace)
    memory = scan_folder(WORKSPACE / "memory", "*.md")
    
    # Connections (life/connections)
    connections = scan_folder(LIFE_PROJECT / "connections", "*.md")
    
    # Scripts (workspace scripts)
    scripts = scan_folder(WORKSPACE / "scripts", "*")
    
    return {
        "core_prompts": core_prompts,
        "important_notes": important_notes,
        "backstage": backstage,
        "skills": skills,
        "gaps": gaps,
        "epic_notes": epic_notes,
        "memory": memory,
        "connections": connections,
        "scripts": scripts
    }

if __name__ == "__main__":
    print("🔄 Generating docs.json...")
    data = generate_docs()
    
    OUTPUT_PATH.parent.mkdir(exist_ok=True)
    
    with open(OUTPUT_PATH, 'w') as f:
        json.dump(data, f, indent=2)
    
    print(f"✅ Generated: {OUTPUT_PATH}")
    for section, items in data.items():
        print(f"   {section}: {len(items)} items")
