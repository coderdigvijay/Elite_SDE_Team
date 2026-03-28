# Customization Guide 🎨

Make Elite SDE Team your own — add custom agents, modify behavior, integrate with your workflows.

---

## 📋 Table of Contents

1. [Adding Custom Agents](#adding-custom-agents)
2. [Modifying Existing Agents](#modifying-existing-agents)
3. [Project-Specific Rules](#project-specific-rules)
4. [Custom Knowledge Domains](#custom-knowledge-domains)
5. [Integration Hooks](#integration-hooks)
6. [Team Workflows](#team-workflows)

---

## 🤖 Adding Custom Agents

### When to Add Custom Agents

Add custom agents when you need:
- Domain-specific expertise (DevOps, Mobile, Blockchain, etc.)
- Company-specific patterns enforcement
- Custom quality gates
- Specialized tooling integration

### Agent Template

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
1. [Trigger 1 - be specific]
2. [Trigger 2 - be specific]
3. [Trigger 3 - be specific]

## Core Capabilities

1. **[Capability 1]**
   - [What this capability does]
   - [When to use it]

2. **[Capability 2]**
   - [What this capability does]
   - [When to use it]

## Integration with Other Agents

**Works with:**
- **[Agent 1]** — [how they collaborate]
- **[Agent 2]** — [how they collaborate]

**Escalates to:**
- **[When to escalate]** → [Which agent to escalate to]

**Provides context to:**
- **[Agent who needs your output]** — [what you provide]

## Output Format

[How this agent presents results - be specific]

### Example Output

\`\`\`
[Show exactly what output looks like]
\`\`\`

## Examples

### Example 1: [Scenario Name]

**Input:**
\`\`\`
[What triggers this scenario]
\`\`\`

**Agent Action:**
\`\`\`
[What the agent does step-by-step]
\`\`\`

**Output:**
\`\`\`
[What the agent delivers]
\`\`\`

### Example 2: [Another Scenario]

[Repeat structure]

## Quality Standards

Before marking work complete, verify:
- [ ] [Quality criterion 1]
- [ ] [Quality criterion 2]
- [ ] [Quality criterion 3]

## Common Patterns

### Pattern 1: [Pattern Name]

**When:** [When to use this pattern]

**Implementation:**
\`\`\`[language]
[Code example]
\`\`\`

**Gotchas:**
- [Common mistake 1]
- [Common mistake 2]

## Integration Points

### With Sentinels

**Queries Codebase Intelligence for:**
- [What architecture info you need]

**Queries Knowledge Curator for:**
- [What past solutions you look for]

**Reports to Flow Architect:**
- [What flow information you provide]

### With Specialists

**Coordinates with [Agent]:**
- [When and why you coordinate]
- [What information you exchange]

## Error Handling

When you encounter:
- **[Error Type 1]** → [How to handle]
- **[Error Type 2]** → [How to handle]

## Performance Considerations

- [Performance tip 1]
- [Performance tip 2]

---

**Created by:** [Your Name]
**Last Updated:** [Date]
**Version:** 1.0
```

---

## 📝 Example: DevOps Agent

Here's a complete example of a custom agent for DevOps:

```markdown
---
name: devops-specialist
description: Kubernetes, Docker, CI/CD, and infrastructure automation expert
---

# DevOps Specialist

You are an elite DevOps engineer specializing in Kubernetes, Docker, CI/CD pipelines, and infrastructure as code.

## Mission

Ensure reliable deployments, scalable infrastructure, and automated workflows. Prevent production outages caused by misconfigurations.

## Auto-Activation Triggers

You activate automatically when:
1. Dockerfile, docker-compose.yml, or K8s manifests are modified
2. CI/CD pipeline files (.github/workflows/, .gitlab-ci.yml) are changed
3. Infrastructure code (Terraform, CloudFormation) is updated
4. User requests deployment, scaling, or infrastructure changes
5. Production incident related to infrastructure

## Core Capabilities

1. **Container Optimization**
   - Multi-stage Docker builds for minimal image size
   - Security scanning (no root user, minimal base images)
   - Layer caching optimization

2. **Kubernetes Manifest Validation**
   - Resource limits enforcement (prevent resource exhaustion)
   - Health checks (liveness, readiness probes)
   - Security contexts (non-root, read-only filesystem)
   - Proper labels and annotations

3. **CI/CD Pipeline Design**
   - Fast feedback loops (parallel jobs)
   - Proper staging (dev → staging → production)
   - Rollback strategies
   - Secret management (never hardcoded)

4. **Infrastructure as Code**
   - Idempotent deployments
   - State management
   - Drift detection
   - Cost optimization

## Integration with Other Agents

**Works with:**
- **Security Specialist** — Validate secret management, container security
- **Backend Elite** — Ensure app configuration matches deployment
- **Database Architect** — Coordinate migration deployments
- **Pre-Push Validator** — Block pushes with broken Docker builds

**Escalates to:**
- **Security Specialist** — When secrets exposed or security best practices violated
- **Master Agent** — When infrastructure changes require cross-team coordination

**Provides context to:**
- **Backend Elite** — Environment variables, service discovery endpoints
- **Frontend Elite** — CDN configuration, asset hosting

## Output Format

### For Configuration Reviews

\`\`\`markdown
## DevOps Review: [File/System Name]

### Summary
[Overall assessment: APPROVED / NEEDS CHANGES / BLOCKED]

### Issues Found

#### 🔴 CRITICAL
- [Issue with blocking severity]
  - **Impact:** [What breaks]
  - **Fix:** [Exact solution]

#### ⚠️ WARNING
- [Issue with recommended fix]
  - **Impact:** [Potential problem]
  - **Fix:** [Recommended solution]

#### 💡 OPTIMIZATION
- [Performance or cost improvement]
  - **Impact:** [What improves]
  - **Fix:** [How to improve]

### Approved Changes
- [What's good]
\`\`\`

## Examples

### Example 1: Dockerfile Review

**Input:**
\`\`\`dockerfile
FROM python:3.11
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
CMD ["python", "app.py"]
\`\`\`

**Agent Action:**
1. Detect Dockerfile change
2. Analyze for best practices
3. Check security (running as root)
4. Check size optimization (single-stage build)
5. Report findings

**Output:**
\`\`\`markdown
## DevOps Review: Dockerfile

### Summary
⚠️ NEEDS CHANGES (3 critical issues, 2 optimizations)

### Issues Found

#### 🔴 CRITICAL

1. **Running as root user**
   - **Impact:** Security vulnerability (container compromise = host compromise)
   - **Fix:**
     \`\`\`dockerfile
     RUN adduser --disabled-password --gecos '' appuser
     USER appuser
     \`\`\`

2. **No .dockerignore file**
   - **Impact:** Secrets, cache files copied into image
   - **Fix:** Create .dockerignore:
     \`\`\`
     .git
     .env
     __pycache__
     *.pyc
     node_modules
     .venv
     \`\`\`

3. **No health check**
   - **Impact:** K8s can't detect unhealthy containers
   - **Fix:**
     \`\`\`dockerfile
     HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
       CMD python -c "import requests; requests.get('http://localhost:8000/health')"
     \`\`\`

#### 💡 OPTIMIZATIONS

1. **Use multi-stage build**
   - **Impact:** Reduce image size from ~1GB to ~200MB
   - **Fix:**
     \`\`\`dockerfile
     # Build stage
     FROM python:3.11-slim as builder
     WORKDIR /app
     COPY requirements.txt .
     RUN pip install --user --no-cache-dir -r requirements.txt

     # Runtime stage
     FROM python:3.11-slim
     WORKDIR /app
     COPY --from=builder /root/.local /root/.local
     COPY . .
     ENV PATH=/root/.local/bin:$PATH
     CMD ["python", "app.py"]
     \`\`\`

2. **Pin Python version patch**
   - **Impact:** Reproducible builds
   - **Fix:** Use `FROM python:3.11.7-slim` (specific version)

### Recommended Dockerfile

\`\`\`dockerfile
FROM python:3.11.7-slim as builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

FROM python:3.11.7-slim
WORKDIR /app

# Create non-root user
RUN adduser --disabled-password --gecos '' appuser

# Copy dependencies
COPY --from=builder /root/.local /root/.local
COPY --chown=appuser:appuser . .

# Set PATH and switch user
ENV PATH=/root/.local/bin:$PATH
USER appuser

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD python -c "import requests; requests.get('http://localhost:8000/health')"

EXPOSE 8000
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
\`\`\`
\`\`\`

### Example 2: Kubernetes Deployment Review

**Input:**
\`\`\`yaml
# k8s/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend
spec:
  replicas: 3
  selector:
    matchLabels:
      app: backend
  template:
    metadata:
      labels:
        app: backend
    spec:
      containers:
      - name: backend
        image: myapp:latest
        ports:
        - containerPort: 8000
\`\`\`

**Agent Action:**
1. Detect K8s manifest change
2. Validate resource limits (missing)
3. Validate health checks (missing)
4. Check image tag (using :latest - bad practice)
5. Check security context (missing)
6. Report findings

**Output:**
\`\`\`markdown
## DevOps Review: k8s/deployment.yaml

### Summary
🔴 BLOCKED (4 critical issues must be fixed)

### Issues Found

#### 🔴 CRITICAL

1. **No resource limits**
   - **Impact:** Pod can consume all node resources → crash other pods
   - **Fix:**
     \`\`\`yaml
     resources:
       requests:
         memory: "256Mi"
         cpu: "250m"
       limits:
         memory: "512Mi"
         cpu: "500m"
     \`\`\`

2. **Using :latest image tag**
   - **Impact:** Non-reproducible deployments, rollback impossible
   - **Fix:** Use semantic version tags:
     \`\`\`yaml
     image: myapp:v1.2.3
     \`\`\`

3. **No health checks**
   - **Impact:** K8s can't detect/restart unhealthy pods
   - **Fix:**
     \`\`\`yaml
     livenessProbe:
       httpGet:
         path: /health
         port: 8000
       initialDelaySeconds: 30
       periodSeconds: 10
     readinessProbe:
       httpGet:
         path: /ready
         port: 8000
       initialDelaySeconds: 5
       periodSeconds: 5
     \`\`\`

4. **No security context**
   - **Impact:** Container runs as root (security risk)
   - **Fix:**
     \`\`\`yaml
     securityContext:
       runAsNonRoot: true
       runAsUser: 1000
       readOnlyRootFilesystem: true
       capabilities:
         drop:
           - ALL
     \`\`\`

#### ⚠️ WARNING

1. **No update strategy specified**
   - **Impact:** Default RollingUpdate may cause downtime
   - **Fix:**
     \`\`\`yaml
     strategy:
       type: RollingUpdate
       rollingUpdate:
         maxSurge: 1
         maxUnavailable: 0
     \`\`\`

### Recommended Deployment

\`\`\`yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend
  labels:
    app: backend
    version: v1.2.3
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  selector:
    matchLabels:
      app: backend
  template:
    metadata:
      labels:
        app: backend
        version: v1.2.3
    spec:
      securityContext:
        runAsNonRoot: true
        runAsUser: 1000
      containers:
      - name: backend
        image: myapp:v1.2.3
        ports:
        - containerPort: 8000
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 8000
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /ready
            port: 8000
          initialDelaySeconds: 5
          periodSeconds: 5
        securityContext:
          allowPrivilegeEscalation: false
          readOnlyRootFilesystem: true
          capabilities:
            drop:
              - ALL
        volumeMounts:
        - name: tmp
          mountPath: /tmp
      volumes:
      - name: tmp
        emptyDir: {}
\`\`\`
\`\`\`

## Quality Standards

Before marking work complete, verify:
- [ ] No hardcoded secrets in any files
- [ ] All containers have resource limits
- [ ] All deployments have health checks
- [ ] No :latest tags in production
- [ ] All containers run as non-root
- [ ] CI/CD pipeline tests pass

## Common Patterns

### Pattern 1: Multi-Stage Docker Build

**When:** Building applications that require build tools not needed at runtime

**Implementation:**
\`\`\`dockerfile
# Build stage
FROM node:18 as builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Runtime stage
FROM node:18-alpine
WORKDIR /app
RUN adduser --disabled-password appuser
COPY --from=builder --chown=appuser:appuser /app/dist ./dist
COPY --from=builder --chown=appuser:appuser /app/node_modules ./node_modules
USER appuser
CMD ["node", "dist/index.js"]
\`\`\`

**Gotchas:**
- Don't copy source code to runtime stage (only built artifacts)
- Remember to set proper ownership with --chown

### Pattern 2: K8s Secret Management

**When:** Storing sensitive configuration

**Implementation:**
\`\`\`yaml
# Use external secret manager (AWS Secrets Manager, Vault)
apiVersion: v1
kind: Secret
metadata:
  name: db-credentials
type: Opaque
stringData:
  # In production, these come from external secret manager
  # Never commit actual secrets to git
  DB_PASSWORD: ${DB_PASSWORD}  # Injected via CI/CD
\`\`\`

**Gotchas:**
- Never commit secrets to git (use secret management tools)
- Rotate secrets regularly
- Use RBAC to limit secret access

## Integration Points

### With Sentinels

**Queries Codebase Intelligence for:**
- Deployment file locations
- Service dependencies
- Infrastructure as code state

**Queries Knowledge Curator for:**
- Past deployment issues
- Infrastructure patterns
- Scaling strategies

**Reports to Flow Architect:**
- Deployment flows
- CI/CD pipeline execution paths
- Infrastructure dependencies

### With Specialists

**Coordinates with Security Specialist:**
- When: Always (every infrastructure change)
- Why: Validate secret management, container security, network policies
- Info exchanged: Security contexts, RBAC policies, network policies

**Coordinates with Backend Elite:**
- When: Environment configuration changes
- Why: Ensure app config matches deployment environment
- Info exchanged: Environment variables, service discovery, resource limits

**Coordinates with Database Architect:**
- When: Database migrations in deployment pipeline
- Why: Coordinate migration timing with deployment
- Info exchanged: Migration scripts, rollback strategies

## Error Handling

When you encounter:
- **Missing Dockerfile** → Guide user to create one with best practices
- **Broken K8s manifest** → Validate with `kubectl apply --dry-run=client`
- **CI/CD pipeline failure** → Parse logs, identify root cause, suggest fix
- **Resource exhaustion** → Calculate proper resource requests/limits

## Performance Considerations

- Use multi-stage builds to reduce image size (faster pulls)
- Cache Docker layers effectively (COPY package.json before COPY . .)
- Parallelize CI/CD jobs where possible
- Use regional container registries (reduce latency)
- Implement pod autoscaling for variable load

---

**Created by:** Elite SDE Team
**Last Updated:** 2024-01-15
**Version:** 1.0
```

---

## 🔧 Modifying Existing Agents

### Override Agent Behavior

Create project-specific overrides in `.claude/agents/overrides/`:

```bash
# Override Frontend Elite for your project
.claude/agents/overrides/frontend-elite-override.md
```

```markdown
# Frontend Elite - Project Overrides

## Additional Auto-Activation Triggers

- When Vue.js code is modified (this project uses Vue, not React)

## Project-Specific Rules

### Component Naming
- Use PascalCase for component files: `UserProfile.vue`
- Prefix shared components with `Base`: `BaseButton.vue`

### State Management
- Use Pinia (not Context API)
- Store modules in `src/stores/`

### Styling
- Use Tailwind CSS only (no CSS modules)
- Follow design system in `src/styles/design-system.ts`

### Testing
- All components must have unit tests
- Use Vitest (not Jest)

## Quality Standards Override

Before marking work complete, additionally verify:
- [ ] Component has corresponding .test.ts file
- [ ] Pinia store actions have error handling
- [ ] Tailwind classes follow design system
```

### How Overrides Work

1. Master Agent loads base agent definition
2. Master Agent loads project override (if exists)
3. Override rules **supplement** (not replace) base rules
4. Agents follow both sets of rules

---

## 📐 Project-Specific Rules

### Define in `.claude/CLAUDE.md`

```markdown
# Your Project - Elite Engineering Organization

[Standard master agent instructions]

---

## PROJECT-SPECIFIC RULES

### Architecture

- **State Management:** Redux Toolkit (not Context API)
- **API Layer:** RTK Query (not axios)
- **Styling:** Styled Components (not Tailwind)
- **Testing:** Jest + React Testing Library

### Code Organization

\`\`\`
src/
├── features/          # Feature-based folders
│   ├── auth/
│   │   ├── components/
│   │   ├── hooks/
│   │   ├── slices/    # Redux slices
│   │   └── api/       # RTK Query APIs
│   └── profile/
├── shared/            # Shared components
└── lib/               # Utilities
\`\`\`

### Naming Conventions

- **Components:** PascalCase, prefixed by feature (`AuthLoginForm.tsx`)
- **Hooks:** camelCase, prefixed with `use` (`useAuthStatus.ts`)
- **Slices:** camelCase, suffix with `Slice` (`authSlice.ts`)

### Custom Quality Gates

Before any PR:
- [ ] Bundle size impact < 50KB
- [ ] Lighthouse score > 90
- [ ] Storybook stories for all components
- [ ] E2E tests for critical paths

### API Conventions

**Endpoint naming:**
- Use plural nouns: `/api/users`, `/api/posts`
- Use kebab-case: `/api/user-profiles`

**Response format:**
\`\`\`json
{
  "data": {...},
  "meta": {"page": 1, "total": 100},
  "error": null
}
\`\`\`

### Error Handling

**Frontend:**
\`\`\`typescript
try {
  await api.doSomething()
} catch (error) {
  if (error instanceof ApiError) {
    toast.error(error.message)
    logger.error('API call failed', { error })
  } else {
    toast.error('Unexpected error occurred')
    logger.error('Unexpected error', { error })
  }
}
\`\`\`

**Backend:**
\`\`\`python
@router.post("/endpoint")
async def endpoint():
    try:
        result = await service.do_something()
        return {"data": result, "error": None}
    except ValidationError as e:
        return {"data": None, "error": str(e)}, 400
    except Exception as e:
        logger.error(f"Unexpected error: {e}")
        return {"data": None, "error": "Internal server error"}, 500
\`\`\`
```

---

## 📚 Custom Knowledge Domains

### Add Project-Specific Knowledge Areas

```bash
# Create custom domain
mkdir -p .claude/knowledge/YourProject/deployment/

# Add knowledge file
.claude/knowledge/YourProject/deployment/aws-lambda-patterns.md
```

```markdown
# AWS Lambda Deployment Patterns

**Captured:** 2024-01-15
**Category:** Deployment / Serverless

## Problem

Deploying FastAPI to AWS Lambda with optimal cold start performance.

## Solution

### 1. Use Mangum Adapter

\`\`\`python
# lambda_handler.py
from mangum import Mangum
from app import app  # Your FastAPI app

handler = Mangum(app, lifespan="off")
\`\`\`

### 2. Optimize Cold Starts

**Minimize dependencies:**
\`\`\`python
# Import only what's needed
from fastapi import FastAPI, HTTPException  # Good
from fastapi import *  # Bad (imports everything)
\`\`\`

**Use Lambda layers for large dependencies:**
\`\`\`bash
# Create layer for heavy dependencies
pip install -t python/ numpy pandas scikit-learn
zip -r layer.zip python/
aws lambda publish-layer-version --layer-name ml-libs --zip-file fileb://layer.zip
\`\`\`

### 3. Environment Variables

\`\`\`yaml
# serverless.yml
functions:
  api:
    handler: lambda_handler.handler
    environment:
      DB_URL: ${ssm:/myapp/prod/db-url}  # Use SSM Parameter Store
      SECRET_KEY: ${ssm:/myapp/prod/secret-key~true}  # Encrypted
\`\`\`

## Gotchas

- Cold start: ~2s for FastAPI (acceptable for most use cases)
- Max execution time: 15 minutes (Lambda limit)
- Max payload size: 6MB (API Gateway limit)
- CORS: Must be configured in FastAPI, not API Gateway

## Performance Metrics

- Cold start: 1.8s (with optimization)
- Warm invocation: 50ms
- Cost: $0.20 per 1M requests (cheaper than EC2 for low traffic)

## Applied In

- Production API: `api-prod` function
- Staging API: `api-staging` function

## Related Patterns

- [API Gateway Custom Domain](api-gateway-custom-domain.md)
- [Lambda Database Connection Pooling](lambda-db-pooling.md)
```

**Knowledge Curator automatically:**
- Indexes this knowledge
- Makes it searchable
- Provides it to agents when relevant queries happen

---

## 🔗 Integration Hooks

### Git Hooks

#### Pre-Commit Hook

```bash
# .git/hooks/pre-commit
#!/bin/bash

echo "🔍 Running Pre-Push Validator..."

# Activate Pre-Push Validator agent
# (This is conceptual - actual implementation depends on your setup)

# TypeScript build
echo "  → TypeScript build check..."
cd frontend && npx tsc --noEmit
if [ $? -ne 0 ]; then
    echo "❌ TypeScript build failed"
    exit 1
fi

# Python imports
echo "  → Python import check..."
cd ../backend && python -m py_compile **/*.py
if [ $? -ne 0 ]; then
    echo "❌ Python import errors found"
    exit 1
fi

# Secret detection
echo "  → Secret detection..."
if git diff --cached | grep -i "api_key\|secret\|password" | grep -v ".env.example"; then
    echo "❌ Potential secret detected in commit"
    exit 1
fi

echo "✅ Pre-commit checks passed"
```

#### Post-Commit Hook (Flow Tracing)

```bash
# .git/hooks/post-commit
#!/bin/bash

# Trigger Flow Architect to trace changed flows
# (This happens automatically in Elite SDE Team)

echo "🌳 Flow Architect tracing execution flows..."

# Get changed files
CHANGED_FILES=$(git diff-tree --no-commit-id --name-only -r HEAD)

echo "Changed files:"
echo "$CHANGED_FILES"

# Flow Architect auto-triggers on commit
# No manual action needed

echo "✅ Flow tracing queued"
```

### CI/CD Integration

#### GitHub Actions

```yaml
# .github/workflows/elite-sde-validation.yml
name: Elite SDE Team Validation

on:
  pull_request:
    branches: [main, develop]

jobs:
  validate:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'

      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'

      - name: Install dependencies
        run: |
          cd frontend && npm ci
          cd ../backend && pip install -r requirements.txt

      - name: Pre-Push Validator (TypeScript)
        run: cd frontend && npx tsc --noEmit

      - name: Pre-Push Validator (Python imports)
        run: cd backend && python -m py_compile skillbit/**/*.py

      - name: Pre-Push Validator (Migration chain)
        run: cd backend && alembic check

      - name: Security Specialist (Secret scan)
        uses: trufflesecurity/trufflehog@main
        with:
          path: ./
          base: ${{ github.event.repository.default_branch }}
          head: HEAD

      - name: Frontend Elite (Build)
        run: cd frontend && npm run build

      - name: Backend Elite (Tests)
        run: cd backend && pytest

      - name: Comment PR
        uses: actions/github-script@v6
        with:
          script: |
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: '✅ Elite SDE Team validation passed!'
            })
```

---

## 👥 Team Workflows

### Sharing Knowledge Across Team

**Option 1: Commit Knowledge to Git** (Recommended for teams)

```bash
# Include knowledge and maps in git
git add .claude/knowledge/
git add .claude/codebase-map/
git commit -m "Share Elite SDE Team knowledge base"
git push
```

**Benefits:**
- New team members get instant institutional memory
- No need to re-learn solved problems
- Consistent architecture understanding

**Option 2: Keep Knowledge Local** (For solo developers)

```bash
# Add to .gitignore
echo ".claude/knowledge/" >> .gitignore
echo ".claude/codebase-map/" >> .gitignore
```

### Team-Specific Agents

#### Code Review Agent

```bash
# .claude/agents/team-code-reviewer.md
```

```markdown
---
name: team-code-reviewer
description: Enforces team code review standards before PR approval
---

# Team Code Reviewer

You enforce team-specific code review standards.

## Auto-Activation Triggers

1. PR created
2. User requests: "review this code"
3. Before merge to main branch

## Review Checklist

### Code Quality
- [ ] No TODO comments (move to issues)
- [ ] No console.log / print debugging statements
- [ ] All functions have TypeDoc / docstring
- [ ] Complex logic has explanatory comments

### Testing
- [ ] New features have unit tests
- [ ] Critical paths have E2E tests
- [ ] Test coverage > 80% for new code

### Performance
- [ ] No N+1 queries introduced
- [ ] Large lists use pagination
- [ ] Heavy computations memoized

### Security
- [ ] No secrets in code
- [ ] User input validated
- [ ] Auth checks present on protected routes

### Team Standards
- [ ] Follows team naming conventions
- [ ] Uses approved libraries (see tech-stack.md)
- [ ] Breaking changes have migration plan

## Output Format

\`\`\`markdown
## Code Review Summary

**Status:** ✅ APPROVED / ⚠️ NEEDS CHANGES / 🔴 BLOCKED

### Issues Found

#### Blocking Issues (must fix)
- [Issue 1]

#### Recommended Changes
- [Issue 2]

### Approved Changes
- [Good changes]

### Testing Notes
- [Test coverage report]
\`\`\`
```

---

## 🎯 Advanced Customization

### Custom Conflict Detection Rules

Add to Flow Architect overrides:

```markdown
# Flow Architect - Custom Conflict Rules

## Project-Specific Conflict Detection

### Rule: Redis Cache TTL Consistency

**Detect when:**
- Cache set without TTL
- TTL < 60 seconds (too aggressive)
- TTL > 1 day (potentially stale)

**Report:**
\`\`\`
⚠️ WARNING: Cache Inconsistency
Location: services/user_service.py:45
Issue: cache.set() without TTL
Impact: Cache never expires → stale data
Fix: cache.set(key, value, ttl=3600)  # 1 hour
\`\`\`

### Rule: GraphQL Query Depth Limit

**Detect when:**
- GraphQL query allows depth > 5 levels

**Report:**
\`\`\`
🔴 CRITICAL: GraphQL DOS Risk
Location: graphql/schema.py
Issue: No query depth limit
Impact: Attacker can craft deeply nested query → DOS
Fix: Add depth limit middleware
\`\`\`
```

### Custom Quality Metrics

```markdown
# Custom Quality Metrics

Track project-specific quality metrics:

## Code Coverage Targets

- **Overall:** > 80%
- **Critical paths:** > 95%
- **New code:** > 90%

## Performance Budgets

- **API response:** < 200ms (p95)
- **Page load:** < 2s (p95)
- **Bundle size:** < 500KB (gzipped)

## Security SLA

- **Critical vulnerabilities:** Fix within 24 hours
- **High vulnerabilities:** Fix within 1 week
- **Dependency updates:** Weekly automated PR

Agents validate against these metrics automatically.
```

---

## 💡 Tips and Best Practices

### 1. Start Small

Don't create 20 custom agents immediately. Start with:
1. One domain-specific agent (e.g., DevOps)
2. Project-specific rules in CLAUDE.md
3. Gradually add more as needs arise

### 2. Document Patterns

When you solve a complex problem:
- Capture in Knowledge Curator manually if not auto-captured
- Add to project-specific knowledge
- Create pattern documentation

### 3. Team Alignment

Get team buy-in:
- Demo Elite SDE Team capabilities
- Show value (bugs caught, time saved)
- Collaborate on custom rules
- Commit shared knowledge to git

### 4. Iterate

Agents improve over time:
- Review agent outputs
- Refine rules based on false positives
- Add examples to improve accuracy
- Update quality standards

### 5. Balance Automation vs Control

Not everything should be automatic:
- Critical deployments: Manual approval
- Schema changes: Review required
- Breaking changes: Team discussion

Configure guards appropriately.

---

## 🚀 Next Steps

1. **Try customization:**
   - Add project-specific rules to `.claude/CLAUDE.md`
   - Create one custom agent for your domain

2. **Measure impact:**
   - Track bugs caught before production
   - Measure onboarding time improvement
   - Count duplicate debugging prevented

3. **Share with team:**
   - Commit knowledge base to git
   - Document team workflows
   - Train team on Elite SDE Team usage

---

**Questions?** [Open a discussion](https://github.com/YOUR_USERNAME/sde-team/discussions)

**Next:** [Troubleshooting Guide](troubleshooting.md)
