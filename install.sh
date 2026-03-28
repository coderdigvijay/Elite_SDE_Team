#!/bin/bash
# Elite SDE Team - One Command Installer
# The AI Engineering Team That Never Sleeps
#
# Usage: curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/sde-team/main/install.sh | bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}"
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                                                           ║"
echo "║           🚀 ELITE SDE TEAM INSTALLER 🚀                 ║"
echo "║                                                           ║"
echo "║         The AI Engineering Team That Never Sleeps        ║"
echo "║                                                           ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""

# Check if we're in a project directory
if [ ! -d ".git" ] && [ ! -f "package.json" ] && [ ! -f "requirements.txt" ] && [ ! -f "go.mod" ] && [ ! -f "Cargo.toml" ]; then
    echo -e "${YELLOW}⚠️  Warning: Doesn't look like a project directory${NC}"
    echo "   This installer works best when run from your project root."
    echo ""
    read -p "Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 1
    fi
fi

echo -e "${BLUE}📦 Detecting project type...${NC}"

# Detect project type
PROJECT_TYPE="Unknown"
STACK_INFO=""

if [ -f "package.json" ]; then
    PROJECT_TYPE="JavaScript/TypeScript"
    if grep -q "react" package.json; then
        STACK_INFO="React"
    elif grep -q "vue" package.json; then
        STACK_INFO="Vue"
    elif grep -q "angular" package.json; then
        STACK_INFO="Angular"
    elif grep -q "next" package.json; then
        STACK_INFO="Next.js"
    fi
fi

if [ -f "requirements.txt" ] || [ -f "pyproject.toml" ] || [ -f "setup.py" ]; then
    if [ "$PROJECT_TYPE" != "Unknown" ]; then
        PROJECT_TYPE="Full Stack ($PROJECT_TYPE + Python)"
    else
        PROJECT_TYPE="Python"
    fi

    if [ -f "manage.py" ]; then
        STACK_INFO="${STACK_INFO:+$STACK_INFO + }Django"
    elif grep -q "fastapi" requirements.txt 2>/dev/null || grep -q "fastapi" pyproject.toml 2>/dev/null; then
        STACK_INFO="${STACK_INFO:+$STACK_INFO + }FastAPI"
    elif grep -q "flask" requirements.txt 2>/dev/null || grep -q "flask" pyproject.toml 2>/dev/null; then
        STACK_INFO="${STACK_INFO:+$STACK_INFO + }Flask"
    fi
fi

if [ -f "go.mod" ]; then
    PROJECT_TYPE="Go"
fi

if [ -f "Cargo.toml" ]; then
    PROJECT_TYPE="Rust"
fi

echo -e "${GREEN}✅ Detected: $PROJECT_TYPE${NC}"
[ -n "$STACK_INFO" ] && echo -e "${GREEN}   Stack: $STACK_INFO${NC}"
echo ""

# Create .claude directory structure
echo -e "${BLUE}📁 Creating .claude directory structure...${NC}"

mkdir -p .claude/{agents,scripts,knowledge,codebase-map}

# Detect project name
PROJECT_NAME=$(basename "$PWD")

# Initialize project-specific directories
mkdir -p .claude/knowledge/"$PROJECT_NAME"/{backend,frontend,database,security,architecture,debugging,performance,_shared}
mkdir -p .claude/codebase-map/"$PROJECT_NAME"/{architecture,backend,frontend,database,contracts,hot-paths,flows}
mkdir -p .claude/codebase-map/"$PROJECT_NAME"/flows/{authentication,users,admin,_critical}

echo -e "${GREEN}✅ Directory structure created${NC}"
echo ""

# Download template files
echo -e "${BLUE}📥 Downloading Elite SDE Team templates...${NC}"

REPO_URL="https://raw.githubusercontent.com/YOUR_USERNAME/sde-team/main"

# Download CLAUDE.md (main config)
echo "   → CLAUDE.md (main configuration)"
curl -sSL "$REPO_URL/template/CLAUDE.md" -o .claude/CLAUDE.md 2>/dev/null || {
    echo -e "${RED}❌ Failed to download CLAUDE.md${NC}"
    echo "   Please check your internet connection or repository URL"
    exit 1
}

# Download all agents
echo "   → Downloading 11 specialist agents..."

agents=(
    "frontend-elite"
    "backend-elite"
    "database-architect"
    "security-specialist"
    "qa-destructive-tester"
    "ui-ux-elite"
    "ai-genai-specialist"
    "pre-push-validator"
    "knowledge-curator"
    "codebase-intelligence"
    "flow-architect"
)

for agent in "${agents[@]}"; do
    curl -sSL "$REPO_URL/template/agents/$agent.md" -o ".claude/agents/$agent.md" 2>/dev/null && \
        echo -e "      ${GREEN}✓${NC} $agent" || \
        echo -e "      ${YELLOW}⚠${NC} $agent (skipped)"
done

# Download scripts
echo "   → Scripts and utilities"
curl -sSL "$REPO_URL/template/scripts/detect-project.sh" -o .claude/scripts/detect-project.sh 2>/dev/null
chmod +x .claude/scripts/detect-project.sh 2>/dev/null

echo -e "${GREEN}✅ Templates downloaded${NC}"
echo ""

# Initialize knowledge base
echo -e "${BLUE}📚 Initializing knowledge base for: $PROJECT_NAME${NC}"

cat > .claude/knowledge/"$PROJECT_NAME"/INDEX.md << 'EOF'
# Knowledge Base Index

Project-specific knowledge captured by Knowledge Curator.

**Last Updated:** $(date +%Y-%m-%d)
**Total Patterns:** 0 (awaiting first capture)

---

## Domains

### Backend (0 patterns)
### Frontend (0 patterns)
### Database (0 patterns)
### Security (0 patterns)
### Architecture (0 patterns)
### Debugging (0 patterns)
### Performance (0 patterns)

---

Knowledge Curator will automatically populate this as you work.
EOF

# Initialize codebase maps
cat > .claude/codebase-map/"$PROJECT_NAME"/README.md << EOF
# Codebase Intelligence Map - $PROJECT_NAME

Auto-generated and maintained by Codebase Intelligence agent.

**Last Updated:** $(date +%Y-%m-%d)
**Status:** Initialized, awaiting first scan

---

Codebase Intelligence will automatically map your architecture.
EOF

# Initialize flow index
cat > .claude/codebase-map/"$PROJECT_NAME"/flows/FLOW-INDEX.md << EOF
# Flow Index - $PROJECT_NAME

Complete catalog of execution flows traced by Flow Architect.

**Last Updated:** $(date +%Y-%m-%d)
**Total Flows:** 0 (awaiting first trace)
**Status:** Ready to trace

---

Flow Architect will automatically trace execution flows on git changes.
EOF

# Initialize conflicts report
cat > .claude/codebase-map/"$PROJECT_NAME"/flows/CONFLICTS.md << EOF
# Conflict & Issue Report - $PROJECT_NAME

Real-time conflict detection by Flow Architect.

**Last Updated:** $(date +%Y-%m-%d)
**Status:** Monitoring

---

## 🔴 CRITICAL ISSUES (0)
## ⚠️ WARNINGS (0)
## 💡 SUGGESTIONS (0)

Flow Architect will automatically detect issues as you code.
EOF

echo -e "${GREEN}✅ Knowledge base initialized${NC}"
echo ""

# Create .gitignore for .claude if it doesn't exist
if [ ! -f ".gitignore" ]; then
    echo "# Elite SDE Team" > .gitignore
    echo ".claude/knowledge/*/  # Project-specific knowledge (optional: commit for team sharing)" >> .gitignore
    echo ".claude/codebase-map/*/  # Project-specific maps (optional: commit for team sharing)" >> .gitignore
else
    if ! grep -q ".claude" .gitignore; then
        echo "" >> .gitignore
        echo "# Elite SDE Team" >> .gitignore
        echo ".claude/knowledge/*/  # Project-specific knowledge (optional: commit for team sharing)" >> .gitignore
        echo ".claude/codebase-map/*/  # Project-specific maps (optional: commit for team sharing)" >> .gitignore
    fi
fi

echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                                                           ║${NC}"
echo -e "${GREEN}║              ✅ INSTALLATION COMPLETE! ✅                 ║${NC}"
echo -e "${GREEN}║                                                           ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}🎯 Your Elite SDE Team is now active:${NC}"
echo ""
echo "   ✅  11 Specialist Agents (builders)"
echo "       • Frontend Elite"
echo "       • Backend Elite"
echo "       • Database Architect"
echo "       • Security Specialist"
echo "       • QA Destructive Tester"
echo "       • UI/UX Elite"
echo "       • AI/GenAI Specialist"
echo "       • Pre-Push Validator"
echo ""
echo "   ✅  3 Persistent Sentinels (always watching)"
echo "       • Knowledge Curator (captures learnings)"
echo "       • Codebase Intelligence (maps architecture)"
echo "       • Flow Architect (traces execution, detects conflicts)"
echo ""
echo -e "${YELLOW}📖 Next Steps:${NC}"
echo ""
echo "   1. Open your project in Claude Code (or Claude Desktop)"
echo "   2. Try: \"Show me what the Elite SDE Team can do\""
echo "   3. Or: \"Trace the execution flow for [feature]\""
echo "   4. Make a code change and commit → Flow Architect auto-traces!"
echo ""
echo -e "${BLUE}📚 Documentation:${NC}"
echo "   • Quick Start: https://github.com/YOUR_USERNAME/sde-team#quick-start"
echo "   • How It Works: https://github.com/YOUR_USERNAME/sde-team/docs/how-it-works.md"
echo "   • Agent Guide: https://github.com/YOUR_USERNAME/sde-team/docs/agents-guide.md"
echo ""
echo -e "${BLUE}🆘 Need Help?${NC}"
echo "   • Issues: https://github.com/YOUR_USERNAME/sde-team/issues"
echo "   • Discussions: https://github.com/YOUR_USERNAME/sde-team/discussions"
echo ""
echo -e "${GREEN}⭐ If this helps you, please star the repo!${NC}"
echo "   https://github.com/YOUR_USERNAME/sde-team"
echo ""
echo -e "${BLUE}Happy coding with your Elite SDE Team! 🚀${NC}"
echo ""
