# Agents Reference

Complete reference for all 46 specialized development agents in the Claude Ultra Quality Enforcement Plugin.

## Table of Contents

- [Quality Enforcement Agents](#quality-enforcement-agents) (11 agents)
- [Language Specialist Agents](#language-specialist-agents) (3 agents)
- [Testing Agents](#testing-agents) (8 agents)
- [Code Management Agents](#code-management-agents) (6 agents)
- [CI/CD & Workflow Agents](#cicd--workflow-agents) (5 agents)
- [Documentation Agents](#documentation-agents) (3 agents)
- [Commit Management Agents](#commit-management-agents) (6 agents)
- [Architecture & Orchestration Agents](#architecture--orchestration-agents) (5 agents)

## Quality Enforcement Agents

### build-validator

**Purpose**: Ensures code compiles with zero errors and zero warnings.

**Key Features**:
- Runs compilation checks for all targets and features
- Enforces `RUSTFLAGS="-D warnings"` for Rust projects
- Validates build artifacts
- Reports detailed compilation issues

**When Used**:
- Before any commit
- In pre-return validation
- During quality checks
- As part of ultra-commit workflow

**Example**:
```bash
# Automatically invoked by quality checks
/quality-check

# Ensures: cargo build --all-features succeeds with zero warnings
```

---

### quality-enforcer

**Purpose**: Overall quality guardian that ensures all quality standards are met.

**Key Features**:
- Validates compilation, tests, linting, formatting
- Checks for forbidden patterns
- Enforces test coverage requirements
- Blocks delivery of substandard code

**When Used**:
- Before code return to user
- During commit process
- In automated quality gates
- As master quality validator

**Standards Enforced**:
- Zero compilation errors
- Zero warnings (all languages)
- 100% test pass rate
- Minimum 85% coverage
- No forbidden patterns
- Complete implementations

---

### quality-enforcer-strict

**Purpose**: Ultra-strict quality enforcement with zero tolerance for any issues.

**Key Features**:
- All features of quality-enforcer
- Stricter coverage requirements (90%+)
- Additional code complexity checks
- Performance regression detection
- Security vulnerability blocking

**When Used**:
- Production releases
- Critical code paths
- Security-sensitive code
- High-reliability requirements

---

### ultra-quality-enforcer

**Purpose**: Ultimate quality gatekeeper with absolute veto power.

**Key Features**:
- Final checkpoint before code delivery
- Cannot be bypassed
- Comprehensive multi-language support
- Automatic fix attempts before blocking
- Detailed failure reporting

**When Used**:
- Final validation before user sees code
- Before any commit is created
- In automated pipelines
- As last line of defense

**Veto Conditions**:
- ANY compilation error
- ANY warning
- ANY failing test
- ANY forbidden pattern
- ANY placeholder code

---

### quality-critic

**Purpose**: Expert code review focusing on optimization and best practices.

**Key Features**:
- Reviews for performance improvements
- Suggests better patterns
- Identifies code smells
- Recommends refactoring opportunities
- Iterates until consensus

**When Used**:
- During code review
- After implementation complete
- Before optimization phase
- For complex algorithms

**Review Criteria**:
- Algorithm efficiency
- Memory usage
- Code maintainability
- Design patterns
- Best practices adherence

---

### pre-return-validator

**Purpose**: Final checkpoint validation before returning code to user.

**Key Features**:
- Absolute veto power
- Ensures zero defects
- Validates completeness
- Checks documentation
- Runs comprehensive tests

**When Used**:
- Immediately before code display
- Cannot be skipped
- Automatic invocation
- Last quality gate

**Validation Checklist**:
- ✅ Compiles successfully
- ✅ Zero warnings
- ✅ All tests pass
- ✅ No TODOs or placeholders
- ✅ Documentation complete
- ✅ Security validated

---

### final-reviewer

**Purpose**: Performs final quality assessment and assigns quality scores.

**Key Features**:
- Comprehensive quality scoring
- Detailed assessment report
- Recommendations for improvement
- Sign-off authority
- Quality metrics tracking

**When Used**:
- End of development cycle
- Before release
- For quality audits
- In review workflows

**Scoring Criteria**:
- Code quality: 0-100
- Test coverage: 0-100
- Documentation: 0-100
- Performance: 0-100
- Security: 0-100
- Overall: weighted average

---

### task-assessor

**Purpose**: Validates task completion against specifications and requirements.

**Key Features**:
- Compares implementation to specification
- Verifies all acceptance criteria met
- Checks for scope creep
- Ensures nothing missed
- Sign-off on completion

**When Used**:
- At task completion
- Before marking work done
- In autonomous workflows
- For deliverable validation

**Assessment Areas**:
- Functional requirements met
- Non-functional requirements met
- Edge cases handled
- Error conditions covered
- Documentation complete

---

### security-scanner

**Purpose**: Deep security analysis and vulnerability detection.

**Key Features**:
- Dependency vulnerability scanning
- Code pattern security analysis
- Secrets detection
- OWASP compliance checks
- Security best practices validation

**When Used**:
- Before commits
- In CI/CD pipelines
- Regular security audits
- Before releases

**Scans For**:
- Known CVEs in dependencies
- Hardcoded secrets/credentials
- SQL injection vulnerabilities
- XSS vulnerabilities
- Insecure crypto usage
- Unsafe deserialization
- Path traversal issues

---

### security-review

**Purpose**: Comprehensive security review with detailed analysis.

**Key Features**:
- Manual security review patterns
- Threat modeling
- Attack surface analysis
- Security architecture review
- Compliance validation

**When Used**:
- Security-critical features
- Before production deployment
- Regular security audits
- After security incidents

**Review Process**:
1. Threat identification
2. Vulnerability assessment
3. Risk analysis
4. Mitigation recommendations
5. Compliance verification

---

### performance-analyzer

**Purpose**: Performance profiling and optimization recommendations.

**Key Features**:
- Algorithm complexity analysis
- Memory usage profiling
- Bottleneck identification
- Optimization suggestions
- Performance regression detection

**When Used**:
- Performance-critical code
- After implementation
- Before optimization
- In performance reviews

**Analysis Includes**:
- Time complexity (Big-O)
- Space complexity
- Cache efficiency
- Allocation patterns
- Hot path identification

---

## Language Specialist Agents

### rust-specialist

**Purpose**: Rust language expert ensuring idiomatic, safe, production-ready code.

**Key Features**:
- **Zero-tolerance for panics in production**
- Enforces Result<T, E> pattern
- Clippy perfection (zero warnings)
- Distinguishes production vs test code
- Comprehensive error handling

**Critical Rules**:

**Production Code (FORBIDDEN)**:
```rust
// ❌ NEVER in production
.unwrap()
.expect("message")
panic!("error")
todo!()
unimplemented!()
```

**Production Code (REQUIRED)**:
```rust
// ✅ Always in production
.ok_or(Error::Missing)?
.map_err(Error::from)?
return Err(Error::Invalid)
```

**Test Code (ALLOWED)**:
```rust
// ✅ OK in tests
#[test]
fn test_something() {
    let value = option.unwrap();  // Fine in tests
    assert_eq!(result.expect("test"), expected);
}
```

**Enforcement Checks**:
```bash
# Production safety
find src -name "*.rs" | xargs grep -l "\.unwrap()" | grep -v test

# Clippy perfection
cargo clippy --all-features -- -D warnings

# Zero warnings build
RUSTFLAGS="-D warnings" cargo build --release
```

**When Used**:
- All Rust code operations
- Before any Rust commit
- During code review
- In CI/CD for Rust projects

---

### python-specialist

**Purpose**: Python expert enforcing Pythonic code and modern best practices.

**Key Features**:
- Type safety with mypy strict mode
- Ruff integration (modern linting)
- Complete implementations only
- Async pattern expertise
- Performance optimization

**Critical Rules**:

**Forbidden Patterns**:
```python
# ❌ NEVER
pass  # TODO
raise NotImplementedError()
# type: ignore
print()  # in production
```

**Required Patterns**:
```python
# ✅ Always
def process(data: List[str]) -> ProcessedResult:
    """Complete implementation with type hints."""
    return ProcessedResult(validate(data))
```

**Quality Checks**:
```bash
# Type checking
mypy . --strict

# Linting and formatting
ruff check .
ruff format .

# Testing with coverage
pytest --cov=. --cov-fail-under=85
```

**When Used**:
- All Python code operations
- Before Python commits
- During code review
- In Python projects

---

### data-scientist

**Purpose**: Data analysis, visualization, and ML workflow specialist.

**Key Features**:
- pandas/numpy expertise
- Statistical analysis
- Data visualization (matplotlib, seaborn)
- Machine learning workflows
- SQL and data processing

**Capabilities**:
- CSV/Excel processing
- Statistical modeling
- Predictive analytics
- Data visualization
- Feature engineering
- Model evaluation

**Tools**:
- pandas, numpy, scipy
- scikit-learn
- matplotlib, seaborn
- SQL databases
- Jupyter notebooks

**When Used**:
- Data analysis tasks
- ML model development
- Statistical analysis
- Data visualization
- Research workflows

---

## Testing Agents

### test-agent

**Purpose**: Strict testing enforcement with zero build warnings.

**Key Features**:
- Refuses code with warnings
- Blocks ignored tests
- Ensures ≥80% coverage
- Comprehensive test execution
- Zero tolerance for test failures

**Standards**:
- 100% test pass rate
- Minimum 80% coverage
- No #[ignore] tests
- No skipped tests
- All warnings resolved

**When Used**:
- Before commits
- In autonomous mode
- During development
- In CI/CD pipelines

---

### test-runner

**Purpose**: Executes all tests and ensures 100% pass rate.

**Key Features**:
- Runs complete test suite
- Validates coverage requirements
- Has veto power
- Detailed failure reporting
- Performance tracking

**Test Execution**:
```bash
# Rust
cargo test --all-features --all-targets

# Python
pytest --cov=. --cov-fail-under=85

# TypeScript
npm test
```

**When Used**:
- Before any code delivery
- In quality gates
- During CI/CD
- On demand via /test

---

### test-fixer

**Purpose**: Automatically fixes failing tests.

**Key Features**:
- Analyzes test failures
- Distinguishes test bugs from code bugs
- Fixes test expectations
- Fixes implementation bugs
- Ensures 100% pass rate

**Fix Strategy**:
1. Analyze failure reason
2. Determine if test or code issue
3. Apply appropriate fix
4. Verify fix works
5. Ensure no regressions

**When Used**:
- When tests fail
- In CI/CD failure recovery
- After code changes
- During refactoring

**Note**: Accepts unwrap() in test code, forbidden in production.

---

### test-guardian

**Purpose**: Ensures comprehensive test quality and prevents test skipping.

**Key Features**:
- 100% test pass rate enforcement
- Adequate coverage validation
- Prevents test disabling
- No skipped/ignored tests
- Quality gate enforcement

**Guardian Rules**:
- Tests must pass
- Coverage must meet threshold
- No bypassing tests
- No test modifications to pass
- Must fix root cause

**When Used**:
- During commits
- In quality checks
- Before merges
- In autonomous workflows

---

### test-writer

**Purpose**: Creates comprehensive test suites following TDD.

**Key Features**:
- Writes tests first (TDD)
- Creates failing tests before implementation
- Comprehensive coverage
- Edge case identification
- Integration test creation

**TDD Process**:
1. Write failing test
2. Run test (should fail)
3. Implement minimum code
4. Run test (should pass)
5. Refactor if needed
6. Repeat

**When Used**:
- Before implementation
- For new features
- Bug fix verification
- Refactoring safety

---

### test-designer

**Purpose**: Designs comprehensive test strategies and plans.

**Key Features**:
- Creates test plans
- Defines coverage goals
- Identifies edge cases
- Plans integration tests
- Documents test approach

**Design Outputs**:
- Test strategy document
- Coverage targets
- Edge case catalog
- Integration scenarios
- Performance test plans

**When Used**:
- Beginning of features
- Complex systems
- Quality planning
- Before implementation

---

### test-quality-analyst

**Purpose**: Validates test coverage and quality.

**Key Features**:
- Coverage analysis
- Test quality assessment
- Edge case verification
- TDD compliance validation
- Quality metrics reporting

**Analysis**:
- Line coverage
- Branch coverage
- Edge case coverage
- Integration coverage
- Quality score

**When Used**:
- Before task completion
- In quality reviews
- Coverage validation
- Quality audits

---

### lint-agent

**Purpose**: Detects and fixes code quality issues with zero tolerance.

**Key Features**:
- Language-specific linting
- Automatic fix capability
- Zero warning tolerance
- Style enforcement
- Best practice validation

**Linters Used**:
- Rust: clippy
- Python: ruff
- TypeScript: eslint
- Shell: shellcheck

**When Used**:
- Post-edit
- Pre-commit
- In quality checks
- During code review

---

## Code Management Agents

### code-fixer

**Purpose**: Fixes ALL code issues until 100% production-ready.

**Key Features**:
- Fixes compilation errors
- Resolves test failures
- Eliminates warnings
- Removes TODOs/placeholders
- Replaces mock implementations
- Iterates until perfect

**Fix Categories**:
- Compilation errors
- Type errors
- Linting violations
- Test failures
- Documentation issues
- Performance issues

**Critical Knowledge**:
- unwrap() OK in tests
- unwrap() FORBIDDEN in production
- Must distinguish context

**When Used**:
- When any issues found
- After code review
- Before commits
- In CI/CD recovery

---

### code-reviewer

**Purpose**: Expert code review against specs and standards.

**Key Features**:
- Validates against specifications
- Checks design documents
- Enforces coding standards
- **Rust**: Strictly enforces panic-free production
- Identifies issues early

**Review Checklist**:
- Meets specifications
- Follows design
- Adheres to standards
- Proper error handling
- Complete documentation
- Security validated

**Rust Enforcement**:
- Zero unwrap() in production
- Zero expect() in production
- Proper Result usage
- Zero clippy warnings

**When Used**:
- Before task completion
- After implementation
- During code review
- In quality gates

---

### code-writer

**Purpose**: Implements solutions to make tests pass.

**Key Features**:
- Clean, maintainable code
- Follows specifications
- Makes tests pass
- Proper design patterns
- Complete implementations

**Implementation**:
1. Read specifications
2. Understand tests
3. Implement minimum code
4. Make tests pass
5. Refactor for quality

**When Used**:
- During implementation phase
- After test writing
- For feature development
- In TDD workflow

---

### format-agent

**Purpose**: Intelligent automatic code formatting.

**Key Features**:
- Language detection
- Appropriate formatter selection
- Zero tolerance for style violations
- Automatic application
- Non-blocking execution

**Formatters**:
- Rust: `cargo fmt`
- Python: `ruff format`
- TypeScript/JavaScript: `prettier`
- Go: `gofmt`

**When Used**:
- After every edit
- PostToolUse hook
- Pre-commit
- On demand

---

### dev-agent

**Purpose**: Autonomous development agent implementing production-quality code.

**Key Features**:
- ZERO panics (Rust)
- ZERO warnings (all languages)
- Complete implementations
- TDD workflow
- Must be used in autonomous mode

**Standards**:
- Production-quality only
- No shortcuts
- Complete error handling
- Full documentation
- Comprehensive tests

**When Used**:
- Autonomous development
- Feature implementation
- Complex tasks
- Production code

---

### spec-writer

**Purpose**: Creates detailed technical specifications from requirements.

**Key Features**:
- Breaks down requirements
- Creates acceptance criteria
- Defines implementation plans
- Documents edge cases
- Clear success metrics

**Specification Includes**:
- Functional requirements
- Non-functional requirements
- Acceptance criteria
- Edge cases
- Success metrics
- Implementation approach

**When Used**:
- Before implementation
- For complex features
- Requirements clarification
- Planning phase

---

## CI/CD & Workflow Agents

### ci-cd-validator

**Purpose**: Validates build configurations and CI/CD setup.

**Key Features**:
- Pipeline validation
- Quality gates verification
- Deployment readiness
- Configuration review
- Best practices enforcement

**Validates**:
- GitHub Actions workflows
- Build configurations
- Test execution
- Quality checks
- Deployment scripts

**When Used**:
- CI/CD setup
- Pipeline changes
- Deployment preparation
- Quality audits

---

### ci-monitor

**Purpose**: Real-time CI/CD monitoring and diagnostics.

**Key Features**:
- Workflow monitoring
- Failure detection
- Log analysis
- Root cause identification
- Detailed diagnostics

**Monitoring**:
- GitHub Actions workflows
- Build status
- Test results
- Deployment status
- Performance metrics

**When Used**:
- During CI/CD runs
- Failure investigation
- Performance analysis
- Troubleshooting

---

### workflow-monitor

**Purpose**: Intelligent GitHub Actions monitoring with queue awareness.

**Key Features**:
- Queue-aware monitoring
- Failure pattern recognition
- Automatic delegation to fixers
- Continues until all pass
- Maximum 10 retry attempts

**Monitoring Process**:
1. Track all workflows
2. Detect failures
3. Identify patterns
4. Delegate to appropriate fixer
5. Verify fixes
6. Continue until 100% pass

**When Used**:
- Post-commit
- CI/CD monitoring
- Automatic recovery
- Quality assurance

---

### workflow-fixer

**Purpose**: Automatically fixes CI/CD failures.

**Key Features**:
- Analyzes failure logs
- Applies targeted solutions
- Handles common failures
- Creates fix commits
- Retries verification

**Fix Categories**:
- Compilation errors
- Test failures
- Dependency issues
- Configuration problems
- Environment issues

**When Used**:
- CI/CD failures detected
- By workflow-monitor
- Automatic recovery
- Build failures

---

### dependency-fixer

**Purpose**: Resolves dependency issues and conflicts.

**Key Features**:
- Updates lock files
- Fixes version conflicts
- Ensures proper installation
- Resolves missing dependencies
- Validates compatibility

**Handles**:
- Cargo.toml/Cargo.lock (Rust)
- package.json/package-lock.json (Node)
- requirements.txt/poetry.lock (Python)
- go.mod/go.sum (Go)

**When Used**:
- Dependency conflicts
- Missing dependencies
- Version mismatches
- Lock file issues
- Package management problems

---

## Documentation Agents

### doc-writer

**Purpose**: Creates comprehensive documentation.

**Key Features**:
- API documentation
- Usage examples
- Architecture notes
- Implementation guides
- User documentation

**Documentation Types**:
- API reference
- User guides
- Developer guides
- Architecture docs
- Examples and tutorials

**When Used**:
- After implementation
- Documentation phase
- API changes
- New features

---

### docs-updater

**Purpose**: Updates documentation when code changes and removes stale docs.

**Key Features**:
- Synchronizes with code
- Removes stale documentation
- Updates README
- Maintains API docs
- Cleanup old references

**Update Triggers**:
- Code changes
- API modifications
- Feature additions
- Deprecations
- Refactoring

**When Used**:
- After code changes
- Documentation sync
- Cleanup operations
- Maintenance

---

### documentation-auditor

**Purpose**: Ensures all code is properly documented.

**Key Features**:
- Checks API documentation
- Verifies examples compile
- Validates completeness
- Ensures accuracy
- Quality assessment

**Audit Criteria**:
- All public APIs documented
- Examples provided
- Usage guides current
- No broken links
- Accurate information

**When Used**:
- Before commits
- Quality checks
- Documentation reviews
- Release preparation

---

## Commit Management Agents

### commit-agent

**Purpose**: Autonomous commit orchestration with quality assurance.

**Key Features**:
- Ensures code quality
- Runs all validations
- Coordinates specialists
- Only commits when perfect
- Full agent orchestration

**Validation Flow**:
1. Dynamic assessment
2. Rust quality gates (if Rust)
3. Specialist coordination
4. Agent results assessment
5. Intelligent commit execution
6. CI/CD monitoring
7. Automated fixing (up to 10 iterations)

**Quality Gates**:
- Zero clippy warnings
- Zero build warnings
- All tests passing
- No panic risks
- Proper error handling

**When Used**:
- Replace manual commits
- Autonomous workflows
- Quality-assured commits
- CI/CD integration

---

### commit-analyzer

**Purpose**: Analyzes git changes and creates comprehensive commit messages.

**Key Features**:
- Change analysis
- Conventional commit format
- Clear descriptions
- Context inclusion
- Breaking change detection

**Message Format**:
```
<type>(<scope>): <subject>

<body>

<footer>
```

**When Used**:
- Commit message generation
- Change documentation
- Release notes
- Git history quality

---

### commit-guardian

**Purpose**: Ultimate commit quality gatekeeper.

**Key Features**:
- ZERO defects tolerance
- ZERO warnings tolerance
- ZERO placeholders tolerance
- Blocks bad commits
- Absolute veto power

**Veto Conditions**:
- Any compilation error
- Any warning
- Any failing test
- Any placeholder
- Any incomplete code

**When Used**:
- Pre-commit validation
- Quality gates
- Automated workflows
- Safety checks

---

### commit-validator

**Purpose**: Pre-commit validation specialist.

**Key Features**:
- Tests passing
- Formatting correct
- Security validated
- Branch status checked
- Ready for commit

**Validation Steps**:
1. Run tests
2. Check formatting
3. Security scan
4. Branch verification
5. Approval/rejection

**When Used**:
- Before commits
- In commit workflow
- Quality assurance
- Safety checks

---

### commit-writer

**Purpose**: Intelligent commit message writer.

**Key Features**:
- Analyzes changes
- Creates meaningful messages
- Follows conventions
- Includes context
- References issues

**Best Practices**:
- Conventional Commits format
- Clear subject line
- Detailed body
- Breaking changes noted
- Issue references

**When Used**:
- Commit creation
- Message generation
- Git history quality
- Documentation

---

## Architecture & Orchestration Agents

### master-orchestrator

**Purpose**: Master coordinator for complex multi-step tasks.

**Key Features**:
- Delegates to specialists
- Ensures quality gates
- Coordinates workflow
- Tracks progress
- Reports status

**Orchestration**:
1. Analyze task
2. Create plan
3. Delegate to agents
4. Monitor progress
5. Ensure completion
6. Validate quality

**When Used**:
- Complex tasks
- Multi-step operations
- Quality workflows
- Autonomous mode

---

### meta-agent

**Purpose**: Generates new Claude Code agent configurations.

**Key Features**:
- Creates agent files
- Proper format
- Tool specifications
- Best practices
- Complete documentation

**Agent Template**:
```markdown
---
name: agent-name
description: Purpose
tools: [list]
---

# Agent Name

[Complete agent specification]
```

**When Used**:
- Creating new agents
- Agent development
- Plugin extension
- Custom agents

---

### system-architect

**Purpose**: System design, architecture decisions, technology selection.

**Key Features**:
- Distributed systems expertise
- Microservices design
- Cloud architectures
- Design patterns
- Technical specifications

**Deliverables**:
- Architecture documents
- Technical specifications
- Design decisions
- Technology recommendations
- Implementation plans

**When Used**:
- System design
- Architecture planning
- Technology selection
- Infrastructure planning

---

### steering-updater

**Purpose**: Updates steering documents based on project evolution.

**Key Features**:
- Documentation updates
- Implementation decisions
- Pattern discovery
- Architectural changes
- Context maintenance

**Updates**:
- docs/steering/
- Implementation patterns
- Architectural decisions
- Design evolution
- Best practices

**When Used**:
- Project evolution
- Architecture changes
- Pattern discovery
- Documentation sync

---

### steering-validator

**Purpose**: Validates work against steering documents.

**Key Features**:
- Alignment validation
- Vision compliance
- Architecture adherence
- Standards verification
- Guards against drift

**Validation**:
- Project vision
- Architecture
- Standards
- Conventions
- Best practices

**When Used**:
- Before tasks
- Quality checks
- Alignment verification
- Standards enforcement

---

## Agent Usage Patterns

### Sequential Agent Patterns

```bash
# Quality workflow
1. code-writer → 2. test-writer → 3. code-reviewer → 4. quality-enforcer

# Commit workflow
1. format-agent → 2. lint-agent → 3. test-runner → 4. commit-agent

# CI/CD workflow
1. workflow-monitor → 2. workflow-fixer → 3. test-fixer → 4. workflow-monitor
```

### Parallel Agent Patterns

```bash
# Comprehensive validation (parallel)
- security-scanner
- performance-analyzer
- documentation-auditor
- test-quality-analyst
(All run simultaneously)

# Language specialists (as needed)
- rust-specialist (for Rust)
- python-specialist (for Python)
- data-scientist (for ML)
```

### Autonomous Agent Chains

```bash
# Ultra-commit chain
commit-agent →
  ├─ rust-specialist (if Rust)
  ├─ security-scanner
  ├─ code-reviewer
  ├─ test-agent
  └─ commit-writer
  ↓
workflow-monitor → workflow-fixer (if needed) → workflow-monitor (repeat)
```

---

## Agent Selection Guide

### When to Use Which Agent

**For Quality Assurance:**
- Pre-commit: `commit-guardian`, `pre-return-validator`
- During development: `quality-enforcer`, `build-validator`
- Final validation: `ultra-quality-enforcer`, `final-reviewer`

**For Testing:**
- Write tests: `test-writer`, `test-designer`
- Run tests: `test-runner`, `test-agent`
- Fix tests: `test-fixer`
- Validate tests: `test-guardian`, `test-quality-analyst`

**For Code Quality:**
- Write code: `code-writer`, `dev-agent`
- Review code: `code-reviewer`, `quality-critic`
- Fix code: `code-fixer`
- Format code: `format-agent`, `lint-agent`

**For Language-Specific:**
- Rust: `rust-specialist` (always)
- Python: `python-specialist` (always)
- Data/ML: `data-scientist`

**For CI/CD:**
- Monitor: `ci-monitor`, `workflow-monitor`
- Fix: `workflow-fixer`, `dependency-fixer`
- Validate: `ci-cd-validator`

**For Documentation:**
- Write: `doc-writer`
- Update: `docs-updater`
- Validate: `documentation-auditor`

**For Commits:**
- Orchestrate: `commit-agent`
- Validate: `commit-validator`, `commit-guardian`
- Messages: `commit-writer`, `commit-analyzer`

**For Architecture:**
- Orchestrate: `master-orchestrator`
- Design: `system-architect`
- Create agents: `meta-agent`
- Validate alignment: `steering-validator`
- Update docs: `steering-updater`

---

## Agent Integration

All agents integrate seamlessly through:

1. **Shared Quality Standards**: All enforce the same rules
2. **Consistent Interfaces**: Standard input/output formats
3. **Tool Coordination**: Appropriate tool access
4. **Error Handling**: Consistent error reporting
5. **Status Reporting**: Unified progress updates

For more information, see:
- [Commands Reference](COMMANDS.md)
- [Hooks Guide](HOOKS.md)
- [Configuration](CONFIGURATION.md)
- [Quick Reference](QUICK_REFERENCE.md)
