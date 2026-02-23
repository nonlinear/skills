# Contract Diagram Skill

**Contract diagram aims to enforce a legible document between AIs and humans**

```mermaid
%%{init: {'theme':'base','themeVariables':{'primaryColor':'#e0e0e0','primaryTextColor':'#000','primaryBorderColor':'#666','lineColor':'#666','secondaryColor':'#FFF9C4','tertiaryColor':'#FFCDD2','nodeBorder':'#666','mainBkg':'#e0e0e0','secondaryBkg':'#FFF9C4','tertiaryBkg':'#FFCDD2'},'flowchart':{'nodeSpacing':50,'rankSpacing':50,'padding':15,'curve':'basis'}}}%%
flowchart TD
    DEFAULT[".default"]:::default
    APPROVED[".approved"]:::approved
    BLOCKER[".blocker"]:::blocker
    DEVELOPED[".developed"]:::developed
    DEVELOPED_NOTES[".developed-notes"]:::developed-notes
    
    DEFAULT -->|"Approved"| APPROVED
    APPROVED -->|"Not approved"| BLOCKER
    BLOCKER -->|"Resolved"| APPROVED
    APPROVED -->|"All nodes approved,<br/>developed"| DEVELOPED
    
    classDef default fill:#e0e0e0,stroke:#666,color:#000
    classDef approved fill:#FFF9C4,stroke:#F9A825,color:#000
    classDef blocker fill:#FFCDD2,stroke:#D32F2F,color:#000
    classDef developed fill:#D5F5D5,stroke:#388E3C,color:#000
    classDef developed-notes fill:#E3F2FD,stroke:#1976D2,color:#000
```

****

- **1️⃣ Gray (.default):** Draft/backlog, not discussed yet
- **2️⃣ Yellow (.approved):** Agreed by stakeholders, ready for development
- **3️⃣ Red (.blocker):** Needs discussion OR failed implementation (always has numbered note)
- **4️⃣ Blue (.developed):** Agreed and implemented, ready for testing
- **5️⃣ Orange (.developed-notes):** Implemented but developer made decisions needing discussion

---

## Requirements

**Wrapper can claim (edit) contracts:**
- Contract MDs must be in engine's domain (`engine/` folder or symlinked)
- Node.js server enables read/write via `/write` endpoint

---

## Policies

In order for this exercise to work, you need:

1. to commit before any change
2. enforce parity between system and diagram (no system without diagram. no diagram with wrong system representation)
3. sandbox epics on branches, so you only "release" systems after approved, developed, tested

---

## Use Cases

- System architecture (flows, components, data)
- API design (endpoints, schemas, auth)
- Database models (ERD, relationships)
- Workflows (state machines, processes)
- Infrastructure (deployment, networking)
