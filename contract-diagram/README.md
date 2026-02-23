# Contract Diagram

**Diagram as contract for agreed-upon AI development**

Use mermaid diagrams as living contracts between you and AI. Define what's agreed (yellow), what's implemented (green), what's blocked (red), and track development phases automatically.

## Features

- ✅ **Auto-claiming**: Opens unclaimed diagrams, injects title + CSS + phase badge
- ✅ **Phase detection**: Design → Ready to approve → Developing... → Ready to check
- ✅ **Live updates**: Badge refreshes every 5s when phase changes
- ✅ **GitHub-compatible**: Shields.io badges + markdown tables render everywhere
- ✅ **Master contract**: SKILL.md defines protocol, all contracts reference it

## Installation

### Via clawhub (recommended)
```bash
openclaw skills install contract-diagram
```

### Manual
```bash
cd ~/Documents/skills  # or your skills directory
git clone https://github.com/nonlinear/skills.git
cd skills/contract-diagram
```

## Requirements

- Node.js (for local server)
- Browser (Safari, Chrome, Firefox)

## Usage

### 1. Start the wrapper
```bash
cd ~/Documents/skills/contract-diagram
./serve.sh
```

Server starts on http://localhost:8080

### 2. Open a diagram
```
http://localhost:8080/?md=/path/to/your-contract.md
```

**Example:**
```
http://localhost:8080/?md=../../librarian/backstage/epic-notes/webhook-contract.md
```

### 3. Let AI help
Tell your AI:
```
"lets diagram epic-notes/webhook-contract.md"
```

AI will:
1. Start server (if not running)
2. Open browser
3. Wrapper auto-claims diagram (adds title + CSS + badge)
4. Tracks phase changes automatically

## Contract Protocol

See [SKILL.md](SKILL.md) for:
- Node class system (default, approved, blocker, developed, notes, outside)
- Phase detection logic
- Claiming workflow
- Numbered notes format

## Legend

| Legend | Description |
|--------|-------------|
| ![default](https://img.shields.io/badge/default-lightgray) | Not discussed yet |
| ![approved](https://img.shields.io/badge/approved-yellow) | Agreed by stakeholders |
| ![blocker](https://img.shields.io/badge/blocker-red) | Needs discussion/failed implementation |
| ![developed](https://img.shields.io/badge/developed-lightgreen) | Agreed and implemented |
| ![notes](https://img.shields.io/badge/notes-blue) | Implemented with developer decisions |
| ![outside](https://img.shields.io/badge/outside-lightgreen) | (dashed border) Performed outside system |

## Files

- **SKILL.md** - Master contract (protocol definition)
- **index.html** - Wrapper (claiming, rendering, phase detection)
- **server.js** - Node.js server (read/write endpoints)
- **styles.css** - Source of truth (mermaid theme variables)
- **serve.sh** - Launcher script
- **github-markdown.css** - Styling

## License

MIT

## Author

nonlinear
