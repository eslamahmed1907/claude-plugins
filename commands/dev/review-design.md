---
description: Review and modify the generated design
---

# 🏗️ Review Design

## Loading Current Design

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
            design_file = workflow_base / orchestration_id / "design.md"
            
            if design_file.exists():
                print(f"🏗️ Design from: {orchestration_id}")
                print("=" * 60)
                print(design_file.read_text())
                print("=" * 60)
            else:
                print(f"❌ No design found for {orchestration_id}")
else:
    print("❌ No orchestration found. Run /orchestrate first!")
```

---

## 🏗️ Current Design

[Design will be displayed here]

---

## ✏️ How to Request Changes

Tell me what you'd like to change in the design:

**Examples:**
- "Change architecture from monolithic to microservices"
- "Add a caching layer between API and database"
- "Split the User component into Auth and Profile"
- "Change data flow to use event-driven pattern"
- "Add Redis for session management"
- "Include a message queue for async processing"

## 🔄 Updating Design

After you describe the changes, I'll:
1. Update the architecture design
2. Adjust component relationships
3. Update data flow diagrams
4. Modify interface definitions
5. Save the new version

**Your requested changes:**
[Waiting for your input...]

---

## 📊 Design Validation

```python
# Validate design changes
def validate_design_changes(design, spec):
    checks = []
    
    # Check if design meets all requirements
    for requirement in spec.requirements:
        if requirement_covered_in_design(requirement, design):
            checks.append(f"✅ {requirement}")
        else:
            checks.append(f"⚠️  {requirement} - needs design element")
    
    # Check component dependencies
    if has_circular_dependencies(design):
        checks.append("❌ Circular dependencies detected")
    else:
        checks.append("✅ No circular dependencies")
    
    return checks

print("Design Validation:")
for check in validate_design_changes(updated_design, current_spec):
    print(f"  {check}")
```

---

## 💾 Saving Changes

```python
# Save updated design
if changes_requested:
    updated_design = apply_design_changes(current_design, requested_changes)
    design_file.write_text(updated_design)
    print(f"✅ Design updated: {design_file}")
    
    # Update task list if needed
    if design_impacts_tasks(changes):
        print("⚠️  Design changes may impact tasks. Run /review-tasks to update.")
```

---

**What would you like to change in the design?**
