#!/usr/bin/env python3
"""
Refresh backend for agenda app
Runs refresh-agenda.sh when called
Start: python3 refresh-server.py &
"""
from http.server import HTTPServer, BaseHTTPRequestHandler
import subprocess
import os
import json
import time
import threading

AGENDA_DIR = os.path.dirname(os.path.abspath(__file__))
REFRESH_SCRIPT = os.path.join(AGENDA_DIR, "refresh-agenda.sh")
STATUS_FILE = os.path.join(AGENDA_DIR, ".refresh-status")

# Global status
status = {"running": False, "last_run": None}

def update_status(running):
    global status
    status["running"] = running
    if not running:
        status["last_run"] = int(time.time())
    # Write to file for cronjob
    with open(STATUS_FILE, "w") as f:
        json.dump(status, f)

# Load status on start
if os.path.exists(STATUS_FILE):
    with open(STATUS_FILE, "r") as f:
        try:
            status = json.load(f)
        except:
            pass

class RefreshHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/refresh':
            try:
                update_status(True)
                
                # Run refresh script
                result = subprocess.run(
                    ['bash', REFRESH_SCRIPT],
                    cwd=AGENDA_DIR,
                    capture_output=True,
                    text=True,
                    timeout=60
                )
                
                update_status(False)
                
                response = {
                    "status": "success" if result.returncode == 0 else "error",
                    "output": result.stdout,
                    "error": result.stderr
                }
                
                self.send_response(200)
                self.send_header('Content-Type', 'application/json')
                self.send_header('Access-Control-Allow-Origin', '*')
                self.end_headers()
                self.wfile.write(json.dumps(response).encode())
                
            except Exception as e:
                update_status(False)
                self.send_response(500)
                self.send_header('Content-Type', 'application/json')
                self.send_header('Access-Control-Allow-Origin', '*')
                self.end_headers()
                self.wfile.write(json.dumps({"status": "error", "error": str(e)}).encode())
        
        elif self.path == '/status':
            self.send_response(200)
            self.send_header('Content-Type', 'application/json')
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()
            self.wfile.write(json.dumps(status).encode())
        
        else:
            self.send_response(404)
            self.end_headers()
    
    def log_message(self, format, *args):
        # Suppress logs
        pass

if __name__ == '__main__':
    PORT = 8766
    print(f"🔄 Refresh server running on http://localhost:{PORT}")
    print(f"   Call: http://localhost:{PORT}/refresh")
    print(f"   Status: http://localhost:{PORT}/status")
    server = HTTPServer(('localhost', PORT), RefreshHandler)
    server.serve_forever()
