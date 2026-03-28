# Troubleshooting Guide 🔧

Common issues and solutions when using Elite SDE Team.

---

## 📋 Quick Diagnosis

**Issue categories:**
- [Installation Problems](#installation-problems)
- [Agents Not Activating](#agents-not-activating)
- [Flow Architect Not Tracing](#flow-architect-not-tracing)
- [Knowledge Not Being Captured](#knowledge-not-being-captured)
- [Codebase Intelligence Stale](#codebase-intelligence-stale)
- [Performance Issues](#performance-issues)
- [Multi-Project Confusion](#multi-project-confusion)
- [Permission Errors](#permission-errors)

---

## 🛠️ Installation Problems

### Issue: "curl: command not found"

**Symptom:**
```bash
$ curl -sSL https://... | bash
bash: curl: command not found
```

**Solution:**

**macOS:**
```bash
# curl is pre-installed, if missing reinstall Command Line Tools
xcode-select --install
```

**Linux (Debian/Ubuntu):**
```bash
sudo apt-get update
sudo apt-get install curl
```

**Linux (RHEL/CentOS):**
```bash
sudo yum install curl
```

**Alternative:** Manual installation
```bash
git clone https://github.com/YOUR_USERNAME/sde-team.git
cp -r sde-team/template/.claude your-project/
```

---

### Issue: "Permission denied" during install

**Symptom:**
```bash
$ curl -sSL https://... | bash
bash: line 42: .claude/agents/: Permission denied
```

**Solution:**

Check directory permissions:
```bash
# Make sure you have write access to project directory
ls -la .

# If needed, fix permissions
chmod u+w .
```

Or install manually with sudo (not recommended):
```bash
curl -sSL https://... -o install.sh
chmod +x install.sh
sudo ./install.sh
```

---

### Issue: ".claude directory already exists"

**Symptom:**
```bash
Error: .claude directory already exists
```

**Solution:**

**Option 1:** Backup and remove existing
```bash
mv .claude .claude.backup
curl -sSL https://... | bash
```

**Option 2:** Merge manually
```bash
# Download to temp directory
mkdir /tmp/elite-sde-team
cd /tmp/elite-sde-team
curl -sSL https://... | bash

# Copy new agents
cp -r .claude/agents/* /path/to/your/project/.claude/agents/

# Copy scripts
cp -r .claude/scripts/* /path/to/your/project/.claude/scripts/
```

---

## 🤖 Agents Not Activating

### Issue: "Agent teams not enabled" (Claude Code)

**Symptom:**
Agents don't activate even after installation. Claude responses are generic.

**Cause:**
Agent teams are **disabled by default** in Claude Code.

**Solution:**

1. Open VS Code settings (`Cmd/Ctrl + ,`)
2. Search for "settings.json"
3. Click "Edit in settings.json"
4. Add:

```json
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  }
}
```

5. Save and **restart VS Code** (critical!)

**Verify:**
After restart, ask Claude:
```
"List all active agents"
```

You should see all 11 agents listed.

---

### Issue: "Agents don't seem to be working"

**Symptom:**
You ask questions but get generic responses, not specialist agent outputs.

**Diagnosis:**

1. **Check `.claude/` directory exists:**
   ```bash
   ls -la .claude/
   # Should show: agents/, scripts/, knowledge/, codebase-map/, CLAUDE.md
   ```

2. **Check `CLAUDE.md` is in `.claude/` folder:**
   ```bash
   ls -la .claude/CLAUDE.md
   # Should exist
   ```

3. **Verify agent files exist:**
   ```bash
   ls -la .claude/agents/
   # Should show 11+ .md files
   ```

**Solutions:**

**If `.claude/` missing:**
```bash
# Reinstall
curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/sde-team/main/install.sh | bash
```

**If `CLAUDE.md` in wrong location:**
```bash
# Move to correct location
mv CLAUDE.md .claude/CLAUDE.md
```

**If agent files missing:**
```bash
# Re-download agents
cd .claude/agents/
curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/sde-team/main/template/agents/master-agent.md -o master-agent.md
# Repeat for other agents...
```

**Claude Code specific:**
1. Restart Claude Code
2. Close and reopen project
3. Clear chat history and start fresh conversation

**Claude Desktop specific:**
1. Remove project from context
2. Re-add project (drag folder or use @)
3. Start new conversation

---

### Issue: "Master Agent explains internal process instead of just delivering results"

**Symptom:**
Master Agent says things like "I'll activate Backend Elite" instead of silently coordinating.

**Solution:**

This is expected behavior in some cases (e.g., when explicitly asked "how does this work?"). But for normal task execution, Master Agent should deliver results directly.

**If happening during normal tasks:**
1. Clear conversation history
2. Start fresh: "Build X" (direct task, no questions)
3. Master Agent should coordinate silently

**Reminder to Master Agent:**
"Execute tasks silently without explaining which agents you're activating. Just deliver the result."

---

## 🌳 Flow Architect Not Tracing

### Issue: "Flow Architect not detecting conflicts"

**Symptom:**
You commit code with obvious race conditions but Flow Architect doesn't report anything.

**Diagnosis:**

1. **Check if Flow Architect agent file exists:**
   ```bash
   ls -la .claude/agents/flow-architect.md
   ```

2. **Check if flow storage directory exists:**
   ```bash
   ls -la .claude/codebase-map/$(basename $(pwd))/flows/
   ```

3. **Check if project detection works:**
   ```bash
   bash .claude/scripts/detect-project.sh
   # Should output your project name
   ```

**Solutions:**

**If agent file missing:**
```bash
curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/sde-team/main/template/agents/flow-architect.md -o .claude/agents/flow-architect.md
```

**If project detection broken:**
```bash
# Verify git repo
git rev-parse --show-toplevel
# Should show your project path

# If not a git repo, initialize
git init
git add .
git commit -m "Initial commit"
```

**If flows directory missing:**
```bash
# Create manually
PROJECT_NAME=$(basename $(git rev-parse --show-toplevel 2>/dev/null) 2>/dev/null || basename $PWD)
mkdir -p .claude/codebase-map/$PROJECT_NAME/flows/
```

**Manual trigger:**

Ask Claude explicitly:
```
"Flow Architect: trace the [feature] flow and detect conflicts"
```

---

### Issue: "Flow Architect traces old flows, not new changes"

**Symptom:**
Made changes but flow map still shows old code.

**Solution:**

Flow Architect traces on git commits. Make sure you committed:
```bash
git add .
git commit -m "Your changes"
```

**Force re-trace:**
```
"Flow Architect: re-trace all flows in [module name]"
```

**Check flow modification time:**
```bash
ls -lt .claude/codebase-map/YourProject/flows/
# Shows files sorted by modification time
```

---

## 📚 Knowledge Not Being Captured

### Issue: "Knowledge Curator not capturing solutions"

**Symptom:**
You solved complex problems but knowledge base is empty.

**Diagnosis:**

1. **Check knowledge directory exists:**
   ```bash
   PROJECT_NAME=$(basename $(pwd))
   ls -la .claude/knowledge/$PROJECT_NAME/
   ```

2. **Check agent file:**
   ```bash
   ls -la .claude/agents/knowledge-curator.md
   ```

**Solutions:**

**If directory missing:**
```bash
PROJECT_NAME=$(basename $(pwd))
mkdir -p .claude/knowledge/$PROJECT_NAME/{backend,frontend,database,security,architecture}
```

**Manual knowledge capture:**

When you solve something complex:
```
"Knowledge Curator: capture this solution about [topic]"
```

**What gets auto-captured:**
- Solutions that took > 5 messages to solve
- Complex debugging scenarios
- Architecture decisions
- Performance optimizations
- Security fixes

**What doesn't get captured:**
- Simple tasks (one-liner fixes)
- Routine CRUD operations
- Straightforward implementations

---

### Issue: "Knowledge exists but agents don't use it"

**Symptom:**
Knowledge files exist but agents re-solve problems instead of checking knowledge base.

**Solution:**

**Verify knowledge is indexed:**
```bash
cat .claude/knowledge/YourProject/INDEX.md
# Should list all knowledge articles
```

**If INDEX.md missing or stale:**
```
"Knowledge Curator: rebuild knowledge index for this project"
```

**Force agent to check knowledge:**
```
"Before implementing, check if Knowledge Curator has existing solutions for [problem]"
```

---

## 🗺️ Codebase Intelligence Stale

### Issue: "Codebase Intelligence shows outdated architecture"

**Symptom:**
Ask "where is X?" and get old file locations or missing new modules.

**Diagnosis:**

1. **Check codebase map age:**
   ```bash
   ls -lt .claude/codebase-map/YourProject/architecture/
   ```

2. **Check if major refactoring happened recently:**
   ```bash
   git log --oneline --since="1 week ago"
   ```

**Solutions:**

**Force rebuild:**
```
"Codebase Intelligence: rebuild architecture map for this project"
```

**Incremental update:**
```
"Codebase Intelligence: update map for [module name] module"
```

**Automated update:**

Codebase Intelligence auto-updates on:
- Git commits (incremental)
- Every 5 minutes (if active)
- On-demand queries

If not updating, restart Claude and re-query.

---

## ⚡ Performance Issues

### Issue: "Claude is slow when activating agents"

**Symptom:**
Responses take 30+ seconds even for simple tasks.

**Causes & Solutions:**

**Cause 1: Large codebase (100K+ lines)**

Solution:
```
"Codebase Intelligence: create summary map (top-level only, skip implementation details)"
```

**Cause 2: Too many knowledge articles**

Solution:
```bash
# Archive old knowledge
cd .claude/knowledge/YourProject/
mkdir archive/
mv old-articles/* archive/
```

**Cause 3: Claude reading entire files**

Solution: Be specific in queries
```
# Instead of: "Show me all auth code"
"Where is the login endpoint specifically?"

# Instead of: "Review entire codebase"
"Review the UserService class"
```

---

### Issue: "Flow tracing takes forever"

**Symptom:**
Flow Architect traces for minutes.

**Solution:**

**Limit scope:**
```
"Flow Architect: trace only the [specific feature] flow, not entire codebase"
```

**Skip unnecessary flows:**
```
"Flow Architect: trace critical paths only (auth, payment, data mutations)"
```

**Optimize flow storage:**
```bash
# Remove old flow traces
find .claude/codebase-map/YourProject/flows/ -mtime +30 -delete
```

---

## 🔀 Multi-Project Confusion

### Issue: "Agents mixing up multiple projects"

**Symptom:**
Working on Project A but agents reference Project B code.

**Diagnosis:**

**Check current project detection:**
```bash
bash .claude/scripts/detect-project.sh
# Should output correct project name
```

**Check knowledge/map directories:**
```bash
ls -la .claude/knowledge/
# Should show separate folder per project
```

**Solutions:**

**If detection wrong:**
```bash
# Make sure you're in correct directory
pwd
# Should be project root

# Make sure project has .git
ls -la .git/
# Should exist

# If not a git repo
git init
git add .
git commit -m "Initial commit"
```

**Force project context:**
```
"I'm working on project [ProjectName]. All queries are for this project only."
```

**Clear context:**
```
"Reset agent context. Current project: [ProjectName]"
```

---

## 🔒 Permission Errors

### Issue: "Permission denied when creating files"

**Symptom:**
```
Error: EACCES: permission denied, mkdir '.claude/knowledge'
```

**Solution:**

**Fix directory permissions:**
```bash
# Check ownership
ls -la .claude/
# If wrong owner:
sudo chown -R $USER:$USER .claude/

# Fix permissions
chmod -R u+w .claude/
```

**If in protected directory (e.g., /usr/local/):**
```bash
# Don't install there! Move project to user directory
cd ~
mkdir projects
mv /path/to/project ~/projects/
cd ~/projects/project-name
```

---

## 🆘 Nuclear Options (When All Else Fails)

### Complete Reinstall

```bash
# 1. Backup existing knowledge (if valuable)
cp -r .claude/knowledge/ ~/elite-sde-backup/knowledge/
cp -r .claude/codebase-map/ ~/elite-sde-backup/codebase-map/

# 2. Remove .claude
rm -rf .claude/

# 3. Reinstall
curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/sde-team/main/install.sh | bash

# 4. Restore knowledge (if backed up)
cp -r ~/elite-sde-backup/knowledge/* .claude/knowledge/
cp -r ~/elite-sde-backup/codebase-map/* .claude/codebase-map/

# 5. Rebuild indexes
# Ask Claude: "Knowledge Curator: rebuild index"
# Ask Claude: "Codebase Intelligence: rebuild architecture map"
```

---

## 🐛 Reporting Bugs

If none of these solutions work:

1. **Gather diagnostic info:**
   ```bash
   # Save to file
   {
     echo "=== System Info ==="
     uname -a
     echo ""
     echo "=== Directory Structure ==="
     tree .claude/ -L 2
     echo ""
     echo "=== Git Status ==="
     git status
     echo ""
     echo "=== Project Detection ==="
     bash .claude/scripts/detect-project.sh
   } > elite-sde-diagnostics.txt
   ```

2. **Open GitHub issue:**
   - Go to: https://github.com/YOUR_USERNAME/sde-team/issues/new
   - Title: Brief description of issue
   - Attach `elite-sde-diagnostics.txt`
   - Describe: What you expected vs what happened
   - Include: Steps to reproduce

3. **Tag appropriately:**
   - `bug` — Something's broken
   - `help wanted` — Need community help
   - `question` — Not sure if bug or misunderstanding

---

## 💬 Getting Help

### Community Support

- **GitHub Discussions:** https://github.com/YOUR_USERNAME/sde-team/discussions
- **Discord:** [Join link]
- **Twitter:** Tweet with #EliteSDETeam

### Documentation

- [Quick Start Guide](quick-start.md)
- [How It Works](how-it-works.md)
- [Agent Guide](agents-guide.md)
- [FAQ](faq.md)

---

## 📖 FAQ Quick Links

- [How do I disable a specific agent?](faq.md#disable-agent)
- [Can I use this with non-Python/JS projects?](faq.md#language-support)
- [How much does this cost?](faq.md#pricing)
- [Does this work offline?](faq.md#offline)

---

**Still stuck?** [Open a discussion](https://github.com/YOUR_USERNAME/sde-team/discussions) — the community is here to help!
