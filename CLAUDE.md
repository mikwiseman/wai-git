# CLAUDE.md

## Project Overview

**acp** (AI Commit & Push) — CLI tool that automates git workflow with AI-generated commit messages.

```
acp = git add -A + git commit -m "AI message" + git push
```

### Supported AI Providers
- **OpenAI** (GPT-4o-mini, GPT-4o)
- **Anthropic** (Claude Haiku, Sonnet, Opus)
- **Ollama** (local, free — qwen2.5-coder, llama, etc.)

### Key Features
- One command for entire git workflow
- Smart diff extraction (sees ALL files, not just first few)
- Interactive setup wizard on first run
- Auto-detects Ollama if installed

---

## Repository Structure

```
wai-git/
├── acp                 # Main script (bash)
├── CHANGELOG.md        # Version history
├── LICENSE             # MIT
├── README.md           # User documentation
└── CLAUDE.md           # This file (dev instructions)
```

**Related repository:**
```
homebrew-wai-git/
└── Formula/
    └── acp.rb          # Homebrew formula
```

---

## Development Workflow

### Making Changes

1. Edit files in `wai-git/`
2. Update `VERSION` in `acp` (line ~20)
3. Update `CHANGELOG.md` with new version

### Testing Locally

```bash
# Run from repo directly
./acp --version
./acp --dry-run

# Test with many changed files
./acp  # Should generate commit message mentioning all files
```

---

## Release Process

### Step-by-step checklist:

```bash
# 1. Update version in acp
VERSION="X.Y.Z"  # line ~20 in acp

# 2. Update CHANGELOG.md
## [X.Y.Z] - YYYY-MM-DD
### Added/Changed/Fixed
- Description

# 3. Commit and push
git add -A
git commit -m "feat/fix: description"
git push

# 4. Create and push tag
git tag vX.Y.Z
git push origin vX.Y.Z

# 5. Get SHA256 of new tarball
curl -sL https://github.com/mikwiseman/wai-git/archive/refs/tags/vX.Y.Z.tar.gz | shasum -a 256

# 6. Update Homebrew formula (in homebrew-wai-git repo)
# Edit Formula/acp.rb:
#   url "...vX.Y.Z.tar.gz"
#   sha256 "NEW_HASH"

# 7. Commit and push formula
cd ../homebrew-wai-git
git add -A
git commit -m "acp X.Y.Z"
git push

# 8. Update local installation
brew update
brew upgrade acp
acp --version  # Verify
```

### Quick Release (one-liner after code changes)

```bash
# After editing acp and CHANGELOG.md:
cd ~/Documents/Code/wai-git && \
git add -A && git commit -m "description" && git push && \
git tag v1.X.X && git push origin v1.X.X && \
SHA=$(curl -sL https://github.com/mikwiseman/wai-git/archive/refs/tags/v1.X.X.tar.gz | shasum -a 256 | cut -d' ' -f1) && \
echo "SHA256: $SHA"

# Then update homebrew-wai-git/Formula/acp.rb with new version and SHA
```

---

## Code Architecture

### Main Functions in `acp`

| Function | Purpose |
|----------|---------|
| `main()` | Entry point, argument parsing |
| `run_acp()` | Main workflow: stage → diff → AI → commit → push |
| `get_diff()` | Smart diff extraction (40KB limit, 3KB/file) |
| `generate_commit_message()` | Calls AI provider |
| `call_openai()` | OpenAI API |
| `call_anthropic()` | Claude API |
| `call_ollama()` | Local Ollama |
| `setup_wizard()` | Interactive first-run setup |

### Config Location

```
~/.config/acp/config
```

Variables:
- `ACP_PROVIDER` — openai, anthropic, ollama
- `ACP_MODEL` — model name
- `ACP_OPENAI_API_KEY`
- `ACP_ANTHROPIC_API_KEY`
- `ACP_AUTO_PUSH` — true/false

---

## Important Notes

### Diff Extraction (v1.2.2+)
- Full `git diff --stat` always included (shows ALL files)
- Per-file: only `+`/`-` lines, max 3KB each
- Total limit: 40KB (~10,000 tokens)
- Prevents AI from seeing only first few files in large commits

### Version Locations
- `acp` line ~20: `VERSION="X.Y.Z"`
- `CHANGELOG.md`: version history
- `homebrew-wai-git/Formula/acp.rb`: url and sha256

### Dependencies
- `bash` (4.0+)
- `curl`
- `jq`
- `git`

---

## Common Issues

### "No staged changes found"
Run in a git repo with uncommitted changes.

### API key errors
Run `acp setup` to reconfigure.

### Homebrew shows old version
```bash
brew update
brew upgrade acp
```

### Testing large diffs
Create a branch with 10+ file changes to verify AI sees all files.
