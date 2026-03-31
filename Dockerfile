FROM node:20-slim

# Install system deps
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install OpenClaw globally
RUN npm install -g openclaw@latest

# Create workspace dir
RUN mkdir -p /app/workspace /app/state

# Copy our config
COPY openclaw.json /app/openclaw.json

# Copy credentials allowlist (pairing data)
COPY credentials/ /app/state/credentials/ 2>/dev/null || true

EXPOSE 18789

ENV OPENCLAW_CONFIG_PATH=/app/openclaw.json
ENV OPENCLAW_STATE_DIR=/app/state

CMD ["openclaw", "gateway", "start", "--force"]
