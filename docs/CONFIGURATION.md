# Configuration Guide

Advanced configuration guide for the Claude Ultra Quality Enforcement Plugin.

## Quick Start

The plugin works out of the box with sensible defaults. No configuration required for basic use!

## Configuration Files

### Plugin Configuration

**File**: `.claude-plugin/marketplace.json`  
**Purpose**: Plugin manifest and hook configuration  
**Scope**: Plugin-wide settings

### Local Overrides

**File**: `.claude/settings.local.json` (in your project)  
**Purpose**: Project-specific overrides  
**Scope**: Current project only

## Plugin Manifest

Complete `marketplace.json` structure:

```json
{
  "name": "claude-ultra-quality-enforcement",
  "version": "1.0.0",
  "description": "Ultra-strict quality enforcement plugin",
  "author": {...},
  "commands": ["./commands/core/", ...],
  "agents": ["./agents/quality/", ...],
  "hooks": {...},
  "requirements": {...}
}
```

## Hook Configuration

### Auto-Format Hook

```json
{
  "PostToolUse": [{
    "matcher": "tool_name in ['Edit', 'Write', 'MultiEdit']",
    "hooks": [{
      "type": "command",
      "command": "${CLAUDE_PLUGIN_ROOT}/hooks/auto-format.sh",
      "timeout": 30
    }]
  }]
}
```

**Customization**:
- Change `timeout` for longer formatting operations
- Modify `matcher` to target specific file types
- Add additional hooks for custom formatting

### Pre-Commit Hook

```json
{
  "PreToolUse": [{
    "matcher": "tool_name == 'Bash' and 'git commit' in parameters.get('command', '')",
    "hooks": [{
      "type": "command",
      "command": "${CLAUDE_PLUGIN_ROOT}/hooks/pre-commit-check.sh",
      "timeout": 60
    }]
  }]
}
```

**Customization**:
- Increase `timeout` for large projects
- Add project-specific validation hooks
- Configure quality thresholds in hook script

### Notification Hooks

```json
{
  "SessionStart": [{
    "matcher": "",
    "hooks": [{
      "type": "command",
      "command": "CLAUDE_HOOK_TYPE=SessionStart ${CLAUDE_PLUGIN_ROOT}/hooks/notify.py",
      "timeout": 10
    }]
  }]
}
```

**Customization**:
- Disable specific event notifications
- Customize notification messages
- Change notification sounds

## Quality Standards

### Default Standards

The plugin enforces these standards by default:

```json
{
  "quality": {
    "compilation": {
      "errors": 0,
      "warnings": 0,
      "required": true
    },
    "testing": {
      "passRate": 100,
      "minCoverage": 85,
      "required": true
    },
    "linting": {
      "warnings": 0,
      "required": true
    },
    "security": {
      "vulnerabilities": 0,
      "required": true
    },
    "documentation": {
      "publicAPIs": 100,
      "required": true
    }
  }
}
```

### Rust-Specific

```json
{
  "rust": {
    "forbiddenPatterns": [
      ".unwrap()",
      ".expect(",
      "panic!(",
      "todo!()",
      "unimplemented!()"
    ],
    "productionOnly": true,
    "testsAllowed": true,
    "clippyWarnings": "deny"
  }
}
```

### Python-Specific

```json
{
  "python": {
    "forbiddenPatterns": [
      "pass  # TODO",
      "raise NotImplementedError",
      "# type: ignore"
    ],
    "minCoverage": 85,
    "typeChecking": "strict"
  }
}
```

### TypeScript-Specific

```json
{
  "typescript": {
    "forbiddenPatterns": [
      ": any",
      "@ts-ignore",
      "console.log"
    ],
    "strictMode": true,
    "maxWarnings": 0
  }
}
```

## Project Overrides

Create `.claude/settings.local.json` in your project:

```json
{
  "quality": {
    "testing": {
      "minCoverage": 90
    }
  },
  "hooks": {
    "auto-format": {
      "enabled": true,
      "languages": ["rust", "python"]
    }
  }
}
```

## Environment Variables

The plugin respects these environment variables:

```bash
# Quality enforcement
CLAUDE_STRICT_MODE=true
CLAUDE_NO_PLACEHOLDERS=true
CLAUDE_REQUIRE_TESTS=true

# Rust-specific
RUSTFLAGS="-D warnings"

# Python-specific
PYTEST_ARGS="--cov=. --cov-fail-under=85"
```

## Agent Configuration

Agents are configured via frontmatter in their markdown files:

```markdown
---
name: agent-name
description: What this agent does
tools: [list, of, allowed, tools]
version: 1.0.0
---

# Agent content...
```

## Command Configuration

Commands use frontmatter for tool permissions:

```markdown
---
allowed-tools: [Read, Write, Bash]
description: Command description
---

# Command content...
```

## Best Practices

### Development

```json
{
  "hooks": {
    "auto-format": true,
    "pre-commit": true,
    "notify": true
  },
  "quality": {
    "strict": true,
    "coverage": 85
  }
}
```

### Production

```json
{
  "hooks": {
    "pre-commit": true
  },
  "quality": {
    "strict": true,
    "coverage": 90,
    "security": "strict"
  }
}
```

## Troubleshooting

### Hook Not Running

1. Check `.claude-plugin/marketplace.json` syntax
2. Verify hook file permissions (`chmod +x`)
3. Check hook matcher condition
4. Review debug logs in `~/.claude/logs/`

### Quality Checks Too Strict

1. Review quality standards in hook scripts
2. Adjust coverage thresholds
3. Configure project-specific overrides
4. Ensure tests are comprehensive

### Performance Issues

1. Increase hook timeouts
2. Optimize quality checks
3. Cache build artifacts
4. Run expensive checks conditionally

## Advanced Topics

### Custom Quality Thresholds

Edit `hooks/pre-commit-check.sh`:

```bash
# Customize coverage requirement
MIN_COVERAGE=90  # Default: 85

# Customize complexity limits
MAX_COMPLEXITY=10  # Per function

# Customize line length
MAX_LINE_LENGTH=100
```

### Language-Specific Overrides

Create language-specific hooks:

```json
{
  "PostToolUse": [{
    "matcher": "parameters.get('file_path', '').endswith('.rs')",
    "hooks": [{
      "command": "${CLAUDE_PLUGIN_ROOT}/hooks/rust-specific.sh"
    }]
  }]
}
```

### Conditional Hooks

Run hooks only in specific contexts:

```json
{
  "matcher": "tool_name == 'Write' and 'src/' in parameters.get('file_path', '')"
}
```

For more information, see:
- [Agents Reference](AGENTS.md)
- [Commands Reference](COMMANDS.md)
- [Hooks Guide](HOOKS.md)
- [Quick Reference](QUICK_REFERENCE.md)
