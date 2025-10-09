---
description: Check the status of current orchestration
---

# 📊 Orchestration Status

## Checking Current Orchestration

```python
from pathlib import Path
import json
from datetime import datetime

# Find the most recent orchestration
orchestration_dir = Path.home() / ".claude" / "orchestration" / "state"

if orchestration_dir.exists():
    state_files = sorted(orchestration_dir.glob("*.json"), 
                         key=lambda x: x.stat().st_mtime, reverse=True)
    
    if state_files:
        with open(state_files[0]) as f:
            state = json.load(f)
            
        orchestration_id = state.get("orchestration_id", "")
        created_at = state.get("created_at", "")
        current_phase = state.get("current_phase", "unknown")
        completed_phases = state.get("completed_phases", [])
        pending_phases = state.get("pending_phases", [])
        workflow_dir = Path(state.get("workflow_dir", ""))
```

---

## 📋 Current Orchestration Status

### Overview
- **Orchestration ID:** `{orchestration_id}`
- **Started:** {created_at}
- **Current Phase:** {current_phase}
- **Working Directory:** `{workflow_dir}`

### Progress Tracker

| Phase | Status | Command |
|-------|---------|---------|
| 1. Specification | {spec_status} | `/review-spec` |
| 2. Design | {design_status} | `/review-design` |
| 3. Task List | {tasks_status} | `/review-tasks` |
| 4. Tests | {tests_status} | Generated after tasks |
| 5. Implementation | {impl_status} | Generated after tasks |

### Completed Phases ✅
{completed_phases_list}

### Pending Phases ⏳
{pending_phases_list}

---

## 📁 Generated Files

```python
# Check what files have been created
workflow_dir = Path(state.get("workflow_dir", ""))

files_created = []
if workflow_dir.exists():
    if (workflow_dir / "specification.md").exists():
        files_created.append("✅ specification.md")
    if (workflow_dir / "design.md").exists():
        files_created.append("✅ design.md")
    if (workflow_dir / "task_list.md").exists():
        files_created.append("✅ task_list.md")
    if (workflow_dir / "tests").exists():
        files_created.append("✅ tests/")
    if (workflow_dir / "src").exists():
        files_created.append("✅ src/")
    if (workflow_dir / "docs").exists():
        files_created.append("✅ docs/")

print("Files created:")
for file in files_created:
    print(f"  {file}")
```

---

## 🎯 Next Step

Based on your current phase, here's what to do next:

### If in Specification Phase:
```
/review-spec
```
Review and modify the specification until satisfied.

### If in Design Phase:
```
/review-design
```
Review and modify the architecture design.

### If in Task Phase:
```
/review-tasks
```
Review and modify the task list.

### If All Phases Complete:
Your orchestration is complete! You can:
- Start implementation following the task list
- Run tests with `/test`
- Archive the project with `/archive-project`
- Start a new orchestration with `/start-orchestrate`

---

## 🔄 Quick Actions

### Continue Current Orchestration
Use the command for your current phase (see above)

### Start Fresh
```
/start-orchestrate
```
Begin a new orchestration workflow

### Archive Current Work
```
/archive-project
```
Save the current state before starting something new

---

## 📊 Statistics

- **Time in current phase:** {time_in_phase}
- **Total files generated:** {file_count}
- **Total time elapsed:** {total_time}

---

**Need help?** Just tell me what you want to do and I'll guide you!
