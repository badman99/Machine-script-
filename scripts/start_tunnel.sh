#!/bin/bash
echo "🚇 Starting Cloudflare Tunnel..."

# 📥 Cloudflared इंस्टॉल करना (Detect Architecture)
if ! command -v cloudflared &> /dev/null
then
    echo "📥 Downloading Cloudflared..."
    wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /tmp/cloudflared
    chmod +x /tmp/cloudflared
    sudo mv /tmp/cloudflared /usr/local/bin/
fi

# 🚀 टनल चालू करो (Port 8000 default)
nohup cloudflared tunnel --url http://localhost:8000 > /tmp/tunnel.log 2>&1 &

# 📡 Render को पिंग मारो
echo "📡 Waiting for Tunnel URL..."
sleep 15
TUNNEL_URL=$(grep -o 'https://[-0-9a-z]*\.trycloudflare.com' /tmp/tunnel.log | head -1)

if [ -n "$TUNNEL_URL" ]; then
    echo "✅ URL Found: $TUNNEL_URL"
    CODESPACE_NAME=$(hostname)
    curl -X POST "$RENDER_API_URL/update-url" \
         -H "Content-Type: application/json" \
         -d "{\"id\": \"$CODESPACE_NAME\", \"url\": \"$TUNNEL_URL\"}"
fi
