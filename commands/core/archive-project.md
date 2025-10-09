---
description: Archive current project state for later reference
---

# 📦 Archive Project

## Archiving Current Project State

I'll create a complete archive of your current project state, including:
- Git status and recent commits
- Current code structure
- Open tasks and TODOs
- Recent changes
- Configuration files
- Documentation snapshot

```python
import json
import shutil
import subprocess
from pathlib import Path
from datetime import datetime

# Create archive
timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
project_name = Path.cwd().name
archive_name = f"{project_name}_{timestamp}"
archive_dir = Path.home() / ".claude" / "archived" / "projects" / archive_name
archive_dir.mkdir(parents=True, exist_ok=True)

print(f"📦 Archiving: {project_name}")
print(f"📁 Archive location: {archive_dir}")
```

---

## 📋 Capturing Project Snapshot

### Git State
```bash
# Capture git info
git log --oneline -20 > git_history.txt
git status > git_status.txt
git diff > uncommitted_changes.diff
git diff --cached > staged_changes.diff
git branch -a > branches.txt
```

### Project Structure
```bash
# Capture directory structure
find . -type f -name "*.rs" -o -name "*.py" -o -name "*.js" -o -name "*.toml" -o -name "*.json" | head -100 > project_files.txt
tree -L 3 -I "target|node_modules|__pycache__|.git" > project_structure.txt
```

### Current TODOs
```bash
# Find all TODOs in code
grep -r "TODO\|FIXME\|HACK\|XXX" --include="*.rs" --include="*.py" --include="*.js" . > todos.txt
```

---

## 📊 Archive Metadata

```python
# Create metadata file
metadata = {
    "project_name": project_name,
    "archived_at": datetime.utcnow().isoformat(),
    "archive_id": archive_name,
    "git_branch": subprocess.run(["git", "branch", "--show-current"], 
                                capture_output=True, text=True).stdout.strip(),
    "last_commit": subprocess.run(["git", "log", "-1", "--format=%H"], 
                                 capture_output=True, text=True).stdout.strip(),
    "working_directory": str(Path.cwd()),
    "files_count": len(list(Path.cwd().rglob("*"))),
    "todos_count": len(open("todos.txt").readlines()) if Path("todos.txt").exists() else 0,
    "archive_reason": archive_reason
}

metadata_file = archive_dir / "archive_metadata.json"
with open(metadata_file, 'w') as f:
    json.dump(metadata, f, indent=2)

print(f"📊 Metadata saved: {metadata_file}")
```

---

## 🗂️ Creating Archive

### Important Files to Archive
- `Cargo.toml` / `package.json` / `requirements.txt` - Dependencies
- `README.md` - Project documentation
- `.env.example` - Environment configuration
- `src/` - Source code (sample)
- `tests/` - Test files (sample)
- `.claude/` - Claude-specific configs

### Archive Creation
```python
# Copy important files
files_to_archive = [
    "Cargo.toml",
    "package.json",
    "requirements.txt",
    "README.md",
    ".env.example",
    "docker-compose.yml",
]

for file in files_to_archive:
    source = Path.cwd() / file
    if source.exists():
        dest = archive_dir / file
        if source.is_file():
            shutil.copy2(source, dest)
        else:
            shutil.copytree(source, dest)
        print(f"  ✓ Archived: {file}")

# Create source snapshot (first 50 files)
src_snapshot = archive_dir / "src_snapshot"
src_snapshot.mkdir(exist_ok=True)

for i, src_file in enumerate(Path.cwd().rglob("*.rs")[:50]):
    relative_path = src_file.relative_to(Path.cwd())
    dest_file = src_snapshot / relative_path
    dest_file.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(src_file, dest_file)
    print(f"  ✓ Snapshot: {relative_path}")
```

---

## 🏷️ Archive Tagging

```python
# Create tags file for easy searching
tags = []

# Auto-detect tags
if Path("Cargo.toml").exists():
    tags.append("rust")
if Path("package.json").exists():
    tags.append("javascript")
if Path("requirements.txt").exists():
    tags.append("python")
if Path(".git").exists():
    tags.append("git")

# Add project-specific tags
if "p2p" in project_name.lower():
    tags.append("p2p")
if "communitas" in project_name.lower():
    tags.append("communitas")

tags_file = archive_dir / "tags.json"
with open(tags_file, 'w') as f:
    json.dump({"tags": tags, "custom_tags": custom_tags}, f, indent=2)

print(f"🏷️  Tags: {', '.join(tags)}")
```

---

## 📝 Archive Summary

```python
# Generate summary
summary = f"""# Archive Summary: {project_name}

## Archive Information
- **Archive ID**: {archive_name}
- **Created**: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}
- **Location**: {archive_dir}

## Project State
- **Current Branch**: {metadata['git_branch']}
- **Last Commit**: {metadata['last_commit'][:8]}
- **Files Count**: {metadata['files_count']}
- **TODOs Count**: {metadata['todos_count']}

## Archive Contents
- Git history and status
- Project structure
- Source code snapshot
- Configuration files
- TODO list
- Metadata

## Tags
{', '.join(tags)}

## Notes
{archive_notes}

---
To restore this project state:
1. Navigate to: {archive_dir}
2. Review metadata.json
3. Use git to checkout the recorded commit
4. Apply any uncommitted changes from diffs
"""

summary_file = archive_dir / "ARCHIVE_SUMMARY.md"
summary_file.write_text(summary)

print(f"📝 Summary saved: {summary_file}")
```

---

## ✅ Archive Complete!

**Archive created successfully!**

📦 **Archive ID**: `{archive_name}`
📁 **Location**: `~/.claude/archived/projects/{archive_name}/`

### Archive Contains:
- Git history and current state
- Project structure and file list
- Source code snapshot (50 files)
- All TODOs and FIXMEs
- Configuration files
- Metadata and tags

### Quick Access Commands:
```bash
# View archive
ls -la ~/.claude/archived/projects/{archive_name}/

# Read summary
cat ~/.claude/archived/projects/{archive_name}/ARCHIVE_SUMMARY.md

# Check metadata
cat ~/.claude/archived/projects/{archive_name}/archive_metadata.json
```

### To Restore Later:
1. Go to archive directory
2. Check the git commit in metadata
3. Apply any uncommitted changes from diff files

---

**Why did you archive this project?** 
[Your reason will be saved with the archive]
