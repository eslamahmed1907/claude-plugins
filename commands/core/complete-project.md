# Complete Project - Task by Task

Process an entire project by completing tasks sequentially.

## Setup

First, define your project tasks in `.claude/project-tasks.md`:
```markdown
# Project Tasks

- [ ] Task 1: Add authentication system
- [ ] Task 2: Implement data validation  
- [ ] Task 3: Add error handling
- [ ] Task 4: Create API documentation
- [ ] Task 5: Add monitoring
```

## Process Current Task

1. **Read task list** from `.claude/project-tasks.md`
2. **Find next unchecked task**
3. **Complete the task** using full development workflow:
   - Write specification
   - Design and write tests (TDD)
   - Implement solution
   - Review and refine
   - Document
4. **Update task list** - mark task complete with [x]
5. **Report completion** and return control

## Example Execution

First run:
```
Processing: Task 1: Add authentication system
[... completes all phases ...]
✅ Task 1 complete!

Status: 1/5 tasks complete
Next: Task 2: Implement data validation
Run /complete-project again to continue.
```

Second run:
```
Processing: Task 2: Implement data validation
[... completes all phases ...]
✅ Task 2 complete!

Status: 2/5 tasks complete
Next: Task 3: Add error handling
Run /complete-project again to continue.
```

## Important Notes

- Completes ONE task per invocation
- Maintains progress in task file
- User controls when to continue
- No automatic looping
- Clear stopping points

## Alternative Approaches

### Parallel Independent Tasks
If tasks 2, 3, and 4 are independent:
```
Use the Task tool to complete tasks 2, 3, and 4 in parallel
```

### Batch Processing
For simple tasks, you might complete multiple in one session:
```
Complete tasks 1 through 3, executing each sequentially
```

But always return control after the batch completes.

## Why This Works

- **Predictable**: Each invocation has clear scope
- **Debuggable**: Can inspect state between tasks
- **Flexible**: User can pause, review, adjust
- **Reliable**: Fresh context for each task
- **Correct**: Aligns with Claude Code architecture

This is the RIGHT way to handle multi-task projects!
