# acp - AI-Powered Git Commits

One command to stage, commit, and push with AI-generated commit messages.

## Installation

```bash
brew tap mikwiseman/wai-git && brew install acp
```

Or with curl:

```bash
curl -fsSL https://raw.githubusercontent.com/mikwiseman/wai-git/main/install.sh | bash
```

## Usage

```bash
# First run - automatically starts setup
acp

# Reconfigure
acp setup
```

That's it! On first run, `acp` will guide you through setup.

## Options

```bash
acp                    # Stage all, generate message, commit, push
acp -y                 # Skip confirmation
acp -n                 # Don't push
acp -d                 # Dry run (show message only)
acp -p ollama          # Use specific provider
acp -m gpt-4o          # Use specific model
acp -s auth            # Add scope: feat(auth): ...
```

## Configuration

Config file: `~/.config/acp/config`

```bash
# Provider: ollama | openai | claude
ACP_PROVIDER=ollama

# API keys (if using cloud providers)
ACP_OPENAI_API_KEY=sk-...
ACP_CLAUDE_API_KEY=sk-ant-...

# Custom models (optional - smart defaults used)
ACP_OPENAI_MODEL=gpt-5-mini
ACP_CLAUDE_MODEL=claude-haiku-4-5
ACP_OLLAMA_MODEL=qwen2.5-coder:7b
```

## Providers

| Provider | Cost | Setup |
|----------|------|-------|
| **Ollama** | Free | `brew install ollama && ollama pull qwen2.5-coder:7b` |
| **OpenAI** | ~$0.25/1000 commits | [Get API key](https://platform.openai.com/api-keys) |
| **Claude** | ~$1/1000 commits | [Get API key](https://console.anthropic.com/settings/keys) |

## Requirements

- `git`, `curl`, `jq`

```bash
# macOS
brew install git curl jq

# Ubuntu
sudo apt install git curl jq
```

## License

MIT
