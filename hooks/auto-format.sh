#!/bin/bash
# Auto-format hook for Claude Code
# Automatically formats code after Edit/Write/MultiEdit operations

set -e

# Debug log
DEBUG_LOG="$HOME/.claude/logs/auto-format.log"
mkdir -p "$(dirname "$DEBUG_LOG")"

log_debug() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$DEBUG_LOG"
}

# Read hook data from stdin
HOOK_DATA=$(cat)
log_debug "Hook triggered with data: $HOOK_DATA"

# Extract tool name and file path from hook data
TOOL_NAME=$(echo "$HOOK_DATA" | jq -r '.tool_name // empty' 2>/dev/null || echo "")
FILE_PATH=$(echo "$HOOK_DATA" | jq -r '.file_path // empty' 2>/dev/null || echo "")

# If no file path in hook data, try to extract from parameters
if [ -z "$FILE_PATH" ]; then
    FILE_PATH=$(echo "$HOOK_DATA" | jq -r '.parameters.file_path // empty' 2>/dev/null || echo "")
fi

log_debug "Tool: $TOOL_NAME, File: $FILE_PATH"

# Function to format based on file extension
format_file() {
    local file="$1"
    local ext="${file##*.}"
    local dir=$(dirname "$file")
    
    log_debug "Formatting file: $file (extension: $ext)"
    
    case "$ext" in
        rs)
            # Rust formatting
            if command -v cargo >/dev/null 2>&1; then
                # Check if we're in a Rust project
                if [ -f "$dir/Cargo.toml" ] || [ -f "$(pwd)/Cargo.toml" ]; then
                    log_debug "Running cargo fmt on $file"
                    cargo fmt -- "$file" 2>>"$DEBUG_LOG" || log_debug "cargo fmt failed"
                fi
            fi
            ;;
        py)
            # Python formatting
            if command -v ruff >/dev/null 2>&1; then
                log_debug "Running ruff format on $file"
                ruff format "$file" 2>>"$DEBUG_LOG" || log_debug "ruff format failed"
            elif command -v black >/dev/null 2>&1; then
                log_debug "Running black on $file"
                black "$file" 2>>"$DEBUG_LOG" || log_debug "black failed"
            fi
            ;;
        js|jsx|ts|tsx|json|md|yml|yaml)
            # JavaScript/TypeScript/JSON/Markdown/YAML formatting
            if command -v prettier >/dev/null 2>&1; then
                log_debug "Running prettier on $file"
                prettier --write "$file" 2>>"$DEBUG_LOG" || log_debug "prettier failed"
            fi
            ;;
        go)
            # Go formatting
            if command -v gofmt >/dev/null 2>&1; then
                log_debug "Running gofmt on $file"
                gofmt -w "$file" 2>>"$DEBUG_LOG" || log_debug "gofmt failed"
            fi
            ;;
        *)
            log_debug "No formatter configured for extension: $ext"
            ;;
    esac
}

# Format if we have a file path
if [ -n "$FILE_PATH" ] && [ -f "$FILE_PATH" ]; then
    format_file "$FILE_PATH"
    log_debug "Formatting completed for $FILE_PATH"
else
    log_debug "No valid file path found or file doesn't exist"
fi

# Always exit successfully to not block the operation
exit 0