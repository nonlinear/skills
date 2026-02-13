# Skills Project

**Collection of OpenClaw skills (public + private)**

> 🤖
>
> - [README](README.md) - Our project
> - [CHANGELOG](backstage/CHANGELOG.md) — What we did
> - [ROADMAP](backstage/ROADMAP.md) — What we wanna do
> - [POLICY](backstage/POLICY.md) — How we do it
> - [HEALTH](backstage/HEALTH.md) — What we accept
>
> 🤖

---

## What's Here

**Public skills** (alphabetical):

- **arch** - Architecture design exercises (collaborative diagrams before coding)
- **backstage-skill** - Project context switching with HEALTH checks
- **context-switch** - Conscious project/epic transitions with parity detection
- **design-discrepancy** - Compare reference docs with live systems (design vs implementation gaps)
- **find-books** - Search foundational/seminal books via Anna's Archive
- **i-ching** - I Ching divination (hexagrams, trigrams, oracles)
- **librarian** - Book research via semantic search (requires external project)
- **notify** - Presence-aware notifications (idle detection + channel routing)
- **[reminder-research](https://clawhub.com/skills/reminder-research)** ⭐ - Process Apple Reminders with custom instructions
- **roadmap** - Backstage roadmap management across projects
- **system-detective** - Auto-detect investigation context and route to correct tool
- **[token-management](https://clawhub.com/skills/token-management)** ⭐ - Manage API tokens/credentials across projects
- **use-for** - Skill suggester (meta-skill for skill discovery)

⭐ = Published on ClawHub

**Skill types:**
- **public** - Standalone or dependent on external projects, publishable to ClawHub
- **private** - Work-specific, NOT publishable, NOT tracked in git (see .gitignore)

See [POLICY.md](backstage/POLICY.md) for frontmatter spec and development workflow.

---

## Backstage

This project uses backstage workflow:
- [ROADMAP.md](backstage/ROADMAP.md) - What we're building
- [POLICY.md](backstage/POLICY.md) - Standards and quality checks
- [HEALTH.md](backstage/HEALTH.md) - Automated tests
- [CHANGELOG.md](backstage/CHANGELOG.md) - What we built

---

## Adding New Skills

1. Create folder: `~/Documents/skills/skill-name/`
2. Add `SKILL.md` with complete frontmatter (see POLICY.md)
3. If private: Add to `.gitignore`
4. If public: Add to ROADMAP epic
5. Run HEALTH checks before committing
6. Test and publish (public only)

**Frontmatter template:**
```yaml
---
name: skill-name
description: "Triggers, use cases, problems solved. Write for AI suggestion."
type: public|private
version: 1.0.0
status: live|stable|testing
dependencies: 
  - https://github.com/user/repo  # external projects
  - system-package  # bins/libs
author: nonlinear
license: MIT
---
```

See [POLICY.md](backstage/POLICY.md) for full spec.
