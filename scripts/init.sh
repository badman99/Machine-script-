#!/bin/bash
echo "🚀 Phoenix Engine: Codespace Initialization Started..."

# 1. Hugging Face CLI इंस्टॉल करना
pip install -U "huggingface_hub[cli]"

# 2. चेक करो कि क्या HF Dataset पर पुराना बैकअप मौजूद है?
echo "📥 Checking for existing backup on Hugging Face..."

# HF CLI से फाइल डाउनलोड करने की कोशिश (अगर फाइल नहीं होगी तो ये एरर देगा, पर हम उसे इग्नोर करेंगे)
huggingface-cli download $HF_REPO_ID workspace_backup.tar.gz --repo-type dataset --token $HF_TOKEN --local-dir /tmp/ || echo "⚠️ No previous backup found. Starting fresh!"

# 3. अगर बैकअप मिल गया, तो उसे रिस्टोर करो
if [ -f "/tmp/workspace_backup.tar.gz" ]; then
    echo "📦 Backup found! Restoring data..."
    
    # एक्सट्रैक्ट करो (मान लो हम /workspaces/my-work-repo के अंदर का डेटा बैकअप ले रहे हैं)
    # --strip-components 1 यूज़ कर रहे हैं ताकि फोल्डर स्ट्रक्चर सही बैठे
    tar -xzvf /tmp/workspace_backup.tar.gz -C /workspaces/
    
    # कचरा साफ़ करो
    rm /tmp/workspace_backup.tar.gz
    echo "✅ Restore Complete! Welcome back, Baap!"
else
    echo "🌱 Fresh Codespace Ready!"
fi
