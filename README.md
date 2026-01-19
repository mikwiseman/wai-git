# acp - AI-Powered Git Add, Commit & Push

**One command to stage, commit, and push with AI-generated commit messages.**

`acp` uses AI to analyze your changes and generate meaningful [Conventional Commits](https://www.conventionalcommits.org/) messages automatically.

## Features

- **Complete workflow**: `git add → generate message → commit → push` in one command
- **Multiple AI providers**: OpenAI, Claude, and Ollama (local/free)
- **Conventional Commits**: Automatically formats messages as `feat:`, `fix:`, etc.
- **Simple bash script**: No Node.js or complex dependencies
- **Fully customizable**: Easy to modify prompt, format, and behavior

## Installation

### Homebrew (macOS/Linux)

```bash
brew tap mikwiseman/wai-git
brew install acp
```

### curl (Universal)

```bash
curl -fsSL https://raw.githubusercontent.com/mikwiseman/wai-git/main/install.sh | bash
```

### Manual

```bash
git clone https://github.com/mikwiseman/wai-git
cd wai-git
sudo cp acp /usr/local/bin/
```

## Quick Start

```bash
# Make some changes to your code
echo "console.log('hello')" >> app.js

# Run acp - it stages, generates message, commits, and pushes
acp
```

Output:
```
→ Staging all changes...
→ Generating commit message with openai (gpt-5-mini)...

Generated commit message:
feat(app): add hello world logging

Commit with this message? [Y/n/e(dit)] y
→ Committing...
✓ Committed!
→ Pushing to remote...
✓ Pushed!

✓ Done!
```

## Configuration

Create a config file at `~/.config/acp/config`:

```bash
# Provider: claude | openai | ollama
ACP_PROVIDER=openai

# OpenAI settings
ACP_OPENAI_API_KEY=sk-...
ACP_OPENAI_MODEL=gpt-5-mini

# Claude settings
ACP_CLAUDE_API_KEY=sk-ant-...
ACP_CLAUDE_MODEL=claude-haiku-4-5

# Ollama settings (leave empty to auto-detect)
ACP_OLLAMA_MODEL=

# Behavior
ACP_AUTO_PUSH=true
ACP_CONVENTIONAL=true
```

### Environment Variables

You can also use standard environment variables:
- `OPENAI_API_KEY` - OpenAI API key
- `ANTHROPIC_API_KEY` - Claude API key

## Usage

```bash
# Basic usage - stage all, generate message, commit, push
acp

# Generate message only (no commit)
acp --dry-run

# Skip confirmation prompt
acp --yes

# Commit but don't push
acp --no-push

# Use specific provider
acp --provider claude
acp --provider openai
acp --provider ollama

# Use specific model
acp --model gpt-5.2
acp --model claude-sonnet-4-5-20250514

# Add scope to commit message
acp --scope auth    # Results in: feat(auth): ...
```

## Options

| Option | Short | Description |
|--------|-------|-------------|
| `--help` | `-h` | Show help message |
| `--version` | `-v` | Show version number |
| `--yes` | `-y` | Skip confirmation prompt |
| `--dry-run` | `-d` | Generate message without committing |
| `--no-push` | `-n` | Commit but don't push |
| `--provider` | `-p` | AI provider (claude, openai, ollama) |
| `--model` | `-m` | Model to use |
| `--scope` | `-s` | Scope for conventional commit |

## Supported Models

### OpenAI
- `gpt-5-mini` (default) - Fast and cheap ($0.25/$2 per 1M tokens)
- `gpt-5.2` - Best quality ($1.75/$14 per 1M tokens)

### Claude
- `claude-haiku-4-5` (default) - Fast and cheap ($1/$5 per 1M tokens)
- `claude-sonnet-4-5-20250514` - Best quality ($3/$15 per 1M tokens)

### Ollama (Free/Local)
- Auto-detects installed models
- Recommended: `qwen2.5-coder:7b`, `llama3.2:3b`

## Requirements

- `git` - For version control
- `curl` - For API calls
- `jq` - For JSON parsing

Install on macOS:
```bash
brew install git curl jq
```

Install on Ubuntu/Debian:
```bash
sudo apt install git curl jq
```

## Setting Up API Keys

### OpenAI

1. Go to [platform.openai.com/api-keys](https://platform.openai.com/api-keys)
2. Create a new API key
3. Add to config:
   ```bash
   echo 'ACP_OPENAI_API_KEY=sk-...' >> ~/.config/acp/config
   ```

### Claude

1. Go to [console.anthropic.com/settings/keys](https://console.anthropic.com/settings/keys)
2. Create a new API key
3. Add to config:
   ```bash
   echo 'ACP_CLAUDE_API_KEY=sk-ant-...' >> ~/.config/acp/config
   ```

### Ollama (Free)

1. Install Ollama: [ollama.ai](https://ollama.ai)
2. Pull a model:
   ```bash
   ollama pull qwen2.5-coder:7b
   ```
3. Start Ollama:
   ```bash
   ollama serve
   ```
4. Use with acp:
   ```bash
   acp --provider ollama
   ```

## How It Works

1. **Stage changes**: Runs `git add -A` (or uses already staged changes)
2. **Get diff**: Extracts the staged diff
3. **Generate message**: Sends diff to AI with Conventional Commits prompt
4. **Confirm**: Shows message and asks for confirmation
5. **Commit**: Creates the commit with the generated message
6. **Push**: Pushes to remote (unless `--no-push`)

## Conventional Commits

acp generates messages following the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
<type>(<scope>): <description>
```

**Types:**
- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation
- `style` - Formatting
- `refactor` - Code restructure
- `test` - Tests
- `chore` - Maintenance

**Examples:**
- `feat(auth): add JWT token refresh`
- `fix(api): handle null response`
- `docs: update installation guide`

## Troubleshooting

### "No changes to commit"
Make sure you have uncommitted changes in your repository.

### "OpenAI API key not found"
Set your API key in the config file or environment:
```bash
mkdir -p ~/.config/acp
echo 'ACP_OPENAI_API_KEY=sk-...' >> ~/.config/acp/config
```

### "Ollama is not running"
Start Ollama with:
```bash
ollama serve
```

### "No Ollama models found"
Pull a model first:
```bash
ollama pull qwen2.5-coder:7b
```

## License

MIT License - see [LICENSE](LICENSE) file.

## Contributing

Contributions welcome! Please open an issue or PR on [GitHub](https://github.com/mikwiseman/wai-git).
