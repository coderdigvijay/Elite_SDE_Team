---
name: Bug Report
about: Report a bug or issue with Elite SDE Team
title: '[BUG] '
labels: bug
assignees: ''
---

## Bug Description

**Clear description of the bug:**


**Expected behavior:**


**Actual behavior:**


---

## Steps to Reproduce

1.
2.
3.

---

## Environment

**Operating System:**
- [ ] macOS
- [ ] Linux (which distro?)
- [ ] Windows

**Claude Interface:**
- [ ] Claude Code (VS Code extension)
- [ ] Claude Desktop

**Project Details:**
- Programming language(s):
- Framework(s):
- Codebase size (approx lines):

---

## Diagnostic Information

**Please run and paste output:**

```bash
{
  echo "=== Directory Structure ==="
  tree .claude/ -L 2
  echo ""
  echo "=== Project Detection ==="
  bash .claude/scripts/detect-project.sh
  echo ""
  echo "=== Git Status ==="
  git status
}
```

**Output:**
```
[Paste here]
```

---

## Screenshots / Logs

**If applicable, add screenshots or logs:**


---

## Additional Context

**Any other information that might help:**


---

## Checklist

Before submitting, please check:
- [ ] I searched existing issues (this isn't a duplicate)
- [ ] I provided steps to reproduce
- [ ] I included diagnostic information
- [ ] I described expected vs actual behavior
