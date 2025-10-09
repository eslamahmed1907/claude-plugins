---
description: Start an interactive orchestration workflow with step-by-step review
---

# 🚀 Start Interactive Orchestration Workflow

## Step 1: Capturing Your Initial Requirements

Thank you for starting a new orchestration! Let me understand what you want to build.

**Your initial description:**
[I'll use what you've told me about your project]

---

## 📋 Generating Initial Specification

Based on your description, I'm creating the initial specification...

```python
import json
import uuid
from pathlib import Path
from datetime import datetime

# Create new orchestration
orchestration_id = str(uuid.uuid4())[:8]
workflow_dir = Path.home() / ".claude" / "workflows" / orchestration_id
workflow_dir.mkdir(parents=True, exist_ok=True)

# Save state for review commands
state_dir = Path.home() / ".claude" / "orchestration" / "state"
state_dir.mkdir(parents=True, exist_ok=True)
state_file = state_dir / f"{orchestration_id}.json"

state = {
    "orchestration_id": orchestration_id,
    "created_at": datetime.utcnow().isoformat(),
    "current_phase": "specification",
    "workflow_dir": str(workflow_dir),
    "completed_phases": [],
    "pending_phases": ["specification", "design", "tasks", "tests", "implementation"]
}

with open(state_file, 'w') as f:
    json.dump(state, f, indent=2)

print(f"✅ Orchestration started: {orchestration_id}")
print(f"📁 Working directory: {workflow_dir}")
```

[Generating specification based on your requirements...]

---

## ✅ Initial Specification Created!

I've generated the initial specification. Now let's review and refine it together.

### 📝 Next Step: Review Specification

**Run this command:**
```
/review-spec
```

This will:
- Show you the generated specification
- Let you request any changes
- Update it based on your feedback

**Common changes you might want:**
- Add missing requirements
- Clarify success criteria
- Add constraints or limitations
- Specify performance targets
- Include security requirements

---

## 🔄 Your Orchestration Workflow

Here's your step-by-step process:

### ✅ Step 1: Start (Current)
- Initial requirements captured
- Base specification generated

### ⏳ Step 2: Review Specification
```
/review-spec
```
- View the specification
- Request changes: "Add requirement for X"
- Iterate until satisfied

### ⏳ Step 3: Review Design
```
/review-design
```
- View the architecture design
- Request changes: "Add caching layer"
- Iterate until satisfied

### ⏳ Step 4: Review Tasks
```
/review-tasks
```
- View the task list
- Request changes: "Split task 3 into subtasks"
- Iterate until satisfied

### ⏳ Step 5: Generate Tests & Code
Once you're happy with spec, design, and tasks, I'll generate:
- TDD test suite
- Implementation skeleton
- Documentation

---

## 📊 Orchestration Status

```python
# Current status
print(f"""
📋 Orchestration Status
=======================
ID: {orchestration_id}
Phase: 1 of 5 (Specification)
Status: Ready for review

Next Command: /review-spec
""")
```

---

## 💡 Tips for Effective Review

1. **Start with the spec** - Make sure all requirements are captured
2. **Design follows spec** - Architecture should meet all requirements
3. **Tasks follow design** - Each component needs implementation tasks
4. **Iterate freely** - You can go back to any phase
5. **Save progress** - Everything is automatically saved

---

## 🎯 Ready for Step 2!

**Your orchestration ID:** `{orchestration_id}`

**Next command to run:**
```
/review-spec
```

This will show you the specification I generated. You can then:
- Review it carefully
- Request any changes
- I'll update it immediately
- Repeat until you're satisfied

Then we'll move to `/review-design`, and so on.

---

**Important:** Each review command will show you the current state and let you iterate. You control the pace - nothing moves forward until you're ready!
