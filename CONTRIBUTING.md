# Contributing to Elite SDE Team 🤝

First off, **thank you** for considering contributing! Elite SDE Team is built by developers, for developers, and every contribution makes it better.

---

## 🎯 Ways to Contribute

### 1. **Report Bugs** 🐛
Found a bug? [Open an issue](https://github.com/coderdigvijay/Elite_SDE_Team/issues/new?template=bug_report.md)

### 2. **Suggest Features** 💡
Have an idea? [Open a feature request](https://github.com/coderdigvijay/Elite_SDE_Team/issues/new?template=feature_request.md)

### 3. **Improve Documentation** 📖
Fix typos, add examples, clarify explanations

### 4. **Add New Agents** 🤖
Create domain-specific agents (e.g., DevOps, Mobile, Testing)

### 5. **Share Your Wins** 🏆
Tweet about it with **#EliteSDETeam** — we'll showcase the best stories!

---

## 🚀 Quick Start for Contributors

### 1. Fork & Clone

```bash
# Fork the repo on GitHub, then:
git clone https://github.com/coderdigvijay/Elite_SDE_Team.git
cd sde-team
```

### 2. Create a Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-bug-fix
```

### 3. Make Changes

Follow the guidelines below based on what you're contributing.

### 4. Test Locally

```bash
# Test the installer
./install.sh

# Verify agents work
# (open in Claude Code and test)
```

### 5. Commit & Push

```bash
git add .
git commit -m "feat: add awesome feature"
git push origin feature/your-feature-name
```

### 6. Open Pull Request

Go to GitHub and open a PR. Describe what you changed and why.

---

## 📝 Contribution Guidelines

### For Bug Fixes

- Include steps to reproduce
- Explain what was broken
- Explain how your fix works
- Test that it actually fixes the issue

### For New Features

- Open an issue first (discuss before building)
- Keep it focused (one feature per PR)
- Update documentation
- Add examples if applicable

### For Documentation

- Fix typos, clarify confusing parts
- Add examples and use cases
- Keep tone friendly and accessible
- Use markdown properly

### For New Agents

- Follow existing agent template structure
- Include clear description and activation triggers
- Add to the main agent list
- Provide usage examples

**Agent Template:**
```markdown
---
name: your-agent-name
description: What this agent does and when it activates
---

# Your Agent Name

Mission: [What this agent solves]

Auto-Activation Triggers:
- [When it activates]

Core Capabilities:
- [What it can do]

[Rest of agent definition]
```

---

## 🎨 Code Style

### Markdown Files

- Use clear headings (H2 for major sections, H3 for subsections)
- Include code examples where helpful
- Add emojis sparingly (only where they add clarity)
- Keep lines under 120 characters

### Shell Scripts

- Use `#!/bin/bash` shebang
- Add comments for complex logic
- Use `set -e` to fail fast
- Include error messages for common failures

### Agent Definitions

- Follow the established YAML frontmatter + markdown format
- Use consistent section headers
- Include practical examples
- Be specific about when agent activates

---

## 🔍 Review Process

### What Happens After You Submit a PR

1. **Automated checks** run (if we have CI/CD set up)
2. **Maintainers review** within 1-3 days
3. **Feedback** provided if changes needed
4. **Merge** when approved!

### Getting Your PR Merged Faster

- ✅ Clear description of what and why
- ✅ Tests pass (if applicable)
- ✅ Documentation updated
- ✅ Follows contribution guidelines
- ✅ Small, focused changes (not 100 files)

---

## 🤖 Creating Custom Agents

Want to add a specialized agent? Here's how:

### 1. Create Agent File

```bash
# Add to template/agents/
touch template/agents/your-agent-name.md
```

### 2. Use This Template

```markdown
---
name: your-agent-name
description: Brief description of what this agent does and when it activates
---

# Your Agent Name

You are [describe the agent's role and expertise].

## Mission

[What problem does this agent solve?]

## Auto-Activation Triggers

You activate automatically when:
1. [Trigger 1]
2. [Trigger 2]
3. [Trigger 3]

## Core Capabilities

[What this agent can do]

## Integration with Other Agents

**Works with:**
- [Agent 1] — [how they collaborate]
- [Agent 2] — [how they collaborate]

**Escalates to:**
- [When to escalate and to whom]

## Output Format

[How this agent presents results]

## Examples

[Real-world usage examples]
```

### 3. Add to Installer

Update `install.sh` to include your new agent in the download list.

### 4. Document It

Add to `README.md` agent list and create usage docs.

### 5. Submit PR

Include:
- Agent file
- Updated installer
- Documentation
- Example usage

---

## 🌟 Recognition

**Contributors get:**
- Listed in README
- Mentioned in release notes
- Featured in showcase (for major contributions)
- Our eternal gratitude 🙏

---

## 📋 Issue Labels

When opening issues, use these labels:

| Label | Description |
|-------|-------------|
| `bug` | Something's broken |
| `enhancement` | New feature request |
| `documentation` | Docs need improvement |
| `good first issue` | Easy for new contributors |
| `help wanted` | We'd love community help on this |
| `question` | Just asking a question |
| `agent` | Related to specific agent |
| `installer` | Related to install script |

---

## 💬 Communication

### Discussions

For open-ended conversations, use [GitHub Discussions](https://github.com/coderdigvijay/Elite_SDE_Team/discussions)

**Good for:**
- Feature ideas (before opening issue)
- Best practices
- Show & tell
- General questions

### Issues

For specific, actionable items, use [GitHub Issues](https://github.com/coderdigvijay/Elite_SDE_Team/issues)

**Good for:**
- Bug reports
- Specific feature requests
- Documentation errors

### Pull Requests

For actual code/doc changes, use [Pull Requests](https://github.com/coderdigvijay/Elite_SDE_Team/pulls)

---

## 🙏 Thank You

Every contribution, no matter how small, makes Elite SDE Team better for everyone.

**Thank you for being part of this!** 🚀

---

## 📜 Code of Conduct

### Our Pledge

We're committed to providing a welcoming, inclusive environment for everyone.

### Our Standards

**Do:**
- Be respectful and constructive
- Welcome newcomers
- Accept feedback gracefully
- Focus on what's best for the community

**Don't:**
- Harass or insult others
- Use inappropriate language
- Be dismissive of questions
- Spam or self-promote excessively

### Enforcement

Violations can be reported to [your-email@example.com]. Serious violations may result in ban from the project.

---

**Questions about contributing?** [Open a discussion](https://github.com/coderdigvijay/Elite_SDE_Team/discussions) — we're here to help!
