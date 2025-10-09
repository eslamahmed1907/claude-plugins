---
allowed-tools: Read, Grep, Bash(cargo audit:*), Bash(npm audit:*), Bash(safety:*)
description: Run comprehensive security audit on the codebase
---

# Security Audit

Perform a thorough security analysis of the codebase.

## Your Task

1. **Dependency Scanning**
   - Run `cargo audit` for Rust dependencies
   - Check for known vulnerabilities
   - Review outdated packages

2. **Code Pattern Analysis**
   - Search for unsafe code blocks in Rust
   - Check for hardcoded secrets or API keys
   - Review file permissions and access patterns
   - Identify potential SQL injection points
   - Check for unsafe deserialization

3. **Security Best Practices**
   - Verify input validation
   - Check error handling doesn't leak sensitive info
   - Review authentication/authorization code
   - Ensure secure random number generation

4. **Report Generation**
   - Summarize findings by severity
   - Provide remediation steps
   - Highlight critical issues requiring immediate attention