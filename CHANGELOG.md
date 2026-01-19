# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
