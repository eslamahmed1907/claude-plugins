---
name: cleanup
description: Comprehensive cleanup command that handles both local repository (.claude) and global (~/.claude) cleanup. Archives completed work and prepares for new planning.
---

# Cleanup Command

Comprehensive cleanup for both local repository and global Claude files.

## Usage

```bash
# Clean up current repository and global files
/cleanup

# Clean up with custom message
/cleanup "Completed MVP, starting phase 2"
```

## What It Does

### 1. **Local Repository Cleanup** (if in a git repo)
Cleans `.claude/` in current repository:
- Archives tasks, plans, specs, todos
- Resets orchestrator state
- Clears event logs
- Preserves everything in timestamped archive

### 2. **Global Cleanup** (~/.claude)
Cleans global accumulation:
- Archives 600+ TODO files
- Cleans orphaned tasks/plans
- Archives old project directories
- Removes logs older than 7 days

## Architecture: Local vs Global

```
~/.claude/                    # GLOBAL (shared)
├── commands/                 # Command definitions
├── agents/                   # Agent definitions
├── hooks/                    # Git hooks
└── archived/                 # Global archives

./your-repo/.claude/          # LOCAL (per project)
├── tasks/                    # Project tasks
├── plans/                    # Project plans
├── specs/                    # Specifications
├── state/                    # Orchestrator state
├── todos/                    # Project TODOs
└── archive/                  # Local archives
```

## Archive Structure

### Local Archive (in repository)
```
.claude/archive/20250130_143022/
├── tasks/           # Completed tasks
├── plans/           # Project plans
├── specs/           # Specifications
├── state/           # Final state
├── todos/           # Project TODOs
└── cleanup-summary.md
```

### Global Archive
```
~/.claude/archived/20250130_143022/
├── todos/           # Global TODOs (600+ files!)
├── projects/        # Old project directories
├── old-logs/        # Expired log files
└── cleanup-summary.md
```

## When to Use

- **After project completion** - Archive everything before starting new
- **Repository cleanup** - Clean local project files
- **Global maintenance** - Remove accumulated TODOs and orphaned files
- **Fresh start** - Reset both local and global state

## Setting Up Local Directories

For new repositories:
```bash
# Set up local .claude in current repo
~/.claude/setup-local-project.sh

# Or migrate existing global files
~/.claude/migrate-to-local.sh
```

## Example Workflow

```bash
# In your repository
cd ~/projects/my-app

# Complete current work
/orchestrate
# ... work completes ...

# Clean up everything
/cleanup "Feature complete"

# Start fresh planning
/plan "Phase 2: Performance optimization"

# Continue with clean state
/orchestrate
```

## Safety Features

- **Non-destructive** - Everything archived, nothing deleted
- **Timestamped** - Unique archives with timestamps
- **Dual-level** - Handles both local and global files
- **Smart detection** - Knows if you're in a repository
- **Comprehensive** - Catches all accumulated files

## Output Example

```
🧹 Comprehensive Cleanup

═══════════════════════════════════════════════════
    LOCAL REPOSITORY CLEANUP: my-app
═══════════════════════════════════════════════════
  • Archiving 12 task files
  • Archiving active plans
  • Archiving 3 specification files
  ✅ Local repository cleanup complete!

═══════════════════════════════════════════════════
           GLOBAL CLEANUP: ~/.claude
═══════════════════════════════════════════════════
  ⚠️ Found 647 global TODO files!
  ✓ Archived 647 TODO files
  ✅ Global cleanup complete!

🎉 CLEANUP COMPLETE!
Ready for new project planning!
```

---

*Implementation: Runs cleanup-comprehensive.sh from ~/.claude directory*
