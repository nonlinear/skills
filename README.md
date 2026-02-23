# Skills

[Nonlinear](https://nonlinear.nyc)'s openclaw skills collection

<table>
<tr>
<th align="left">Name</th>
<th align="left">Description</th>
<th align="left">Status</th>
</tr>
<tr valign="top">
<td><strong>contract-diagram</strong><br><a href="contract-diagram/SKILL.md#diagram">flow diagram</a></td>
<td>Diagram as contract for agreed-upon AI development</td>
<td><a href="https://clawhub.ai/nonlinear/contract-diagram">published</a></td>
</tr>
<tr valign="top">
<td><strong>context-switch</strong></td>
<td>Conscious project/epic transitions with HEALTH checks. Triggers: 'bom dia' (morning load main+wiley M-F), 'vamos trabalhar no X' (switch to project/epic), 'boa noite' (evening close + victory lap). Prevents context confusion, enforces HEALTH rituals, detects gaps between docs and reality.</td>
<td>stable</td>
</tr>
<tr valign="top">
<td><strong>design-discrepancy</strong><br><a href="design-discrepancy/SKILL.md#diagram">flow diagram</a></td>
<td>Compare reference docs (Figma, specs) with live system via Chrome Relay. Surface design vs implementation gaps for QA reports. Triggers: 'compare X with Y', 'check discrepancies', 'design vs implementation', 'Figma vs live site'.</td>
<td>stable</td>
</tr>
<tr valign="top">
<td><strong>find-books</strong></td>
<td>Search foundational/seminal books on topics via Anna's Archive. Triggers: 'procura livros sobre X', 'find canonical works on Y', 'livros fundacionais/seminais'. Returns piracy links (fuck copyright hypocrisy). Use for: discovering authoritative sources, building reading lists, research foundation.</td>
<td>stable</td>
</tr>
<tr valign="top">
<td><strong>i-ching</strong></td>
<td>I Ching divination (hexagrams, trigrams, oracles). Companion, not fortune-teller—reflects what you know but can't see. Triggers: 'hexagrama X', 'I Ching pergunta Y', 'trigrama acima/abaixo', 'moedas'. Methods: hexagram number, trigram pair, coin throws (with changing lines). Philosophy: 'muito na chincha' (deeply aligned, profoundly useful).</td>
<td>stable</td>
</tr>
<tr valign="top">
<td><strong>notify</strong></td>
<td>Detect user presence (idle/active) and choose notification channel. Triggers: 'me avisa quando X', 'let me know when Y', 'lmk Z'. Monitors task completion, notifies via Telegram (away) or in-chat (active). Uses macOS ioreg for idle detection.</td>
<td>stable</td>
</tr>
<tr valign="top">
<td><strong>reminder-research</strong><br><a href="https://clawhub.com/skills/reminder-research">published</a></td>
<td>Process Apple Reminders. Smart research: custom instructions (book + web search constraints), list-based defaults (claw=system solutions, shopping=price comparison, generic=how-to tutorials). Result tracking with 💎 signifier. Triggers: reminders without notes, heartbeat automated processing.</td>
<td>published</td>
</tr>
<tr valign="top">
<td><strong>roadmap</strong></td>
<td>Manage backstage roadmaps across projects. Add items, create epics, groom with emoji shortcuts. Triggers: 'add to roadmap X', '[project]: add roadmap item Y', 'merge 5️⃣ on 6️⃣', 'move 8️⃣ before 7️⃣'. Tracks main + project-specific roadmaps. Use for: epic planning, priority management, roadmap grooming.</td>
<td>stable</td>
</tr>
<tr valign="top">
<td><strong>system-detective</strong></td>
<td>Auto-detect investigation context and route to right tool. Triggers: 'investiga X', 'consulta Y', 'vê Z', 'sniff', 'inspeciona'. Decision tree: Jira → jira-check.py, URLs → web-fetch/browser, systems → exec/process, topics → librarian. Reduces tool selection overhead.</td>
<td>testing</td>
</tr>
<tr valign="top">
<td><strong>token-management</strong><br><a href="https://clawhub.com/skills/token-management">published</a></td>
<td>Centralized API token management workflow. Store tokens in .env with expiration dates, test permissions via script battery, document capabilities in connections/, set calendar renewal reminders. Prevents re-asking for credentials, ensures token security, tracks expiration.</td>
<td>published</td>
</tr>
<tr valign="top">
<td><strong>use-for</strong></td>
<td>Meta skill: Scans all SKILL.md frontmatter descriptions and suggests which skill helps with user's current task/struggle. Triggers: 'how do I...?', 'is there a skill for X?', repeated failed attempts, uncertainty. Returns top 3 matches with name + description. Reduces tool selection overhead.</td>
<td>stable</td>
</tr>
</table>

## Companion Skills

### belong to other projects

<table>
<tr>
<th align="left">Name</th>
<th align="left">Description</th>
<th align="left">Status</th>
</tr>
<tr valign="top">
<td><strong>backstage companion</strong><br><a href="https://github.com/backstage/skills/backstage/SKILL.md#diagram">flow diagram</a></td>
<td>Manage backstage workflow in projects (ROADMAP, POLICY, HEALTH, CHANGELOG). Triggers: 'backstage start', 'vamos trabalhar no X', 'backstage health'. Installs protocol if missing, updates global rules, runs health checks, shows active epics. Use for: epic planning, project setup, quality enforcement, context switching.<br>companion for <a href="https://github.com/nonlinear/backstage">backstage</a></td>
<td><a href="https://clawhub.com/skills/backstage">published</a></td>
</tr>
<tr valign="top">
<td><strong>librarian companion</strong><br><a href="https://github.com/librarian/skill/SKILL.md#diagram">flow diagram</a></td>
<td>OpenClaw conversational interface for semantic book search.<br>companion for <a href="https://github.com/nonlinear/librarian">backstage</a></td>
<td><a href="https://clawhub.ai/nonlinear/librarian">published</a></td>
</tr>
</table>


---







> 🤖
>
> This project follows [backstage protocol](https://github.com/nonlinear/backstage) v0.3.4
>
> [README](README.md) 👏 [ROADMAP](backstage/ROADMAP.md) 👏 [CHANGELOG](backstage/CHANGELOG.md) 👏 checks: [local](backstage/checks/local/) <sup>5</sup>, [global](backstage/checks/global/) <sup>0</sup>
>
> 🤖







```mermaid
graph LR
    A[🏗️ v0.1.0 Skill Reordering]
    B[📋 v1.0.0 arch]
    A --> B
    C[📋 v1.1.0 i-ching]
    B --> C
    D[📋 v1.4.0 notify]
    C --> D
    E[📋 v1.6.0 system-detective]
    D --> E
    F[📋 v1.7.0 find-books]
    E --> F
    G[📋 v2.0.0 open-with]
    F --> G
    H[📋 v2.1.0 use-for]
    G --> H
```

