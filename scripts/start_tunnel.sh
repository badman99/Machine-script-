#!/bin/bash
echo "🚀 Starting Tmate Terminal Sharing..."

# 1. Tmate इंस्टॉल करना (Ubuntu/Alpine compatible)
if ! command -v tmate &> /dev/null
then
    echo "📥 Installing Tmate..."
    sudo apt update && sudo apt install ttyd tmate -y || sudo apk add tmate --no-cache
fi

# 2. Tmate को बैकग्राउंड में चालू करना
echo "🛰️ Launching Tmate session..."
tmate -S /tmp/tmate.sock new-session -d
tmate -S /tmp/tmate.sock wait tmate-ready

# 3. Tmate का Web URL और SSH लिंक निकालना
TMATE_WEB=$(tmate -S /tmp/tmate.sock display -p '#{tmate_web}')
TMATE_SSH=$(tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}')

echo "✅ Tmate Ready!"
echo "🌐 Web: $TMATE_WEB"
echo "🔑 SSH: $TMATE_SSH"

# 4. Render API को ये दोनों लिंक भेजना (ताकि UI पर दिखें)
# हम दोनों लिंक्स को एक साथ भेज रहे हैं
FINAL_URL="Web: $TMATE_WEB | SSH: $TMATE_SSH"
CODESPACE_NAME=$(hostname)

echo "📡 Sending Tmate links to Render..."
curl -X POST "$RENDER_API_URL/update-url" \
     -H "Content-Type: application/json" \
     -d "{\"id\": \"$CODESPACE_NAME\", \"url\": \"$FINAL_URL\"}"
