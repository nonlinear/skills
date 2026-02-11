# Project Policy

> 🤖
>
> - [README](../README.md) - Our project
> - [CHANGELOG](CHANGELOG.md) — What we did
> - [ROADMAP](ROADMAP.md) — What we wanna do
> - [POLICY](POLICY.md) — How we do it
> - [HEALTH](HEALTH.md) — What we accept
>
> 🤖

---

> 🌟
>
> This project follows the [global backstage POLICY](global/POLICY.md)
> Do write all policies, standards you want in your project here
> Running [/backstage-start](.github/prompts/backstage-start.prompt.md) enforce them
> If these rules conflict with [global backstage POLICY](global/POLICY.md), yours take precedence
> For more machine tests, see [HEALTH.md](HEALTH.md)
>
> 🌟

---

## Skills Project Policy

### Frontmatter Specification

**All skills MUST have complete frontmatter:**

```yaml
---
name: skill-name
description: "Triggers, use cases, problems solved. Write for AI suggestion (use-for skill reads this)."
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

**Required fields:**
- `name` - Skill identifier (matches folder name)
- `description` - How/when to use (for AI suggestion). Include: triggers, use cases, problems solved.
- `type` - `public` (publishable) or `private` (not publishable, in .gitignore)
- `version` - Semantic versioning (1.0.0)
- `status` - `live` (published on ClawdHub), `stable` (works, not published), `testing` (in epic, changing)
- `dependencies` - Array of GitHub repos (external projects) or system packages
- `author` - Creator name
- `license` - MIT, Unlicense, etc.

---

### Skill Types

**Type = publishability + governance**

**public:**
- Standalone OR dependent on external projects (via dependencies)
- Publishable to ClawdHub
- Examples: i-ching, arch, librarian (depends on external repo)
- Governance: This project (skills)

**private:**
- Work-specific, personal, sensitive data
- NOT publishable to ClawdHub
- MUST be in .gitignore
- Examples: design-discrepancy (Wiley internal)
- Governance: This project (skills)

**Publishing:**
- `type: public` → ClawdHub publish allowed
- `type: private` → NEVER publish (security risk)

---

### Status Definitions

**live:**
- Published on ClawdHub
- Must include ClawdHub package name in SKILL.md

**stable:**
- Feature complete, tested, working
- Not yet published (or not intended for publication)
- Ready for daily use

**testing:**
- In active development (usually tied to an epic)
- Unstable, changing
- Document what's pending in epic notes

---

### Description Field Guidelines

**Purpose:** Help `use-for` skill suggest the right skill to users.

**What makes a good description:**
1. **Triggers:** Exact phrases users might say ("vamos desenhar X", "pesquisa Y")
2. **Use cases:** What problems it solves
3. **Context:** When to reach for this skill
4. **Keywords:** Domain-specific terms (architecture, divination, research)

**Examples:**

✅ Good:
```yaml
description: "I Ching divination (hexagrams, trigrams). Triggers: 'hexagrama X', 'I Ching pergunta Y'. Companion, not fortune-teller—reflects what you know but can't see."
```

✅ Good:
```yaml
description: "Auto-detect investigation context. Triggers: 'investiga X', 'vê Y'. Routes to jira-check.py, web-fetch, librarian, or exec based on context type."
```

❌ Bad:
```yaml
description: "A skill for things."
```

---

### Dependencies Field

**GitHub repos (external projects):**
```yaml
dependencies:
  - https://github.com/yourusername/librarian
  - https://github.com/yourusername/backstage-skill
```

**System packages:**
```yaml
dependencies:
  - python3
  - faiss
  - jq
  - remindctl
```

**Mixed:**
```yaml
dependencies:
  - https://github.com/yourusername/librarian
  - python3
  - sentence-transformers
```

**None:**
```yaml
dependencies: []
```

---

## Quality Checks

**Each folder = separate skill. Run checks for EACH skill:**

### 1. Has SKILL.md?
- ❌ Missing → Create or document why

### 2. Has frontmatter?
- ❌ Missing → Add frontmatter block

### 3. Frontmatter complete?
All required fields present:
- `name` ✅
- `description` ✅
- `type` ✅
- `version` ✅
- `status` ✅
- `dependencies` ✅
- `author` ✅
- `license` ✅

### 4. Private skills in .gitignore?
- ❌ Private skill NOT in .gitignore → Security risk
- ✅ All private skills ignored

### 5. Description quality?
- ⚠️ Generic/vague → Add triggers, use cases, context
- ✅ Specific, actionable, helpful for AI suggestion

**Quality levels:**
- ✅ **Complete:** All required fields present + good description
- ⚠️ **Incomplete:** Missing optional fields or weak description
- ❌ **Invalid:** Missing required fields

---

## use-for Skill (Meta Skill)

**Purpose:** Suggest skills based on user context/struggle

**How it works:**
1. Scans all SKILL.md in `~/.openclaw/skills/` + `~/Documents/skills/`
2. Extracts `description` from frontmatter
3. Matches user query against descriptions
4. Returns top 3 matches

**Relies on quality descriptions** - make them count!

---

## Versioning

Follows [Semantic Versioning](https://semver.org/):

- **MAJOR.MINOR.PATCH** (1.0.0)
- **MAJOR:** Breaking changes (incompatible updates)
- **MINOR:** New features (backward compatible)
- **PATCH:** Bug fixes (backward compatible)

**When to bump:**
- New skill → Start at 1.0.0
- Bug fix → Increment PATCH (1.0.1)
- New feature → Increment MINOR (1.1.0)
- Breaking change → Increment MAJOR (2.0.0)

---

## Project-Specific Rules

### Private Skills Security

**All private skills MUST be in .gitignore:**

```gitignore
# Private skills (work-specific, sensitive data)
design-discrepancy/
another-private-skill/
```

**Never commit:**
- API keys
- Company-specific code
- Wiley internal data
- Personal credentials

**HEALTH check enforces this** - fails if private skill not ignored.

---

### Publication Process (Public Skills Only)

1. Ensure `status: stable` or `status: live`
2. Run HEALTH checks (all pass)
3. Test locally
4. Publish to ClawdHub
5. Update `status: live` in frontmatter
6. Document ClawdHub package name in SKILL.md

**Private skills:** NEVER publish. Skip this process entirely.
