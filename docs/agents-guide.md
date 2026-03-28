# Agent Guide 🤖

Complete reference for all 11 specialist agents + 3 sentinel agents in Elite SDE Team.

---

## 📋 Quick Reference

| Agent | Type | Domain | Auto-Activates When |
|-------|------|--------|---------------------|
| **Master Agent** | Orchestrator | All | Always (invisible to user) |
| **Frontend Elite** | Specialist | React/TS/UI | Frontend code needed |
| **Backend Elite** | Specialist | FastAPI/Services | Backend logic needed |
| **Database Architect** | Specialist | PostgreSQL/Schema | Database changes needed |
| **Security Specialist** | Specialist | Auth/RBAC | Security review needed |
| **QA Destructive** | Specialist | Testing/Edge Cases | After implementation |
| **UI/UX Elite** | Specialist | Design/UX | UI work needed |
| **AI/GenAI Specialist** | Specialist | LLMs/RAG | AI features needed |
| **Pre-Push Validator** | Specialist | Full-Stack Gate | Before git push |
| **Knowledge Curator** | Sentinel | Institutional Memory | Always running |
| **Codebase Intelligence** | Sentinel | Architecture Map | Always running |
| **Flow Architect** | Sentinel | Execution Tracing | Always running |

---

## 🎩 Master Agent

### Role
Supreme orchestrator of the entire Elite SDE Team.

### What It Does
- Parses user requests and decomposes into subtasks
- Activates specialist agents in correct order
- Coordinates cross-agent reviews
- Synthesizes final solutions
- Manages multi-agent conflicts

### When It Activates
Always active (you interact with Master Agent, not individual specialists)

### Example Interaction

**User request:**
```
"Add user profile editing with avatar upload"
```

**Master Agent (silently orchestrates):**
```
1. Query Codebase Intelligence
   → Where is user profile code?

2. Activate Frontend Elite
   → Build ProfileEditForm component with avatar upload

3. Activate Backend Elite
   → Create PUT /api/users/{id}/profile endpoint
   → Add avatar upload handling

4. Activate Security Specialist
   → Validate: Auth required, file type validation, size limits

5. Activate QA Destructive
   → Test: Large files, invalid types, concurrent updates

6. Activate Flow Architect
   → Trace new flow, detect conflicts

7. Activate Knowledge Curator
   → Capture file upload pattern

8. Cross-review all work

9. Deliver to user: Complete implementation
```

**User sees:**
```
✅ Profile editing implemented
✅ Avatar upload with validation
✅ Auth enforced
✅ No race conditions
✅ All edge cases handled
```

### Key Behaviors
- **Silent coordination** — Never explains internal process to user
- **Parallel activation** — Runs independent agents concurrently
- **Cross-review enforcement** — Security + QA always review implementations
- **Context-aware** — Queries sentinels before activating specialists

---

## 🎨 Frontend Elite Engineer

### Role
React, TypeScript, and UI performance expert.

### Expertise
- Component architecture
- State management (Context, hooks)
- Performance optimization (memoization, lazy loading)
- Bundle size optimization
- TypeScript type safety
- Responsive design
- Accessibility (WCAG compliance)

### Auto-Activation Triggers
- User requests UI feature
- Frontend component needed
- State management question
- Performance issue in frontend
- TypeScript error

### What It Does

**Before implementing:**
1. Queries Codebase Intelligence for existing patterns
2. Checks Knowledge Curator for similar solutions
3. Reviews project coding standards

**During implementation:**
- Follows React best practices
- Uses TypeScript strictly
- Implements proper error boundaries
- Adds loading states
- Handles edge cases (empty states, errors)

**After implementing:**
- Coordinates with Security Specialist (auth in frontend)
- Runs TypeScript build check
- Validates bundle size impact

### Example Output

**Task:** Add user profile editing form

**Frontend Elite delivers:**

```tsx
// frontend/src/components/ProfileEditForm.tsx

import { useState } from 'react';
import { useAuth } from '../hooks/useAuth';
import { userService } from '../services/user';
import type { User, UpdateUserDTO } from '../types/user';

interface ProfileEditFormProps {
  user: User;
  onUpdate: (user: User) => void;
}

export const ProfileEditForm: React.FC<ProfileEditFormProps> = ({
  user,
  onUpdate
}) => {
  const { token } = useAuth();
  const [formData, setFormData] = useState({
    username: user.username,
    email: user.email,
    bio: user.bio || ''
  });
  const [avatar, setAvatar] = useState<File | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError(null);

    try {
      // Update profile
      const updated = await userService.updateProfile(user.id, formData);

      // Upload avatar if provided
      if (avatar) {
        await userService.uploadAvatar(user.id, avatar);
      }

      onUpdate(updated);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Update failed');
    } finally {
      setLoading(false);
    }
  };

  const handleAvatarChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      // Validate file type
      if (!file.type.startsWith('image/')) {
        setError('Please select an image file');
        return;
      }
      // Validate file size (5MB max)
      if (file.size > 5 * 1024 * 1024) {
        setError('Image must be less than 5MB');
        return;
      }
      setAvatar(file);
      setError(null);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      {error && (
        <div className="bg-red-50 text-red-600 p-3 rounded">
          {error}
        </div>
      )}

      <div>
        <label htmlFor="username" className="block text-sm font-medium">
          Username
        </label>
        <input
          id="username"
          type="text"
          value={formData.username}
          onChange={(e) => setFormData({ ...formData, username: e.target.value })}
          className="mt-1 block w-full rounded border-gray-300"
          required
        />
      </div>

      <div>
        <label htmlFor="email" className="block text-sm font-medium">
          Email
        </label>
        <input
          id="email"
          type="email"
          value={formData.email}
          onChange={(e) => setFormData({ ...formData, email: e.target.value })}
          className="mt-1 block w-full rounded border-gray-300"
          required
        />
      </div>

      <div>
        <label htmlFor="bio" className="block text-sm font-medium">
          Bio
        </label>
        <textarea
          id="bio"
          value={formData.bio}
          onChange={(e) => setFormData({ ...formData, bio: e.target.value })}
          className="mt-1 block w-full rounded border-gray-300"
          rows={4}
        />
      </div>

      <div>
        <label htmlFor="avatar" className="block text-sm font-medium">
          Avatar
        </label>
        <input
          id="avatar"
          type="file"
          accept="image/*"
          onChange={handleAvatarChange}
          className="mt-1 block w-full"
        />
        {avatar && (
          <p className="text-sm text-gray-600 mt-1">
            Selected: {avatar.name}
          </p>
        )}
      </div>

      <button
        type="submit"
        disabled={loading}
        className="bg-blue-600 text-white px-4 py-2 rounded disabled:opacity-50"
      >
        {loading ? 'Saving...' : 'Save Changes'}
      </button>
    </form>
  );
};
```

**Also updates:**
- `frontend/src/services/user.ts` (API calls)
- `frontend/src/types/user.ts` (TypeScript types)

**Coordinates with:**
- Backend Elite (API endpoint contract)
- Security Specialist (client-side validation only, server enforces)
- UI/UX Elite (design consistency)

---

## ⚙️ Backend Elite Engineer

### Role
FastAPI, service layer, and backend architecture expert.

### Expertise
- RESTful API design
- Business logic isolation (services/)
- Concurrency safety (optimistic locking)
- Caching strategies
- Database transactions
- Error handling
- Performance optimization

### Auto-Activation Triggers
- User requests backend feature
- API endpoint needed
- Business logic question
- Service layer implementation
- Performance issue in backend

### What It Does

**Before implementing:**
1. Queries Codebase Intelligence for service layer patterns
2. Checks Knowledge Curator for similar logic
3. Reviews coding rules (`.claude/coding_rules_backend.md`)

**During implementation:**
- Business logic in `services/` only (never in routers)
- Atomic operations for concurrency-sensitive code
- Proper error handling with custom exceptions
- Cache invalidation on mutations
- Transaction management

**After implementing:**
- Coordinates with Database Architect (query review)
- Coordinates with Security Specialist (auth/RBAC check)
- Coordinates with QA Destructive (edge case testing)

### Example Output

**Task:** Add user profile update endpoint

**Backend Elite delivers:**

```python
# backend/skillbit/routers/users.py

from fastapi import APIRouter, Depends, HTTPException, UploadFile, File
from backend.skillbit.services import user_service, access_service
from backend.skillbit.schemas.user import UserResponse, UpdateUserDTO
from backend.skillbit.core.auth import get_current_user
from backend.skillbit.models.user import User

router = APIRouter(prefix="/users", tags=["users"])

@router.put("/{user_id}/profile", response_model=UserResponse)
async def update_user_profile(
    user_id: int,
    data: UpdateUserDTO,
    current_user: User = Depends(get_current_user)
):
    """Update user profile (own profile only or admin)."""
    # Auth check via Security Specialist pattern
    if not access_service.can_update_user(current_user.id, user_id):
        raise HTTPException(status_code=403, detail="Not authorized")

    # Delegate to service layer
    updated_user = await user_service.update_profile(user_id, data)
    return updated_user


@router.post("/{user_id}/avatar", response_model=UserResponse)
async def upload_avatar(
    user_id: int,
    file: UploadFile = File(...),
    current_user: User = Depends(get_current_user)
):
    """Upload user avatar image."""
    # Auth check
    if not access_service.can_update_user(current_user.id, user_id):
        raise HTTPException(status_code=403, detail="Not authorized")

    # File validation (Security Specialist requirement)
    if not file.content_type.startswith("image/"):
        raise HTTPException(status_code=400, detail="File must be an image")

    # Size limit check
    max_size = 5 * 1024 * 1024  # 5MB
    contents = await file.read()
    if len(contents) > max_size:
        raise HTTPException(status_code=400, detail="Image too large (max 5MB)")

    # Delegate to service
    updated_user = await user_service.upload_avatar(user_id, contents, file.content_type)
    return updated_user
```

```python
# backend/skillbit/services/user_service.py

from sqlalchemy.orm import Session
from backend.skillbit.models.user import User
from backend.skillbit.schemas.user import UpdateUserDTO
from backend.skillbit.core.database import get_db
from backend.skillbit.core.cache import cache
from backend.skillbit.core.storage import upload_file
from backend.skillbit.core.exceptions import NotFoundError, ConcurrentUpdateError

async def update_profile(user_id: int, data: UpdateUserDTO) -> User:
    """Update user profile with optimistic locking."""
    db: Session = next(get_db())

    # Fetch with current version
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise NotFoundError(f"User {user_id} not found")

    current_version = user.version

    # Atomic update with version check (Flow Architect pattern)
    result = db.query(User).filter(
        User.id == user_id,
        User.version == current_version
    ).update({
        "username": data.username,
        "email": data.email,
        "bio": data.bio,
        "version": User.version + 1
    })

    if result == 0:
        raise ConcurrentUpdateError("Profile was modified by another request")

    db.commit()

    # Cache invalidation (Flow Architect requirement)
    cache.delete(f"user:{user_id}")
    cache.delete(f"user_stats:{user_id}")

    # Refresh and return
    db.refresh(user)
    return user


async def upload_avatar(user_id: int, file_contents: bytes, content_type: str) -> User:
    """Upload user avatar to storage."""
    db: Session = next(get_db())

    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise NotFoundError(f"User {user_id} not found")

    # Upload to cloud storage (S3, etc.)
    avatar_url = await upload_file(
        file_contents,
        folder="avatars",
        filename=f"user_{user_id}.jpg",
        content_type=content_type
    )

    # Update user record
    user.avatar_url = avatar_url
    db.commit()

    # Cache invalidation
    cache.delete(f"user:{user_id}")

    return user
```

**Also creates:**
- `backend/skillbit/schemas/user.py` (DTO schemas)
- `backend/skillbit/core/storage.py` (if doesn't exist)

**Coordinates with:**
- Frontend Elite (API contract match)
- Database Architect (query optimization)
- Security Specialist (RBAC validation)

---

## 🗄️ Database Master Architect

### Role
PostgreSQL schema, migrations, and query optimization expert.

### Expertise
- Schema design (normalization, constraints)
- Alembic migrations
- Index strategies
- Query optimization (EXPLAIN ANALYZE)
- Transaction isolation
- Foreign key relationships
- Performance tuning

### Auto-Activation Triggers
- Schema change needed
- Migration required
- Query performance issue
- N+1 query detected
- Index missing

### What It Does

**Before schema changes:**
1. Reviews existing schema
2. Plans migration (forward + rollback)
3. Validates constraints
4. Plans indexes

**During migration:**
- Creates reversible Alembic migration
- Adds proper indexes
- Validates constraints
- Tests migration locally

**After migration:**
- Coordinates with Backend Elite (ORM model updates)
- Runs EXPLAIN ANALYZE on new queries
- Updates documentation

### Example Output

**Task:** Add avatar_url column to users table

**Database Architect delivers:**

```python
# backend/alembic/versions/022_add_user_avatar.py

"""Add avatar_url to users table

Revision ID: 022_add_user_avatar
Revises: 021_add_unique_constraints
Create Date: 2024-01-15 14:23:45.123456
"""

from alembic import op
import sqlalchemy as sa

revision = '022_add_user_avatar'
down_revision = '021_add_unique_constraints'
branch_labels = None
depends_on = None


def upgrade():
    """Add avatar_url column."""
    op.add_column(
        'users',
        sa.Column('avatar_url', sa.String(500), nullable=True)
    )

    # Add index for faster avatar lookups (if needed for queries)
    # Not needed here since we query by user_id (primary key)


def downgrade():
    """Remove avatar_url column."""
    op.drop_column('users', 'avatar_url')
```

**Also updates:**
```python
# backend/skillbit/models/user.py

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String(50), unique=True, nullable=False)
    email = Column(String(255), unique=True, nullable=False)
    password_hash = Column(String(255), nullable=False)
    bio = Column(Text, nullable=True)
    avatar_url = Column(String(500), nullable=True)  # NEW
    version = Column(Integer, default=1, nullable=False)
    created_at = Column(DateTime, server_default=sa.func.now())
    updated_at = Column(DateTime, onupdate=sa.func.now())
```

**Coordinates with:**
- Backend Elite (model sync)
- Flow Architect (query impact analysis)

---

## 🔒 Security Specialist

### Role
Authentication, authorization, and security vulnerability expert.

### Expertise
- JWT authentication
- RBAC (Role-Based Access Control)
- SQL injection prevention
- XSS prevention
- CSRF protection
- Input validation
- Rate limiting
- Privilege escalation detection

### Auto-Activation Triggers
- Auth-related feature
- New API endpoint created
- User input handling
- Permission check needed
- Security review required

### What It Does

**Before implementation:**
1. Reviews auth requirements
2. Checks RBAC rules
3. Validates input sanitization approach

**During review:**
- Checks every endpoint for auth decorator
- Validates permission checks are server-side
- Reviews input validation
- Checks for injection risks
- Validates sensitive data handling

**After review:**
- Reports CRITICAL issues (blocking)
- Reports WARNING issues (recommended fixes)
- Coordinates with Backend Elite for fixes

### Example Output

**Task:** Review profile update endpoint

**Security Specialist reports:**

```markdown
## Security Review: Profile Update Endpoint

### Endpoint: PUT /api/users/{user_id}/profile

✅ **PASSED**

### Checks Performed

1. **Authentication**
   - ✅ `@Depends(get_current_user)` present
   - ✅ JWT token required

2. **Authorization**
   - ✅ `access_service.can_update_user()` validates ownership
   - ✅ Prevents user A from updating user B's profile

3. **Input Validation**
   - ✅ Pydantic schema validates types
   - ⚠️ RECOMMENDATION: Add regex validation for username (alphanumeric only)
   - ⚠️ RECOMMENDATION: Add email format validation
   - ⚠️ RECOMMENDATION: Add bio length limit (prevent abuse)

4. **File Upload (Avatar)**
   - ✅ Content-type validated (image/* only)
   - ✅ File size limit enforced (5MB)
   - ⚠️ RECOMMENDATION: Add file extension whitelist (.jpg, .png only)
   - ⚠️ RECOMMENDATION: Sanitize filename (prevent path traversal)

5. **SQL Injection**
   - ✅ ORM used (SQLAlchemy prevents injection)
   - ✅ No raw SQL queries

6. **Data Exposure**
   - ✅ Password hash not returned in response
   - ✅ Sensitive fields filtered

### Recommended Improvements

\`\`\`python
# backend/skillbit/schemas/user.py

from pydantic import BaseModel, EmailStr, Field, validator
import re

class UpdateUserDTO(BaseModel):
    username: str = Field(..., min_length=3, max_length=30)
    email: EmailStr  # Built-in email validation
    bio: str | None = Field(None, max_length=500)

    @validator('username')
    def validate_username(cls, v):
        if not re.match(r'^[a-zA-Z0-9_]+$', v):
            raise ValueError('Username must be alphanumeric')
        return v
\`\`\`

\`\`\`python
# backend/skillbit/routers/users.py

ALLOWED_EXTENSIONS = {'.jpg', '.jpeg', '.png', '.gif'}

@router.post("/{user_id}/avatar")
async def upload_avatar(
    user_id: int,
    file: UploadFile = File(...),
    current_user: User = Depends(get_current_user)
):
    # Existing checks...

    # NEW: Extension whitelist
    ext = os.path.splitext(file.filename)[1].lower()
    if ext not in ALLOWED_EXTENSIONS:
        raise HTTPException(
            status_code=400,
            detail=f"Invalid file type. Allowed: {ALLOWED_EXTENSIONS}"
        )

    # NEW: Sanitize filename (prevent path traversal)
    safe_filename = f"user_{user_id}_avatar{ext}"

    # Continue...
\`\`\`

### Risk Assessment

- **Overall Risk:** LOW
- **Auth Implementation:** SECURE
- **Input Validation:** GOOD (with recommendations)
- **Injection Risk:** NONE
```

---

## 🧪 Elite QA / Destructive Tester

### Role
Edge case hunter and failure scenario simulator.

### Expertise
- Race condition testing
- Concurrent request simulation
- Boundary value testing
- Error path validation
- Failure injection
- Load testing
- Edge case discovery

### Auto-Activation Triggers
- After any implementation
- Performance concern raised
- Concurrency-sensitive operation
- Critical user flow

### What It Does

**After implementation:**
1. Reviews code for edge cases
2. Simulates failure scenarios
3. Tests concurrent execution
4. Validates error handling
5. Checks boundary conditions

**Testing approach:**
- "What if user does X and Y simultaneously?"
- "What if database is down?"
- "What if file is 0 bytes? 1GB?"
- "What if network fails mid-upload?"

### Example Output

**Task:** Test profile update feature

**QA Destructive reports:**

```markdown
## QA Test Report: Profile Update

### Test Scenarios

#### 1. Concurrent Updates (Race Condition Test)

**Test:**
```python
# Simulate two users updating same profile simultaneously
async def test_concurrent_update():
    user_id = 1

    async def update_1():
        await user_service.update_profile(user_id, {"bio": "Bio 1"})

    async def update_2():
        await user_service.update_profile(user_id, {"bio": "Bio 2"})

    # Run concurrently
    await asyncio.gather(update_1(), update_2())
```

**Result:** ✅ PASS
- Optimistic locking prevents data loss
- One request succeeds, other raises `ConcurrentUpdateError`
- Correct behavior

---

#### 2. Large File Upload

**Test:**
```python
# Upload 10MB file (exceeds 5MB limit)
def test_large_file():
    large_file = b"x" * (10 * 1024 * 1024)
    response = client.post(
        f"/users/{user_id}/avatar",
        files={"file": ("huge.jpg", large_file, "image/jpeg")}
    )
```

**Result:** ✅ PASS
- Returns 400 "Image too large"
- Proper error message

---

#### 3. Invalid File Type

**Test:**
```python
# Upload .exe file
def test_invalid_file():
    response = client.post(
        f"/users/{user_id}/avatar",
        files={"file": ("virus.exe", b"MZ...", "application/x-executable")}
    )
```

**Result:** ✅ PASS
- Returns 400 "File must be an image"
- Attack blocked

---

#### 4. Empty File

**Test:**
```python
# Upload 0-byte file
def test_empty_file():
    response = client.post(
        f"/users/{user_id}/avatar",
        files={"file": ("empty.jpg", b"", "image/jpeg")}
    )
```

**Result:** ⚠️ WARNING
- Accepted and uploaded
- **RECOMMENDATION:** Add minimum file size check (e.g., 100 bytes)

---

#### 5. Unauthorized Access

**Test:**
```python
# User A tries to update User B's profile
def test_unauthorized_update():
    response = client.put(
        "/users/999/profile",  # User 999
        json={"username": "hacked"},
        headers={"Authorization": f"Bearer {user_1_token}"}  # User 1 token
    )
```

**Result:** ✅ PASS
- Returns 403 "Not authorized"
- RBAC working correctly

---

#### 6. Network Failure During Upload

**Test:**
```python
# Simulate network failure mid-upload
async def test_upload_failure():
    with mock.patch('backend.skillbit.core.storage.upload_file', side_effect=Exception("Network error")):
        response = client.post(
            f"/users/{user_id}/avatar",
            files={"file": ("test.jpg", b"fake image", "image/jpeg")}
        )
```

**Result:** ⚠️ ISSUE FOUND
- Returns 500 Internal Server Error
- **BUG:** No proper error handling in upload flow

**FIX REQUIRED:**
\`\`\`python
async def upload_avatar(user_id: int, file_contents: bytes, content_type: str):
    try:
        avatar_url = await upload_file(...)
    except Exception as e:
        logger.error(f"Avatar upload failed for user {user_id}: {e}")
        raise ServiceError("Avatar upload failed. Please try again.")

    # Continue...
\`\`\`

---

### Summary

- **Total Tests:** 6
- **Passed:** 4
- **Warnings:** 1 (empty file accepted)
- **Issues Found:** 1 (network failure not handled)
- **Overall Quality:** GOOD (after fixes)

### Required Actions

1. Add minimum file size validation
2. Add error handling for upload failures
```

**Coordinates with:**
- Backend Elite (implement fixes)
- Security Specialist (validate security tests)

---

## 🎨 UI/UX Elite Designer

### Role
Design systems, user experience, and accessibility expert.

### Expertise
- Design system consistency
- UX flow optimization
- Accessibility (WCAG)
- Visual hierarchy
- Color theory
- Typography
- Interaction design
- Responsive design

### Auto-Activation Triggers
- UI component creation
- Design decision needed
- Accessibility review
- UX flow question

### Uses
- `.claude/skills/ui-ux-pro-max/` skill for design patterns

### Example Output

**Task:** Review profile edit form UX

**UI/UX Elite reports:**

```markdown
## UX Review: Profile Edit Form

### Design System Consistency

✅ Uses Tailwind utility classes (project standard)
✅ Spacing consistent (space-y-4)
✅ Button styling matches design system

### Accessibility

⚠️ **ISSUES FOUND:**

1. **Form Labels**
   - Issue: Labels not explicitly associated with inputs
   - Fix: Add `htmlFor` attribute
   - Impact: Screen readers can't associate labels

\`\`\`tsx
// BEFORE
<label className="block text-sm font-medium">Username</label>
<input type="text" ... />

// AFTER
<label htmlFor="username" className="block text-sm font-medium">
  Username
</label>
<input id="username" type="text" ... />
\`\`\`

2. **Error Messages**
   - Issue: Error div not announced to screen readers
   - Fix: Add `role="alert"` and `aria-live="polite"`

\`\`\`tsx
{error && (
  <div role="alert" aria-live="polite" className="bg-red-50 text-red-600 p-3 rounded">
    {error}
  </div>
)}
\`\`\`

3. **Loading State**
   - Issue: Button disabled but no visual feedback
   - Fix: Add loading spinner

\`\`\`tsx
<button
  type="submit"
  disabled={loading}
  className="bg-blue-600 text-white px-4 py-2 rounded disabled:opacity-50"
  aria-busy={loading}
>
  {loading && <SpinnerIcon className="inline mr-2" />}
  {loading ? 'Saving...' : 'Save Changes'}
</button>
\`\`\`

### UX Flow

✅ Clear form structure
✅ Immediate validation feedback
✅ Loading states present
⚠️ **RECOMMENDATION:** Add confirmation message after successful save

\`\`\`tsx
const [success, setSuccess] = useState(false);

// In handleSubmit:
onUpdate(updated);
setSuccess(true);
setTimeout(() => setSuccess(false), 3000);

// In render:
{success && (
  <div role="status" className="bg-green-50 text-green-600 p-3 rounded">
    ✓ Profile updated successfully
  </div>
)}
\`\`\`

### Visual Hierarchy

✅ Form fields clearly labeled
⚠️ **RECOMMENDATION:** Add visual grouping

\`\`\`tsx
<form className="space-y-6">
  {/* Personal Info Section */}
  <div className="border-b pb-4">
    <h3 className="text-lg font-semibold mb-3">Personal Information</h3>
    {/* username, email fields */}
  </div>

  {/* Profile Section */}
  <div className="border-b pb-4">
    <h3 className="text-lg font-semibold mb-3">Profile</h3>
    {/* bio, avatar fields */}
  </div>

  {/* Actions */}
  <div>
    <button type="submit">Save Changes</button>
  </div>
</form>
\`\`\`

### Summary

- **Accessibility Score:** 6/10 (needs fixes)
- **UX Flow:** 8/10 (good with recommendations)
- **Visual Design:** 7/10 (functional, could improve hierarchy)
- **Overall:** GOOD (after accessibility fixes)
```

---

## 🤖 AI/GenAI Specialist

### Role
Large language models, RAG, and AI pipeline expert.

### Expertise
- LLM integration (OpenAI, Anthropic)
- Prompt engineering
- RAG (Retrieval-Augmented Generation)
- Vector embeddings
- AI pipeline optimization
- Context management
- Fine-tuning strategies

### Auto-Activation Triggers
- AI feature requested
- LLM integration needed
- RAG system implementation
- Prompt optimization

### Example Output

**Task:** Add AI-powered code validation for challenges

**AI/GenAI Specialist delivers:**

```python
# backend/skillbit/services/ai_service.py

from anthropic import Anthropic
from backend.skillbit.core.config import settings
from backend.skillbit.models.challenge import Challenge

client = Anthropic(api_key=settings.ANTHROPIC_API_KEY)

async def validate_code(code: str, test_cases: list, challenge: Challenge) -> dict:
    """
    Validate submitted code using Claude with structured output.

    Returns:
        {
            "passed": bool,
            "score": int (0-100),
            "feedback": str,
            "test_results": [...]
        }
    """

    # Construct prompt with clear structure
    prompt = f"""You are a code validator for a cybersecurity learning platform.

**Challenge:** {challenge.title}
**Description:** {challenge.description}

**Student's Code:**
```python
{code}
```

**Test Cases:**
{_format_test_cases(test_cases)}

**Task:**
1. Run the code mentally against each test case
2. Check for:
   - Correct output
   - Security best practices
   - Code quality
   - Edge case handling

**Output Format (JSON):**
{{
  "passed": true/false,
  "score": 0-100,
  "feedback": "Constructive feedback for student",
  "test_results": [
    {{"test": "Test 1", "passed": true, "output": "..."}},
    ...
  ]
}}
"""

    response = client.messages.create(
        model="claude-3-5-sonnet-20241022",
        max_tokens=2000,
        temperature=0,  # Deterministic for grading
        messages=[{"role": "user", "content": prompt}]
    )

    # Parse JSON response
    import json
    result = json.loads(response.content[0].text)

    return result


def _format_test_cases(test_cases: list) -> str:
    """Format test cases for prompt."""
    formatted = []
    for i, tc in enumerate(test_cases, 1):
        formatted.append(f"{i}. Input: {tc['input']}")
        formatted.append(f"   Expected: {tc['expected']}")
    return "\n".join(formatted)
```

**Also adds:**
- Error handling for API failures
- Rate limiting (avoid token overuse)
- Caching for identical submissions
- Fallback to rule-based validation

**Coordinates with:**
- Backend Elite (service integration)
- Security Specialist (API key security)
- QA Destructive (test edge cases: empty code, timeout, etc.)

---

## ✅ Pre-Push Validator

### Role
Full-stack quality gate before code ships.

### Expertise
- TypeScript build validation
- Backend import checks
- Migration chain verification
- API contract matching
- Auth surface validation
- Secret detection

### Auto-Activation Triggers
- Before `git push`
- Manual: "validate before push"

### What It Validates

```markdown
## Pre-Push Validation Checklist

### Frontend
- [ ] TypeScript build passes (`tsc --noEmit`)
- [ ] No type errors
- [ ] No unused imports
- [ ] Bundle size within limits

### Backend
- [ ] Python imports valid
- [ ] No circular dependencies
- [ ] All services use typing
- [ ] Alembic migration chain intact

### API Contracts
- [ ] Frontend types match backend schemas
- [ ] All API calls have matching endpoints
- [ ] No breaking changes without version bump

### Security
- [ ] All new endpoints have auth decorators
- [ ] No secrets in code (`.env` check)
- [ ] No console.log with sensitive data

### Database
- [ ] Migration reversible (up + down)
- [ ] No DROP statements without confirmation
- [ ] Foreign keys validated

### Tests
- [ ] All tests pass
- [ ] New code has tests (if applicable)

If ANY fail → **BLOCKED** (fix before push)
```

---

## 👁️ Sentinels (Always Active)

### Knowledge Curator

**See:** [How It Works - Knowledge Curator](how-it-works.md#knowledge-curator)

**Quick summary:**
- Captures complex solutions automatically
- Builds institutional memory
- Trains other agents
- Storage: `.claude/knowledge/{project}/`

---

### Codebase Intelligence

**See:** [How It Works - Codebase Intelligence](how-it-works.md#codebase-intelligence)

**Quick summary:**
- Maps architecture continuously
- Provides instant context
- Tracks dependencies
- Storage: `.claude/codebase-map/{project}/`

---

### Flow Architect

**See:** [How It Works - Flow Architect](how-it-works.md#flow-architect)

**Quick summary:**
- Traces execution flows automatically
- Detects conflicts (race conditions, N+1s, cache gaps, security holes)
- Provides exact fixes
- Storage: `.claude/codebase-map/{project}/flows/`

---

## 🎯 When to Use Which Agent

| Scenario | Agents Activated (by Master Agent) |
|----------|-----------------------------------|
| **"Add login feature"** | Frontend Elite, Backend Elite, Database Architect, Security Specialist, Flow Architect, Knowledge Curator |
| **"Where is auth logic?"** | Codebase Intelligence |
| **"Optimize database queries"** | Database Architect, Flow Architect, Backend Elite |
| **"Review security"** | Security Specialist, Flow Architect |
| **"Design profile page"** | UI/UX Elite, Frontend Elite |
| **"Add AI feature"** | AI/GenAI Specialist, Backend Elite, Security Specialist |
| **"Find race conditions"** | Flow Architect, QA Destructive |
| **"Before pushing code"** | Pre-Push Validator |

---

## 🔄 Agent Collaboration Example

**User Request:** "Add forgot password feature"

**Master Agent orchestrates:**

```
1. Codebase Intelligence
   → Provide auth context: where is auth code?

2. Frontend Elite
   → Build ForgotPasswordForm component
   → Add "Forgot Password?" link to login page

3. Backend Elite
   → Create POST /api/auth/forgot-password endpoint
   → Generate password reset token
   → Send email with reset link

4. Database Architect
   → Add password_reset_token, password_reset_expires to users table
   → Create migration

5. Security Specialist
   → Review:
     - Token must be random (crypto.randomBytes)
     - Token must expire (1 hour max)
     - Rate limit endpoint (prevent abuse)
     - Email must be masked in logs

6. QA Destructive
   → Test:
     - Expired token rejected
     - Invalid token rejected
     - Multiple reset requests (last token wins)
     - Email not found (don't leak info)

7. Flow Architect
   → Trace forgot-password flow
   → Check for conflicts: ✅ None

8. Knowledge Curator
   → Capture: "Password Reset Flow with Token Expiry"

9. Master Agent
   → Synthesize and deliver complete implementation
```

**User receives:** Complete forgot password feature with all concerns handled.

---

## 💡 Key Takeaways

- **You interact with Master Agent only** — Specialists activate automatically
- **Sentinels always watch** — Learning, mapping, tracing continuously
- **Cross-agent review is mandatory** — Security + QA always check implementations
- **Context-first approach** — Every agent queries sentinels before implementing
- **Production-grade by default** — Conflicts caught, security enforced, quality guaranteed

---

**Next:** [Customization Guide](customization.md) — Add your own custom agents
