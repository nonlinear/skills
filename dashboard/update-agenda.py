#!/usr/bin/env python3
"""
Update Work Agenda - generates data/jira.json
Run: python3 ~/Documents/life/agenda/update-agenda.py
"""
import requests
from datetime import datetime, date
import json
import os
from dotenv import load_dotenv

# Load .env from workspace
load_dotenv(os.path.expanduser("~/.openclaw/workspace/.env"))

JIRA_URL = "https://wiley-global.atlassian.net"
EMAIL = "nfrota@wiley.com"
API_TOKEN = os.getenv("WILEY_JIRA_TOKEN")

def get_my_issues():
    url = f"{JIRA_URL}/rest/api/3/search/jql"
    auth = (EMAIL, API_TOKEN)
    headers = {"Accept": "application/json"}
    jql = "assignee = currentUser() AND status != Done AND duedate is not EMPTY ORDER BY duedate ASC"
    params = {
        "jql": jql,
        "fields": "summary,duedate,status,key",
        "maxResults": 100
    }
    response = requests.get(url, auth=auth, headers=headers, params=params)
    if response.status_code != 200:
        return {"overdue": [], "today": []}
    return response.json()

def generate_json(data):
    today = date.today()
    result = {
        "overdue": [],
        "today": [],
        "soon": [],
        "calendar": "https://wiley-global.atlassian.net/jira/plans/2095/scenarios/2095/calendar?filter=assignee%20%3D%205f6a182958ea7b00706d352a"
    }
    
    for issue in data.get("issues", []):
        key = issue["key"]
        summary = issue["fields"]["summary"]
        due_str = issue["fields"].get("duedate")
        status = issue["fields"]["status"]["name"]
        
        if not due_str:
            continue
        
        if status.lower() in ["closed", "done"] and "2019" in due_str:
            continue
        
        due_date = datetime.strptime(due_str, "%Y-%m-%d").date()
        days_diff = (due_date - today).days
        
        project = key.split("-")[0]
        
        item = {
            "title": summary,
            "link": f"https://wiley-global.atlassian.net/browse/{key}",
            "project": project,
            "days": abs(days_diff)
        }
        
        if due_date < today:
            result["overdue"].append(item)
        elif due_date == today:
            result["today"].append(item)
        elif days_diff > 0 and days_diff <= 3:
            result["soon"].append(item)
    
    return result

if __name__ == "__main__":
    print("🔄 Updating agenda...")
    data = get_my_issues()
    result = generate_json(data)
    
    # Save to agenda data folder
    script_dir = os.path.dirname(os.path.abspath(__file__))
    data_dir = os.path.join(script_dir, "data")
    os.makedirs(data_dir, exist_ok=True)
    output_path = os.path.join(data_dir, "jira.json")
    
    with open(output_path, 'w') as f:
        json.dump(result, f, indent=2)
    
    print(f"✅ Updated: {output_path}")
    print(f"   {len(result['overdue'])} overdue, {len(result['today'])} today")
