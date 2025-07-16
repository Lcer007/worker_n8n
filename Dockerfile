FROM docker.n8n.io/n8nio/n8n:latest

USER root

RUN apk update && \
    apk add --no-cache python3 py3-pip && \
    ln -sf python3 /usr/bin/python

RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install \
        @telepilotco/tdl \
        @telepilotco/tdlib-binaries-prebuilt \
        @telepilotco/n8n-nodes-telepilot && \
    chown -R node:node /home/node/.n8n/nodes

ENV N8N_CUSTOM_EXTENSIONS=/home/node/.n8n/nodes/node_modules

USER node

# 🔥 Explicitly run the n8n worker via full node path
ENTRYPOINT ["node", "/usr/local/lib/node_modules/n8n/bin/n8n", "worker"]
