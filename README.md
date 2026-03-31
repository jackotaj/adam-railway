# Adam — Railway Deployment

OpenClaw gateway for Adam, hosted 24/7 on Railway.

## How it works
- Runs `openclaw gateway start` with `bind: lan` (all interfaces)
- Clones workspace from `jackotaj/clawd-workspace` on startup
- API keys injected via Railway environment variables

## Environment Variables Required
- `ANTHROPIC_API_KEY`
- `TELEGRAM_BOT_TOKEN`
- `OPENCLAW_GATEWAY_TOKEN`
- `TELEGRAM_ALLOWED_USER`
- `GITHUB_TOKEN` (for cloning private workspace repo)
