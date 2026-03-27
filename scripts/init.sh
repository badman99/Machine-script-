#!/bin/bash
# 🛠️ Universal Auto-Setup (Final Fixed Version)
export PATH="$HOME/.local/bin:$PATH"

# 1. Install dependencies
if [ -f /etc/alpine-release ]; then
    sudo apk add python3 py3-pip curl wget tar libc6-compat --no-cache
elif [ -f /etc/lsb-release ] || [ -f /etc/debian_version ]; then
    sudo apt update && sudo apt install python3-pip curl wget tar -y
fi

# 2. Install Hugging Face (The safe way)
pip install huggingface_hub --break-system-packages --no-cache-dir || pip install huggingface_hub --no-cache-dir

# 3. Use Python module directly (Anti-Error Trick)
HF_CLI="python3 -m huggingface_hub.commands.huggingface_cli"

echo "🔍 Checking for backup..."
$HF_CLI download $HF_REPO_ID workspace_backup.tar.gz --repo-type dataset --token $HF_TOKEN --local-dir /tmp/ || echo "⚠️ No backup."

if [ -f "/tmp/workspace_backup.tar.gz" ]; then
    tar -xzvf /tmp/workspace_backup.tar.gz -C /workspaces/
    rm /tmp/workspace_backup.tar.gz
    echo "✅ Restore Done!"
fi
