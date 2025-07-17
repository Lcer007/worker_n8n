FROM docker.n8n.io/n8nio/n8n:1.102.3

USER root

# Install Python
RUN apk add --no-cache python3 py3-pip && \
    ln -sf python3 /usr/bin/python

# Install Telepilot dependencies
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install \
      @telepilotco/tdl \
      @telepilotco/tdlib-binaries-prebuilt \
      @telepilotco/n8n-nodes-telepilot && \
    chown -R node:node /home/node/.n8n

# Register custom nodes
ENV N8N_CUSTOM_EXTENSIONS=/home/node/.n8n/nodes/node_modules

USER node

# ENTRYPOINT must be n8n
CMD ["n8n", "worker"]


