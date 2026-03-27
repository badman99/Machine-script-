#!/bin/bash
echo "📥 Phoenix Engine: Re-animating the Soul (Restore)..."

# 1. Hugging Face से बैकअप खींचो (The 'hf' command)
# $HF_REPO_ID और $HF_TOKEN एनवायरनमेंट में होने चाहिए
hf download $HF_REPO_ID workspace_backup.tar.gz --repo-type dataset --token $HF_TOKEN --local-dir /tmp/

# 2. अगर बैकअप मिल गया, तो उसे रिस्टोर करो
if [ -f "/tmp/workspace_backup.tar.gz" ]; then
    echo "📦 Backup found! Merging data..."
    
    # एक्सट्रैक्ट करो और ओवरराइट करो
    sudo tar -xzvf /tmp/workspace_backup.tar.gz -C / --overwrite
    
    # कचरा साफ़ करो
    rm /tmp/workspace_backup.tar.gz
    echo "✅ Restore Complete! Automatically cleaning the terminal..."
    
    # 3. 🧹 ऑटोमैटिक सफाई और पेंट (The Final Cleanup)
    sleep 2 # 2 सेकंड रुको ताकि तुम मैसेज देख सको
    clear
    export PS1='$ '
else
    echo "❌ Error: Hugging Face dataset is empty or backup missing!"
fi
