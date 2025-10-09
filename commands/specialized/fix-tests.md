# Fix Tests - Target Test Failures

Fix failing tests in CI/CD pipelines using the test-fixer agent.

```bash
claude -p "Task(subagent_type='test-fixer', description='Fix failing tests', prompt='Analyze failing CI tests and fix them. Ensure 100% test pass rate.')"
```