#!/bin/bash
# Pre-commit quality check hook for Claude Code
# Blocks commits if quality standards are not met

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Debug log
DEBUG_LOG="$HOME/.claude/logs/pre-commit-check.log"
mkdir -p "$(dirname "$DEBUG_LOG")"

log_debug() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$DEBUG_LOG"
}

# Read hook data from stdin
HOOK_DATA=$(cat)
log_debug "Pre-commit check triggered with data: $HOOK_DATA"

# Track failures
FAILURES=0
FAILURE_MESSAGES=()

# Function to add failure message
add_failure() {
    FAILURES=$((FAILURES + 1))
    FAILURE_MESSAGES+=("$1")
    log_debug "Failure added: $1"
}

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}🔍 PRE-COMMIT QUALITY CHECK${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# Get current directory to check project type
CURRENT_DIR=$(pwd)
log_debug "Checking project in: $CURRENT_DIR"

# Function to check Rust project
check_rust_project() {
    echo -e "${YELLOW}🦀 Checking Rust project...${NC}"
    
    # Check if Cargo.toml exists
    if [ ! -f "Cargo.toml" ]; then
        return 0
    fi
    
    # 1. Check for compilation errors
    echo "  📦 Checking compilation..."
    if ! cargo check --all-features 2>/dev/null; then
        add_failure "Rust compilation errors detected"
        echo -e "  ${RED}❌ Compilation failed${NC}"
    else
        echo -e "  ${GREEN}✅ Compilation successful${NC}"
    fi
    
    # 2. Check clippy warnings
    echo "  🔍 Running clippy..."
    # Touch lib.rs or main.rs to force recompilation for clippy
    if [ -f "src/lib.rs" ]; then
        touch src/lib.rs
    elif [ -f "src/main.rs" ]; then
        touch src/main.rs
    fi
    if ! cargo clippy --all-features -- -D warnings 2>/dev/null; then
        add_failure "Clippy warnings detected"
        echo -e "  ${RED}❌ Clippy warnings found${NC}"
    else
        echo -e "  ${GREEN}✅ No clippy warnings${NC}"
    fi
    
    # 3. Check for forbidden patterns in production code
    echo "  🚫 Checking for forbidden patterns..."
    FORBIDDEN_COUNT=0
    
    # Check for unwrap, expect, panic in non-test files
    for file in $(find src -name "*.rs" -type f 2>/dev/null); do
        # Skip test files
        if [[ "$file" == *"test"* ]] || [[ "$file" == *"tests"* ]]; then
            continue
        fi
        
        # Check for forbidden patterns
        if grep -q '\.unwrap()' "$file" 2>/dev/null; then
            FORBIDDEN_COUNT=$((FORBIDDEN_COUNT + 1))
            log_debug "Found .unwrap() in $file"
        fi
        if grep -q '\.expect(' "$file" 2>/dev/null; then
            FORBIDDEN_COUNT=$((FORBIDDEN_COUNT + 1))
            log_debug "Found .expect() in $file"
        fi
        if grep -q 'panic!(' "$file" 2>/dev/null; then
            FORBIDDEN_COUNT=$((FORBIDDEN_COUNT + 1))
            log_debug "Found panic!() in $file"
        fi
        if grep -q 'todo!(' "$file" 2>/dev/null; then
            FORBIDDEN_COUNT=$((FORBIDDEN_COUNT + 1))
            log_debug "Found todo!() in $file"
        fi
        if grep -q 'unimplemented!(' "$file" 2>/dev/null; then
            FORBIDDEN_COUNT=$((FORBIDDEN_COUNT + 1))
            log_debug "Found unimplemented!() in $file"
        fi
    done
    
    if [ $FORBIDDEN_COUNT -gt 0 ]; then
        add_failure "Forbidden patterns found in production code (unwrap/expect/panic/todo)"
        echo -e "  ${RED}❌ Found $FORBIDDEN_COUNT forbidden patterns${NC}"
    else
        echo -e "  ${GREEN}✅ No forbidden patterns${NC}"
    fi
    
    # 4. Run tests
    echo "  🧪 Running tests..."
    if ! cargo test --all 2>/dev/null; then
        add_failure "Test failures detected"
        echo -e "  ${RED}❌ Tests failed${NC}"
    else
        echo -e "  ${GREEN}✅ All tests passing${NC}"
    fi
    
    # 5. Check formatting
    echo "  📐 Checking formatting..."
    if ! cargo fmt --all -- --check 2>/dev/null; then
        add_failure "Code needs formatting (run: cargo fmt)"
        echo -e "  ${RED}❌ Code needs formatting${NC}"
    else
        echo -e "  ${GREEN}✅ Code properly formatted${NC}"
    fi
}

# Function to check Python project
check_python_project() {
    echo -e "${YELLOW}🐍 Checking Python project...${NC}"
    
    # Check if any Python files exist
    if ! ls *.py 2>/dev/null && ! ls */*.py 2>/dev/null; then
        return 0
    fi
    
    # 1. Check with ruff
    if command -v ruff >/dev/null 2>&1; then
        echo "  🔍 Running ruff..."
        if ! ruff check . 2>/dev/null; then
            add_failure "Ruff linting errors detected"
            echo -e "  ${RED}❌ Ruff found issues${NC}"
        else
            echo -e "  ${GREEN}✅ Ruff check passed${NC}"
        fi
        
        echo "  📐 Checking formatting with ruff..."
        if ! ruff format --check . 2>/dev/null; then
            add_failure "Code needs formatting (run: ruff format)"
            echo -e "  ${RED}❌ Code needs formatting${NC}"
        else
            echo -e "  ${GREEN}✅ Code properly formatted${NC}"
        fi
    fi
    
    # 2. Check for forbidden patterns
    echo "  🚫 Checking for forbidden patterns..."
    FORBIDDEN_COUNT=0
    
    for file in $(find . -name "*.py" -type f 2>/dev/null | grep -v __pycache__ | grep -v .venv); do
        # Skip test files
        if [[ "$file" == *"test"* ]] || [[ "$file" == *"tests"* ]]; then
            continue
        fi
        
        # Check for placeholders
        if grep -q 'pass # TODO' "$file" 2>/dev/null; then
            FORBIDDEN_COUNT=$((FORBIDDEN_COUNT + 1))
            log_debug "Found 'pass # TODO' in $file"
        fi
        if grep -q 'raise NotImplementedError' "$file" 2>/dev/null; then
            FORBIDDEN_COUNT=$((FORBIDDEN_COUNT + 1))
            log_debug "Found NotImplementedError in $file"
        fi
        if grep -q '# type: ignore' "$file" 2>/dev/null; then
            FORBIDDEN_COUNT=$((FORBIDDEN_COUNT + 1))
            log_debug "Found type: ignore in $file"
        fi
    done
    
    if [ $FORBIDDEN_COUNT -gt 0 ]; then
        add_failure "Forbidden patterns found in Python code"
        echo -e "  ${RED}❌ Found $FORBIDDEN_COUNT forbidden patterns${NC}"
    else
        echo -e "  ${GREEN}✅ No forbidden patterns${NC}"
    fi
    
    # 3. Run tests if pytest is available
    if command -v pytest >/dev/null 2>&1; then
        echo "  🧪 Running tests..."
        if ! pytest 2>/dev/null; then
            add_failure "Test failures detected"
            echo -e "  ${RED}❌ Tests failed${NC}"
        else
            echo -e "  ${GREEN}✅ All tests passing${NC}"
        fi
    fi
}

# Function to check TypeScript/JavaScript project
check_typescript_project() {
    echo -e "${YELLOW}📜 Checking TypeScript/JavaScript project...${NC}"
    
    # Check if package.json exists
    if [ ! -f "package.json" ]; then
        return 0
    fi
    
    # 1. Check for type errors (if tsconfig exists)
    if [ -f "tsconfig.json" ] && command -v tsc >/dev/null 2>&1; then
        echo "  📦 Checking TypeScript compilation..."
        if ! tsc --noEmit 2>/dev/null; then
            add_failure "TypeScript compilation errors detected"
            echo -e "  ${RED}❌ TypeScript errors found${NC}"
        else
            echo -e "  ${GREEN}✅ TypeScript check passed${NC}"
        fi
    fi
    
    # 2. Run ESLint if available
    if command -v eslint >/dev/null 2>&1 || [ -f "node_modules/.bin/eslint" ]; then
        echo "  🔍 Running ESLint..."
        ESLINT_CMD="eslint"
        if [ -f "node_modules/.bin/eslint" ]; then
            ESLINT_CMD="node_modules/.bin/eslint"
        fi
        
        if ! $ESLINT_CMD . 2>/dev/null; then
            add_failure "ESLint errors detected"
            echo -e "  ${RED}❌ ESLint found issues${NC}"
        else
            echo -e "  ${GREEN}✅ ESLint check passed${NC}"
        fi
    fi
    
    # 3. Check for forbidden patterns
    echo "  🚫 Checking for forbidden patterns..."
    FORBIDDEN_COUNT=0
    
    for file in $(find . -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" 2>/dev/null | grep -v node_modules); do
        # Check for any type
        if grep -q ': any' "$file" 2>/dev/null; then
            FORBIDDEN_COUNT=$((FORBIDDEN_COUNT + 1))
            log_debug "Found 'any' type in $file"
        fi
        # Check for console.log
        if grep -q 'console.log' "$file" 2>/dev/null; then
            FORBIDDEN_COUNT=$((FORBIDDEN_COUNT + 1))
            log_debug "Found console.log in $file"
        fi
        # Check for @ts-ignore
        if grep -q '@ts-ignore' "$file" 2>/dev/null; then
            FORBIDDEN_COUNT=$((FORBIDDEN_COUNT + 1))
            log_debug "Found @ts-ignore in $file"
        fi
    done
    
    if [ $FORBIDDEN_COUNT -gt 0 ]; then
        add_failure "Forbidden patterns found (any type, console.log, @ts-ignore)"
        echo -e "  ${RED}❌ Found $FORBIDDEN_COUNT forbidden patterns${NC}"
    else
        echo -e "  ${GREEN}✅ No forbidden patterns${NC}"
    fi
    
    # 4. Run tests if available
    if [ -f "package.json" ] && grep -q '"test"' package.json 2>/dev/null; then
        echo "  🧪 Running tests..."
        if ! npm test 2>/dev/null; then
            add_failure "Test failures detected"
            echo -e "  ${RED}❌ Tests failed${NC}"
        else
            echo -e "  ${GREEN}✅ All tests passing${NC}"
        fi
    fi
}

# Run checks based on project type
if [ -f "Cargo.toml" ]; then
    check_rust_project
fi

if ls *.py 2>/dev/null || ls */*.py 2>/dev/null; then
    check_python_project
fi

if [ -f "package.json" ]; then
    check_typescript_project
fi

# Final summary
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

if [ $FAILURES -eq 0 ]; then
    echo -e "${GREEN}✅ ALL QUALITY CHECKS PASSED${NC}"
    echo -e "${GREEN}   Commit can proceed safely${NC}"
    log_debug "All checks passed - commit allowed"
    exit 0
else
    echo -e "${RED}❌ QUALITY CHECKS FAILED${NC}"
    echo -e "${RED}   Found $FAILURES issue(s):${NC}"
    echo ""
    for msg in "${FAILURE_MESSAGES[@]}"; do
        echo -e "${RED}   • $msg${NC}"
    done
    echo ""
    echo -e "${YELLOW}📝 Fix these issues before committing:${NC}"
    echo -e "${YELLOW}   - For Rust: cargo fmt && cargo clippy --fix${NC}"
    echo -e "${YELLOW}   - For Python: ruff format . && ruff check --fix .${NC}"
    echo -e "${YELLOW}   - For TS/JS: npm run lint:fix (if configured)${NC}"
    echo -e "${YELLOW}   - Remove all forbidden patterns from production code${NC}"
    echo -e "${YELLOW}   - Ensure all tests pass${NC}"
    
    log_debug "Checks failed - blocking commit"
    
    # Exit with error to block the operation
    exit 1
fi