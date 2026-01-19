# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.1] - 2026-01-19

### Fixed
- ANSI color codes now render correctly in setup wizard (added `-e` flag to echo)

### Changed
- `acp config` now shows "Unknown option" instead of special message
- Simplified README documentation

## [1.2.0] - 2026-01-19

### Added
- Auto-setup on first run — no need to know about `acp setup` beforehand
- Smart Ollama detection — if Ollama is installed with models, it's offered first
- Browser auto-open for API key pages (OpenAI, Claude, Ollama)
- Russian language UI for setup wizard

### Changed
- Simplified help output — shows only essential commands
- Setup wizard now prioritizes free Ollama option
- Removed step asking about auto-push (defaults to true)

### Removed
- `acp config` commands (list, set, get, path) — use `acp setup` instead
- Verbose help text — streamlined for clarity

## [1.1.0] - 2026-01-19

### Added
- `acp setup` - Interactive setup wizard for first-time configuration
- `acp config list` - Show current configuration
- `acp config set <key> <value>` - Set configuration values
- `acp config get <key>` - Get configuration values
- `acp config path` - Show config file location
- API key masking in config list output

### Changed
- Improved help text with commands section

## [1.0.0] - 2026-01-19

### Added
- Initial release
- Support for OpenAI (gpt-5-mini default)
- Support for Claude (claude-haiku-4-5 default)
- Support for Ollama with auto-detection
- Conventional Commits format
- Configuration file support (~/.config/acp/config)
- Command line options: --yes, --dry-run, --no-push, --provider, --model, --scope
- Homebrew tap installation
- curl-based installer
