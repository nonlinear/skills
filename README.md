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

**Public skills:**
- `arch` - Architecture design exercises
- `i-ching` - I Ching divination
- `context-switch` - Project/epic transitions with HEALTH checks
- `apple-reminders-processing` - Process reminders without notes
- `notify` - Presence-aware notifications
- `roadmap` - Backstage roadmap management
- `system-detective` - Auto-detect investigation context
- `find-books` - Find foundational/seminal books
- `use-for` - Skill suggester (meta)
- `librarian` - Book research via semantic search (requires external project)

**Private skills:**
- `design-discrepancy` - Design system validation (Wiley internal, not publishable)

---

## Skill Types

- **public** - Standalone or dependent on external projects, publishable
- **private** - Work-specific, NOT publishable, in .gitignore

See [POLICY.md](backstage/POLICY.md) for frontmatter spec.

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
