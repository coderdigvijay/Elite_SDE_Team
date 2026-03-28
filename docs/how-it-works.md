# How Elite SDE Team Works 🏗️

Deep dive into the architecture, agent coordination, and technical implementation.

---

## 🎯 Core Philosophy

Elite SDE Team operates on three principles:

1. **Automatic Intelligence** — Agents activate without manual triggers
2. **Persistent Awareness** — Sentinels continuously monitor and learn
3. **Zero Configuration** — Works out of the box, improves over time

---

## 🏛️ Three-Tier Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    MASTER AGENT                         │
│         (Orchestrates everything automatically)         │
│                                                         │
│  • Receives user intent                                │
│  • Decomposes into subtasks                            │
│  • Activates specialist agents                         │
│  • Coordinates cross-agent reviews                     │
│  • Delivers final solution                             │
└────────────────────┬────────────────────────────────────┘
                     │
        ┌────────────┴────────────┐
        │                         │
  ┌─────▼──────┐          ┌──────▼─────┐
  │ SPECIALISTS │          │  SENTINELS │
  │  (Builders) │          │ (Watchers) │
  └─────┬───────┘          └──────┬─────┘
        │                         │
        │                         │
  ┌─────▼──────────────────┐      │
  │ Frontend Elite         │      │
  │ Backend Elite          │      │
  │ Database Architect     │      │
  │ Security Specialist    │      │
  │ QA Destructive         │      │
  │ UI/UX Elite            │      │
  │ AI/GenAI Specialist    │      │
  │ Pre-Push Validator     │      │
  └────────────────────────┘      │
                                  │
                 ┌────────────────▼──────────────┐
                 │ Knowledge Curator             │
                 │ (Institutional Memory)        │
                 │                               │
                 │ Codebase Intelligence         │
                 │ (Live Architecture Map)       │
                 │                               │
                 │ Flow Architect                │
                 │ (Execution Tracing + Conflicts) │
                 └───────────────────────────────┘
```

---

## 🤖 Agent Types Explained

### 1. Master Agent (You Never See This)

**Role:** Supreme orchestrator

**Activation:** Always active when you interact with Claude

**What it does:**
1. Parses your request
2. Determines which specialists needed
3. Activates agents in correct order
4. Coordinates cross-agent reviews
5. Synthesizes final solution
6. Delivers result to you

**Example:**
```
You: "Add user profile editing"

Master Agent (silently):
1. Query Codebase Intelligence → Where is user logic?
2. Activate Frontend Elite → Build UI components
3. Activate Backend Elite → Create API endpoint
4. Activate Database Architect → Check schema (no changes needed)
5. Activate Security Specialist → Validate auth requirements
6. Activate QA Destructive → Find edge cases
7. Flow Architect → Trace new flow, detect conflicts
8. Knowledge Curator → Capture patterns for future
9. Synthesize and deliver

You see: [Complete implementation with all concerns handled]
```

---

### 2. Specialist Agents (The Builders)

**Role:** Domain experts who implement features

**Activation:** When Master Agent assigns task in their domain

**Specialists:**

| Agent | Domain | Expertise |
|-------|--------|-----------|
| **Frontend Elite** | React, TypeScript, UI | Components, state, performance, bundle optimization |
| **Backend Elite** | FastAPI, Services, APIs | Business logic, concurrency, caching, API design |
| **Database Architect** | PostgreSQL, Migrations | Schema design, indexes, query optimization, migrations |
| **Security Specialist** | Auth, RBAC, Exploits | JWT, permissions, injection, privilege escalation |
| **QA Destructive** | Testing, Edge Cases | Race conditions, failure scenarios, stress testing |
| **UI/UX Elite** | Design, Accessibility | Design systems, UX flows, visual hierarchy |
| **AI/GenAI Specialist** | LLMs, RAG, Embeddings | AI pipelines, prompt engineering, vector search |
| **Pre-Push Validator** | Full-Stack Gate Check | TypeScript build, imports, migrations, API contracts |

**How they work:**

```python
# Conceptual flow (automatic)

def handle_user_request(request: str):
    # Master Agent decides
    needed_agents = master.analyze(request)

    # Parallel activation
    results = []
    for agent in needed_agents:
        # Each agent queries sentinels first
        context = agent.get_context_from_sentinels()

        # Then implements
        implementation = agent.execute(request, context)

        # Cross-review
        issues = cross_review(implementation, other_agents)

        results.append(implementation)

    # Master Agent synthesizes
    return master.synthesize(results)
```

---

### 3. Sentinel Agents (The Watchers)

**Role:** Persistent intelligence that never stops

**Activation:** Always running in background

**The Three Sentinels:**

#### A. Knowledge Curator

**Mission:** Never debug the same bug twice

**How it works:**

```
Continuous Monitoring:
┌─────────────────────────────────────────────┐
│ 1. Watch for complex problem-solving        │
│ 2. Detect when solution is non-trivial      │
│ 3. Capture:                                  │
│    • Problem description                     │
│    • Solution approach                       │
│    • Code examples                           │
│    • Gotchas discovered                      │
│    • Performance implications                │
│ 4. Store in project-specific knowledge base │
│ 5. Index for fast retrieval                 │
│ 6. Train other agents                        │
└─────────────────────────────────────────────┘

Storage Structure:
.claude/knowledge/
└── YourProject/
    ├── backend/
    │   ├── concurrency-patterns.md
    │   ├── cache-invalidation-gotchas.md
    │   └── performance-optimizations.md
    ├── frontend/
    │   ├── state-management-decisions.md
    │   └── bundle-optimization.md
    ├── database/
    │   ├── migration-lessons.md
    │   └── index-strategies.md
    └── INDEX.md (searchable)
```

**Example capture:**

```markdown
# Optimistic Locking for Concurrent Updates

**Captured:** 2024-01-15
**Problem:** User score updated by two concurrent requests → data loss
**Trigger:** Race condition detected by Flow Architect
**Solution:** Add version column + WHERE clause

## Implementation Pattern

\`\`\`python
# Add version to model
class User(Base):
    version = Column(Integer, default=1)

# Update with optimistic lock
def update_score(user_id: int, points: int):
    user = db.query(User).filter_by(id=user_id).first()

    # Atomic update with version check
    result = db.query(User).filter(
        User.id == user_id,
        User.version == user.version
    ).update({
        "score": User.score + points,
        "version": User.version + 1
    })

    if result == 0:
        raise ConcurrentUpdateError("Version mismatch")

    db.commit()
\`\`\`

## Gotchas
- Always increment version in same UPDATE
- Handle ConcurrentUpdateError with retry logic
- Consider row-level locks for complex multi-field updates

## Applied In
- services/challenge_service.py:156
- services/reward_service.py:89
- services/group_service.py:234
```

---

#### B. Codebase Intelligence

**Mission:** Instant, complete context for any question

**How it works:**

```
Continuous Mapping:
┌─────────────────────────────────────────────┐
│ 1. Scan codebase on every git commit        │
│ 2. Build architectural map:                 │
│    • Module dependencies                    │
│    • API contracts                          │
│    • Database models                        │
│    • Service layers                         │
│    • Frontend components                    │
│ 3. Track relationships                      │
│ 4. Index by domain/feature                  │
│ 5. Serve instant answers                    │
└─────────────────────────────────────────────┘

Storage Structure:
.claude/codebase-map/
└── YourProject/
    ├── architecture/
    │   ├── backend-services.md
    │   ├── frontend-structure.md
    │   └── api-contracts.md
    ├── backend/
    │   ├── routers/
    │   ├── services/
    │   └── models/
    ├── frontend/
    │   ├── components/
    │   ├── pages/
    │   └── services/
    ├── database/
    │   └── schema.md
    └── hot-paths/
        └── critical-operations.md
```

**Query examples:**

```bash
# You ask: "Where is user authentication?"

Codebase Intelligence instantly returns:

User authentication spans:

Backend:
  • routers/auth.py:45-89 — POST /login, /logout
  • services/auth_service.py:23-67 — authenticate_user()
  • services/access_service.py:12-45 — check_permission()

Frontend:
  • services/auth.ts:8-34 — login(), logout()
  • contexts/AuthContext.tsx:15-78 — global auth state
  • hooks/useAuth.ts:5-23 — useAuth hook

Database:
  • models/user.py:12-34 — User model
  • models/token.py:8-19 — RefreshToken model

Flow: See .claude/codebase-map/YourProject/flows/authentication/
```

---

#### C. Flow Architect

**Mission:** Catch bugs automatically by tracing execution

**How it works:**

```
Flow Tracing Algorithm:
┌─────────────────────────────────────────────┐
│ 1. Detect code change (git commit)          │
│ 2. Identify entry point (user action)       │
│ 3. Trace execution tree:                    │
│                                              │
│    User clicks button                       │
│      → Frontend handler                     │
│        → API call                            │
│          → Backend router                   │
│            → Service layer                  │
│              → Database query               │
│              ← Result                       │
│            ← Processed data                 │
│          ← JSON response                    │
│        ← Success                            │
│      ← UI update                            │
│                                              │
│ 4. For each node:                           │
│    • Check for conflicts                    │
│    • Measure performance                    │
│    • Validate security                      │
│    • Detect anti-patterns                   │
│                                              │
│ 5. Build complete flow tree                 │
│ 6. Store with conflict annotations          │
│ 7. Alert on CRITICAL issues                 │
└─────────────────────────────────────────────┘
```

**Conflict Detection Engine:**

```python
# Conceptual implementation

def detect_conflicts(flow_tree):
    issues = []

    # 1. Race Conditions
    for node in flow_tree.db_operations:
        if node.operation == "UPDATE" and not node.has_lock:
            if concurrent_access_possible(node):
                issues.append({
                    "severity": "CRITICAL",
                    "type": "Race Condition",
                    "location": node.file_path,
                    "line": node.line_number,
                    "description": f"Concurrent {node.operation} without locking",
                    "impact": "Data loss on simultaneous requests",
                    "fix": generate_lock_solution(node)
                })

    # 2. N+1 Queries
    for node in flow_tree.loops:
        if has_query_inside(node):
            iterations = estimate_iterations(node)
            if iterations > 10:
                issues.append({
                    "severity": "WARNING",
                    "type": "N+1 Query",
                    "location": node.file_path,
                    "description": f"Query inside loop ({iterations}x multiplier)",
                    "impact": f"1 query → {iterations} queries under load",
                    "fix": "Use JOIN or bulk fetch"
                })

    # 3. Cache Invalidation Gaps
    for mutation in flow_tree.mutations:
        cached_keys = find_related_cache_keys(mutation.model)
        if not mutation.invalidates_cache(cached_keys):
            issues.append({
                "severity": "WARNING",
                "type": "Cache Gap",
                "location": mutation.file_path,
                "description": f"{mutation.model} updated but cache not invalidated",
                "impact": "Stale data served to users",
                "fix": f"Add cache.delete({cached_keys})"
            })

    # 4. Security Holes
    for endpoint in flow_tree.api_endpoints:
        if not endpoint.has_auth_check:
            issues.append({
                "severity": "CRITICAL",
                "type": "Security Hole",
                "location": endpoint.file_path,
                "description": "Endpoint missing authentication check",
                "impact": "Unauthorized access possible",
                "fix": "Add @require_auth decorator"
            })

    return issues
```

**Storage Structure:**

```
.claude/codebase-map/YourProject/flows/
├── authentication/
│   ├── login-flow.md
│   ├── logout-flow.md
│   └── token-refresh-flow.md
├── user-management/
│   ├── profile-update-flow.md
│   └── score-update-flow.md
└── challenges/
    ├── submit-solution-flow.md
    └── validate-answer-flow.md
```

**Example flow output:**

```markdown
# Login Flow

**Entry Point:** User clicks "Login" button
**Traced:** 2024-01-15 14:23:45
**Status:** ✅ No conflicts detected

## Execution Tree

LoginForm.tsx:89 (onClick)
  → authService.login(email, password)
    → POST /api/auth/login
      → routers/auth.py:45 (login endpoint)
        ✅ Auth: Public endpoint (intentional)
        → auth_service.authenticate_user(email, password)
          → db.query(User).filter_by(email=email).first()
            📊 Query: SELECT * FROM users WHERE email = ?
            ⚡ Performance: 5ms (indexed)
          → bcrypt.verify(password, user.password_hash)
            ⚡ Performance: 200ms (acceptable for bcrypt)
          → create_jwt_token(user.id)
            ✅ Security: JWT signed with secret
          ← {"access_token": "...", "user": {...}}
        ← 200 OK
      ← JSON response
    ← Success
  → AuthContext.setUser(user)
  → navigate("/dashboard")

## Metrics

- **Total Time:** ~250ms
- **DB Queries:** 1 (optimized)
- **Cache Hits:** 0 (no caching on login)
- **Security:** ✅ Password hashed, JWT signed
- **Performance:** ✅ Acceptable

## Conflicts Detected

None ✅

## Recommendations

1. Consider rate limiting on login endpoint (prevent brute force)
2. Add logging for failed login attempts
3. Cache user permissions after login (reduce DB queries on next request)
```

---

## 🔄 Automatic Workflow

### When You Make a Code Change

```
1. You commit code
   ↓
2. Flow Architect activates (automatic)
   ↓
3. Traces all affected flows
   ↓
4. Detects conflicts (if any)
   ↓
5. Reports issues with severity + fixes
   ↓
6. Knowledge Curator captures solution (if complex)
   ↓
7. Codebase Intelligence updates maps
```

### When You Ask a Question

```
1. You: "Where is authentication logic?"
   ↓
2. Master Agent activates
   ↓
3. Queries Codebase Intelligence (instant)
   ↓
4. Returns complete answer with file:line references
```

### When You Request a Feature

```
1. You: "Add user profile editing"
   ↓
2. Master Agent decomposes task
   ↓
3. Activates specialists:
   • Codebase Intelligence → provide context
   • Frontend Elite → build UI
   • Backend Elite → create API
   • Security Specialist → validate auth
   • QA Destructive → find edge cases
   ↓
4. Each agent queries sentinels first
   ↓
5. Parallel implementation
   ↓
6. Cross-agent review
   ↓
7. Flow Architect traces new flow
   ↓
8. Knowledge Curator captures patterns
   ↓
9. Master Agent synthesizes
   ↓
10. You receive complete solution
```

---

## 🧠 Agent Coordination Protocol

### Cross-Agent Review

After any implementation, automatic review happens:

```python
# Conceptual flow

def cross_agent_review(implementation):
    reviews = []

    # Security review (always)
    security_issues = security_specialist.review(implementation)
    reviews.append(security_issues)

    # QA review (always)
    edge_cases = qa_destructive.review(implementation)
    reviews.append(edge_cases)

    # Database review (if schema touched)
    if implementation.touches_database:
        db_issues = database_architect.review(implementation)
        reviews.append(db_issues)

    # Performance review (if flow changed)
    if implementation.changes_flow:
        perf_issues = flow_architect.review(implementation)
        reviews.append(perf_issues)

    # Aggregate
    critical_issues = [r for r in reviews if r.severity == "CRITICAL"]

    if critical_issues:
        return "BLOCKED", critical_issues
    else:
        return "APPROVED", reviews
```

---

## 📊 Multi-Project Intelligence

### Project Detection

```bash
# Automatic detection script
.claude/scripts/detect-project.sh

# Logic:
1. Check git repo name: basename $(git rev-parse --show-toplevel)
2. Fallback to directory name: basename $PWD
3. Store in PROJECT_NAME variable
```

### Project-Specific Storage

```
.claude/knowledge/
├── YourProject/          ← Auto-detected
├── my-ecommerce/      ← Auto-detected
└── social-network/    ← Auto-detected

.claude/codebase-map/
├── YourProject/
├── my-ecommerce/
└── social-network/
```

### Context Switching

```bash
# You work on Project A
cd ~/projects/skillbit
# Agents load: .claude/knowledge/YourProject/, .claude/codebase-map/YourProject/

# You switch to Project B
cd ~/projects/ecommerce
# Agents load: .claude/knowledge/ecommerce/, .claude/codebase-map/ecommerce/

# No manual configuration. Ever.
```

---

## ⚡ Performance Optimizations

### 1. Lazy Loading

Agents only load context when needed:

```python
# Conceptual
class Agent:
    def execute(self, task):
        # Only load relevant context
        context = self.load_context(task.domain)

        # Not entire codebase
        return self.implement(task, context)
```

### 2. Incremental Updates

Sentinels update incrementally:

```python
# Conceptual
class FlowArchitect:
    def on_commit(self, changed_files):
        # Only re-trace affected flows
        affected_flows = self.find_affected_flows(changed_files)

        for flow in affected_flows:
            self.trace(flow)

        # Not entire codebase
```

### 3. Caching

```python
# Conceptual
class CodebaseIntelligence:
    @cache(ttl=300)  # 5 minutes
    def get_architecture_map(self, project):
        # Expensive operation cached
        return self.build_map(project)
```

---

## 🎯 Quality Gates

### Before Any Code Ships

```
Pre-Push Validator runs:

✅ TypeScript build passes
✅ Backend imports valid
✅ Migration chain intact
✅ API contracts match
✅ No unprotected endpoints
✅ No secrets in code
✅ All tests pass

If any fail → BLOCKED
```

---

## 🔒 Security Model

### Always Server-Side

```python
# WRONG (client-side check)
if user.role == "admin":
    show_admin_panel()

# RIGHT (server-side enforcement)
@require_permission("admin:access")
def admin_endpoint():
    # Server validates via Security Specialist
    return admin_data
```

### Automatic Validation

```python
# Security Specialist checks every endpoint:

def validate_endpoint(endpoint):
    issues = []

    if not endpoint.has_auth_decorator:
        issues.append("Missing @require_auth")

    if endpoint.accepts_user_input and not endpoint.validates_input:
        issues.append("Unvalidated input (injection risk)")

    if endpoint.returns_sensitive_data and not endpoint.filters_fields:
        issues.append("Potential data leak")

    return issues
```

---

## 🎓 Learning Over Time

### Knowledge Accumulation

```
Day 1: Solve race condition → Captured
Day 30: Similar issue → Solution retrieved in 10 seconds
Day 90: Pattern applied 15 times automatically
Day 180: New team member asks → Instant answer with examples
```

### Pattern Recognition

```python
# Conceptual
class KnowledgeCurator:
    def detect_pattern(self, solution):
        # Find similar past solutions
        similar = self.search(solution.problem_signature)

        if len(similar) >= 3:
            # Pattern emerging
            self.create_pattern_doc(similar)
            self.train_agents(pattern)
```

---

## 📈 Metrics and Observability

### What Gets Tracked

```
Per Flow:
- Execution time
- DB query count
- Cache hit rate
- Conflicts detected
- Security validations

Per Project:
- Total flows mapped
- Knowledge articles captured
- Conflicts prevented
- Average implementation time
```

### Continuous Improvement

```
Flow Architect learns:
- Which patterns cause conflicts
- Performance bottlenecks
- Common security gaps

Knowledge Curator learns:
- Which problems recur
- Which solutions work
- Which patterns scale

Codebase Intelligence learns:
- Architecture evolution
- Dependency changes
- Hot paths
```

---

## 🛠️ Extensibility

### Adding Custom Agents

```bash
# Create agent file
.claude/agents/my-custom-agent.md

# Follow template structure
---
name: my-custom-agent
description: What this agent does
---

# Agent content
[See CONTRIBUTING.md for full template]
```

### Custom Knowledge Domains

```bash
# Add custom knowledge area
.claude/knowledge/YourProject/my-domain/

# Agents automatically discover and use it
```

---

## 🎬 Real-World Example

### Complete Flow: User Submits Challenge Solution

```
1. User clicks "Submit" in frontend
   ↓
2. Flow Architect traces (automatic):

   ChallengeForm.tsx:156
     → challengeService.submitSolution(challengeId, code)
       → POST /api/challenges/{id}/submit
         → routers/challenges.py:89
           ✅ Auth: @require_auth present
           → challenge_service.validate_and_score(user_id, challenge_id, code)
             → db.query(Challenge).filter_by(id=challenge_id).first()
               📊 1 query
             → ai_service.validate_code(code, challenge.test_cases)
               ⚡ 2000ms (AI call)
             → db.query(Submission).filter_by(
                   user_id=user_id,
                   challenge_id=challenge_id
               ).with_for_update().first()
               ✅ Optimistic lock present
             → submission.score = calculated_score
             → db.commit()
               ⚠️ WARNING: Cache invalidation needed
             ← score
           ← {"score": 100, "passed": true}
         ← 200 OK
       ← Success
     → Update UI

3. Flow Architect detects:
   ⚠️ WARNING: Cache Gap
   Location: services/challenge_service.py:234
   Issue: User stats cached but not invalidated on score update
   Fix: Add cache.delete(f"user_stats:{user_id}")

4. Backend Elite applies fix

5. Knowledge Curator captures:
   "Cache Invalidation: User Stats on Score Update"

6. Flow re-traced: ✅ No conflicts
```

---

## 🚀 Why This Works

### Traditional Development

```
Developer implements feature
  → Code review (manual)
    → QA testing (manual)
      → Production (🤞)
        → Bug discovered
          → Hotfix
            → Repeat
```

**Time to catch race condition:** Weeks (if lucky)

### With Elite SDE Team

```
Developer implements feature
  → Flow Architect traces (automatic)
    → Conflicts detected (automatic)
      → Fix applied (assisted)
        → Cross-review (automatic)
          → Flow re-traced ✅
            → Knowledge captured (automatic)
              → Production (confident)
```

**Time to catch race condition:** Seconds

---

## 💡 Key Takeaways

1. **You focus on WHAT to build** — Agents handle HOW, WHERE, and WHEN
2. **Zero manual coordination** — Master Agent orchestrates silently
3. **Continuous learning** — Gets smarter with every problem solved
4. **Multi-project aware** — Never confuses projects
5. **Production-grade by default** — Conflicts caught before code review

---

**Next:** [Agent Guide](agents-guide.md) — Deep dive into each agent
