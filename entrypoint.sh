#!/bin/bash
set -e

echo "🚀 Starting Adam on Railway..."

# Set up openclaw state dir
mkdir -p /root/.openclaw/agents/main/agent

# Write cloud config
cp /app/openclaw.cloud.json /root/.openclaw/openclaw.json

# Write auth profiles with injected keys
cat > /root/.openclaw/agents/main/agent/auth-profiles.json << AUTHEOF
{
  "version": 1,
  "profiles": {
    "anthropic:auto": {
      "provider": "anthropic",
      "token": "${ANTHROPIC_API_KEY}"
    }
  },
  "lastGood": {
    "anthropic": "anthropic:auto"
  },
  "usageStats": {}
}
AUTHEOF

# Write telegram allowFrom credentials
mkdir -p /root/.openclaw/credentials
cat > /root/.openclaw/credentials/telegram-allowFrom.json << CREDEOF
{
  "version": 1,
  "allowFrom": ["${TELEGRAM_ALLOWED_USER}"]
}
CREDEOF

# Clone or pull workspace
if [ -d "/root/.openclaw/workspace/.git" ]; then
  echo "Pulling latest workspace..."
  cd /root/.openclaw/workspace && git pull origin main
else
  echo "Cloning workspace..."
  git clone "https://${GITHUB_TOKEN}@github.com/jackotaj/clawd-workspace.git" /root/.openclaw/workspace
fi

# Update agents.defaults.workspace in config to point to cloned workspace
sed -i 's|/app/workspace|/root/.openclaw/workspace|g' /root/.openclaw/openclaw.json

echo "✅ Starting OpenClaw gateway..."
exec openclaw gateway start --bind lan
