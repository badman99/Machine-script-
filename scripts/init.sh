#!/bin/bash
echo "🚀 Phoenix Engine: Starting Universal Auto-Setup..."

# 🛠️ OS Detection & Package Installation
if [ -f /etc/alpine-release ]; then
    echo "🗻 Alpine Linux Detected! Installing dependencies..."
    sudo apk update && sudo apk add python3 py3-pip curl wget tar libc6-compat --no-cache
elif [ -f /etc/lsb-release ] || [ -f /etc/debian_version ]; then
    echo "🐧 Ubuntu/Debian Detected! Installing dependencies..."
    sudo apt update && sudo apt install python3-pip curl wget tar -y
fi

# 🐍 Python के नखरे खत्म करना
echo "📦 Installing Hugging Face Hub..."
pip install huggingface_hub --break-system-packages --no-cache-dir || pip install huggingface_hub --no-cache-dir

# 📥 Backup check (Hugging Face)
echo "🔍 Checking for existing backup..."
huggingface-cli download $HF_REPO_ID workspace_backup.tar.gz --repo-type dataset --token $HF_TOKEN --local-dir /tmp/ || echo "⚠️ No backup found."

if [ -f "/tmp/workspace_backup.tar.gz" ]; then
    echo "📦 Restoring data..."
    tar -xzvf /tmp/workspace_backup.tar.gz -C /workspaces/
    rm /tmp/workspace_backup.tar.gz
    echo "✅ Restore Complete!"
fi
