# Contributing to Claude Ultra Quality Enforcement Plugin

First off, thank you for considering contributing to this project! It's people like you that make this plugin better for everyone.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Quality Standards](#quality-standards)
- [Pull Request Process](#pull-request-process)
- [Style Guidelines](#style-guidelines)
- [Agent Development](#agent-development)
- [Command Development](#command-development)
- [Hook Development](#hook-development)

## Code of Conduct

### Our Pledge

We are committed to providing a welcoming and inspiring community for all. Please be respectful and constructive in all interactions.

### Our Standards

**Positive behaviors include:**
- Using welcoming and inclusive language
- Being respectful of differing viewpoints
- Gracefully accepting constructive criticism
- Focusing on what is best for the community
- Showing empathy towards other community members

**Unacceptable behaviors include:**
- Trolling, insulting/derogatory comments, and personal attacks
- Public or private harassment
- Publishing others' private information without permission
- Other conduct which could reasonably be considered inappropriate

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues to avoid duplicates. When creating a bug report, include:

- **Clear title and description**
- **Steps to reproduce** the behavior
- **Expected behavior** vs actual behavior
- **Screenshots** if applicable
- **Environment details** (OS, Claude Code version, etc.)
- **Additional context** that might be helpful

**Bug Report Template:**

```markdown
### Description
[Clear description of the bug]

### Steps to Reproduce
1.
2.
3.

### Expected Behavior
[What you expected to happen]

### Actual Behavior
[What actually happened]

### Environment
- OS: [e.g., macOS 14.5]
- Claude Code Version: [e.g., 1.2.0]
- Plugin Version: [e.g., 1.0.0]

### Additional Context
[Any other relevant information]
```

### Suggesting Enhancements

Enhancement suggestions are welcome! Please include:

- **Clear title and description**
- **Use case** for the enhancement
- **Current behavior** vs desired behavior
- **Why this enhancement would be useful** to most users
- **Possible implementation** ideas (optional)

### Your First Code Contribution

Unsure where to begin? Look for issues tagged with:

- `good-first-issue` - Simple issues perfect for newcomers
- `help-wanted` - Issues where we need community help
- `documentation` - Documentation improvements

### Pull Requests

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes following our standards
4. Push to your fork (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Development Setup

### Prerequisites

- Claude Code installed
- Git
- For Rust development: Rust toolchain (rustc, cargo, clippy, rustfmt)
- For Python development: Python 3.8+, ruff, mypy
- For shell scripts: Bash 4.0+

### Local Development

```bash
# Clone the repository
git clone https://github.com/dirvine/claude-plugins.git
cd claude-plugins

# Install as development plugin
cp -r . ~/.claude/plugins/ultra-quality-dev

# Enable the development plugin
/plugin enable ultra-quality-dev

# Make changes and test
# Restart Claude Code to reload changes
```

### Testing Your Changes

```bash
# Test agents
./tests/test_agents.sh

# Test commands
./tests/test_commands.sh

# Test hooks
./tests/test_hooks.sh

# Run all tests
./tests/run_all_tests.sh
```

## Quality Standards

**This plugin enforces strict quality standards on itself!**

All contributions must meet these requirements:

### Code Quality
- ✅ Zero compilation errors
- ✅ Zero warnings (language-specific linters)
- ✅ All tests passing
- ✅ No forbidden patterns
- ✅ Complete implementations (no TODOs or placeholders)
- ✅ Proper error handling
- ✅ Comprehensive documentation

### Testing
- ✅ New features must include tests
- ✅ Bug fixes must include regression tests
- ✅ Maintain minimum 85% coverage
- ✅ All tests must pass

### Documentation
- ✅ All public functions/agents/commands documented
- ✅ Usage examples provided
- ✅ README updated if needed
- ✅ CHANGELOG.md updated

### Specific Language Standards

#### Bash Scripts
```bash
# Use strict mode
set -e  # Exit on error
set -u  # Error on undefined variables
set -o pipefail  # Catch errors in pipes

# Include documentation
# Description: What this script does
# Usage: ./script.sh [arguments]

# Use meaningful variable names
# Include error handling
# Add logging where appropriate
```

#### Python
```python
# Type hints required
def process_data(data: List[str]) -> ProcessedResult:
    """Process and validate data.

    Args:
        data: List of strings to process

    Returns:
        ProcessedResult with validated data

    Raises:
        ValueError: If data is invalid
    """
    pass

# No placeholders allowed
# No raise NotImplementedError in production code
# Use proper logging instead of print()
```

#### Markdown (Agents/Commands)
```markdown
---
name: agent-name
description: Clear, concise description
tools: [list, of, allowed, tools]
version: 1.0.0
---

# Agent/Command Name

Clear description of what this does.

## Usage

Examples of how to use this.

## Parameters

Description of parameters if applicable.

## Output

Description of expected output.
```

## Pull Request Process

### Before Submitting

1. **Test thoroughly** - All tests must pass
2. **Update documentation** - Reflect your changes
3. **Follow style guidelines** - Consistent with existing code
4. **Write clear commit messages** - Following Conventional Commits
5. **Add CHANGELOG entry** - Document your changes

### Commit Message Format

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

**Examples:**

```
feat(agents): add performance-optimizer agent

Added new agent for automated performance optimization analysis.
Includes profiling integration and bottleneck detection.

Closes #123
```

```
fix(hooks): resolve pre-commit check for nested test files

Fixed issue where pre-commit hook incorrectly flagged test files
in nested directories as production code.

Fixes #456
```

### PR Description Template

```markdown
## Description
[Clear description of changes]

## Motivation and Context
[Why is this change needed? What problem does it solve?]

## How Has This Been Tested?
[Describe testing performed]

## Types of Changes
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to change)
- [ ] Documentation update

## Checklist
- [ ] My code follows the code style of this project
- [ ] I have updated the documentation accordingly
- [ ] I have added tests to cover my changes
- [ ] All new and existing tests passed
- [ ] I have updated the CHANGELOG.md
- [ ] My changes generate no new warnings
```

### Review Process

1. **Automated checks** run on every PR
2. **Maintainer review** typically within 48 hours
3. **Address feedback** from reviewers
4. **Approval** from at least one maintainer required
5. **Merge** by maintainer after approval

## Style Guidelines

### File Organization

```
claude-plugins/
├── agents/
│   ├── quality/         # Quality enforcement agents
│   ├── language/        # Language specialists
│   ├── workflow/        # Workflow automation
│   └── specialized/     # Specialized agents
├── commands/
│   ├── core/            # Essential commands
│   ├── quality/         # Quality-related commands
│   ├── dev/             # Development commands
│   └── specialized/     # Specialized commands
├── hooks/               # Event hooks
├── docs/                # Documentation
├── tests/               # Test scripts
└── examples/            # Usage examples
```

### Naming Conventions

- **Agents**: `kebab-case.md` (e.g., `rust-specialist.md`)
- **Commands**: `kebab-case.md` (e.g., `ultra-commit.md`)
- **Hooks**: `kebab-case.sh/.py` (e.g., `pre-commit-check.sh`)
- **Variables**: `UPPER_SNAKE_CASE` for constants, `snake_case` for variables

## Agent Development

### Agent Structure

```markdown
---
name: agent-name
description: One-line description of what this agent does
tools: [list, of, tools, this, agent, can, use]
version: 1.0.0
---

# Agent Name

Detailed description of the agent's purpose and capabilities.

## Purpose

Why this agent exists and what problems it solves.

## Responsibilities

- Clear list of responsibilities
- What this agent does
- What it doesn't do

## Usage

### Direct Invocation
```bash
/command that uses this agent
```

### Automatic Invocation
When this agent is automatically called.

## Examples

Concrete examples of this agent in action.

## Integration

How this agent integrates with others.

## Quality Standards

Any specific quality requirements this agent enforces.
```

### Agent Best Practices

1. **Single Responsibility** - Each agent should have one clear purpose
2. **Clear Documentation** - Users should understand what the agent does
3. **Proper Tool Access** - Only request tools the agent actually needs
4. **Error Handling** - Handle errors gracefully with helpful messages
5. **Integration** - Consider how the agent works with others

## Command Development

### Command Structure

```markdown
---
allowed-tools: [List, Of, Tools]
description: One-line description
---

# Command Name

Detailed description of what this command does.

## Usage

```bash
/command-name [arguments]
```

## Arguments

- `arg1`: Description of first argument
- `arg2`: Description of second argument

## Examples

```bash
# Example 1
/command-name basic

# Example 2
/command-name --advanced
```

## Output

Description of expected output.

## Related Commands

- `/other-command` - Related functionality
```

### Command Best Practices

1. **Clear Purpose** - Obvious what the command does
2. **Good Defaults** - Works well without arguments
3. **Helpful Output** - Clear, actionable feedback
4. **Error Messages** - Specific about what went wrong
5. **Documentation** - Complete usage examples

## Hook Development

### Hook Structure

```bash
#!/bin/bash
# Hook Name - Brief description
#
# Event: Which event triggers this hook
# Purpose: What this hook accomplishes

set -e  # Exit on error
set -u  # Error on undefined
set -o pipefail  # Catch pipe errors

# Configuration
HOOK_NAME="hook-name"
LOG_FILE="$HOME/.claude/logs/${HOOK_NAME}.log"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Main logic
main() {
    # Read hook data from stdin
    HOOK_DATA=$(cat)

    # Your hook logic here

    # Exit successfully
    exit 0
}

main
```

### Hook Best Practices

1. **Robust Error Handling** - Never crash unexpectedly
2. **Non-Blocking** - Complete quickly or run async
3. **Clear Logging** - Log enough for debugging
4. **Timeout Awareness** - Respect configured timeouts
5. **Idempotent** - Can be run multiple times safely

## Questions?

- **Documentation**: Check the `docs/` directory
- **Issues**: [GitHub Issues](https://github.com/dirvine/claude-plugins/issues)
- **Discussions**: [GitHub Discussions](https://github.com/dirvine/claude-plugins/discussions)

## Recognition

Contributors will be recognized in:
- README.md Contributors section
- CHANGELOG.md for their contributions
- Release notes when applicable

Thank you for contributing! 🎉

---

*Remember: Quality is not an act, it is a habit.* - Aristotle
