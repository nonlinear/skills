# Skills - Health Metrics

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
> This project follows the [global backstage HEALTH](global/HEALTH.md)
> Do write all tests here as explained below
> [/backstage-start](.github/prompts/backstage-start.prompt.md) trigger tests
> For more policies, see [POLICY.md](POLICY.md)
>
> 🌟

---

### Test: Private Skills in .gitignore

```bash
cd ~/Documents/skills
PRIVATE_SKILLS=$(find . -maxdepth 2 -name "SKILL.md" -exec grep -l "^type: private" {} \; | sed 's|./||' | sed 's|/SKILL.md||')
FAILED=0
for skill in $PRIVATE_SKILLS; do
  if ! grep -q "^$skill/" .gitignore 2>/dev/null; then
    echo "❌ FAIL: Private skill '$skill' not in .gitignore"
    FAILED=1
  fi
done
if [ $FAILED -eq 0 ]; then
  echo "✅ PASS: All private skills in .gitignore"
fi
exit $FAILED
```

Expected: All skills with `type: private` must be listed in `.gitignore`
Pass: ✅ No private skills tracked by git

---

### Test: Published Skills Have ClawHub Link

```bash
cd ~/Documents/skills
PUBLISHED_SKILLS=$(find . -maxdepth 2 -name "SKILL.md" -exec grep -l "^status: published" {} \; | sed 's|./||' | sed 's|/SKILL.md||')
FAILED=0
for skill_dir in $PUBLISHED_SKILLS; do
  SLUG=$(grep "^name:" "$skill_dir/SKILL.md" | awk '{print $2}')
  if ! grep -q "clawhub.com" "$skill_dir/SKILL.md"; then
    echo "⚠️  WARN: Published skill '$SLUG' missing ClawHub link in SKILL.md"
    FAILED=1
  fi
done
if [ $FAILED -eq 0 ]; then
  echo "✅ PASS: All published skills have ClawHub links"
fi
exit $FAILED
```

Expected: Skills with `status: published` should document ClawHub URL
Pass: ✅ All published skills reference clawhub.com

---

### Test: Frontmatter Completeness

```bash
cd ~/Documents/skills
REQUIRED_FIELDS="name description type version status author license"
FAILED=0
for skill_md in */SKILL.md; do
  SKILL=$(dirname "$skill_md")
  for field in $REQUIRED_FIELDS; do
    if ! grep -q "^$field:" "$skill_md"; then
      echo "❌ FAIL: $SKILL missing required field '$field'"
      FAILED=1
    fi
  done
done
if [ $FAILED -eq 0 ]; then
  echo "✅ PASS: All skills have complete frontmatter"
fi
exit $FAILED
```

Expected: All SKILL.md files have required frontmatter fields
Pass: ✅ No missing required fields

---

## Summary

**Project-specific checks ensure:**

- ✅ Private skills never tracked in git
- ✅ Published skills document ClawHub links
- ✅ All skills have complete frontmatter

---

**Run all checks:**

```bash
cd ~/Documents/skills/backstage
bash -c "$(grep -A 10 '^```bash' HEALTH.md | grep -v '^```' | grep -v '^--$' | grep -v '^Expected:' | grep -v '^Pass:')"
```
