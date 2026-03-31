FROM node:22-slim

# Install openclaw globally
RUN npm install -g openclaw@latest

# Set up workspace directory
WORKDIR /app

# Clone workspace on startup (done via entrypoint)
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 18789

ENTRYPOINT ["/entrypoint.sh"]
