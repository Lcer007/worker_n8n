FROM docker.n8n.io/n8nio/n8n:1.102.3

USER root

RUN apk update && \
    apk add --no-cache python3 py3-pip && \
    ln -sf python3 /usr/bin/python

# Install Telepilot node modules
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install \
        @telepilotco/tdl \
        @telepilotco/tdlib-binaries-prebuilt \
        @telepilotco/n8n-nodes-telepilot && \
    chown -R node:node /home/node/.n8n/nodes

# Tell n8n where to find custom nodes
ENV N8N_CUSTOM_EXTENSIONS=/home/node/.n8n/nodes/node_modules

USER node

# 🧠 CMD for Railway (don’t override with ENTRYPOINT)
CMD ["n8n", "worker"]

