FROM docker.n8n.io/n8nio/n8n:latest

USER root

# Install Python (required by some dependencies)
RUN apk update && \
    apk add --no-cache python3 py3-pip && \
    ln -sf python3 /usr/bin/python

# Install Telepilot dependencies in n8n's custom node path
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm i @telepilotco/tdl \
           @telepilotco/tdlib-binaries-prebuilt \
           @telepilotco/n8n-nodes-telepilot && \
    chown -R node:node /home/node/.n8n/nodes 

# Ensure correct ENV for custom node loading
ENV N8N_CUSTOM_EXTENSIONS=/home/node/.n8n/nodes

USER node

# Run in worker mode only
CMD ["n8n", "worker"]
