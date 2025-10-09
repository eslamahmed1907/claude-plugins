# Quick Reference

## 📊 Contents Summary

### Agents (46 total)

#### Quality Enforcement (11)
- build-validator - Build verification
- quality-enforcer - Quality guardian
- quality-enforcer-strict - Strict enforcement
- ultra-quality-enforcer - Ultimate quality gate
- quality-critic - Quality review
- pre-return-validator - Final checkpoint
- final-reviewer - Final assessment
- task-assessor - Task validation
- security-scanner - Security validation
- security-review - Comprehensive security analysis
- performance-analyzer - Performance optimization

#### Language Specialists (3)
- rust-specialist - Rust expert (panic-free production)
- python-specialist - Python best practices
- data-scientist - Data analysis & ML

#### Testing (8)
- test-agent - Strict testing with zero warnings
- test-runner - Test execution
- test-fixer - Automatic test fixing
- test-guardian - Test quality enforcement
- test-writer - Test suite creation
- test-designer - Test strategy design
- test-quality-analyst - Coverage analysis
- lint-agent - Linting enforcement

#### Code Management (6)
- code-fixer - Fix compilation and code issues
- code-reviewer - Code quality assessment
- code-writer - Clean code implementation
- format-agent - Code formatting
- dev-agent - Autonomous development (TDD)
- spec-writer - Technical specifications

#### CI/CD & Workflow (5)
- ci-cd-validator - Pipeline validation
- ci-monitor - Real-time CI monitoring
- workflow-monitor - GitHub Actions monitoring
- workflow-fixer - Automatic CI/CD fixing
- dependency-fixer - Dependency resolution

#### Documentation (3)
- doc-writer - Documentation creation
- docs-updater - Documentation synchronization
- documentation-auditor - Documentation completeness

#### Commit Management (6)
- commit-agent - Autonomous commit orchestration
- commit-analyzer - Commit analysis
- commit-guardian - Commit quality gate
- commit-validator - Pre-commit validation
- commit-writer - Intelligent commit messages

#### Architecture & Orchestration (5)
- master-orchestrator - Complex task coordination
- meta-agent - Agent configuration generation
- system-architect - System design & architecture
- steering-updater - Update steering documents
- steering-validator - Validate against steering

### Commands (23 total)

#### Core (9)
- /orchestrate - Multi-step task orchestration
- /orchestrate-status - Check orchestration status
- /start-orchestrate - Begin orchestrated workflow
- /steer - Project documentation and analysis
- /git_status - Enhanced git status
- /cleanup - Repository cleanup
- /archive-project - Archive completed project
- /complete-project - Mark project complete
- /debug-tokens - Debug token usage

#### Quality (3)
- /quality-check - Full quality validation
- /security - Comprehensive security audit
- /test - Advanced test execution

#### Development (7)
- /ultra-dev - Complete development workflow
- /ultra-commit - Quality-assured commits
- /review-design - Review system design
- /review-spec - Review specifications
- /review-tasks - Review task completion
- /spec - Specification creation
- /tdd - Test-driven development

#### Specialized (4)
- /fix-ci - CI/CD failure resolution
- /fix-deps - Dependency issue fixing
- /fix-tests - Test failure fixing
- /tests - Test management

### Hooks (3 total)

#### auto-format.sh
- **Trigger**: PostToolUse (Edit, Write, MultiEdit)
- **Purpose**: Automatic code formatting
- **Languages**: Rust (cargo fmt), Python (ruff), TypeScript/JavaScript (prettier), Go (gofmt)
- **Timeout**: 30 seconds
- **Blocking**: No (runs in background)

#### pre-commit-check.sh
- **Trigger**: PreToolUse (git commit)
- **Purpose**: Quality validation before commits
- **Checks**: Compilation, linting, tests, forbidden patterns, formatting
- **Timeout**: 60 seconds
- **Blocking**: Yes (blocks on quality issues)

#### notify.py
- **Trigger**: SessionStart, Stop, SubagentStop
- **Purpose**: Audio/visual notifications
- **Timeout**: 10 seconds
- **Blocking**: No

## 🚀 Quick Start Examples

### Commit with Quality
```bash
/ultra-commit
```

### Full Development Workflow
```bash
/ultra-dev "implement new feature"
```

### Security Audit
```bash
/security
```

### Test Everything
```bash
/test --all --strict
```

### Fix CI/CD Issues
```bash
/fix-ci
```

## 🎯 Common Workflows

### New Feature Development
```bash
1. /spec "feature description"     # Create specification
2. /tdd                            # Test-driven development
3. /ultra-commit                   # Quality commit
4. /security                       # Security check
```

### Bug Fix
```bash
1. /test --identify-failure        # Find failing test
2. /fix-tests                      # Fix the tests/code
3. /ultra-commit "fix: ..."        # Commit fix
```

### Code Review
```bash
1. /quality-check                  # Check all quality
2. /security                       # Security audit
3. /review-spec                    # Review against spec
```

### Project Management
```bash
1. /steer                          # Analyze project
2. /orchestrate-status             # Check progress
3. /complete-project               # Mark complete
4. /archive-project                # Archive work
```

## 📝 Quality Standards

### Rust
- ❌ `.unwrap()`, `.expect()`, `panic!()` in production
- ✅ `Result<T, E>` and `?` operator
- ✅ Zero clippy warnings
- ✅ Zero compiler warnings
- ✅ 100% test pass rate

### Python
- ❌ `pass # TODO`, `raise NotImplementedError`, `# type: ignore`
- ✅ Complete implementations
- ✅ Type hints (mypy strict)
- ✅ Ruff format and check
- ✅ 85%+ test coverage

### TypeScript
- ❌ `any` type, `@ts-ignore`, `console.log`
- ✅ Proper typing
- ✅ ESLint zero warnings
- ✅ Prettier formatting
- ✅ All tests passing

---

For detailed documentation, see:
- [Agents Reference](AGENTS.md) - Complete agent documentation
- [Commands Reference](COMMANDS.md) - All slash commands
- [Hooks Guide](HOOKS.md) - Hook configuration
- [Configuration](CONFIGURATION.md) - Advanced settings
