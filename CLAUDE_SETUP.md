# Claude Code Setup Guide 🚀

How to make Claude automatically detect and use Elite SDE Team agents.

---

## 🎯 How Claude Discovers Agents

Claude Code/Claude Desktop **automatically** discovers agents when:

1. **`.claude/` folder exists** in your project root
2. **`CLAUDE.md`** file exists in `.claude/` folder
3. **Agent files** (`.md`) exist in `.claude/agents/` folder

That's it! No manual configuration needed.

---

## ✅ Installation Process

### Step 1: Enable Agent Teams (Claude Code Only)

**CRITICAL: Agent teams are disabled by default in Claude Code.**

**For Claude Code (VS Code Extension):**

1. Open VS Code settings (`Cmd/Ctrl + ,`)
2. Search for "settings.json"
3. Click "Edit in settings.json"
4. Add this configuration:

```json
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  }
}
```

5. Save and restart VS Code

**For Claude Desktop:**
- ✅ Agent teams enabled by default - no configuration needed

---

### Step 2: Install Elite SDE Team

```bash
# Navigate to your project
cd /path/to/your/project

# Run installer
curl -sSL https://raw.githubusercontent.com/coderdigvijay/Elite_SDE_Team/main/install.sh | bash
```

**What this does:**
- Creates `.claude/` folder structure
- Downloads all agent files
- Sets up knowledge and codebase-map directories
- Makes everything discoverable by Claude

---

### Step 3: Open Project in Claude

**Option A: Claude Code (VS Code Extension)**

1. Open VS Code
2. Open your project folder (File → Open Folder)
3. Claude Code extension automatically detects `.claude/` folder
4. Chat panel shows "Elite SDE Team active ✅"

**Option B: Claude Desktop**

1. Open Claude Desktop app
2. Add project context:
   - Click "Attach" button (📎)
   - Select "Add folder"
   - Choose your project folder
3. Claude automatically detects `.claude/` folder
4. All agents are now active

---

### Step 3: Verify Installation

Ask Claude:
```
"List all active agents"
```

Claude should respond with:
```
✅ Elite SDE Team Active

Specialist Agents:
• Frontend Elite
• Backend Elite
• Database Architect
• Security Specialist
• QA Destructive Tester
• UI/UX Elite
• AI/GenAI Specialist
• Pre-Push Validator

Sentinel Agents (Always Watching):
• Knowledge Curator
• Codebase Intelligence
• Flow Architect
```

---

## 🔍 How Claude Uses Agents

### Automatic Activation

**You don't need to manually activate agents.** Claude's Master Agent automatically:

1. **Reads your request**
2. **Determines which specialists are needed**
3. **Activates them silently**
4. **Coordinates their work**
5. **Delivers final result**

**Example:**

```
You: "Add user authentication"

Claude (silently):
  → Activates: Frontend Elite, Backend Elite, Database Architect,
               Security Specialist, Flow Architect
  → Coordinates their implementation
  → Delivers complete auth system

You see: Complete implementation with:
  - Frontend login form
  - Backend JWT endpoints
  - Database user table
  - Security review passed
  - No race conditions detected
```

---

## 📁 Required File Structure

After installation, your project should have:

```
your-project/
├── .claude/                    ← Claude auto-detects this folder
│   ├── CLAUDE.md               ← Master instructions
│   ├── agents/                 ← Agent definitions
│   │   ├── master-agent.md
│   │   ├── frontend-elite.md
│   │   ├── backend-elite.md
│   │   └── ... (11+ agents)
│   ├── scripts/
│   │   └── detect-project.sh
│   ├── knowledge/              ← Institutional memory (auto-created)
│   └── codebase-map/           ← Architecture maps (auto-created)
│
├── your-code/
└── ...
```

**Claude looks for:** `.claude/CLAUDE.md` - If this exists, agents are active.

---

## 🔧 Troubleshooting

### Issue: "Claude doesn't seem to use agents"

**Check:**
```bash
# Verify .claude folder exists
ls -la .claude/

# Should show:
# CLAUDE.md
# agents/
# scripts/
# knowledge/
# codebase-map/
```

**Fix:**
```bash
# If missing, reinstall
curl -sSL https://raw.githubusercontent.com/coderdigvijay/Elite_SDE_Team/main/install.sh | bash
```

---

### Issue: "CLAUDE.md not found"

**Check location:**
```bash
# Should be IN .claude/ folder, not root
ls -la .claude/CLAUDE.md
```

**Fix if in wrong location:**
```bash
# If in root, move it
mv CLAUDE.md .claude/CLAUDE.md
```

---

### Issue: "Agents activate but don't have context"

**This is normal on first use.** Sentinels need time to build initial maps.

**Speed it up:**
```
"Codebase Intelligence: map this project's architecture"
"Flow Architect: trace all critical flows"
```

After this, agents have full context.

---

## 🎨 Claude Code Specific Features

### Chat Panel

In VS Code with Claude Code:
- Open chat panel (Cmd/Ctrl + Shift + P → "Claude Code: Open Chat")
- Ask questions directly
- Claude auto-activates agents based on your question

### File Context

Claude Code automatically provides:
- Currently open file
- Selected code
- Workspace structure

Agents use this context automatically.

---

## 📱 Claude Desktop Specific Features

### Project Context

1. **Attach project folder** (📎 → Add folder)
2. **Claude scans `.claude/` folder**
3. **Agents activate automatically**

### Multiple Projects

Claude Desktop supports multiple projects:
- Each project's `.claude/` folder is independent
- No cross-contamination
- Switch projects by changing attached folder

---

## 🚀 First Usage Examples

### Example 1: Get Instant Context

```
You: "Where is the user authentication logic?"

Claude (uses Codebase Intelligence):
  → Returns exact file locations
  → Shows complete auth flow
  → No searching needed
```

### Example 2: Catch Bugs Automatically

```
You: *commits code with race condition*

Claude (Flow Architect auto-activates):
  → "⚠️ Race condition detected in user_service.py:67"
  → Shows exact fix
  → Prevents production bug
```

### Example 3: Never Debug Twice

```
You: "How do I handle concurrent updates?"

Claude (Knowledge Curator):
  → "Found existing pattern from 2 weeks ago"
  → Shows exact code used 3 times already
  → Copy-paste ready solution
```

---

## 🎯 What Happens Behind the Scenes

### When You Open Project

```
1. Claude Code/Desktop starts
2. Scans for .claude/CLAUDE.md
3. If found:
   → Reads master instructions
   → Discovers all agent files
   → Loads agent capabilities
   → Activates sentinel agents
4. You see: "Ready" (agents are active)
```

### When You Ask Question

```
1. Master Agent receives your question
2. Analyzes what's needed
3. Queries sentinels for context:
   → Codebase Intelligence: architecture
   → Knowledge Curator: past solutions
   → Flow Architect: execution flows
4. Activates specialist agents needed
5. Coordinates their work
6. Delivers synthesized result
```

### When You Commit Code

```
1. Git commit detected
2. Flow Architect auto-activates
3. Traces affected execution flows
4. Detects conflicts:
   → Race conditions
   → N+1 queries
   → Cache gaps
   → Security holes
5. Reports findings immediately
```

---

## 💡 Pro Tips

### Tip 1: Let Claude Work Automatically

**Don't say:** "Activate Backend Elite to build API endpoint"

**Instead say:** "Build API endpoint for user profile"

Master Agent handles agent activation automatically.

---

### Tip 2: Start Fresh Conversations for Big Tasks

For major features:
1. Close current chat
2. Start new conversation
3. Claude loads fresh context

---

### Tip 3: Use Specific Queries

**Vague:** "Review my code"
**Better:** "Review UserService for race conditions"

More specific = faster, more accurate results.

---

### Tip 4: Check Knowledge Base Regularly

```
"Knowledge Curator: what patterns have we captured?"
```

Shows institutional memory growing over time.

---

## 📊 Verification Commands

Test that everything works:

```bash
# 1. Check installation
ls -la .claude/

# 2. Open in Claude Code/Desktop

# 3. Run verification queries:
"List all active agents"
"Where is [some functionality] in this codebase?"
"Flow Architect: trace [feature name] flow"
"Knowledge Curator: what have we learned so far?"
```

If all respond correctly → ✅ Setup complete!

---

## 🔄 Updates

When Elite SDE Team releases updates:

```bash
# Pull latest changes
cd .claude/
git pull  # If you cloned the repo

# Or reinstall (preserves knowledge/)
curl -sSL https://raw.githubusercontent.com/coderdigvijay/Elite_SDE_Team/main/install.sh | bash
```

Your knowledge base and codebase maps are preserved.

---

## ✅ Success Checklist

You know it's working when:

- [x] `.claude/CLAUDE.md` exists
- [x] Claude responds with agent-specific insights
- [x] Flow Architect detects conflicts automatically
- [x] Codebase Intelligence answers "where is X?" instantly
- [x] Knowledge Curator recalls past solutions
- [x] No manual agent activation needed

---

## 🆘 Still Not Working?

1. **Restart Claude Code/Desktop**
2. **Close and reopen project folder**
3. **Verify file structure** (see above)
4. **Check [Troubleshooting Guide](docs/troubleshooting.md)**
5. **Open GitHub issue** with diagnostic info

---

**Bottom line:** Install → Open project in Claude → Everything works automatically. No configuration. No manual setup. Just works. ✅
