# Steer - Complete Project Initialization & Documentation Management

Comprehensive project initialization, documentation, and context management system that sets up Claude Code integration and maintains project understanding.

## Usage
```bash
/steer                    # Full init, analysis, and documentation
/steer --update           # Update existing documentation  
/steer --check            # Verify quality and consistency
/steer --hooks-only       # Just ensure hooks are configured
/steer --focus [area]     # Focus on specific area (api|tests|docs|security)
/steer --audit            # Complete project audit
/steer --sync             # Sync all documentation
```

## Core Functions

### 1. Claude Code Initialization (NEW)
```yaml
Actions:
  - Create .claude/ directory structure
  - Configure .claude/settings.json with hooks
  - Set up quality enforcement
  - Initialize specialized agents
  - Configure project-specific rules
```

### 2. Project Analysis
```yaml
Actions:
  - Scan entire codebase
  - Map project structure
  - Identify components
  - Analyze dependencies
  - Document architecture
  - Track technical debt
```

### 3. Documentation Management
```yaml
CRITICAL - Files Created in PROJECT ROOT (not .claude/):
  - ./CLAUDE.md: Project-specific Claude configuration (ROOT)
  - ./STEER.md: Project overview and context (ROOT)
  - ./ARCHITECTURE.md: System design (ROOT)
  
Optional Documentation (also in ROOT):
  - ./API.md: API documentation
  - ./TESTING.md: Test strategy
  - ./SECURITY.md: Security considerations
  - ./PERFORMANCE.md: Performance metrics
  - ./DECISIONS.md: Technical decisions
  - ./ROADMAP.md: Future plans

Configuration Files (in .claude/):
  - .claude/settings.json: Quality configuration
  - .claude/agents/*.md: Specialized agents
  - .claude/commands/*.md: Custom commands
```

### 3. Context Preservation
```yaml
Tracks:
  - Current task status
  - Recent changes
  - Open issues
  - Technical decisions
  - Quality metrics
  - Test coverage
  - Performance baselines
  - Security posture
```

## Agent Orchestration

### Primary Agents
```yaml
steering-validator:
  - Validates documentation completeness
  - Ensures consistency
  - Checks accuracy

steering-updater:
  - Updates documentation
  - Syncs changes
  - Maintains context

documentation-auditor:
  - Audits documentation quality
  - Identifies gaps
  - Suggests improvements

docs-updater:
  - Updates specific docs
  - Maintains formatting
  - Ensures standards
```

### Supporting Agents
```yaml
code-reviewer:
  - Reviews code changes
  - Identifies impact

test-quality-analyst:
  - Analyzes test coverage
  - Reports quality metrics

security-scanner:
  - Security assessment
  - Vulnerability tracking

performance-analyzer:
  - Performance profiling
  - Optimization suggestions
```

## Documentation Structure

### CLAUDE.md Template (MUST BE IN PROJECT ROOT)
```markdown
# CLAUDE.md - Project Configuration

## Project Context
[Project name and description]

## Claude Code Integration ✅
- Hooks: Inherited from ~/.claude/settings.json (no duplication)
- Quality Mode: Ultra-Strict
- Specialized Agents: Active
- Project-specific overrides: Use .claude/settings.local.json if needed

## Project-Specific Rules
[Any special patterns or requirements for this project]

## Quality Standards
- Compilation: Zero errors, zero warnings
- Testing: [Coverage requirement]%
- Documentation: 100% public APIs
- Security: [Security level]

## Available Commands
- `/steer` - Project analysis and documentation
- `/orchestrate` - Task orchestration
- `/commit` - Smart commits
- `/test` - Run tests with coverage

## Notes
[Project-specific notes and context]
```

### STEER.md Template (MUST BE IN PROJECT ROOT)
```markdown
# Project: [Name]
Last Updated: [Date]
Version: [Version]

## Overview
[Project description and purpose]

## Architecture
[High-level architecture summary]

## Current State
- Active Features: [List]
- In Progress: [List]
- Planned: [List]

## Quality Metrics
- Test Coverage: [%]
- Build Status: [Status]
- Security Score: [Score]
- Performance: [Metrics]

## Recent Changes
[Chronological list of significant changes]

## Technical Decisions
[Key decisions and rationale]

## Known Issues
[Current problems and planned fixes]

## Dependencies
[External and internal dependencies]

## Team Context
[Relevant team information]
```

### ARCHITECTURE.md Template
```markdown
# System Architecture

## Overview
[System design philosophy]

## Components
[Component descriptions and interactions]

## Data Flow
[How data moves through the system]

## Technology Stack
- Languages: [List]
- Frameworks: [List]
- Databases: [List]
- Infrastructure: [List]

## Design Patterns
[Patterns used and why]

## Scalability
[Scalability considerations]

## Security
[Security architecture]

## Diagrams
[Architecture diagrams]
```

## Execution Workflow

### Phase 0: Initialize Claude Code (NEW)
```bash
# Create .claude directory structure if not exists
mkdir -p .claude/{agents,commands,hooks,logs,specs,templates,workflows}

# DO NOT copy settings.json to avoid duplication of hooks
# Projects will inherit from ~/.claude/settings.json automatically
# Only create .claude/settings.local.json if project needs specific overrides

# CRITICAL: Set working directory for file creation
# All documentation files MUST be created in PROJECT ROOT
# Use absolute paths: $(pwd)/CLAUDE.md, $(pwd)/STEER.md
```

### Phase 1: Discovery
```bash
# Scan project structure
find . -type f -name "*.rs" -o -name "*.py" -o -name "*.ts" | head -20

# Analyze dependencies
cargo tree 2>/dev/null || pip list 2>/dev/null || npm list 2>/dev/null

# Check existing documentation
ls -la *.md

# Review recent commits
git log --oneline -10
```

### Phase 2: Analysis
```yaml
Actions:
  - Parse code structure
  - Extract API definitions
  - Map component relationships
  - Identify patterns
  - Detect anti-patterns
  - Calculate metrics
```

### Phase 3: Documentation Generation
```yaml
CRITICAL FILE LOCATIONS:
  Root Directory Files (MUST use absolute paths):
    - $(pwd)/CLAUDE.md - Project-specific Claude configuration
    - $(pwd)/STEER.md - Project overview and metrics
    - $(pwd)/ARCHITECTURE.md - System design (if needed)
    
  .claude Directory Files:
    - .claude/settings.json - Quality configuration
    - .claude/agents/*.md - Specialized agents

Generate:
  - CLAUDE.md with project-specific rules (IN ROOT)
  - STEER.md with project overview (IN ROOT)  
  - API documentation from code
  - Test documentation from test files
  - Architecture from structure
  - Decisions from git history
  - Metrics from analysis
```

### Phase 4: Validation
```yaml
Verify:
  - Documentation accuracy
  - Completeness check
  - Consistency validation
  - Format verification
  - Link validation
```

### Phase 5: Integration
```yaml
Update:
  - README.md with current info
  - CHANGELOG.md with recent changes
  - CONTRIBUTING.md with standards
  - Wiki or external docs
```

## Quality Checks

### Documentation Standards
```yaml
Required Sections:
  - Overview/Purpose
  - Installation/Setup
  - Usage Examples
  - API Reference
  - Configuration
  - Testing
  - Troubleshooting
  - Contributing

Quality Criteria:
  - Clear and concise
  - Up-to-date
  - Technically accurate
  - Well-formatted
  - Properly linked
  - Version controlled
```

### Consistency Validation
```yaml
Check:
  - Naming conventions
  - Code style consistency
  - Documentation style
  - Comment formatting
  - Version numbering
  - Date formats
```

## Focus Areas

### --focus api
```yaml
Analyzes:
  - API endpoints
  - Request/response formats
  - Authentication
  - Rate limiting
  - Error codes
  - Examples
```

### --focus tests
```yaml
Analyzes:
  - Test coverage
  - Test types
  - Test performance
  - Flaky tests
  - Missing tests
  - Test documentation
```

### --focus docs
```yaml
Analyzes:
  - Documentation coverage
  - Outdated sections
  - Missing documentation
  - Broken links
  - Formatting issues
  - Examples accuracy
```

### --focus security
```yaml
Analyzes:
  - Security vulnerabilities
  - Authentication/Authorization
  - Data validation
  - Encryption usage
  - Security headers
  - Audit logs
```

## Audit Mode (--audit)

### Comprehensive Project Audit
```yaml
Checks:
  - Code Quality:
    - Complexity metrics
    - Duplication
    - Code smells
    - Technical debt
    
  - Testing:
    - Coverage gaps
    - Test quality
    - Performance tests
    - Security tests
    
  - Documentation:
    - Completeness
    - Accuracy
    - Clarity
    - Examples
    
  - Security:
    - Vulnerabilities
    - Best practices
    - Compliance
    
  - Performance:
    - Bottlenecks
    - Optimization opportunities
    - Resource usage
    
  - Dependencies:
    - Outdated packages
    - Security issues
    - License compliance
```

## Sync Mode (--sync)

### Documentation Synchronization
```yaml
Syncs:
  - Code comments → Documentation
  - Test names → Test documentation
  - API changes → API docs
  - Config changes → Setup docs
  - Schema changes → Data docs
```

## Output Formats

### Standard Report
```
STEER ANALYSIS COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Project: awesome-project
Version: 1.2.3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Documentation:
  ✅ STEER.md (updated)
  ✅ ARCHITECTURE.md (current)
  ✅ API.md (generated)
  ⚠️ TESTING.md (outdated)
  ❌ SECURITY.md (missing)
  
Quality Metrics:
  Code Coverage: 84%
  Documentation: 78%
  Complexity: Low
  Tech Debt: 12 hours
  
Recommendations:
  1. Update TESTING.md with new test cases
  2. Create SECURITY.md documentation
  3. Add examples to API.md
  4. Document error handling patterns
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Files Updated: 3
Files Created: 1
Issues Found: 2
```

### Audit Report
```
PROJECT AUDIT REPORT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Critical Issues: 0
High Priority: 2
Medium Priority: 5
Low Priority: 12
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Details:
[Detailed findings with recommendations]
```

## Integration with Other Commands

### With /orchestrate
```bash
# Automatically called after task completion
/orchestrate "implement feature" 
# → Triggers /steer --update afterwards
```

### With /commit
```bash
# Updates CHANGELOG before commit
/commit feat "new feature"
# → Updates documentation first
```

### With /test
```bash
# Updates test documentation
/test --all
# → Updates TESTING.md with results
```

## CRITICAL: File Creation Guidelines

### MUST Follow These Rules
1. **CLAUDE.md** - ALWAYS create in project root: `./CLAUDE.md` or `$(pwd)/CLAUDE.md`
2. **STEER.md** - ALWAYS create in project root: `./STEER.md` or `$(pwd)/STEER.md`  
3. **settings.json** - Create in `.claude/settings.json` (subdirectory)
4. **Agents** - Create in `.claude/agents/*.md` (subdirectory)

### Common Mistakes to Avoid
- ❌ Creating CLAUDE.md in .claude/CLAUDE.md (WRONG)
- ❌ Creating STEER.md in .claude/STEER.md (WRONG)
- ✅ Creating CLAUDE.md in ./CLAUDE.md (CORRECT)
- ✅ Creating STEER.md in ./STEER.md (CORRECT)

## Best Practices

1. **Run on new projects**: Initialize with `/steer` first
2. **Run regularly**: At least daily on active projects
3. **Update on changes**: After significant modifications
4. **Audit weekly**: Full audit once per week
5. **Sync before release**: Ensure docs are current
6. **Focus strategically**: Deep dive when needed
7. **Version control**: Commit documentation changes
8. **Team review**: Share audit reports

## Configuration

### .steerrc (Optional)
```json
{
  "updateFrequency": "on-change",
  "documentationStandard": "strict",
  "auditSchedule": "weekly",
  "focusAreas": ["api", "security"],
  "outputFormat": "markdown",
  "integrations": {
    "wiki": true,
    "confluence": false,
    "notion": false
  },
  "qualityThresholds": {
    "coverage": 80,
    "documentation": 90,
    "complexity": 10
  }
}
```

## Remember

Steer is your project's memory and documentation brain. It ensures:
- Nothing is forgotten
- Documentation stays current
- Quality is tracked
- Context is preserved
- Knowledge is shared

Keep your project well-steered!
