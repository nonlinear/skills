#!/usr/bin/env python3
"""
WebSocket file watcher for hot reload
Watches MD file, sends 'reload' message on change
"""
import asyncio
import websockets
import sys
from pathlib import Path
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

clients = set()
watched_file = None

class MDFileHandler(FileSystemEventHandler):
    def on_modified(self, event):
        global watched_file
        if event.src_path == str(watched_file):
            print(f"📝 {watched_file.name} changed, notifying clients...")
            asyncio.run(notify_clients())

async def notify_clients():
    if clients:
        await asyncio.gather(*[client.send('reload') for client in clients])

async def handler(websocket):
    clients.add(websocket)
    print(f"✅ Client connected ({len(clients)} total)")
    try:
        await websocket.wait_closed()
    finally:
        clients.remove(websocket)
        print(f"❌ Client disconnected ({len(clients)} remaining)")

async def main():
    global watched_file
    
    if len(sys.argv) < 2:
        print("Usage: watch-reload.py <file.md>")
        sys.exit(1)
    
    watched_file = Path(sys.argv[1]).resolve()
    
    if not watched_file.exists():
        print(f"❌ File not found: {watched_file}")
        sys.exit(1)
    
    print(f"👀 Watching: {watched_file}")
    print(f"🌐 WebSocket server: ws://localhost:8767")
    
    # Start file watcher
    event_handler = MDFileHandler()
    observer = Observer()
    observer.schedule(event_handler, str(watched_file.parent), recursive=False)
    observer.start()
    
    # Start WebSocket server
    async with websockets.serve(handler, "localhost", 8767):
        await asyncio.Future()  # Run forever

if __name__ == "__main__":
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        print("\n👋 Shutting down...")
