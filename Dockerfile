FROM docker.n8n.io/n8nio/n8n:latest

USER root

# Install Python (required by TDLib if needed)
RUN apk update && \
    apk add --no-cache python3 py3-pip && \
    ln -sf python3 /usr/bin/python

# Install Telepilot custom nodes in proper n8n location
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install \
      @telepilotco/tdl \
      @telepilotco/tdlib-binaries-prebuilt \
      @telepilotco/n8n-nodes-telepilot && \
    chown -R node:node /home/node/.n8n/nodes

# Required so n8n can auto-load the custom nodes
ENV N8N_CUSTOM_EXTENSIONS=/home/node/.n8n/nodes/node_modules

USER node

# Run n8n as a worker
CMD ["n8n", "worker"]
