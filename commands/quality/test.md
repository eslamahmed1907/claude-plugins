# Test - Comprehensive Testing Command

Execute thorough testing with quality validation before any code is returned.

## Usage
```
/test [options] [specific-tests]
```

## Options
- `--all`: Run all test suites (default)
- `--unit`: Unit tests only
- `--integration`: Integration tests only
- `--e2e`: End-to-end tests only
- `--coverage`: Generate coverage report
- `--strict`: Fail on any warning or non-critical issue
- `--fix`: Auto-fix issues where possible

## Core Testing Flow

### Phase 1: Pre-Test Validation
```bash
# Ensure code compiles first
cargo build --all-features 2>&1 | tee build.log
if grep -E "error|warning" build.log; then
    echo "❌ Build issues must be fixed before testing"
    exit 1
fi
```

### Phase 2: Test Execution
```bash
# Run all tests with detailed output
cargo test --all-features -- --nocapture --test-threads=1

# Verify no test is ignored
cargo test --all-features -- --ignored 2>&1 | grep "0 ignored" || {
    echo "⚠️ Found ignored tests - they should be fixed or removed"
}
```

### Phase 3: Coverage Analysis
```bash
# Generate test coverage
cargo tarpaulin --out Html --output-dir coverage

# Check coverage threshold (minimum 80%)
coverage_percent=$(cargo tarpaulin --print-summary | grep "Coverage" | grep -oE "[0-9]+\.[0-9]+")
if (( $(echo "$coverage_percent < 80" | bc -l) )); then
    echo "❌ Coverage too low: ${coverage_percent}% (minimum: 80%)"
    exit 1
fi
```

### Phase 4: Quality Checks
```bash
# Check for unwrap() in non-test code
if grep -r "\.unwrap()" --include="*.rs" --exclude-dir="tests"; then
    echo "❌ Found unwrap() in production code"
    exit 1
fi

# Touch lib.rs or main.rs to force recompilation for clippy
if [ -f "src/lib.rs" ]; then touch src/lib.rs; elif [ -f "src/main.rs" ]; then touch src/main.rs; fi
# Run clippy with strict settings
cargo clippy --all-features -- -D warnings
```

## Test Categories

### Unit Tests
Test individual functions and modules:
```rust
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_function_success() {
        let result = function_under_test("valid input").unwrap();
        assert_eq!(result, expected_value());
    }

    #[test]
    fn test_function_error_handling() {
        let result = function_under_test("invalid input");
        assert!(result.is_err());
        assert_eq!(result.unwrap_err().to_string(), "Expected error");
    }
}
```

### Integration Tests
Test module interactions:
```rust
// tests/integration_test.rs
#[test]
fn test_module_integration() {
    let system = System::new();
    let result = system.process_complete_workflow();
    assert!(result.is_ok());
    verify_side_effects();
}
```

### Property-Based Tests
Test with generated inputs:
```rust
#[cfg(test)]
mod property_tests {
    use proptest::prelude::*;

    proptest! {
        #[test]
        fn test_never_panics(input: String) {
            let result = process_input(&input);
            // Should never panic regardless of input
            assert!(result.is_ok() || result.is_err());
        }
    }
}
```

## Test Quality Standards

### Required Test Coverage
- **Functions**: Every public function tested
- **Error Cases**: All error paths tested
- **Edge Cases**: Boundary conditions tested
- **Integration**: Module interactions tested
- **Properties**: Invariants verified

### Test Naming Convention
```rust
#[test]
fn test_module_function_condition_expectation() {
    // Example: test_auth_login_invalid_password_returns_error
}
```

### Assertion Requirements
```rust
// Always use descriptive assertions
assert_eq!(actual, expected, "Login should succeed with valid credentials");

// Test both success and failure paths
assert!(result.is_ok(), "Operation should succeed");
assert!(result.is_err(), "Should fail with invalid input");

// Verify error types
assert!(matches!(result, Err(Error::InvalidInput(_))));
```

## Platform-Specific Testing

### Rust Testing
```bash
# Standard test run
cargo test

# With specific features
cargo test --features "feature1,feature2"

# Release mode testing
cargo test --release

# Doctest verification
cargo test --doc

# Benchmark tests
cargo bench
```

### Python Testing
```bash
# Run pytest with coverage
pytest -xvs --cov=. --cov-report=html

# Type checking
mypy . --strict

# Run specific test file
pytest tests/test_module.py -v
```

### JavaScript/TypeScript Testing
```bash
# Run Jest tests
npm test -- --coverage

# Run with watch mode
npm test -- --watch

# E2E tests
npm run test:e2e
```

## Test Output Validation

### Expected Output
```
running 42 tests
test module::test_function_1 ... ok
test module::test_function_2 ... ok
...
test result: ok. 42 passed; 0 failed; 0 ignored; 0 measured

Doc-tests project
running 5 tests
...
test result: ok. 5 passed; 0 failed; 0 ignored

Coverage: 85.3%
```

### Failure Handling
If tests fail:
1. Identify failing test
2. Fix the implementation (not the test!)
3. Re-run tests
4. Verify all pass
5. Check coverage hasn't decreased

## Test Report Format

```
TEST EXECUTION REPORT
====================
Test Suite: my-project
Timestamp: 2025-08-15 10:30:00

Results:
✅ Unit Tests: 30/30 passed
✅ Integration Tests: 10/10 passed
✅ Doc Tests: 5/5 passed
✅ Property Tests: 100/100 passed

Coverage:
- Line Coverage: 85.3%
- Branch Coverage: 78.2%
- Function Coverage: 92.1%

Quality Checks:
✅ No unwrap() in production code
✅ All error paths tested
✅ No ignored tests
✅ No test warnings

Status: ALL TESTS PASSING ✅
```

## Common Issues and Fixes

### Flaky Tests
```rust
// ❌ Flaky - depends on timing
#[test]
fn test_timeout() {
    sleep(Duration::from_secs(1));
    assert!(check_timeout());
}

// ✅ Deterministic
#[test]
fn test_timeout() {
    let mock_time = MockTime::new();
    mock_time.advance(Duration::from_secs(1));
    assert!(check_timeout_with_time(&mock_time));
}
```

### Missing Error Tests
```rust
// ❌ Only tests success
#[test]
fn test_parse() {
    let result = parse("valid").unwrap();
    assert_eq!(result, expected);
}

// ✅ Tests both paths
#[test]
fn test_parse_success() {
    let result = parse("valid").unwrap();
    assert_eq!(result, expected);
}

#[test]
fn test_parse_invalid_input() {
    let result = parse("invalid");
    assert!(result.is_err());
}
```

Remember: Untested code is broken code. Test everything!