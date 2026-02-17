#!/usr/bin/env python3
"""
Fetch Jira task descriptions and save to JSON
"""
import json
import requests
from requests.auth import HTTPBasicAuth

EMAIL = "nfrota@wiley.com"
TOKEN = "***REMOVED_TOKEN***"
JIRA_URL = "https://wiley-global.atlassian.net"

def extract_text(node):
    """Extract text from Atlassian Document Format, preserving links"""
    if not node:
        return ''
    if isinstance(node, dict):
        # Handle text nodes
        if 'text' in node:
            text = node['text']
            # Check if parent has marks (links, bold, etc)
            if 'marks' in node:
                for mark in node['marks']:
                    if mark.get('type') == 'link':
                        href = mark.get('attrs', {}).get('href', '')
                        # Use the text as title, not the URL
                        return f'<a href="{href}" target="_blank">{text}</a>'
            return text
        
        # Handle inline cards (Figma links, Jira links) - these don't have text nodes
        if node.get('type') == 'inlineCard':
            url = node.get('attrs', {}).get('url', '')
            # Try to extract a readable title from URL
            title = url.split('/')[-1][:30] if '/' in url else url[:30]
            return f'<a href="{url}" target="_blank">{title}</a>'
        
        # Recursively process content
        if 'content' in node:
            parts = [extract_text(n) for n in node['content']]
            # Add spacing between list items
            if node.get('type') == 'listItem':
                return '• ' + ' '.join(parts) + ' '
            return ' '.join(parts)
    
    return ''

def get_descriptions(keys):
    """Fetch descriptions for list of Jira keys"""
    descriptions = {}
    
    for key in keys:
        try:
            response = requests.get(
                f"{JIRA_URL}/rest/api/3/issue/{key}",
                auth=HTTPBasicAuth(EMAIL, TOKEN),
                headers={"Accept": "application/json"},
                params={"fields": "description"}
            )
            response.raise_for_status()
            data = response.json()
            
            desc = data.get('fields', {}).get('description')
            if desc:
                text = extract_text(desc)
                descriptions[key] = text[:300] + ('...' if len(text) > 300 else '')
            else:
                descriptions[key] = "(No description)"
                
        except Exception as e:
            print(f"Error fetching {key}: {e}")
            descriptions[key] = "(Error loading)"
    
    return descriptions

if __name__ == "__main__":
    # Read current jira.json
    with open('/Users/nfrota/.openclaw/workspace/data/jira.json', 'r') as f:
        jira_data = json.load(f)
    
    # Collect all keys
    keys = set()
    for section in ['overdue', 'today', 'soon']:
        for item in jira_data.get(section, []):
            # Extract key from link
            if '/browse/' in item['link']:
                key = item['link'].split('/browse/')[-1]
                keys.add(key)
    
    # Fetch descriptions
    descriptions = get_descriptions(keys)
    
    # Save to file
    with open('/Users/nfrota/.openclaw/workspace/data/jira-descriptions.json', 'w') as f:
        json.dump(descriptions, f, indent=2)
    
    print(f"✅ Saved descriptions for {len(descriptions)} tasks")
