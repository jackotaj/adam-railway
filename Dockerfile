FROM node:22-slim

# Install git and other essentials
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Install openclaw globally
RUN npm install -g openclaw@latest

# Set up workspace directory
WORKDIR /app

# Copy config files
COPY openclaw.cloud.json /app/openclaw.cloud.json

# Clone workspace on startup (done via entrypoint)
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 18789

ENTRYPOINT ["/entrypoint.sh"]
