# Project Policy

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

## README Tables

**README.md has TWO skill tables, both auto-generated from SKILL.md frontmatter fields.**

**Format:** HTML table with `valign="top"` (top-aligned rows for readability)

**Table 1: What's Here**
- All folders in `~/Documents/skills/` with `SKILL.md`
- Alphabetical order

**Table 2: Companion Skills (belong to other projects)**
- Auto-discovered via `~/Documents/*/skill/` (exclude `~/Documents/skills/`)
- Alphabetical order
- Description appends: `<br>companion for [project](git-repo-link)`

**Table columns:**
- **Name:** `name:` from frontmatter (with ClawHub link if published)
- **Description:** `description:` from frontmatter
- **Status:** `status:` from frontmatter (no emoji, raw value: `published`, `stable`, `testing`, `draft`)

**Why:**
- Single source of truth (frontmatter)
- No manual sync drift
- Top-aligned = readable multi-line descriptions
- Companions auto-discovered (no hardcoding)
- Clear separation: this project vs external projects

---

