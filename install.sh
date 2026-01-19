#!/usr/bin/env bash
#
# acp installer
# Usage: curl -fsSL https://raw.githubusercontent.com/mikwiseman/wai-git/main/install.sh | bash
#
set -euo pipefail

REPO="mikwiseman/wai-git"
INSTALL_DIR="${HOME}/.local/bin"
SCRIPT_NAME="acp"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

print_error() {
    echo -e "${RED}error:${NC} $1" >&2
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_info() {
    echo -e "${BLUE}→${NC} $1"
}

# Check for required commands
check_dependencies() {
    local missing=()

    for cmd in curl git jq; do
        if ! command -v "${cmd}" &>/dev/null; then
            missing+=("${cmd}")
        fi
    done

    if [[ ${#missing[@]} -gt 0 ]]; then
        print_error "Missing required dependencies: ${missing[*]}"
        echo ""
        echo "Install with:"
        echo "  macOS:  brew install ${missing[*]}"
        echo "  Ubuntu: sudo apt install ${missing[*]}"
        exit 1
    fi
}

# Create install directory
ensure_install_dir() {
    if [[ ! -d "${INSTALL_DIR}" ]]; then
        print_info "Creating ${INSTALL_DIR}..."
        mkdir -p "${INSTALL_DIR}"
    fi
}

# Check if directory is in PATH
check_path() {
    if [[ ":${PATH}:" != *":${INSTALL_DIR}:"* ]]; then
        echo ""
        print_info "Add ${INSTALL_DIR} to your PATH:"
        echo ""
        echo "  For bash:  echo 'export PATH=\"\${HOME}/.local/bin:\${PATH}\"' >> ~/.bashrc"
        echo "  For zsh:   echo 'export PATH=\"\${HOME}/.local/bin:\${PATH}\"' >> ~/.zshrc"
        echo ""
        echo "Then restart your terminal or run: source ~/.bashrc (or ~/.zshrc)"
    fi
}

# Download and install
install_acp() {
    local url="https://raw.githubusercontent.com/${REPO}/main/acp"
    local dest="${INSTALL_DIR}/${SCRIPT_NAME}"

    print_info "Downloading acp..."

    if curl -fsSL "${url}" -o "${dest}"; then
        chmod +x "${dest}"
        print_success "Installed to ${dest}"
    else
        print_error "Failed to download acp"
        exit 1
    fi
}

# Create config directory
setup_config() {
    local config_dir="${HOME}/.config/acp"

    if [[ ! -d "${config_dir}" ]]; then
        print_info "Creating config directory..."
        mkdir -p "${config_dir}"
    fi

    if [[ ! -f "${config_dir}/config" ]]; then
        cat > "${config_dir}/config" << 'EOF'
# acp configuration
# https://github.com/mikwiseman/wai-git

# Provider: claude | openai | ollama
ACP_PROVIDER=openai

# OpenAI settings
# Get your API key: https://platform.openai.com/api-keys
# ACP_OPENAI_API_KEY=sk-...
ACP_OPENAI_MODEL=gpt-5-mini

# Claude settings
# Get your API key: https://console.anthropic.com/settings/keys
# ACP_CLAUDE_API_KEY=sk-ant-...
ACP_CLAUDE_MODEL=claude-haiku-4-5

# Ollama settings (leave empty to auto-detect installed model)
ACP_OLLAMA_MODEL=

# Behavior
ACP_AUTO_PUSH=true
ACP_CONVENTIONAL=true
EOF
        print_success "Created config at ${config_dir}/config"
    fi
}

main() {
    echo ""
    echo "Installing acp - AI-powered git add, commit & push"
    echo ""

    check_dependencies
    ensure_install_dir
    install_acp
    setup_config
    check_path

    echo ""
    print_success "Installation complete!"
    echo ""
    echo "Next steps:"
    echo "  1. Add your API key to ~/.config/acp/config"
    echo "  2. Run 'acp --help' to see usage"
    echo ""
}

main
