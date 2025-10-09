# Debug Token Usage

Shows exactly what's consuming tokens in your current session.

## Usage
```
/debug-tokens
```

## What It Shows

### 1. Current Session Info
- Session ID
- Tokens used so far
- Context window usage percentage

### 2. Files Currently Loaded
- Lists all files Claude has accessed
- Shows size of each file
- Identifies large files

### 3. Commands Used
- Which commands have been run
- Estimated token usage per command

### 4. Potential Issues
- Large files being auto-loaded
- Steering docs being pulled in
- Test output accumulation

## How to Use for Diagnosis

### Step 1: Start Fresh
```bash
/clear
/cost  # Should show ~0 tokens
```

### Step 2: Run Your Task
```bash
/orchestrate-lite "your task"
# Watch for the compacting message
```

### Step 3: Check What Happened
```bash
/debug-tokens
# See what got loaded
```

## Common Culprits

### 1. File Exploration
Claude reading multiple files to understand context:
- Solution: Use `/orchestrate-minimal` instead

### 2. Test Output
Running full test suites generates massive output:
- Solution: Run specific tests only

### 3. Error Messages
Compilation errors can be huge:
- Solution: Fix one file at a time

### 4. Documentation Loading
Steering docs or README files being loaded:
- Solution: Check what's in CLAUDE.md

## Quick Fixes

If you see large token usage:

### Option 1: Ultra-Minimal Mode
```bash
/clear
# Don't use any orchestrate commands
# Just ask: "Show me how to fix X"
```

### Option 2: Manual Work
```bash
# Get the fix without Claude reading files:
"Write code to replace unwrap() with ? for Result types"
# Apply it yourself
```

### Option 3: Single File Mode
```bash
/clear
@path/to/single/file.rs
"Fix the unwrap on line 45"
```

## Red Flags

If you see any of these, you're loading too much:
- Tokens > 5,000 after one command
- Multiple files listed (>3)
- Steering docs in the list
- Test output > 1,000 lines

## Emergency Escape

If compacting happens constantly:
```bash
/clear
# Work without commands
# Just describe what you need
# Apply changes manually
```

This diagnostic helps identify the root cause!