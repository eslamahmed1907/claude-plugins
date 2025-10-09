---
description: Review and modify the generated task list
---

# 📋 Review Tasks

## Loading Current Task List

```python
from pathlib import Path
import json

# Find the most recent orchestration
orchestration_dir = Path.home() / ".claude" / "orchestration" / "state"
workflow_base = Path.home() / ".claude" / "workflows"

# Get the most recent orchestration ID
if orchestration_dir.exists():
    state_files = sorted(orchestration_dir.glob("*.json"), key=lambda x: x.stat().st_mtime, reverse=True)
    if state_files:
        with open(state_files[0]) as f:
            state = json.load(f)
            orchestration_id = state.get("orchestration_id", "")
            task_file = workflow_base / orchestration_id / "task_list.md"
            
            if task_file.exists():
                print(f"📋 Task List from: {orchestration_id}")
                print("=" * 60)
                print(task_file.read_text())
                print("=" * 60)
            else:
                print(f"❌ No task list found for {orchestration_id}")
else:
    print("❌ No orchestration found. Run /orchestrate first!")
```

---

## 📋 Current Task List

[Task list will be displayed here]

---

## ✏️ How to Request Changes

Tell me what you'd like to change in the task list:

**Examples:**
- "Add a task for database migration"
- "Split task 3 into two smaller tasks"
- "Change time estimate for task 5 to 8 hours"
- "Add dependency: task 7 depends on task 4"
- "Remove the documentation tasks"
- "Reorder tasks 3 and 4"
- "Add a testing phase after implementation"

## 🔄 Updating Tasks

After you describe the changes, I'll:
1. Add/remove/modify tasks
2. Update time estimates
3. Adjust dependencies
4. Recalculate total timeline
5. Reorder execution phases

**Your requested changes:**
[Waiting for your input...]

---

## 📊 Task Analysis

```python
# Analyze task list
def analyze_tasks(task_list):
    total_hours = sum(task.hours for task in task_list)
    total_days = total_hours / 8
    
    by_priority = {
        'critical': len([t for t in task_list if t.priority == 'critical']),
        'high': len([t for t in task_list if t.priority == 'high']),
        'medium': len([t for t in task_list if t.priority == 'medium']),
        'low': len([t for t in task_list if t.priority == 'low'])
    }
    
    by_type = {
        'setup': len([t for t in task_list if t.type == 'setup']),
        'implementation': len([t for t in task_list if t.type == 'implementation']),
        'testing': len([t for t in task_list if t.type == 'testing']),
        'documentation': len([t for t in task_list if t.type == 'documentation'])
    }
    
    print(f"📊 Task Summary:")
    print(f"  Total Tasks: {len(task_list)}")
    print(f"  Total Hours: {total_hours}")
    print(f"  Total Days: {total_days:.1f}")
    print(f"  By Priority: {by_priority}")
    print(f"  By Type: {by_type}")
```

---

## 🔗 Dependency Validation

```python
# Check for dependency issues
def validate_dependencies(task_list):
    issues = []
    
    for task in task_list:
        for dep_id in task.dependencies:
            dep_task = find_task(dep_id, task_list)
            if not dep_task:
                issues.append(f"❌ Task {task.id} depends on non-existent task {dep_id}")
            elif dep_task.phase > task.phase:
                issues.append(f"⚠️  Task {task.id} depends on later task {dep_id}")
    
    # Check for circular dependencies
    if has_circular_deps(task_list):
        issues.append("❌ Circular dependencies detected")
    
    if not issues:
        print("✅ All dependencies valid")
    else:
        for issue in issues:
            print(issue)
```

---

## 💾 Saving Changes

```python
# Save updated task list
if changes_requested:
    updated_tasks = apply_task_changes(current_tasks, requested_changes)
    task_file.write_text(format_task_list(updated_tasks))
    print(f"✅ Task list updated: {task_file}")
    
    # Generate updated Gantt chart
    gantt_file = task_file.parent / "task_gantt.md"
    gantt_file.write_text(generate_gantt_chart(updated_tasks))
    print(f"📊 Gantt chart updated: {gantt_file}")
    
    # Update test files if tasks changed
    if tasks_impact_tests(changes):
        print("⚠️  Task changes may impact tests. Updating test suite...")
```

---

**What would you like to change in the task list?**
