# Claude Ultra Quality Enforcement Plugin

> Zero-tolerance quality enforcement for Claude Code with comprehensive Rust, Python, and TypeScript support.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/dirvine/claude-plugins)

## 🎯 Overview

A comprehensive Claude Code plugin that enforces **absolute zero-tolerance** for errors, warnings, and technical debt. Built for professional developers who refuse to compromise on code quality.

### Core Philosophy

**Never deliver broken code. Ever.**

This plugin ensures that every line of code meets the highest professional standards:
- ✅ Zero compilation errors
- ✅ Zero warnings (Clippy, ESLint, Ruff)
- ✅ Zero panics in production Rust code
- ✅ 100% test pass rate
- ✅ Comprehensive error handling
- ✅ Complete documentation

## 🚀 Features

### 🦀 Rust Excellence
- **Zero-tolerance for panic patterns** - `.unwrap()`, `.expect()`, `panic!()` banned in production
- **Clippy perfection** - All clippy warnings must be resolved
- **Cargo fmt enforcement** - Automatic code formatting
- **Comprehensive testing** - 100% test pass rate required
- **Production-ready error handling** - `Result<T, E>` everywhere

### 🐍 Python Quality
- **Ruff integration** - Modern Python linting and formatting
- **Type safety** - MyPy strict mode support
- **No placeholders** - Complete implementations only
- **Test coverage** - Minimum 85% coverage enforced

### 📜 TypeScript/JavaScript Support
- **ESLint zero warnings** - Perfect linting
- **TypeScript strict mode** - Full type safety
- **Prettier formatting** - Consistent code style
- **No any types** - Proper typing required

### 🤖 Intelligent Agents (30+)

#### Quality Enforcement
- **quality-enforcer** - Ultimate quality gatekeeper
- **build-validator** - Compilation verification
- **pre-return-validator** - Final checkpoint before code delivery
- **test-guardian** - Ensures 100% test pass rate

#### Language Specialists
- **rust-specialist** - Rust idioms and safety patterns
- **python-specialist** - Pythonic code enforcement
- **data-scientist** - Data analysis and ML workflows

#### Development Workflow
- **commit-agent** - Intelligent commit orchestration
- **workflow-monitor** - CI/CD monitoring and auto-fixing
- **test-fixer** - Automatic test failure resolution
- **dependency-fixer** - Dependency conflict resolution

#### Security & Performance
- **security-scanner** - Vulnerability detection
- **performance-analyzer** - Performance optimization
- **documentation-auditor** - Documentation completeness

### 🔧 Slash Commands (20+)

#### Core Commands
- `/ultra-commit` - Quality-assured git commits
- `/ultra-dev` - Complete development workflow
- `/security` - Comprehensive security audit
- `/test` - Advanced test execution
- `/quality-check` - Full quality validation

#### Development Workflow
- `/orchestrate` - Multi-step task orchestration
- `/steer` - Project documentation and analysis
- `/cleanup` - Repository cleanup
- `/fix-ci` - CI/CD failure resolution
- `/fix-deps` - Dependency issue fixing

### 🪝 Automatic Hooks

#### Post-Edit Formatting
Automatically formats code after every edit:
- Rust: `cargo fmt`
- Python: `ruff format`
- TypeScript/JavaScript: `prettier`
- Go: `gofmt`

#### Pre-Commit Validation
Blocks commits with quality issues:
- ✅ Compilation check
- ✅ Linting validation
- ✅ Test execution
- ✅ Forbidden pattern detection
- ✅ Documentation completeness

#### Event Notifications
Audio/visual notifications for:
- Session start/stop
- Agent completion
- Quality gate passage
- Error detection

## 📦 Installation

### Via Plugin Marketplace

```bash
# Install from GitHub
/plugin marketplace add dirvine/claude-plugins

# Enable the plugin
/plugin enable claude-ultra-quality-enforcement
```

### Manual Installation

```bash
# Clone the repository
git clone https://github.com/dirvine/claude-plugins.git ~/.claude/plugins/ultra-quality

# Or download and extract to:
# ~/.claude/plugins/ultra-quality/
```

## 🔧 Configuration

### Quick Start

The plugin works out of the box with sensible defaults. For customization:

```bash
# Copy example configuration
cp .claude/settings.json.example .claude/settings.local.json

# Edit your settings
vim .claude/settings.local.json
```

### Quality Standards

Configure enforcement levels in `settings.local.json`:

```json
{
  "qualityStandards": {
    "enforceStrictMode": true,
    "blockOnCompileErrors": true,
    "blockOnWarnings": true,
    "blockOnTestFailures": true,
    "minTestCoverage": 85,
    "forbidPlaceholders": true,
    "requireFullImplementation": true
  }
}
```

### Language-Specific Settings

#### Rust
```json
{
  "rustSpecific": {
    "forbiddenPatterns": [
      ".unwrap()",
      ".expect(",
      "panic!(",
      "todo!()",
      "unimplemented!()"
    ],
    "clippySettings": {
      "deny": ["warnings"]
    }
  }
}
```

#### Python
```json
{
  "pythonSpecific": {
    "forbiddenPatterns": [
      "pass  # TODO",
      "raise NotImplementedError",
      "type: ignore"
    ],
    "minTestCoverage": 85
  }
}
```

## 📚 Usage

### Basic Workflow

```bash
# Start a new feature with quality enforcement
/ultra-dev "implement user authentication"

# The system will:
# 1. Analyze requirements
# 2. Write tests first (TDD)
# 3. Implement solution
# 4. Run quality checks
# 5. Fix any issues
# 6. Create quality commit
```

### Commit with Quality Assurance

```bash
# Automatically validates before committing
/ultra-commit

# Or with custom message
/ultra-commit "feat: add OAuth2 support"

# The system ensures:
# - Zero compilation errors
# - Zero warnings
# - All tests passing
# - No forbidden patterns
# - Complete documentation
```

### Security Audit

```bash
# Comprehensive security analysis
/security

# Checks for:
# - Dependency vulnerabilities
# - Unsafe code patterns
# - Hardcoded secrets
# - SQL injection risks
# - Authentication issues
```

### Test Management

```bash
# Run all tests with strict validation
/test --all --strict

# Run with coverage requirements
/test --coverage --min 85

# Fix failing tests automatically
/test --fix
```

## 🎓 Documentation

Comprehensive guides available in the `docs/` directory:

- [**Agents Reference**](docs/AGENTS.md) - Complete agent documentation
- [**Commands Reference**](docs/COMMANDS.md) - All slash commands
- [**Hooks Guide**](docs/HOOKS.md) - Hook configuration and customization
- [**Configuration Guide**](docs/CONFIGURATION.md) - Advanced settings
- [**Best Practices**](docs/BEST_PRACTICES.md) - Recommended workflows

## 🛡️ Quality Guarantees

When using this plugin, you get:

| Feature | Guarantee |
|---------|-----------|
| Compilation | ✅ Zero errors, zero warnings |
| Tests | ✅ 100% pass rate |
| Coverage | ✅ Minimum 85% |
| Panics | ✅ None in production Rust |
| Placeholders | ✅ Complete implementations only |
| Documentation | ✅ All public APIs documented |
| Security | ✅ No known vulnerabilities |
| Formatting | ✅ Automatic enforcement |

## 🚫 Forbidden Patterns

### Rust Production Code
```rust
// ❌ NEVER ALLOWED
.unwrap()
.expect("message")
panic!("error")
todo!()
unimplemented!()

// ✅ REQUIRED
.ok_or(Error::Missing)?
.map_err(Error::from)?
return Err(Error::Invalid)
```

### Python Production Code
```python
# ❌ NEVER ALLOWED
pass  # TODO
raise NotImplementedError()
# type: ignore

# ✅ REQUIRED
return process_data()  # Complete implementation
```

### TypeScript Production Code
```typescript
// ❌ NEVER ALLOWED
const value: any = ...;
// @ts-ignore
console.log(...)

// ✅ REQUIRED
const value: SpecificType = ...;
// Proper typing
logger.info(...)
```

## 🤝 Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Development Setup

```bash
# Clone the repository
git clone https://github.com/dirvine/claude-plugins.git
cd claude-plugins

# Test locally
cp -r . ~/.claude/plugins/ultra-quality-dev
/plugin enable ultra-quality-dev
```

### Testing

```bash
# Run test suite
./tests/run_all_tests.sh

# Test specific components
./tests/test_agents.sh
./tests/test_commands.sh
./tests/test_hooks.sh
```

## 📝 Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history and changes.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with [Claude Code](https://claude.ai/claude-code)
- Inspired by the Rust community's commitment to safety and quality
- Contributions from the open-source community

## 🆘 Support

- **Issues**: [GitHub Issues](https://github.com/dirvine/claude-plugins/issues)
- **Discussions**: [GitHub Discussions](https://github.com/dirvine/claude-plugins/discussions)
- **Documentation**: [docs/](docs/)

## 🎯 Mission

**Never deliver broken code. Ever.**

This plugin embodies a simple principle: quality is non-negotiable. Every line of code that leaves your development environment should be:

- Fully functional
- Properly tested
- Well documented
- Security reviewed
- Performance validated
- Error handled correctly

---

*Quality is not an act, it is a habit.* - Aristotle

Made with ❤️ in Barr, Scotland by David Irvine
