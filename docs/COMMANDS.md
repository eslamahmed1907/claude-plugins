# Commands Reference

Complete reference for all 23 slash commands in the Claude Ultra Quality Enforcement Plugin.

## Table of Contents

- [Core Commands](#core-commands) (9 commands)
- [Quality Commands](#quality-commands) (3 commands)
- [Development Commands](#development-commands) (7 commands)
- [Specialized Commands](#specialized-commands) (4 commands)

## Core Commands

### /orchestrate

**Purpose**: Multi-step task orchestration with intelligent agent coordination.

**Usage**:
```bash
/orchestrate "task description"
/orchestrate "implement user authentication with OAuth2"
/orchestrate --plan-only "add caching layer"
```

**Features**:
- Automatic agent delegation
- Quality enforcement at every step
- Context-aware workflow
- Progress tracking
- Comprehensive error handling

**Workflow**:
1. Analyze task requirements
2. Create execution plan
3. Delegate to specialist agents
4. Monitor progress
5. Validate quality at each step
6. Report completion

**Example**:
```bash
/orchestrate "implement retry logic with exponential backoff"

# Automatically:
# - Analyzes requirements
# - Creates specification (spec-writer)
# - Writes tests first (test-writer)
# - Implements solution (code-writer)
# - Validates quality (quality-enforcer)
# - Runs security scan (security-scanner)
# - Creates commit (commit-agent)
```

**Options**:
- `--plan-only`: Show execution plan without executing
- `--no-tests`: Skip test creation (not recommended)
- `--no-commit`: Don't create commit after completion

**Related**:
- `/orchestrate-status` - Check progress
- `/start-orchestrate` - Interactive orchestration

---

### /orchestrate-status

**Purpose**: Check the status of current orchestration.

**Usage**:
```bash
/orchestrate-status
```

**Shows**:
- Current phase
- Completed tasks
- Active tasks
- Pending tasks
- Overall progress
- Estimated completion

**Example Output**:
```
Orchestration Status
════════════════════════════════════════
Phase: Implementation
Progress: 65% (13/20 tasks)

✅ Completed (13):
   - Requirement analysis
   - Specification creation
   - Test design
   - Unit tests (10 tests)
   - Core implementation

🔄 In Progress (2):
   - Integration testing
   - Documentation

⏳ Pending (5):
   - Security review
   - Performance validation
   - Final quality check
   - Commit creation
   - CI/CD monitoring

Estimated completion: 15 minutes
```

---

### /start-orchestrate

**Purpose**: Begin an interactive orchestration workflow with step-by-step review.

**Usage**:
```bash
/start-orchestrate
```

**Interactive Workflow**:
1. Task description prompt
2. Show execution plan
3. Confirm each step
4. Review intermediate results
5. Make adjustments if needed
6. Final validation

**Features**:
- Step-by-step control
- Review before each action
- Modify plan mid-execution
- Skip optional steps
- Early termination

**Best For**:
- Complex, uncertain tasks
- Learning the orchestration process
- Tasks requiring manual review
- Exploratory development

**Example**:
```bash
/start-orchestrate

> Enter task description: Implement API rate limiting

Execution Plan:
1. Analyze requirements
2. Design rate limiting strategy
3. Write tests
4. Implement rate limiter
5. Add middleware integration
6. Security review
7. Performance testing
8. Documentation

Proceed with step 1? [Y/n]
```

---

### /steer

**Purpose**: Project documentation and context analysis.

**Usage**:
```bash
/steer                    # Full analysis
/steer --update           # Update documentation
/steer --check            # Verify quality
/steer --focus api        # Focus on specific area
```

**Features**:
- Maintains project documentation
- Enforces conventions
- Context management
- Generates steering documents
- Quality verification

**Steering Documents**:
```
docs/steering/
├── architecture.md      # System architecture
├── conventions.md       # Coding conventions
├── decisions.md         # Design decisions
├── patterns.md          # Common patterns
└── standards.md         # Quality standards
```

**Example**:
```bash
/steer --update

# Updates:
# - Architecture documentation
# - Convention guidelines
# - Design decision log
# - Pattern catalog
# - Quality standards
```

**Options**:
- `--update`: Update all steering documents
- `--check`: Verify compliance
- `--focus <area>`: Focus on specific component
- `--summary`: Show summary only

---

### /git_status

**Purpose**: Enhanced git status with quality insights.

**Usage**:
```bash
/git_status
```

**Shows**:
- Standard git status
- Quality issues in changed files
- Test coverage impact
- Documentation updates needed
- Commit readiness

**Example Output**:
```
Git Status with Quality Insights
════════════════════════════════════════

Branch: feature/auth
Ahead: 3 commits
Behind: 0 commits

Modified Files (5):
✅ src/auth/mod.rs         (formatted, tested)
⚠️  src/auth/oauth.rs      (2 clippy warnings)
❌ src/auth/tokens.rs      (compilation error)
✅ tests/auth_test.rs      (all passing)
📝 README.md               (needs update)

Quality Summary:
- Compilation: ❌ 1 error
- Warnings: ⚠️ 2 warnings
- Tests: ✅ All passing (15/15)
- Coverage: 87% (+2%)
- Documentation: ⚠️ Updates needed

Commit Readiness: ❌ NOT READY
- Fix: src/auth/tokens.rs compilation error
- Fix: src/auth/oauth.rs clippy warnings
- Update: README.md documentation
```

---

### /cleanup

**Purpose**: Repository cleanup with intelligent archiving.

**Usage**:
```bash
/cleanup                  # Interactive cleanup
/cleanup --aggressive     # Remove all unused
/cleanup --dry-run        # Show what would be removed
```

**Cleans**:
- Build artifacts
- Temporary files
- Unused dependencies
- Stale branches
- Old logs
- Cache directories

**Archives**:
- Completed task documents
- Old specifications
- Historical logs
- Backup files

**Safety Features**:
- Interactive confirmation
- Dry-run mode
- Backup before deletion
- Whitelist protection
- Undo capability

**Example**:
```bash
/cleanup

Cleanup Analysis:
════════════════════════════════════════
Build Artifacts: 245 MB
Temporary Files: 89 MB
Old Logs: 156 MB
Cache: 423 MB
Total Savings: 913 MB

Safe to Remove:
✓ target/ (245 MB)
✓ .cache/ (423 MB)
✓ *.log files (156 MB)
✓ tmp/ (89 MB)

Proceed? [Y/n]
```

---

### /archive-project

**Purpose**: Archive current project state for later reference.

**Usage**:
```bash
/archive-project
/archive-project "v1.0 release"
```

**Archives**:
- Complete source code
- Documentation
- Build artifacts (optional)
- Git history
- Project metadata
- Quality reports

**Archive Location**:
```
~/.claude/plans/archive/
└── YYYYMMDD_HHMMSS/
    ├── source/
    ├── docs/
    ├── quality-report.md
    └── metadata.json
```

**Metadata Includes**:
- Archive date
- Project version
- Commit SHA
- Quality metrics
- Test results
- Coverage data

**Use Cases**:
- Release milestones
- Major refactors
- Before experimental changes
- Compliance requirements

---

### /complete-project

**Purpose**: Mark project as complete with final validation.

**Usage**:
```bash
/complete-project
```

**Completion Steps**:
1. Run final quality check
2. Validate all tests passing
3. Check documentation completeness
4. Security scan
5. Generate completion report
6. Archive project state
7. Update project status

**Completion Report**:
```
Project Completion Report
════════════════════════════════════════
Project: My Project
Completed: 2025-10-09 19:30:00
Duration: 45 days

Quality Metrics:
✅ Compilation: 0 errors, 0 warnings
✅ Tests: 487 passing, 0 failing
✅ Coverage: 92%
✅ Security: 0 vulnerabilities
✅ Documentation: 100% complete

Deliverables:
✅ Source code
✅ Documentation
✅ Test suite
✅ Build artifacts
✅ Deployment scripts

Status: COMPLETE ✅
```

---

### /debug-tokens

**Purpose**: Debug token usage and context limits.

**Usage**:
```bash
/debug-tokens
```

**Shows**:
- Current token usage
- Available tokens
- Usage by category
- Optimization suggestions
- Context compression status

**Example Output**:
```
Token Usage Analysis
════════════════════════════════════════
Current: 45,234 / 200,000 (23%)
Available: 154,766

Usage Breakdown:
- System prompt: 8,450 (19%)
- File context: 22,300 (49%)
- Conversation: 12,484 (28%)
- Tool results: 2,000 (4%)

Optimization Suggestions:
⚡ Context compression available
⚡ Remove 3 old file contexts
⚡ Compact conversation history

Projected: 38,120 after optimization
Savings: 7,114 tokens (16%)
```

---

## Quality Commands

### /quality-check

**Purpose**: Comprehensive quality validation across all dimensions.

**Usage**:
```bash
/quality-check
/quality-check --strict
/quality-check --fast
```

**Checks**:
- ✅ Compilation (zero errors, zero warnings)
- ✅ Linting (all languages)
- ✅ Testing (100% pass rate)
- ✅ Coverage (minimum 85%)
- ✅ Formatting (style compliance)
- ✅ Documentation (completeness)
- ✅ Security (vulnerabilities)
- ✅ Performance (no regressions)
- ✅ Forbidden patterns (none present)

**Report Format**:
```
Quality Check Report
════════════════════════════════════════
Overall: ✅ PASS (9/9 checks)

✅ Compilation
   - Rust: cargo build --all-features
   - Exit code: 0
   - Warnings: 0

✅ Linting
   - Clippy: 0 warnings
   - Ruff: 0 issues
   - ESLint: 0 warnings

✅ Tests
   - Total: 487 tests
   - Passing: 487 (100%)
   - Failing: 0
   - Ignored: 0

✅ Coverage
   - Line: 92%
   - Branch: 88%
   - Target: 85% ✅

✅ Security
   - Vulnerabilities: 0
   - Dependencies: All secure
   - Code patterns: Safe

✅ Performance
   - No regressions detected
   - All benchmarks within targets

✅ Documentation
   - Public APIs: 100% documented
   - Examples: All compile
   - README: Up to date

✅ Formatting
   - All files formatted correctly

✅ Forbidden Patterns
   - Production unwrap(): 0
   - TODOs: 0
   - Placeholders: 0

════════════════════════════════════════
Status: ✅ READY FOR COMMIT
```

**Options**:
- `--strict`: Ultra-strict validation (90% coverage, etc.)
- `--fast`: Quick validation (skip expensive checks)
- `--fix`: Attempt automatic fixes

---

### /security

**Purpose**: Comprehensive security audit of the codebase.

**Usage**:
```bash
/security
/security --deep
/security --report-only
```

**Security Checks**:

**1. Dependency Scanning**
```bash
# Rust
cargo audit

# Python
safety check
pip-audit

# Node
npm audit
```

**2. Code Pattern Analysis**
- Unsafe code blocks
- Hardcoded secrets/API keys
- SQL injection risks
- XSS vulnerabilities
- Path traversal issues
- Unsafe deserialization
- Insecure cryptography

**3. Security Best Practices**
- Input validation
- Error handling (no info leaks)
- Authentication/authorization
- Secure random generation
- HTTPS usage
- CORS configuration

**Report Format**:
```
Security Audit Report
════════════════════════════════════════
Scan Date: 2025-10-09 19:30:00
Severity Threshold: Medium

════════════════════════════════════════
SUMMARY
════════════════════════════════════════
Critical: 0
High: 0
Medium: 1
Low: 3
Info: 5

════════════════════════════════════════
FINDINGS
════════════════════════════════════════

[MEDIUM] Potential Secret Exposure
Location: config/default.yaml:15
Issue: Hardcoded API key pattern detected
Recommendation: Use environment variables

[LOW] Weak Random Generation
Location: src/tokens.rs:45
Issue: Using rand::thread_rng() for security token
Recommendation: Use OsRng for cryptographic randomness

[LOW] Missing HTTPS Enforcement
Location: src/server.rs:120
Issue: HTTP endpoint exposed
Recommendation: Enforce HTTPS in production

════════════════════════════════════════
RECOMMENDATIONS
════════════════════════════════════════
1. Move secrets to environment variables
2. Use cryptographic-grade RNG for tokens
3. Enforce HTTPS for all endpoints
4. Add rate limiting to API
5. Implement CSRF protection

════════════════════════════════════════
DEPENDENCY VULNERABILITIES
════════════════════════════════════════
None found ✅

════════════════════════════════════════
OVERALL RATING: B+
Critical Issues: 0
Action Required: Address 1 medium issue
```

**Options**:
- `--deep`: Deep analysis (slower, more thorough)
- `--report-only`: Generate report without fixes
- `--fix`: Auto-fix security issues where possible

---

### /test

**Purpose**: Advanced test execution with comprehensive reporting.

**Usage**:
```bash
/test
/test --all
/test --coverage
/test --strict
/test --fix
/test --watch
```

**Features**:
- Runs complete test suite
- Coverage analysis
- Performance tracking
- Failure diagnosis
- Automatic fixing
- Watch mode

**Test Execution**:
```bash
# Rust
cargo test --all-features --all-targets
cargo test --release

# Python
pytest -xvs --cov=. --cov-report=term-missing

# TypeScript
npm test
```

**Report Format**:
```
Test Execution Report
════════════════════════════════════════

Test Suite: All
Duration: 12.4s
Parallelization: 8 threads

════════════════════════════════════════
RESULTS
════════════════════════════════════════

Unit Tests: 325
✅ Passing: 325 (100%)
❌ Failing: 0
⏭️  Ignored: 0

Integration Tests: 142
✅ Passing: 142 (100%)
❌ Failing: 0

Benchmarks: 20
✅ All within targets

════════════════════════════════════════
COVERAGE
════════════════════════════════════════

Line Coverage: 92.3%
Branch Coverage: 87.8%
Function Coverage: 95.1%

Target: 85% ✅

Uncovered Areas:
- src/error.rs: 78% (error display)
- src/utils.rs: 82% (edge cases)

════════════════════════════════════════
PERFORMANCE
════════════════════════════════════════

Slowest Tests:
1. integration::full_workflow - 2.1s
2. stress::concurrent_requests - 1.8s
3. integration::database_migration - 1.3s

Performance: ✅ All tests < 5s

════════════════════════════════════════
STATUS: ✅ ALL TESTS PASSING
Coverage: ✅ Above target (92% > 85%)
Performance: ✅ Within limits
```

**Options**:
- `--all`: Run all tests including expensive ones
- `--coverage`: Generate coverage report
- `--strict`: Fail on any coverage below 90%
- `--fix`: Attempt to fix failing tests
- `--watch`: Re-run on file changes
- `--filter <pattern>`: Run specific tests

---

## Development Commands

### /ultra-dev

**Purpose**: Complete development workflow with quality enforcement.

**Usage**:
```bash
/ultra-dev "feature description"
/ultra-dev "implement user authentication"
```

**Complete Workflow**:
1. **Requirement Analysis**
   - Parse feature description
   - Identify requirements
   - Define success criteria

2. **Specification**
   - Create technical spec (spec-writer)
   - Define acceptance criteria
   - Document edge cases

3. **Test-Driven Development**
   - Write failing tests (test-writer)
   - Verify tests fail
   - Document expected behavior

4. **Implementation**
   - Implement minimum code (code-writer)
   - Make tests pass
   - Refactor for quality

5. **Quality Validation**
   - Run quality checks (quality-enforcer)
   - Security scan (security-scanner)
   - Performance validation (performance-analyzer)
   - Documentation audit (documentation-auditor)

6. **Commit Creation**
   - Auto-commit if quality passes (commit-agent)
   - CI/CD monitoring (workflow-monitor)
   - Auto-fix if CI fails (workflow-fixer)

**Example**:
```bash
/ultra-dev "add rate limiting to API endpoints"

════════════════════════════════════════
ULTRA DEVELOPMENT WORKFLOW
════════════════════════════════════════

Step 1: Requirement Analysis ✅
- Feature: Rate limiting for API
- Endpoints: All public APIs
- Strategy: Token bucket algorithm
- Limits: 100 req/min per user

Step 2: Specification Created ✅
- Created: docs/specs/rate-limiting.md
- Acceptance criteria defined
- Edge cases documented

Step 3: Tests Written ✅
- Unit tests: 15 tests
- Integration tests: 8 tests
- Load tests: 3 scenarios
- All tests failing (expected)

Step 4: Implementation ✅
- RateLimiter struct implemented
- Middleware integration complete
- Configuration support added
- All tests now passing ✅

Step 5: Quality Validation ✅
- Compilation: ✅ 0 errors, 0 warnings
- Tests: ✅ 23/23 passing
- Coverage: ✅ 94%
- Security: ✅ No issues
- Performance: ✅ < 1ms overhead
- Documentation: ✅ Complete

Step 6: Commit & CI/CD ✅
- Commit created: abc1234
- Pushed to: origin/feature/rate-limiting
- CI/CD: ✅ All workflows passing

════════════════════════════════════════
✅ FEATURE COMPLETE
Duration: 8 minutes
Quality: 100%
```

---

### /ultra-commit

**Purpose**: Quality-assured git commits with zero tolerance for issues.

**Usage**:
```bash
/ultra-commit
/ultra-commit "custom message"
/ultra-commit --fix
/ultra-commit --dry-run
```

**Quality Gates** (ALL must pass):

1. **Code Formatting** ✅
```bash
cargo fmt --all
ruff format .
prettier --write .
```

2. **Compilation** ✅
```bash
RUSTFLAGS="-D warnings" cargo build --release
```

3. **Linting** ✅
```bash
cargo clippy -- -D warnings
ruff check .
eslint . --max-warnings 0
```

4. **Forbidden Patterns** ✅
- No `.unwrap()` in production Rust
- No `panic!()` anywhere
- No `TODO` comments
- No placeholders

5. **Tests** ✅
```bash
cargo test --all
pytest --cov=.
npm test
```

6. **Security** ✅
```bash
cargo audit
safety check
npm audit
```

7. **Documentation** ✅
- All public APIs documented
- README up to date
- Examples provided

**Execution Flow**:
```
/ultra-commit
  ↓
[1] Format code automatically
  ↓
[2] Run all quality checks
  ↓
Decision: All pass?
  ↓
YES → [3] Generate commit message
      [4] Create commit
      [5] Push to remote
      [6] Monitor CI/CD
      [7] Auto-fix if CI fails
  ↓
NO  → [3] Report issues
      [4] Block commit
      [5] Suggest fixes
```

**Success Output**:
```
════════════════════════════════════════
COMMIT SUCCESSFUL
════════════════════════════════════════

✅ All Quality Checks Passed
   - Formatting: ✅
   - Compilation: ✅ 0 errors, 0 warnings
   - Linting: ✅ 0 issues
   - Tests: ✅ 487/487 passing
   - Security: ✅ No vulnerabilities
   - Documentation: ✅ Complete

Commit: abc1234
Message: feat(api): add rate limiting middleware
Branch: feature/rate-limiting
Pushed: origin/feature/rate-limiting

CI/CD Monitoring: Active
└── Watching workflows until all pass
```

**Blocked Output**:
```
❌ COMMIT BLOCKED - Quality Issues Detected
════════════════════════════════════════
Issues Found: 3

1. Clippy Warnings (2)
   - src/main.rs:45 - use of unwrap()
   - src/lib.rs:120 - unnecessary clone()

2. Test Failures (1)
   - test_auth_flow failed

3. Documentation Missing
   - Public function 'process_data' undocumented

════════════════════════════════════════
Auto-Fix Available: YES
Run: /ultra-commit --fix
```

**Options**:
- `--fix`: Automatically fix issues before committing
- `--dry-run`: Show what would be committed
- `--force-check`: Re-run all checks (bypass cache)
- `--amend`: Amend previous commit

---

### /review-design

**Purpose**: Review and modify generated system design.

**Usage**:
```bash
/review-design
/review-design --update
```

**Reviews**:
- System architecture
- Component design
- Data models
- API design
- Integration points

**Interactive Review**:
```
Design Review
════════════════════════════════════════

Component: Authentication System

Current Design:
├── AuthService
│   ├── authenticate(credentials) -> Token
│   ├── validate(token) -> User
│   └── refresh(token) -> Token
├── TokenStore (Redis)
└── UserRepository (PostgreSQL)

Security: OAuth2 + JWT
Session: Stateless tokens
Expiry: 1 hour (access), 7 days (refresh)

════════════════════════════════════════
Review Questions:

1. Design approach? [Approve/Modify/Reject]
2. Security adequate? [Y/n]
3. Scalability concerns? [Y/n]
4. Simplification possible? [Y/n]

Changes to make? [Y/n]
```

---

### /review-spec

**Purpose**: Review and modify generated technical specifications.

**Usage**:
```bash
/review-spec
/review-spec <spec-file>
```

**Reviews**:
- Functional requirements
- Non-functional requirements
- Acceptance criteria
- Edge cases
- Success metrics

**Specification Format**:
```markdown
# Feature Specification: Rate Limiting

## Overview
Implement rate limiting for all public API endpoints.

## Functional Requirements
- FR1: Limit requests per user per time window
- FR2: Return 429 status when limit exceeded
- FR3: Include rate limit headers in responses

## Non-Functional Requirements
- NFR1: < 1ms overhead per request
- NFR2: 99.99% accuracy in counting
- NFR3: Distributed counter support

## Acceptance Criteria
- AC1: 100 requests/minute enforced
- AC2: Graceful degradation if Redis unavailable
- AC3: Admin bypass functionality

## Edge Cases
- EC1: Clock skew handling
- EC2: Burst traffic handling
- EC3: Multiple concurrent requests
```

**Review Process**:
1. Read specification
2. Check completeness
3. Verify clarity
4. Validate feasibility
5. Suggest improvements
6. Update if needed

---

### /review-tasks

**Purpose**: Review task completion against requirements.

**Usage**:
```bash
/review-tasks
```

**Reviews**:
- Task completion status
- Acceptance criteria met
- Quality standards met
- Documentation updated
- Tests comprehensive

**Review Output**:
```
Task Completion Review
════════════════════════════════════════

Task: Implement Rate Limiting
Status: Complete
Duration: 2 hours

════════════════════════════════════════
ACCEPTANCE CRITERIA
════════════════════════════════════════

✅ AC1: 100 req/min enforced
   - Implementation: TokenBucket algorithm
   - Testing: Load test confirms limit
   - Status: ✅ PASS

✅ AC2: Graceful degradation
   - Implementation: Fallback to in-memory
   - Testing: Redis failure scenarios
   - Status: ✅ PASS

✅ AC3: Admin bypass
   - Implementation: Admin role check
   - Testing: Admin requests unlimited
   - Status: ✅ PASS

════════════════════════════════════════
QUALITY METRICS
════════════════════════════════════════

✅ Compilation: 0 errors, 0 warnings
✅ Tests: 23/23 passing
✅ Coverage: 94%
✅ Performance: 0.8ms overhead
✅ Security: No issues
✅ Documentation: Complete

════════════════════════════════════════
OVERALL: ✅ TASK COMPLETE
All acceptance criteria met
Quality standards exceeded
Ready for merge
```

---

### /spec

**Purpose**: Create detailed technical specification from requirements.

**Usage**:
```bash
/spec "feature description"
/spec "add caching layer to reduce database queries"
```

**Generates**:
1. Feature overview
2. Functional requirements
3. Non-functional requirements
4. Acceptance criteria
5. Edge cases
6. Success metrics
7. Implementation approach

**Example**:
```bash
/spec "implement distributed caching with Redis"

Generated: docs/specs/distributed-caching.md

# Specification: Distributed Caching

## Overview
Implement Redis-based distributed caching to reduce
database load and improve response times.

## Functional Requirements
FR1: Cache frequently accessed data
FR2: TTL-based expiration (configurable)
FR3: Cache invalidation on data updates
FR4: Fallback to database on cache miss

## Non-Functional Requirements
NFR1: < 5ms cache lookup time
NFR2: 99.9% cache hit rate for popular data
NFR3: Horizontal scaling support
NFR4: Zero data loss on cache failure

## Acceptance Criteria
AC1: Database queries reduced by 80%
AC2: Response time improved by 50%
AC3: Cache consistency maintained
AC4: Monitoring and metrics available

## Edge Cases
EC1: Cache warming on startup
EC2: Cache thundering herd
EC3: Network partition handling
EC4: Memory limits

## Success Metrics
- Database load: -80%
- Response time: -50%
- Cache hit rate: >95%
- Error rate: <0.1%

## Implementation Approach
1. Redis cluster setup
2. Cache key design
3. TTL strategy
4. Invalidation hooks
5. Monitoring integration
```

---

### /tdd

**Purpose**: Test-driven development workflow.

**Usage**:
```bash
/tdd
/tdd "feature to implement"
```

**TDD Cycle**:
```
1. Write Test (RED)
   ↓
2. Run Test → Should FAIL
   ↓
3. Write Code (GREEN)
   ↓
4. Run Test → Should PASS
   ↓
5. Refactor
   ↓
6. Run Test → Should PASS
   ↓
Repeat
```

**Workflow**:
```bash
/tdd "user authentication"

════════════════════════════════════════
TDD WORKFLOW
════════════════════════════════════════

CYCLE 1: User Login
────────────────────────────────────────
[RED] Write test: test_successful_login
Test written ✅
Running test... ❌ FAIL (expected)

[GREEN] Implement: authenticate()
Code written ✅
Running test... ✅ PASS

[REFACTOR] Extract validation logic
Refactored ✅
Running test... ✅ PASS

────────────────────────────────────────
CYCLE 2: Invalid Credentials
────────────────────────────────────────
[RED] Write test: test_invalid_password
Test written ✅
Running test... ❌ FAIL (expected)

[GREEN] Add password validation
Code written ✅
Running test... ✅ PASS

[REFACTOR] Simplify error handling
Refactored ✅
Running test... ✅ PASS

════════════════════════════════════════
TDD Summary:
- Cycles completed: 5
- Tests written: 8
- All tests passing: ✅
- Code coverage: 96%
```

---

## Specialized Commands

### /fix-ci

**Purpose**: Automatically fix CI/CD pipeline failures.

**Usage**:
```bash
/fix-ci
/fix-ci --workflow <name>
```

**Fixes**:
- Compilation errors
- Test failures
- Linting issues
- Dependency problems
- Configuration errors
- Environment issues

**Process**:
1. Detect workflow failures
2. Analyze error logs
3. Identify root cause
4. Apply targeted fix
5. Create fix commit
6. Trigger re-run
7. Verify success

**Example**:
```bash
/fix-ci

CI/CD Failure Detected
════════════════════════════════════════

Workflow: Tests
Run: #1234
Status: ❌ Failed

Failures:
1. clippy: unused variable 'result'
2. test: test_auth_flow failed
3. build: dependency version conflict

════════════════════════════════════════
FIXING ISSUES
════════════════════════════════════════

[1/3] Fixing clippy warning...
   - Removed unused variable
   - File: src/auth.rs:45
   - Status: ✅ Fixed

[2/3] Fixing test failure...
   - Updated test expectation
   - File: tests/auth_test.rs:78
   - Status: ✅ Fixed

[3/3] Resolving dependency conflict...
   - Updated tokio version
   - File: Cargo.toml
   - Status: ✅ Fixed

════════════════════════════════════════
CREATING FIX COMMIT
════════════════════════════════════════

Commit: def5678
Message: fix(ci): resolve workflow failures
Files changed: 3

Pushed to: origin/main
Triggering re-run...

════════════════════════════════════════
RE-RUN STATUS: ✅ ALL PASSING
```

---

### /fix-deps

**Purpose**: Fix dependency issues and conflicts.

**Usage**:
```bash
/fix-deps
/fix-deps --update
/fix-deps --audit
```

**Handles**:
- Version conflicts
- Missing dependencies
- Outdated packages
- Security vulnerabilities
- Lock file issues
- Transitive dependencies

**Rust Example**:
```bash
/fix-deps

Dependency Analysis
════════════════════════════════════════

Issues Found: 3

1. Version Conflict
   - tokio: 1.35.0 vs 1.36.0
   - Requested by: hyper, tower
   - Resolution: Update to 1.36.0

2. Security Vulnerability
   - Package: time
   - Version: 0.1.43
   - CVE: CVE-2020-26235
   - Fix: Update to 0.3.0

3. Outdated Package
   - Package: serde
   - Current: 1.0.195
   - Latest: 1.0.197
   - Recommendation: Update

════════════════════════════════════════
APPLYING FIXES
════════════════════════════════════════

[1/3] Resolving tokio conflict...
   - Updated Cargo.toml
   - Version: 1.36.0
   - Status: ✅ Fixed

[2/3] Fixing security vulnerability...
   - Updated time dependency
   - Version: 0.3.0
   - Status: ✅ Fixed

[3/3] Updating serde...
   - Version: 1.0.197
   - Status: ✅ Fixed

Running cargo update... ✅
Running cargo build... ✅
Running cargo test... ✅

════════════════════════════════════════
ALL DEPENDENCIES FIXED ✅
```

---

### /fix-tests

**Purpose**: Automatically fix failing tests.

**Usage**:
```bash
/fix-tests
/fix-tests --all
/fix-tests <test-name>
```

**Strategies**:
1. **Test Bug**: Fix test expectations
2. **Code Bug**: Fix implementation
3. **Environment**: Fix test setup
4. **Timing**: Fix race conditions
5. **Data**: Fix test data

**Example**:
```bash
/fix-tests

Test Failure Analysis
════════════════════════════════════════

Failed: test_user_authentication (1/487)

Failure Details:
────────────────────────────────────────
thread 'test_user_authentication' panicked at
'assertion failed: `(left == right)`
  left: `Some(User { id: 1, ... })`,
 right: `None`'

Root Cause Analysis:
────────────────────────────────────────
Type: Code Bug
Issue: Database query returns None
Expected: Return user with ID 1
Actual: Returns None

Fix Strategy: Update implementation

════════════════════════════════════════
APPLYING FIX
════════════════════════════════════════

File: src/auth/repository.rs:42
Change: Fix SQL query WHERE clause

Before:
WHERE id = $1 AND deleted = true

After:
WHERE id = $1 AND deleted = false

Status: ✅ Fixed

════════════════════════════════════════
VERIFICATION
════════════════════════════════════════

Running: cargo test test_user_authentication
Result: ✅ PASS

Running: cargo test --all
Result: ✅ ALL PASSING (487/487)
```

---

### /tests

**Purpose**: Comprehensive test management and execution.

**Usage**:
```bash
/tests list              # List all tests
/tests run               # Run all tests
/tests run <pattern>     # Run matching tests
/tests coverage          # Coverage report
/tests watch             # Watch mode
/tests benchmark         # Run benchmarks
```

**Features**:
- Test discovery
- Selective execution
- Coverage analysis
- Performance tracking
- Watch mode
- Benchmark execution

**Example**:
```bash
/tests list

Test Inventory
════════════════════════════════════════

Unit Tests (325):
├── auth (45 tests)
│   ├── test_login
│   ├── test_logout
│   └── ...
├── api (120 tests)
│   ├── test_get_user
│   ├── test_create_user
│   └── ...
└── utils (160 tests)

Integration Tests (142):
├── database (45 tests)
├── http (67 tests)
└── cache (30 tests)

Performance Tests (20):
├── benchmarks (15)
└── load tests (5)

Total: 487 tests
```

```bash
/tests run auth

Running auth tests...
════════════════════════════════════════

test auth::test_login ... ok (12ms)
test auth::test_logout ... ok (8ms)
test auth::test_invalid_password ... ok (6ms)
test auth::test_expired_token ... ok (15ms)
... (41 more)

────────────────────────────────────────
Results: 45/45 passing
Duration: 0.8s
Coverage: 94%
────────────────────────────────────────
✅ ALL TESTS PASSED
```

---

## Command Chaining

### Common Workflows

**Complete Feature Development**:
```bash
/spec "feature description"
→ /tdd
→ /quality-check
→ /security
→ /ultra-commit
```

**Bug Fix Workflow**:
```bash
/tests run <failing-test>
→ /fix-tests
→ /quality-check
→ /ultra-commit
```

**CI/CD Recovery**:
```bash
/fix-ci
→ /tests run
→ /ultra-commit
```

**Project Cleanup**:
```bash
/cleanup
→ /quality-check
→ /archive-project
```

---

## Best Practices

### Command Selection

**Use `/ultra-dev` when**:
- Starting new features
- Want complete automation
- Need TDD workflow
- Require quality enforcement

**Use `/ultra-commit` when**:
- Ready to commit
- Need quality validation
- Want automatic CI/CD monitoring
- Require zero-defect commits

**Use `/quality-check` when**:
- Before commits
- After major changes
- Periodic validation
- Release preparation

**Use `/security` when**:
- Before releases
- After dependency updates
- Regular security audits
- Compliance requirements

**Use `/orchestrate` when**:
- Complex multi-step tasks
- Need agent coordination
- Want progress tracking
- Require comprehensive workflows

---

For more information, see:
- [Agents Reference](AGENTS.md)
- [Hooks Guide](HOOKS.md)
- [Configuration](CONFIGURATION.md)
- [Quick Reference](QUICK_REFERENCE.md)
