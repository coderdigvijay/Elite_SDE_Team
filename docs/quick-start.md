# Quick Start Guide 🚀

Get Elite SDE Team running in your project in **10 minutes**.

---

## Prerequisites

**Required:**
- [Claude Code](https://www.anthropic.com/claude/code) (VS Code extension) **OR**
- [Claude Desktop](https://claude.ai/download) (standalone app)

**Optional:**
- Any coding project (any language, any framework)
- Git (recommended for flow tracing)

**Important:** Elite SDE Team is a **Claude-native framework**. It requires Claude to run. Agents execute inside Claude automatically when you open your project.

**That's it.** No complex setup, no configuration files, no additional dependencies.

---

## Step 1: Enable Agent Teams (Claude Code Only)

**⚠️ CRITICAL: Claude Code requires this configuration first.**

### For Claude Code Users

Agent teams are **disabled by default**. Enable them:

1. Open VS Code
2. Press `Cmd/Ctrl + ,` (open settings)
3. Search for "settings.json"
4. Click "Edit in settings.json"
5. Add:

```json
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  }
}
```

6. Save and **restart VS Code**

### For Claude Desktop Users

✅ **Skip this step** — agent teams enabled by default.

---

## Step 2: Install Elite SDE Team (30 seconds)

### Option A: One-Command Install (Recommended)

```bash
# Navigate to your project directory
cd /path/to/your/project

# Run installer
curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/sde-team/main/install.sh | bash
```

### Option B: Manual Install

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/sde-team.git

# Copy template to your project
cp -r sde-team/template/.claude /path/to/your/project/

# Done!
```

---

## Step 2: Verify Installation (10 seconds)

```bash
# Check if .claude directory was created
ls -la .claude/

# You should see:
# .claude/
# ├── CLAUDE.md
# ├── agents/ (11+ agent files)
# ├── scripts/
# ├── knowledge/
# └── codebase-map/
```

✅ If you see this structure, installation successful!

---

## Step 3: Open Project in Claude (1 minute)

**Agents activate automatically when Claude detects `.claude/` folder.**

### Option A: Claude Code (VS Code Extension)

1. Open VS Code
2. Open your project folder: **File → Open Folder**
3. Claude Code auto-detects `.claude/` folder
4. ✅ **Agents are now active**

### Option B: Claude Desktop

1. Open Claude Desktop app
2. Click **Attach** button (📎)
3. Select **Add folder** → choose your project
4. Claude Desktop auto-detects `.claude/` folder
5. ✅ **Agents are now active**

### Verify Agents Are Active

Ask Claude:
```
"List all active agents"
```

You should see:
```
✅ Elite SDE Team Active

Specialist Agents:
• Frontend Elite, Backend Elite, Database Architect...

Sentinel Agents:
• Knowledge Curator, Codebase Intelligence, Flow Architect
```

**If you see this, you're ready!** No further setup needed.

---

## Step 4: Try It Out (5 minutes)

### Example 1: Get Instant Context

```
You: "Where is the user authentication logic?"

Master Agent:
User authentication spans:

Backend:
  • routers/auth.py:45-89
  • services/auth_service.py:23-67

Frontend:
  • services/auth.ts:8-34
  • contexts/AuthContext.tsx:15-78

[Complete breakdown provided]
```

---

### Example 2: Trace Execution Flow

```
You: "Show me the login flow"

Master Agent:
Complete execution trace:

LoginForm.tsx:89
  → authService.login()
    → POST /api/auth/login
      → routers/auth.py:45
        → auth_service.authenticate_user()
          → db.query(User)
          → bcrypt.verify()
          → create_jwt_token()
          [returns success]

Metrics:
  • DB Queries: 1
  • Response Time: ~200ms
  • Security: ✅ Auth verified, JWT signed
  • Issues: None detected
```

---

### Example 3: Detect Conflicts

```
# Make a change with a race condition
# (e.g., update user.score without locking)

# Commit your code
git add .
git commit -m "Add score tracking"

# Flow Architect automatically:
⚠️ RACE CONDITION DETECTED

Issue: Concurrent writes to user.score without locking
Location: services/user_service.py:67
Impact: Data loss on concurrent requests

Fix:
user = db.query(User).with_for_update().filter_by(id=id).first()
user.score += points
db.commit()
```

---

### Example 4: Build a Feature

```
You: "Add user profile page with avatar upload"

Master Agent:
[Automatically coordinates Frontend Elite, Backend Elite, Security Specialist]
[Checks existing patterns from sentinels]
[Implements with full context]

Done! User profile page implemented:
  ✅ Frontend: ProfilePage.tsx with avatar upload
  ✅ Backend: PUT /api/users/{id}/avatar endpoint
  ✅ Security: Auth check + file validation
  ✅ Database: avatar_url column added
  ✅ Tests: All passing

No race conditions detected ✅
```

---

## Step 5: Understand What's Happening

### Behind the Scenes (Automatic):

1. **Master Agent** orchestrates everything
2. **Specialist Agents** (Frontend, Backend, etc.) build features
3. **Sentinels** provide context and catch issues:
   - **Knowledge Curator** remembers past solutions
   - **Codebase Intelligence** knows where everything is
   - **Flow Architect** traces execution and detects conflicts

**You just say what you want. Everything else is automatic.**

---

## Common First Tasks

### Explore Your Codebase

```
"Show me the overall architecture"
"What are the main API endpoints?"
"Where is database connection configured?"
"Show me all authentication-related code"
```

### Trace Flows

```
"Show me the user registration flow"
"Trace what happens when user clicks submit"
"How does authentication work end-to-end?"
```

### Find Issues

```
"Are there any race conditions?"
"Show me all N+1 queries"
"What endpoints are missing auth checks?"
"Check for cache invalidation gaps"
```

### Build Features

```
"Add email verification to registration"
"Implement password reset flow"
"Add user profile editing"
"Create admin dashboard"
```

---

## Configuration (Optional)

Elite SDE Team works **out of the box** with zero configuration.

But if you want to customize:

### Customize Agent Behavior

Edit `.claude/CLAUDE.md` to:
- Add project-specific rules
- Define coding standards
- Specify architectural patterns
- Add tech stack details

### Add Custom Agents

See [Customization Guide](customization.md)

### Share Knowledge Across Team

Commit `.claude/knowledge/` and `.claude/codebase-map/` to git:

```bash
# Remove from .gitignore
# This shares institutional memory with your team!
git add .claude/knowledge/
git add .claude/codebase-map/
git commit -m "Share Elite SDE Team knowledge base"
```

---

## Troubleshooting

### Issue: "Agents not responding"

**Solution:**
1. Verify `.claude/` directory exists
2. Check `.claude/CLAUDE.md` is present
3. Restart Claude Code/Desktop
4. Try: "Reset agent context and show me the team"

### Issue: "Flow Architect not tracing"

**Solution:**
Flow Architect traces automatically on git commits. If not working:
1. Make sure you're committing to git
2. Or manually trigger: "Flow Architect: trace all flows"

### Issue: "Knowledge not being captured"

**Solution:**
Knowledge Curator captures automatically when:
- Complex problems solved
- Edge cases found
- Architectural decisions made

Give it time. After solving a few complex issues, check:
```bash
cat .claude/knowledge/YOUR_PROJECT/INDEX.md
```

---

## Next Steps

✅ **You're ready!** Start building with your Elite SDE Team.

**Recommended reading:**
- [How It Works](how-it-works.md) — Understand the architecture
- [Agent Guide](agents-guide.md) — What each agent does
- [Customization](customization.md) — Make it your own

**Join the community:**
- [GitHub Discussions](https://github.com/YOUR_USERNAME/sde-team/discussions)
- [Report Issues](https://github.com/YOUR_USERNAME/sde-team/issues)
- [Twitter](https://twitter.com/YOUR_HANDLE) — Share your wins with #EliteSDETeam

---

**Questions?** [Open an issue](https://github.com/YOUR_USERNAME/sde-team/issues) or [start a discussion](https://github.com/YOUR_USERNAME/sde-team/discussions).

**Happy coding with your Elite SDE Team!** 🚀
