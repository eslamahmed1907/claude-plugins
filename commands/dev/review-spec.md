---
description: Review and modify the generated specification
---

# 📋 Review Specification

## Loading Current Specification

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
            spec_file = workflow_base / orchestration_id / "specification.md"
            
            if spec_file.exists():
                print(f"📄 Specification from: {orchestration_id}")
                print("=" * 60)
                print(spec_file.read_text())
                print("=" * 60)
            else:
                print(f"❌ No specification found for {orchestration_id}")
else:
    print("❌ No orchestration found. Run /orchestrate first!")
```

---

## 📝 Current Specification

[Specification will be displayed here]

---

## ✏️ How to Request Changes

Tell me what you'd like to change in the specification:

**Examples:**
- "Add a requirement for audit logging"
- "Change the performance target to 5000 req/s"
- "Remove the constraint about PostgreSQL"
- "Add security requirement for OAuth2 support"
- "Expand the success criteria section"

## 🔄 Updating Specification

After you describe the changes, I'll:
1. Update the specification with your changes
2. Save the new version
3. Show you the updated content
4. Optionally cascade changes to design and tasks

**Your requested changes:**
[Waiting for your input...]

---

## 💾 Saving Changes

```python
# Save updated specification
if changes_requested:
    updated_spec = apply_changes(current_spec, requested_changes)
    spec_file.write_text(updated_spec)
    print(f"✅ Specification updated: {spec_file}")
    
    # Track revision
    revision_file = spec_file.parent / f"specification_v{revision_number}.md"
    revision_file.write_text(current_spec)  # Backup old version
    print(f"📚 Previous version saved as: {revision_file.name}")
```

---

**What would you like to change in the specification?**
