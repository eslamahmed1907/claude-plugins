# Hooks Reference

Complete guide to the 3 automatic hooks in the Claude Ultra Quality Enforcement Plugin.

## Table of Contents

- [Overview](#overview)
- [auto-format.sh](#auto-formatsh) - Post-edit formatting
- [pre-commit-check.sh](#pre-commit-checksh) - Pre-commit validation
- [notify.py](#notifypy) - Event notifications
- [Hook Configuration](#hook-configuration)
- [Custom Hooks](#custom-hooks)
- [Troubleshooting](#troubleshooting)

## Overview

Hooks are automatic event handlers that execute at specific points in your workflow. This plugin includes 3 production-ready hooks that enforce quality standards automatically.

### Hook Types

| Hook | Trigger | Purpose | Blocking | Timeout |
|------|---------|---------|----------|---------|
| auto-format.sh | PostToolUse (Edit/Write) | Auto-format code | No | 30s |
| pre-commit-check.sh | PreToolUse (git commit) | Quality validation | Yes | 60s |
| notify.py | Session events | Notifications | No | 10s |

### Hook Execution Flow

```
User Action (Edit/Write/Commit)
  ↓
Hook Matcher Evaluated
  ↓
Match? → YES → Execute Hook
  ↓              ↓
  NO           Blocking?
  ↓              ↓
Continue     YES → Wait for result
               ↓
             Exit 0? → Continue
             Exit 1? → Block action
```

---

## auto-format.sh

**File**: `hooks/auto-format.sh`  
**Trigger**: `PostToolUse` on Edit, Write, MultiEdit  
**Purpose**: Automatically format code after file modifications  
**Blocking**: No (runs in background)  
**Timeout**: 30 seconds

### Supported Languages

| Language | Formatter | Command |
|----------|-----------|---------|
| Rust | cargo fmt | `cargo fmt -- <file>` |
| Python | ruff | `ruff format <file>` |
| TypeScript/JavaScript | prettier | `prettier --write <file>` |
| Go | gofmt | `gofmt -w <file>` |
| JSON/YAML/Markdown | prettier | `prettier --write <file>` |

### How It Works

1. **Hook Triggered**: After Edit, Write, or MultiEdit tool use
2. **File Detection**: Extracts file path from hook data
3. **Extension Check**: Determines file type
4. **Formatter Selection**: Chooses appropriate formatter
5. **Format Execution**: Runs formatter on the file
6. **Logging**: Records operation to debug log

### Configuration

Located in `.claude-plugin/marketplace.json`:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "tool_name in ['Edit', 'Write', 'MultiEdit']",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PLUGIN_ROOT}/hooks/auto-format.sh",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

### Detailed Behavior

#### Rust Formatting
```bash
# For any .rs file
cargo fmt -- /path/to/file.rs

# Only runs if:
# - File is in a Cargo project (Cargo.toml exists)
# - cargo is installed
# - File exists
```

#### Python Formatting
```bash
# For any .py file
ruff format /path/to/file.py

# Fallback if ruff not available:
black /path/to/file.py

# Only runs if formatter is installed
```

#### TypeScript/JavaScript Formatting
```bash
# For .ts, .tsx, .js, .jsx, .json, .md, .yml, .yaml
prettier --write /path/to/file

# Only runs if prettier is installed
```

#### Go Formatting
```bash
# For .go files
gofmt -w /path/to/file.go

# Only runs if gofmt is installed
```

### Debug Logging

All operations logged to: `~/.claude/logs/auto-format.log`

Example log:
```
[2025-10-09 19:30:15] Hook triggered with data: {...}
[2025-10-09 19:30:15] Tool: Edit, File: src/main.rs
[2025-10-09 19:30:15] Formatting file: src/main.rs (extension: rs)
[2025-10-09 19:30:15] Running cargo fmt on src/main.rs
[2025-10-09 19:30:16] Formatting completed for src/main.rs
```

### Error Handling

- **Always exits with 0** (never blocks operation)
- Logs errors to debug log
- Fails silently if formatter not available
- Skips formatting if file doesn't exist

### Customization

To add a new language:

```bash
# Edit hooks/auto-format.sh
case "$ext" in
    # ... existing cases ...
    
    your_ext)
        # Your language formatting
        if command -v your_formatter >/dev/null 2>&1; then
            log_debug "Running your_formatter on $file"
            your_formatter "$file" 2>>"$DEBUG_LOG"
        fi
        ;;
esac
```

---

## pre-commit-check.sh

**File**: `hooks/pre-commit-check.sh`  
**Trigger**: `PreToolUse` on git commit  
**Purpose**: Quality validation before commits  
**Blocking**: Yes (blocks on failures)  
**Timeout**: 60 seconds

### Quality Checks

This hook runs comprehensive quality validation:

#### 1. Rust Projects

```bash
✅ Compilation Check
   cargo check --all-features
   
✅ Clippy (with recompilation)
   touch src/lib.rs  # Force clippy recompilation
   cargo clippy --all-features -- -D warnings
   
✅ Forbidden Pattern Scan
   find src -name "*.rs" | xargs grep "\.unwrap()\|\.expect(\|panic!("
   (Excluding test files)
   
✅ Test Execution
   cargo test --all
   
✅ Format Check
   cargo fmt --all -- --check
```

#### 2. Python Projects

```bash
✅ Ruff Check
   ruff check .
   
✅ Format Check
   ruff format --check .
   
✅ Forbidden Patterns
   Check for: pass # TODO, NotImplementedError, # type: ignore
   (Excluding test files)
   
✅ Test Execution (if pytest available)
   pytest
```

#### 3. TypeScript/JavaScript Projects

```bash
✅ TypeScript Check (if tsconfig.json exists)
   tsc --noEmit
   
✅ ESLint Check
   eslint .
   
✅ Forbidden Patterns
   Check for: : any, console.log, @ts-ignore
   
✅ Test Execution (if test script in package.json)
   npm test
```

### Execution Flow

```
git commit attempt
  ↓
Pre-commit hook triggered
  ↓
Detect project type(s)
  ↓
Run language-specific checks
  ↓
┌─────────────────┐
│ All checks pass?│
└────────┬────────┘
         │
    YES  │  NO
         │
    ┌────▼────┐
    │Continue │
    │Commit   │
    └─────────┘
         │
    ┌────▼─────┐
    │ Block    │
    │ Commit   │
    │ Show     │
    │ Errors   │
    └──────────┘
```

### Success Output

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔍 PRE-COMMIT QUALITY CHECK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🦀 Checking Rust project...
  📦 Checking compilation...
  ✅ Compilation successful
  
  🔍 Running clippy...
  ✅ No clippy warnings
  
  🚫 Checking for forbidden patterns...
  ✅ No forbidden patterns
  
  🧪 Running tests...
  ✅ All tests passing
  
  📐 Checking formatting...
  ✅ Code properly formatted

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ ALL QUALITY CHECKS PASSED
   Commit can proceed safely
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Failure Output

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
❌ QUALITY CHECKS FAILED
   Found 3 issue(s):
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

   • Clippy warnings detected
   • Forbidden patterns found in production code
   • Test failures detected

📝 Fix these issues before committing:
   - For Rust: cargo fmt && cargo clippy --fix
   - For Python: ruff format . && ruff check --fix .
   - For TS/JS: npm run lint:fix (if configured)
   - Remove all forbidden patterns from production code
   - Ensure all tests pass
```

### Configuration

Located in `.claude-plugin/marketplace.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "tool_name == 'Bash' and 'git commit' in parameters.get('command', '')",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PLUGIN_ROOT}/hooks/pre-commit-check.sh",
            "timeout": 60
          }
        ]
      }
    ]
  }
}
```

### Debug Logging

All operations logged to: `~/.claude/logs/pre-commit-check.log`

Example log:
```
[2025-10-09 19:30:20] Pre-commit check triggered
[2025-10-09 19:30:20] Checking project in: /path/to/project
[2025-10-09 19:30:20] Failure added: Clippy warnings detected
[2025-10-09 19:30:21] Checks failed - blocking commit
```

### Bypass (Not Recommended)

If you absolutely must bypass (emergency only):

```bash
# Temporarily disable hook
git commit --no-verify -m "emergency: description"

# Or edit .claude-plugin/marketplace.json to remove hook temporarily
```

**WARNING**: Bypassing quality checks defeats the purpose of this plugin!

---

## notify.py

**File**: `hooks/notify.py`  
**Trigger**: SessionStart, Stop, SubagentStop, PreCompact  
**Purpose**: Audio/visual notifications for events  
**Blocking**: No  
**Timeout**: 10 seconds

### Supported Events

| Event | When Triggered | Notification |
|-------|---------------|--------------|
| SessionStart | Claude Code session begins | "Session started" |
| Stop | Claude Code session ends | "Session stopped" |
| SubagentStop | Agent completes execution | "Agent <name> completed" |
| PreCompact | Before context compaction | "Compacting context" |

### Features

- **Audio notifications**: System sound (macOS/Linux/Windows)
- **Visual notifications**: System notification bubble
- **Configurable**: Enable/disable per event type
- **Logging**: All events logged for debugging

### How It Works

1. **Hook Triggered**: On specified event
2. **Read Hook Data**: Parse event information
3. **Generate Message**: Create notification message
4. **Play Sound**: System beep/sound
5. **Show Notification**: OS notification bubble
6. **Log Event**: Record to debug log

### Configuration

Located in `.claude-plugin/marketplace.json`:

```json
{
  "hooks": {
    "SessionStart": [{
      "matcher": "",
      "hooks": [{
        "type": "command",
        "command": "CLAUDE_HOOK_TYPE=SessionStart ${CLAUDE_PLUGIN_ROOT}/hooks/notify.py",
        "timeout": 10
      }]
    }],
    "Stop": [{
      "matcher": "",
      "hooks": [{
        "type": "command",
        "command": "CLAUDE_HOOK_TYPE=Stop ${CLAUDE_PLUGIN_ROOT}/hooks/notify.py",
        "timeout": 10
      }]
    }],
    "SubagentStop": [{
      "matcher": "",
      "hooks": [{
        "type": "command",
        "command": "CLAUDE_HOOK_TYPE=SubagentStop ${CLAUDE_PLUGIN_ROOT}/hooks/notify.py",
        "timeout": 10
      }]
    }]
  }
}
```

### Notification Examples

#### SessionStart
```
🚀 Claude Code
Session Started
Ready to code!
```

#### SubagentStop
```
🤖 Claude Code
Agent Complete: rust-specialist
Quality validation passed ✅
```

#### Stop
```
👋 Claude Code
Session Ended
Total duration: 2h 34m
```

### Customization

Edit `hooks/notify.py` to customize:

```python
# Customize messages
MESSAGES = {
    'SessionStart': 'Welcome back! Ready to code?',
    'Stop': 'Session complete. Great work!',
    'SubagentStop': 'Agent {} finished successfully',
}

# Customize sounds
SOUNDS = {
    'SessionStart': 'Glass',  # macOS sound name
    'Stop': 'Blow',
    'SubagentStop': 'Pop',
}

# Disable specific events
ENABLED_EVENTS = {
    'SessionStart': True,
    'Stop': True,
    'SubagentStop': False,  # Disabled
    'PreCompact': False,    # Disabled
}
```

### Troubleshooting

**No sound playing?**
- Check system volume
- Verify sound files exist (macOS: `/System/Library/Sounds/`)
- Check notification permissions

**No notifications showing?**
- Verify notification permissions in System Preferences
- Check Do Not Disturb is disabled
- Test with: `notify.py test`

---

## Hook Configuration

### Global Hook Settings

All hooks configured in `.claude-plugin/marketplace.json`:

```json
{
  "hooks": {
    "HookType": [
      {
        "matcher": "condition_expression",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PLUGIN_ROOT}/hooks/script.sh",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

### Hook Matcher Syntax

Matchers use Python expressions with available variables:

**PostToolUse / PreToolUse**:
```python
# Variables available:
# - tool_name: Name of the tool (e.g., 'Edit', 'Bash')
# - parameters: Dict of tool parameters

# Examples:
"tool_name == 'Edit'"
"tool_name in ['Edit', 'Write', 'MultiEdit']"
"'git commit' in parameters.get('command', '')"
"parameters.get('file_path', '').endswith('.rs')"
```

**Other Events**:
```python
# Empty matcher matches all events
""

# Or use event-specific conditions
"event_data.get('agent_name') == 'rust-specialist'"
```

### Timeout Configuration

```json
{
  "timeout": 30  // seconds
}
```

- **Default**: 30 seconds
- **Minimum**: 1 second
- **Maximum**: 600 seconds (10 minutes)
- **Blocking hooks**: Will block for up to timeout duration
- **Non-blocking hooks**: Killed after timeout

### Environment Variables

Hooks run with these environment variables:

```bash
CLAUDE_PLUGIN_ROOT=/path/to/plugin
CLAUDE_HOOK_TYPE=PostToolUse  # or SessionStart, etc.
```

---

## Custom Hooks

### Creating Custom Hooks

1. **Create Hook Script**:
```bash
#!/bin/bash
# hooks/my-custom-hook.sh

set -e
set -u
set -o pipefail

# Read hook data from stdin
HOOK_DATA=$(cat)

# Your custom logic here
echo "Custom hook executed!"

# Exit 0 for success, 1 for failure
exit 0
```

2. **Make Executable**:
```bash
chmod +x hooks/my-custom-hook.sh
```

3. **Add to marketplace.json**:
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "tool_name == 'Write'",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PLUGIN_ROOT}/hooks/my-custom-hook.sh",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

### Hook Best Practices

**DO**:
- ✅ Use `set -e` to exit on errors
- ✅ Use `set -u` to error on undefined variables
- ✅ Use `set -o pipefail` to catch pipe errors
- ✅ Log to a debug file for troubleshooting
- ✅ Exit with clear exit codes (0 = success, 1 = failure)
- ✅ Handle missing tools gracefully
- ✅ Be idempotent (safe to run multiple times)
- ✅ Complete quickly or run async
- ✅ Include comprehensive error handling

**DON'T**:
- ❌ Block for long periods (use async if needed)
- ❌ Modify files unexpectedly
- ❌ Fail silently (log errors)
- ❌ Assume tools are available (check first)
- ❌ Ignore stdin data
- ❌ Use interactive prompts (hooks are non-interactive)
- ❌ Rely on specific working directory
- ❌ Produce excessive output

### Example Custom Hooks

#### Git Hook - Auto-add files
```bash
#!/bin/bash
# hooks/auto-git-add.sh

HOOK_DATA=$(cat)
FILE_PATH=$(echo "$HOOK_DATA" | jq -r '.file_path // empty')

if [ -n "$FILE_PATH" ] && [ -f "$FILE_PATH" ]; then
    git add "$FILE_PATH" 2>/dev/null || true
fi

exit 0
```

#### Linting Hook - Run on save
```bash
#!/bin/bash
# hooks/lint-on-save.sh

HOOK_DATA=$(cat)
FILE_PATH=$(echo "$HOOK_DATA" | jq -r '.file_path // empty')
EXT="${FILE_PATH##*.}"

case "$EXT" in
    rs)
        cargo clippy -- -D warnings || exit 1
        ;;
    py)
        ruff check "$FILE_PATH" || exit 1
        ;;
    ts|tsx|js|jsx)
        eslint "$FILE_PATH" || exit 1
        ;;
esac

exit 0
```

#### Notification Hook - Slack integration
```bash
#!/bin/bash
# hooks/slack-notify.sh

HOOK_DATA=$(cat)
MESSAGE="Claude Code: $CLAUDE_HOOK_TYPE event"

curl -X POST \
    -H 'Content-type: application/json' \
    --data "{\"text\":\"$MESSAGE\"}" \
    "$SLACK_WEBHOOK_URL"

exit 0
```

---

## Troubleshooting

### Hook Not Executing

**Check**:
1. Hook file exists and is executable
2. Matcher condition is correct
3. Timeout is sufficient
4. Check debug logs

**Debug**:
```bash
# Check if hook file is executable
ls -la ~/.claude/plugins/*/hooks/

# Test hook manually
echo '{}' | ~/.claude/plugins/*/hooks/auto-format.sh

# Check matcher syntax
# (View in marketplace.json)

# View debug logs
tail -f ~/.claude/logs/auto-format.log
tail -f ~/.claude/logs/pre-commit-check.log
```

### Hook Timing Out

**Solutions**:
1. Increase timeout in marketplace.json
2. Optimize hook script
3. Run expensive operations async
4. Cache results where possible

**Example - Async execution**:
```bash
#!/bin/bash
# Run expensive operation in background
(expensive_operation &)
exit 0
```

### Hook Blocking Incorrectly

**For PreToolUse hooks**:
- Check exit codes
- Verify conditions
- Review error output

**Example**:
```bash
# Exit 0 = allow operation
# Exit 1 = block operation

if quality_check_passes; then
    exit 0  # Allow commit
else
    echo "Quality check failed"
    exit 1  # Block commit
fi
```

### Permission Issues

```bash
# Make hooks executable
chmod +x hooks/*.sh hooks/*.py

# Check permissions
ls -la hooks/

# Fix permissions
find hooks/ -type f -name "*.sh" -exec chmod +x {} \;
find hooks/ -type f -name "*.py" -exec chmod +x {} \;
```

### Log Files

Default log locations:
```
~/.claude/logs/
├── auto-format.log
├── pre-commit-check.log
└── notify.log
```

View logs:
```bash
# Auto-format
tail -f ~/.claude/logs/auto-format.log

# Pre-commit
tail -f ~/.claude/logs/pre-commit-check.log

# All logs
tail -f ~/.claude/logs/*.log
```

---

## Advanced Configuration

### Conditional Hooks

Run hooks only in specific contexts:

```json
{
  "matcher": "tool_name == 'Edit' and parameters.get('file_path', '').endswith('.rs')"
}
```

### Multiple Hooks per Event

Execute multiple hooks for the same event:

```json
{
  "PostToolUse": [
    {
      "matcher": "tool_name == 'Edit'",
      "hooks": [
        {
          "type": "command",
          "command": "${CLAUDE_PLUGIN_ROOT}/hooks/format.sh",
          "timeout": 30
        },
        {
          "type": "command",
          "command": "${CLAUDE_PLUGIN_ROOT}/hooks/lint.sh",
          "timeout": 30
        }
      ]
    }
  ]
}
```

### Hook Chains

Hooks execute in order:

```json
{
  "hooks": [
    { "command": "${CLAUDE_PLUGIN_ROOT}/hooks/step1.sh" },
    { "command": "${CLAUDE_PLUGIN_ROOT}/hooks/step2.sh" },
    { "command": "${CLAUDE_PLUGIN_ROOT}/hooks/step3.sh" }
  ]
}
```

If any hook fails (exit 1), the chain stops.

---

## Summary

### Hook Comparison

| Feature | auto-format.sh | pre-commit-check.sh | notify.py |
|---------|---------------|---------------------|-----------|
| Trigger | Post-edit | Pre-commit | Events |
| Blocking | No | Yes | No |
| Timeout | 30s | 60s | 10s |
| Purpose | Formatting | Validation | Notification |
| Exit codes | Always 0 | 0 or 1 | Always 0 |
| Languages | Multi | Multi | N/A |

### Quick Reference

**Enable all hooks**: Default (already enabled)

**Disable a hook**: Remove from marketplace.json

**Custom hook**: Add script + update marketplace.json

**Debug hook**: Check logs in `~/.claude/logs/`

**Test hook**: Run manually with echo '{}' | hook.sh

---

For more information, see:
- [Agents Reference](AGENTS.md)
- [Commands Reference](COMMANDS.md)
- [Configuration](CONFIGURATION.md)
- [Quick Reference](QUICK_REFERENCE.md)
